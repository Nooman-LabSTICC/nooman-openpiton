#ifndef PREESM_H
#define PREESM_H


#include <string.h>
#include <stdlib.h>
#include <stdio.h>
//#include <math.h>


#define IN
#define OUT

#define stopThreads 0

typedef unsigned char uchar;

#define PREESM_LOOP_SIZE	1
#define LOOP_SIZE		PREESM_LOOP_SIZE //Compatibility issue

#define NB_CORES		4

/**
* Define the color of the black background for rendered frames.
*/
#define BG_BLACK_Y 0
#define BG_BLACK_U 128
#define BG_BLACK_V 128

#define PI (3.141592653589793f)

#define NB_DISPLAY 1
#define DISPLAY_W (2*BORDER+WIDTH)*NB_DISPLAY
#define DISPLAY_H (2*BORDER+HEIGHT)


#define HIGH_PASS_FILTER_TAP 1

#define INIT_OVERLAY {NULL} // must be se same size as NB_DISPLAY

/**
* MIN and MAX macro to lighten code.
*/
#define MIN(x,y) ((x>y)? y:x)
#define MAX(x,y) ((x>y)? x:y)


typedef struct coord {
	int x; //!< Abscissa
	int y; //!< Ordinate
} coord;

/**
* Structure used to store 2D coordinates as floats.
* These coordinates are stored as float to avoid accumlating rounding errors
* when computing cumulated motion and average motion vectors.
*/
typedef struct coordf {
	float x; //!< Abscissa
	float y; //!< Ordinate
} coordf;

/*
* Structure used to store two by two matrices with float coefficients.
*/
typedef struct matrix {
	float coeffs[2 * 2];
} matrix;


 //********************** YUVREAD.C **********************

void initReadYUV(int width, int height) {

}

/*========================================================================

   readYUV DEFINITION

   ======================================================================*/
void readYUV(int width, int height, unsigned char *y, unsigned char *u, unsigned char *v) {

	int counter = 0;
	//Fake values
	for(int h=0; h<height; h++){
		for(int w=0; w<height; w++){
			*(y+counter)= h+1*w+10;
			*(u+counter) = h+1*w+12;
			*(v+counter) = h+1*w+15;
			counter++;
		}
	}

    printf("readPPM finished\n");
}

void endYUVRead(){
}

 //********************** MATRIX.C **********************

void meanVector(const unsigned int nbVector, const coord * const vectors,
				coordf * const mean){
	long x = 0, y = 0;
	const coord * vec = vectors;
	for (; vec < vectors + nbVector; vec++){
		x += vec->x;
		y += vec->y;
	}

	mean->x = x / (float)nbVector;
	mean->y = y / (float)nbVector;
}

void covarianceMatrix2D(const unsigned int nbVector, const coord * const vectors,
						const coordf * const mean, matrix * const sigma){

	int x[nbVector];
	int y[nbVector];
    unsigned int i ;
    unsigned int c;
	// Substract mean to all vectors
	for (i = 0; i < nbVector; i++){
		x[i] = (vectors + i)->x - mean->x;
		y[i] = (vectors + i)->y - mean->y;
	}

	// Compute Sigma
	// sigma(row,col) = temp(row)' * temp(col)
	sigma->coeffs[0] = 0.0;
	sigma->coeffs[1] = 0.0;
	sigma->coeffs[2] = 0.0;
	sigma->coeffs[3] = 0.0;
	for (c = 0; c < nbVector; c++){
		sigma->coeffs[0] += x[i] * c;
		sigma->coeffs[1] += y[i] * c;
		// sigma->coeffs[2] += equal to coeffs[1]
		sigma->coeffs[3] += y[i] * x[i];
	}

	// mean
	sigma->coeffs[0] /= (nbVector - 1);
	sigma->coeffs[1] /= (nbVector - 1);
	sigma->coeffs[2] = sigma->coeffs[1];
	sigma->coeffs[3] /= (nbVector - 1);

}

void inverseMatrix2D(const matrix * const mat, matrix * const invMat){
	float detMat = mat->coeffs[0] * mat->coeffs[3] - mat->coeffs[2] * mat->coeffs[1];

	invMat->coeffs[0] = mat->coeffs[3] / detMat;
	invMat->coeffs[1] = -mat->coeffs[1] / detMat;
	invMat->coeffs[2] = -mat->coeffs[2] / detMat;
	invMat->coeffs[3] = mat->coeffs[0] / detMat;
}

void getProbabilities(const unsigned int nbVector, const coord * const vectors,
					  const coordf * const mean, matrix * const sigma, float * proba){
	// Compute sigma determinant and inverse
	float detSigma = sigma->coeffs[0] * sigma->coeffs[3] - sigma->coeffs[2] * sigma->coeffs[1];
	matrix invSigma;

	// If the multivariate gaussian can be computed.
	if (detSigma > 0.0f){
		inverseMatrix2D(sigma, &invSigma);

		// pre compute denominator
		const float divisor = 1.0f / /*sqrtf(4.0f **/ PI * PI * detSigma;
		unsigned int i ;

		// Loop over the vectors to compute probability
		for (i= 0; i < nbVector; i++){
			const coord *vec = vectors + i;
			// Substract mean value
			float tX = vec->x - mean->x;
			float tY = vec->y - mean->y;

			// multiply by invSigma
			float sigmaTX = invSigma.coeffs[0] * tX + invSigma.coeffs[2] * tY;
			float sigmaTY = invSigma.coeffs[1] * tX + invSigma.coeffs[3] * tY;

			// Proba
			//*(proba + i) = expf(-((tX*sigmaTX) + (tY*sigmaTY)) / 2) * divisor;
			*(proba + i) = -((tX*sigmaTX) + (tY*sigmaTY)) / 2 * divisor;
		}
	}
	// If the multivariata gaussian cannot be computed
	else {
		// Find the dimension of the two dimensions that has a null variance.
		const int dimension = (sigma->coeffs[0] == 0.0 && sigma->coeffs[3] == 0.0) ?
			0 : ((sigma->coeffs[0] == 0.0) ? 1 : 2);

		// compute the probabilities for the dimension with non zero variance (if any).
		if (dimension == 0){
                unsigned int i;
			// all vectors are identical
			for (i = 0; i < nbVector; i++){
				proba[i] = 1.0;
			}
		}
		else {
			// keep variance
			const float var = (dimension == 2) ? sigma->coeffs[0] : sigma->coeffs[3];
			// pre compute denominator
			const float divisor = 1.0f / /*(sqrtf(2.0f **/ PI * var;

			// Loop over the vectors to compute probability
			unsigned int i;
			for (i = 0; i < nbVector; i++){
				float val = (dimension == 2) ? vectors[i].x - mean->x : vectors[i].y - mean->y;
				//proba[i] = expf(-(val*val) / (2 * var))*divisor;
				proba[i] = -(val*val) / (2 * var)*divisor;
			}
		}
	}
}


 //********************** STABILIZATION.C **********************

void renderFrame(const int frameWidth, const int frameHeight,
	const int dispWidth, const int dispHeight,
	const coordf * const delta,
	const coordf * const deltaPrev,
	const unsigned char * const yIn, const unsigned char * const uIn, const unsigned char * const vIn,
	const unsigned char * const yPrev, const unsigned char * const uPrev, const unsigned char * const vPrev,
	unsigned char * const yOut, unsigned char * const uOut, unsigned char * const vOut){

	// Set the background color
	memset(yOut, BG_BLACK_Y, (size_t)(dispWidth) * (size_t)(dispHeight));
	memset(uOut, BG_BLACK_U, (size_t)(dispWidth) * (size_t)(dispHeight) / 4);
	memset(vOut, BG_BLACK_V, (size_t)(dispWidth) * (size_t)(dispHeight) / 4);

	// Create the fading ghost of previous frame

	// find position
	int deltaPrevX = (int)(deltaPrev->x)*2; // Multiply by 2 for Y
	int deltaPrevY = (int)(deltaPrev->y)*2;
	int xPrevLeft = MIN(MAX(0, -deltaPrevX), dispWidth);
	int yPrevTop = MIN(MAX(0, -deltaPrevY), dispHeight);
	int xPrevRight = MIN(dispWidth, dispWidth - deltaPrevX);
	int yPrevBot = MIN(dispHeight, dispHeight - deltaPrevY);

	static int first = 1;

    if (first) {
        first = 0;
    } else {
        // Render Ghost
        int lineLengthGhost = xPrevRight - xPrevLeft;
        for (int y = yPrevTop; y < yPrevBot; ++y){
            // Y Ghost Rendering
            for (int x = xPrevLeft; x < xPrevLeft + lineLengthGhost; ++x) {
                *(yOut + y * dispWidth + x) = *(yPrev + (y + deltaPrevY)*dispWidth + (x + deltaPrevX)) * HIGH_PASS_FILTER_TAP;
            }
            // UV Ghost Rendering
            memcpy(uOut + (y / 2) * (dispWidth / 2) + xPrevLeft / 2, uPrev + ((y + deltaPrevY) / 2) * (dispWidth / 2) + (xPrevLeft + deltaPrevX) / 2, (xPrevRight - xPrevLeft) / 2);
            memcpy(vOut + (y / 2) * (dispWidth / 2) + xPrevLeft / 2, vPrev + ((y + deltaPrevY) / 2) * (dispWidth / 2) + (xPrevLeft + deltaPrevX) / 2, (xPrevRight - xPrevLeft) / 2);
        }
    }

	// Compute the position of the rendered frame
	// top-left (first pixel position)
	int xLeft = dispWidth / 2 - frameWidth / 2 + (int)(delta->x);
	int yTop = dispHeight / 2 - frameHeight / 2 + (int)(delta->y);
	// bottom right corner (last pixel position +(1,1))
	int xRight = xLeft + frameWidth;
	int yBot = yTop + frameHeight;

	// Clip previous values to stay within the rendered frame
	int xLeftClip = MAX(MIN(xLeft, dispWidth), 0);
	int yTopClip = MAX(MIN(yTop, dispHeight), 0);
	int xRightClip = MIN(MAX(xRight, 0), dispWidth);
	int yBotClip = MIN(MAX(yBot, 0), dispHeight);

	for (int y = yTopClip; y < yBotClip; y++){
        // Render Y
		memcpy(yOut + y * dispWidth + xLeftClip, yIn + (y - yTop) * frameWidth + (xLeftClip - xLeft), xRightClip - xLeftClip);

        // Render UV
        memcpy(uOut + (y / 2) * (dispWidth / 2) + xLeftClip / 2, uIn + (y - yTop) / 2 * (frameWidth / 2) + (xLeftClip - xLeft) / 2, (xRightClip - xLeftClip) / 2);
        memcpy(vOut + (y / 2) * (dispWidth / 2) + xLeftClip / 2, vIn + (y - yTop) / 2 * (frameWidth / 2) + (xLeftClip - xLeft) / 2, (xRightClip - xLeftClip) / 2);
	}
}

void divideBlocks(const int width, const int height,
	const int blockWidth, const int blockHeight,
	const unsigned char * const frame,
	coord * const blocksCoord,
	unsigned char * const blocksData){
	const int blocksPerLine = width / blockWidth;
	const int blockSize = blockHeight*blockWidth;
	// Raster scan blocks
	int x, y;
	for (y = 0; y < height / blockHeight; y++){
		for (x = 0; x < blocksPerLine; x++){
			coord * blockCoord = blocksCoord + y*(blocksPerLine)+x;
			unsigned char * blockData = blocksData + (y*(blocksPerLine)+x)*blockSize;
			int line;
			blockCoord->x = x*blockWidth;
			blockCoord->y = y*blockHeight;
			// Copy block lines in output
			for (line = 0; line < blockHeight; line++){
				memcpy(blockData + line * blockWidth, frame + (y*blockHeight + line)*width + x*blockWidth, blockWidth);
			}
		}
	}
}

unsigned int computeMeanSquaredError(const int width, const int height,
	const int blockWidth, const int blockHeight,
	const int deltaX, const int deltaY,
	const coord * blockCoord,
	const unsigned char * const blockData,
	const unsigned char * const previousFrame){
	// Clip previous values to stay within the previousFrame
	int yMinClip = MIN(MAX(0 - deltaY, 0), blockHeight);
	int xMinClip = MIN(MAX(0 - deltaX, 0), blockWidth);
	int yMaxClip = MAX(MIN(height - deltaY, blockHeight), 0);
	int xMaxClip = MAX(MIN(width - deltaX, blockWidth), 0);

	// Compute MSE
	unsigned int cost;

	// At least half of the block must be matched within previous frame to
	// consider the cost as valid (otherwise, a small number of pixel might
	// get "lucky" and get a low cost).
	int matchedSize = (yMaxClip - yMinClip)*(xMaxClip - xMinClip);
	if (matchedSize < blockHeight*blockWidth / 2) {
		cost = 0xffffffff;
	}
	else {
		cost = 0;
		int y, x;
		for (y = yMinClip; y < yMaxClip; y++){
			for (x = xMinClip; x < xMaxClip; x++){
				const unsigned char pixBlock = *(blockData + y*blockWidth + x);
				const unsigned char pixFrame = *(previousFrame + (deltaY * width + deltaX) + y * width + x);
				// Squared error
				short diff = pixFrame - pixBlock;
				cost += diff*diff;
			}
		}
		// Mean
		cost /= matchedSize;
	}

	return cost;
}

void computeBlockMotionVector(const int width, const int height,
	const int blockWidth, const int blockHeight,
	const int maxDeltaX, const int maxDeltaY,
	const coord * const blockCoord, const unsigned char * const blockData,
	const unsigned char * const previousFrame,
	coord * const vector){
	// Compute neighboorhood start positions
	// Top-left
	int deltaYTop = blockCoord->y - maxDeltaY;
	int deltaXLeft = blockCoord->x - maxDeltaX;
	// Bottom-right +(1,1)
	int deltaYBot = blockCoord->y + maxDeltaY;
	int deltaXRight = blockCoord->x + maxDeltaX;

	// Initialize MMSE search
	unsigned int minCost = 0xffffffff;
	vector->x = 0;
	vector->y = 0;
	// Raster scan neighborhood
	int deltaY, deltaX;
	for (deltaY = deltaYTop; deltaY < deltaYBot; deltaY++){
		for (deltaX = deltaXLeft; deltaX < deltaXRight; deltaX++){
			// Compute MSE
			unsigned int cost = computeMeanSquaredError(width, height,
				blockWidth, blockHeight,
				deltaX, deltaY,
				blockCoord,
				blockData, previousFrame);

			// Minimizes MSE
			if (cost < minCost){
				minCost = cost;
				vector->x = deltaX - blockCoord->x;
				vector->y = deltaY - blockCoord->y;
			}
		}
	}
}

void computeBlockMotionVectors(const int width, const int height,
	const int blockWidth, const int blockHeight,
	const int maxDeltaX, const int maxDeltaY,
	const unsigned char * const frame, const unsigned char * const previousFrame,
	coord * const vectors){
	// Useful constant
	const int blocksPerLine = width / blockWidth;
	const int nbBlocks = ((width / blockWidth)*(height / blockHeight));
	const int blockSize = blockHeight*blockWidth;

	// Divide into blocks
	coord blocksCoord[nbBlocks];
	//blocksCoord = malloc(nbBlocks*sizeof(coord));
	unsigned char blocksData[nbBlocks*blockSize];
	//blocksData = malloc(nbBlocks*blockSize*sizeof(unsigned char));
	divideBlocks(width, height, blockWidth, blockHeight, frame, blocksCoord, blocksData);

	// Process the blocks one by one
	int blY;
	for (blY = 0; blY < (height / blockHeight); blY++){
		int blX;
		for (blX = 0; blX < (width / blockWidth); blX++){
			const unsigned char * const blockData = blocksData + (blY*blocksPerLine + blX)*blockSize;
			const coord * const blockCoord = blocksCoord + blY*blocksPerLine + blX;
			computeBlockMotionVector(width, height,
				blockWidth, blockHeight,
				maxDeltaX, maxDeltaY,
				blockCoord,
				blockData, previousFrame,
				vectors + blY*blocksPerLine + blX);
		}
	}

	// Free blocks memory
	//free(blocksCoord);
	//free(blocksData);
}



void findDominatingMotionVector(const int nbVectors,
	const coord * const vectors, coordf * const dominatingVector){
	static int first = 0;

	if (first == 0){
		first = 1;
		dominatingVector->x = 0;
		dominatingVector->y = 0;
	}
	else {
		// Compute multivariate gaussian parameters
		coordf mean;
		matrix sigma;
		meanVector(nbVectors, vectors, &mean);
		covarianceMatrix2D(nbVectors, vectors, &mean, &sigma);


		// Keep only the vectors with the highest probability
		// (criteria is a probability threshold, but a fixed number of vectors
		// could be used instead)
		float probas[nbVectors];// = malloc(nbVectors*sizeof(nbVectors));
		getProbabilities(nbVectors, vectors, &mean, &sigma, probas);

		// Keep the mean of most probable vectors
		// find max proba
		float threshold = 0.0f;
		int i;
		for (i = 0; i < nbVectors; i++){
			threshold = MAX(threshold, probas[i]);
		}

		// Lower thresold
		threshold *= 2.0f / 3.0f;
		dominatingVector->x = 0.0f;
		dominatingVector->y = 0.0f;
		int nbAbove = 0;
		for (i = 0; i < nbVectors; i++){
			if (probas[i] > threshold){
				nbAbove++;
				dominatingVector->x += vectors[i].x;
				dominatingVector->y += vectors[i].y;
			}
		}
		dominatingVector->x /= (float)nbAbove;
		dominatingVector->y /= (float)nbAbove;


		// Cleanup
		//free(probas);
	}
}

void accumulateMotion(IN const coordf * const motionVector, IN const coordf * const accumulatedMotionIn,
						   IN coordf * const filteredMotionIn,
						   OUT coordf * const filteredMotionOut, OUT coordf * const accumulatedMotionOut) {

	// Compute filtered motion
	filteredMotionOut->x = filteredMotionIn->x -(filteredMotionIn->x);
	filteredMotionOut->y = filteredMotionIn->y -(filteredMotionIn->y);
	filteredMotionOut->x = filteredMotionOut->x + (accumulatedMotionIn->x * (1.0f - HIGH_PASS_FILTER_TAP)) / 2.0f;
	filteredMotionOut->y = filteredMotionOut->y + (accumulatedMotionIn->y * (1.0f - HIGH_PASS_FILTER_TAP)) /2.0f;

	// Apply filter
	accumulatedMotionOut->x = accumulatedMotionIn->x * HIGH_PASS_FILTER_TAP;
	accumulatedMotionOut->y = accumulatedMotionIn->y * HIGH_PASS_FILTER_TAP;

	// Accumulate new motion vector
	accumulatedMotionOut->x += motionVector->x;
	accumulatedMotionOut->y += motionVector->y;
}

 //********************** YUVWRITE.C **********************

void initYUVWrite(){
}

void yuvWrite(const int width, const int height, const unsigned char * const y, const unsigned char * const u, const unsigned char * const v){
}


void endYUVWrite(){
}
 //********************** YUVDISPLAY.C **********************


/**
* Initializes a display frame. Be careful, once a window size has been chosen,
* all videos must share the same window size
*
* @param id display unique identifier
* @param width width
* @param height heigth
*/
void yuvDisplayInit(int id, int width, int height)
{
	return;
}

void yuvDisplay(int id, unsigned char *y, unsigned char *u, unsigned char *v){
	return;
}

void yuvDisplayWithNbSlice(int id, int nbSlice, unsigned char *y, unsigned char *u, unsigned char *v)
{
	return;
}


void yuvFinalize(int id)
{
	return;
}

#endif
