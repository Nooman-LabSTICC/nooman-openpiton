#ifndef PREESM_H
#define PREESM_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#define IN
#define OUT

typedef unsigned char uchar;

#define PREESM_LOOP_SIZE	1
#define LOOP_SIZE		PREESM_LOOP_SIZE //Compatibility issue

#define NB_CORES		4



 //********************** CONS.C **********************

void consume(int msg_size, unsigned char *cons_input){
	unsigned int sum = 0;
	static int loop_counter = 1 ;

	//printf("Begin loop\n\n");

	for(int i=0; i<msg_size; i++){
		sum += (unsigned int) cons_input[i];
		printf("%d |", cons_input[i]);
	}

	printf("Computed loop %d\n", loop_counter++);

	//printf("End loop, sum: %d\n", sum);

}

 //********************** PROD.C **********************

void produce(int msg_size, unsigned char *prod_output){
	static int loop_counter = 1 ;

	for(int i=0; i<msg_size; i++){
		prod_output[i] = i;
	}

	printf("Produced %d\n", loop_counter++);

}



 //********************** PROCESSING.C **********************

void processing(int slice_size, unsigned char *input, unsigned char *output){
	static int loop_counter = 1 ;

	//printf("\n");
	for(int i=0; i<slice_size; i++){
		//printf("%d, ", output[i]);
		output[i] = input[i] + 1;
	}

	printf("Processing %d\n", loop_counter++);
	//printf("\n");

}

#endif
