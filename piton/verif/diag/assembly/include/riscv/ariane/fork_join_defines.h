#ifndef PREESM_H
#define PREESM_H

#define IN
#define OUT

typedef unsigned char uchar;

#define PREESM_LOOP_SIZE	3
#define LOOP_SIZE			PREESM_LOOP_SIZE //Compatibility issue

#define NB_CORES		2


//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************
//********************** CONS.C **********************

void consume(int msg_size, unsigned char *cons_input){
	volatile unsigned char i;
	unsigned int sum = 0;

	printf("Begin loop\n\n");

	for(i=0; i<msg_size; i++){
		sum += (unsigned int) cons_input[i];
		printf("%d |", cons_input[i]);
	}

	printf("End loop, sum: %d\n", sum);

}
//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************
//********************** PROD.C **********************

void produce(int msg_size, unsigned char *prod_output){
	volatile unsigned char i;

	for(i=0; i<msg_size; i++){
		prod_output[i] = i;
	}

}


//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************
//********************** PROCESSING.C **********************

void processing(int slice_size, unsigned char *input, unsigned char *output){
	int i;
	//printf("\n");
	for(i=0; i<slice_size; i++){
		//printf("%d, ", output[i]);
		output[i] = input[i] + 1;
	}
	//printf("\n");

}

#endif