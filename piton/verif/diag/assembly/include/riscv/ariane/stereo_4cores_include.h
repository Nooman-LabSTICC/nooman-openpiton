#ifndef PREESM_H
#define PREESM_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
//#include <math.h>


#define min(x,y) (((x)<(y))?(x):(y))
#define max(x,y) (((x)<(y))?(y):(x))
#define R_gamaC (float) 1.0/16.0 /*(1.0)/16.0 */
#define clamp(x) (x>255)? 255 : ((x<0)? 0 : x);

#define IN
#define OUT

typedef unsigned char uchar;

#define PREESM_LOOP_SIZE	1
#define LOOP_SIZE		PREESM_LOOP_SIZE //Compatibility issue

#define NB_CORES		4



 //********************** OFFSETGEN.C **********************

void offsetGen (int nbIterations, int *offsets){
	int i;
	int sum = 0;
	for(i=0; i< nbIterations; i++){
		offsets[i] = 2*sum + 1;
		sum += offsets[i];
		offsets[i] %= 32;  
	}
}

 //********************** AGGREGATECOST.C **********************

void aggregateCost (int height , int width, int nbIterations,
					float *disparityError, int *offsets,
					float *hWeights, float *vWeights,
					float *aggregatedDisparity){
    int offsetIdx;
	int i,j;

    // For each of the offset, do the horizontal and vertical
    // aggregation
    for(offsetIdx=0; offsetIdx< 2*nbIterations; offsetIdx++){
        int offset = offsets[offsetIdx/2];

		// Even iterations are vertical, Odd are horizontal
		int hOffset = (offsetIdx%2 == 1)? offset : 0;
		int vOffset = (offsetIdx%2 == 0)? offset : 0;
		
		// Select the weights corresponding to the current offset
		float *weights = (offsetIdx%2 == 0)? vWeights : hWeights;
		int weightIdx = (offsetIdx/2) * (3*height*width);

		// Select the computation destination and source
		// Even iteration from disparityError and Odd from aggregated Disparity
		float *src = (offsetIdx%2 == 0)? disparityError: aggregatedDisparity; 
		float *dest = (offsetIdx%2 == 0)? aggregatedDisparity: disparityError; 

        // Scan the image pixels
		for(j=0; j<height; j++){
			for(i=0; i<width; i++){
				float costM, costP, costO;
				float weightM, weightP, weightO;
				
				// Get the costs of the pixels
				costO = src[j*width+i];
				costM = src[max(j-vOffset,0)*width+max(i-hOffset,0)];
				costP = src[min(j+vOffset,height-1)*width+min(i+hOffset,width-1)];

				// Get the weights
				weightO = weights[weightIdx + 3*(j*width+i)];
				weightM = weights[weightIdx + 3*(j*width+i)+1];
				weightP = weights[weightIdx + 3*(j*width+i)+2];
				
				dest[j*width+i] = weightO*costO+weightM*costM+weightP*costP;
			}
		}
    }

    // Copy the result in the output buffer.
    memcpy(aggregatedDisparity,disparityError,height*width*sizeof(float));
}


 //********************** CENSUS.C **********************

void census(int height, int width, float *gray, unsigned char *cen){
    int i,j;
    int k,l;

    // Scan the pixels of the grey image
    // except the 1 pixel-wide band around the image.
    for(j=1; j<height-1; j++){
		// 1st and last pixels of the line are 0
		cen[j*width] = 0;
		cen[(j+1)*width-1] = 0;
        for(i=1; i<width-1; i++){
            unsigned char signature = 0x00;
            int bit = 7;
            // For each pixel, compute its census signature with
            // a 3x3 pixels window around it.
            for(l = -1; l <= 1; l++){
                for(k=-1 ; k<=1; k++){
                    // In the 8 bit signature, a bit is set
                    // to 1 if the compared pixel is inferior to the current.
					// Ex:
					// |20|21|13|
					// |15|18|19|  => 0x35 (00110101)
					// |13|18|16|
                    if(k!=0 || l!=0){
                        if(gray[j*width+i] > gray[(j+l)*width+(i+k)]){
                            signature |= 1 << bit;
                        }
                        bit--;
                    }
                }
            }
            cen[j*width+i] = signature;
        }
    }

	// Fill the 1st and last lines with 0
	memset(cen,0,width*sizeof(char));
	memset(cen+(height-1)*width,0,width*sizeof(char));
}

 //********************** DISPARITYGEN.C **********************

void disparityGen (int minDisparity, int maxDisparity,
				   unsigned char *disparities){
	int disp;
	for(disp=minDisparity; disp<maxDisparity; disp++){
		disparities[disp-minDisparity] = disp;
	}
}

 //********************** DISPLAYRGB.C **********************


void displayRGBInit(int id, int height, int width){
	return;
}

void displayLum(int id, unsigned char *lum){
	return;
}

void displayRGB(int id, int height, int width, unsigned char *rgb){
	return;
}


void refreshDisplayRGB(int id)
{
	return;
}

void finalizeRGB(int id)
{
	return;
}



 //********************** RGB2GRAY.C **********************

void rgb2Gray(int size, unsigned char *rgb, float *gray){
    int idx;
    
    for(idx=0; idx< size; idx++){
        /*gray[idx] = RGB2GRAY_COEF_R*(float)rgb[3*idx] +
                    RGB2GRAY_COEF_G*(float)rgb[3*idx+1] +
                    RGB2GRAY_COEF_B*(float)rgb[3*idx+2];*/
    }
}

 //********************** COSTCONSTRUCTION.C **********************


unsigned char hammingCost(unsigned char *a, unsigned char *b)
{
    int i;
    unsigned char res=0;

    // Bitwise exclusive or to identify the differences
    // between the two signatures
    unsigned char diffBit = *a ^ *b;

    // Count the 1 in the diffBit word
    for(i=0; i<8; i++)
    {
        res += ((diffBit & (1<<i))? 1 : 0);
    }

    return res;
}

void costConstruction (int height, int width, float truncValue,
                       unsigned char *disparity,
                       float *grayL, float *grayR,
                       unsigned char *cenL, unsigned char *cenR,
                       float *disparityError, unsigned char * back)
{
    int i,j;

    // For each disparity, scan the pixels of the left image
    for(j=0; j<height; j++)
    {
        for(i=0; i<width; i++)
        {
            unsigned char censusCost;
            int leftPxlIdx = j*width + i;
            int rightPxlIdx = j*width + (((i-*disparity)>0)?i-*disparity:0);

            // Get the cost from the census signatures
            censusCost = hammingCost(cenL+leftPxlIdx, cenR+rightPxlIdx);

            // Combination method 3 -- weight addition
            //disparityError[leftPxlIdx] =  min(fabs((float)(grayL[leftPxlIdx]-grayR[rightPxlIdx])),truncValue) + censusCost/5.0;
        }
    }
}

 //********************** MEDIANFILTER.C **********************

void swap(unsigned char *a, unsigned char *b){
	unsigned char buf = *a;
	*a=*b;
	*b=buf;
}

void quickSortPartition(int startIdx, int endIdx, int *pivotIdx, unsigned char *values){
	int idx;
	int swapIdx = startIdx;
	swap(values+*pivotIdx,values+endIdx);
	for(idx = startIdx; idx < endIdx; idx++){
		if(values[idx]<=values[endIdx]){
			swap(values+swapIdx,values+idx);
			swapIdx++;
		}
	}
	swap(values+swapIdx, values+endIdx);
	*pivotIdx = swapIdx;
}


void quickSort(int startIdx, int endIdx, unsigned char *values){
	if(startIdx<endIdx){
		int pivotIdx = startIdx;
		quickSortPartition(startIdx, endIdx, &pivotIdx, values);
		quickSort(startIdx,pivotIdx-1,values);
		quickSort(pivotIdx+1,endIdx,values);
	}	
}

void medianFilter (int height , int width, int topDownBorderSize, 
                   unsigned char *rawDisparity,
				   unsigned char *filteredDisparity)
{	
	int i,j;
	int k,l;
	// Process pixels one by one
	for(j=topDownBorderSize; j< height-topDownBorderSize; j++){
		for(i=0;i<width;i++){
			unsigned char pixels[9];
			// output pixel is the median of a 3x3 window
			// Get the 9 pixels
			for(l=-1;l<=1;l++){
				int y = min(max(j+l,0),height-1);
				for(k=-1;k<=1;k++){
					int x = min(max(i+k,0),width-1);
					pixels[(l+1)*3+k+1] = rawDisparity[y*width+x];
				}
			}

			// Sort the 9 values
			quickSort(0, 8, pixels);
			filteredDisparity[(j-topDownBorderSize)*width+i] = pixels[9/2];
		}
	}
}

 //********************** COMPUTEWEIGHTS.C **********************

void computeWeights (int height , int width, int horOrVert,
					 int *offset, unsigned char *rgbL, float *weights)
{
    int i, j;

    // hOffset of vOffset depending on the computed weights
    int hOffset = (horOrVert == 0)? *offset : 0;
    int vOffset = (horOrVert == 1)? *offset : 0;

    // Distance coeff
    float distanceCoeff = -(float)(*offset)/36.0;
	//distanceCoeff *= -1;

    // Scan the pixels of the rgb image
    for(j=0; j<height; j++)
    {
        for(i=0; i<width; i++)
        {
            float r0, g0, b0, r, g, b;
            float weightM, weightP, weightO;

            // Compute the weights
            r0 = rgbL[3*(j*width+i)];
            g0 = rgbL[3*(j*width+i)+1];
            b0 = rgbL[3*(j*width+i)+2];

            r  = rgbL[3*(max(j-vOffset,0)*width+max(i-hOffset,0))];
            g  = rgbL[3*(max(j-vOffset,0)*width+max(i-hOffset,0))+1];
            b  = rgbL[3*(max(j-vOffset,0)*width+max(i-hOffset,0))+2];
            //weightM = sqrtf((r0-r)*(r0-r)+(g0-g)*(g0-g)+(b0-b)*(b0-b))* R_gamaC;

            r  = rgbL[3*(min(j+vOffset,height-1)*width+min(i+hOffset,width-1))];
            g  = rgbL[3*(min(j+vOffset,height-1)*width+min(i+hOffset,width-1))+1];
            b  = rgbL[3*(min(j+vOffset,height-1)*width+min(i+hOffset,width-1))+2];
            //weightP = sqrtf((r0-r)*(r0-r)+(g0-g)*(g0-g)+(b0-b)*(b0-b))* R_gamaC;

            //weightM = exp(distanceCoeff-weightM);
            //weightP = exp(distanceCoeff-weightP);

            weightO = 1/(weightM+weightP+1);
            weightM = weightM*weightO;
            weightP = weightP*weightO;

            // Store the three weights one after the other in the
            // output buffer;
            weights[3*(j*width+i)+0] = weightO;
            weights[3*(j*width+i)+1] = weightM;
            weights[3*(j*width+i)+2] = weightP;
        }
    }
}

 //********************** DISPARITYSELECT.C **********************

void disparitySelect (int height, int width, int nbDisparities, int scale,
                      int minDisparity,
                      unsigned char *disparity,
					  float *aggregatedDisparity,
                      float *bestCostFeed, unsigned char *currentResult,
                      unsigned char *result,
					  float *backBestCost)
{
    int i,j;

    // Special processng for the first iteration
    if(*(int*)(bestCostFeed+height*width) == 0)
    {
        // Copy the input aggregated disparity in the feedback
        memcpy(backBestCost,aggregatedDisparity,height*width*sizeof(float));
        // Fill the result map with minDisparity
        memset(result, 0, height*width*sizeof(char));
    }
    else
    {
        // For all other iterations
        // Scan the pixels of the aggregated disparity
        for(j=0; j<height; j++)
        {
            for(i=0; i<width; i++)
            {
				// If the cost of the aggregated disparity is lower, keep the new
				// disparity as the best, else, keep te current.
                result[j*width+i] =
					(aggregatedDisparity[j*width+i]<bestCostFeed[j*width+i])?
						scale*((*disparity)-minDisparity) : currentResult[j*width+i];

                backBestCost[j*width+i] = min(aggregatedDisparity[j*width+i],bestCostFeed[j*width+i]);

            }
        }
    }
	*(int*)(backBestCost+height*width) = (*(int*)(bestCostFeed+height*width) + 1)%nbDisparities;
}

 //********************** YUV2RGB.C **********************

void yuv2rgb(int width, int height, unsigned char *y, unsigned char *u, unsigned char *v, unsigned char *rgb){
    int i,j;
    for(i=0; i< height; i++){
        for(j=0; j < width; j++){
			int idx = i*width + j;
			int idxUV = i/2*width/2 + j/2;

			int c = y[idx];
			int d = u[idxUV];
			int e = v[idxUV];

			c = c -16;
			d = d -128;
			e = e -128;

            *(rgb + 3*idx+0) = (unsigned char) clamp((298*c+409*e+128)>>8);
            *(rgb + 3*idx+1) = (unsigned char) clamp((298*c-100*d-208*e+128)>>8);
            *(rgb + 3*idx+2) = (unsigned char) clamp((298*c+516*d+128)>>8);

		}
    }
}


 //********************** SPLITMERGE.C **********************

void split(int nbSlice, int width, int height, unsigned char *input, unsigned char *output){
	if(output != NULL){
		int i;
		int sliceSize =  width*height/nbSlice;
		// Fill first and last line with 0
		memset(output,0,width);
		// First Slice
		memcpy(output+width, input, sliceSize);
		// Copy next line if several slice
		if (nbSlice > 1){
			memcpy(output +  width + sliceSize , input + sliceSize, width);
		}
		// Slice other than first and last
		for(i=1; i<nbSlice-1; i++){
			int destIndex = i*(sliceSize+2*width);
			memcpy(output + destIndex, input+i*sliceSize-width, sliceSize+2*width);
		}
		// Last Slice
		i = nbSlice-1;
		if(nbSlice > 1){
			// we have i = nbSlice -1;
			int destIndex = i*(sliceSize+2*width);
			memcpy(output + destIndex, input+i*sliceSize-width, sliceSize+width);
		}
		// Last line
		memset(output + (height+nbSlice*2-1)*width,0,width);
	} else {
		// Output has been splitted and is null
		// Fill first and last line with 0
		memset(input - width, 0, width);
		// Last line
		memset(input + height*width,0,width);
	}
}


void merge(int nbSlice, int width, int height, unsigned char *input, unsigned char *output){
	int i;
	int sliceSize =  width*height/nbSlice;
	// Copy the slice content except the first and last lines
	for(i = 0; i< nbSlice; i++){
		int idx = i*(sliceSize+2*width);
		memcpy(output+i*sliceSize, input+idx+width, sliceSize);
	}
}


 //********************** PPM.C **********************

void writePPM(int height, int width, unsigned char *gray){
    return;
}

void readPPMInit(int id,int height, int width) {
    return;
}

void readPPM(int id,int height, int width, unsigned char *rgbPtr){

    for(int h=0; h<height; h++){
        for(int w=0; w<width; w++){
            *(rgbPtr++)= h+1*w+10;
            *(rgbPtr++) = h+1*w+12;
            *(rgbPtr++) = h+1*w+15;
        }
    }

    printf("readPPM finished\n");

}

#endif