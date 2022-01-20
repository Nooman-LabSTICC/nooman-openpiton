
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Dataflow application converted to run in OpenPiton
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "synParallel.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

//Barrier descriptor
m_barrier iter_barrier;


//Core Global Definitions
//********** Core0 global definitions *****************
char Shared[1680]; //  size:= 1680*char
char *const Prod_0__explode_Prod_0_prod___0 = (char*) (Shared+0);  // Prod_0 > explode_Prod_0_prod_output size:= 840*char
char *const explode_Prod_0_prod_output____0 = (char*) (Shared+0);  // explode_Prod_0_prod_output > Processing_0 size:= 120*char
char *const explode_Prod_0_prod_output____1 = (char*) (Shared+120);  // explode_Prod_0_prod_output > Processing_1 size:= 120*char
char *const explode_Prod_0_prod_output____2 = (char*) (Shared+240);  // explode_Prod_0_prod_output > Processing_2 size:= 120*char
char *const explode_Prod_0_prod_output____3 = (char*) (Shared+360);  // explode_Prod_0_prod_output > Processing_3 size:= 120*char
char *const explode_Prod_0_prod_output____4 = (char*) (Shared+480);  // explode_Prod_0_prod_output > Processing_4 size:= 120*char
char *const explode_Prod_0_prod_output____5 = (char*) (Shared+600);  // explode_Prod_0_prod_output > Processing_5 size:= 120*char
char *const explode_Prod_0_prod_output____6 = (char*) (Shared+720);  // explode_Prod_0_prod_output > Processing_6 size:= 120*char
char *const implode_Cons_0_cons_input__C__0 = (char*) (Shared+840);  // implode_Cons_0_cons_input > Cons_0 size:= 840*char
char *const Processing_0__implode_Cons_0__0 = (char*) (Shared+840);  // Processing_0 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_1__implode_Cons_0__0 = (char*) (Shared+960);  // Processing_1 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_2__implode_Cons_0__0 = (char*) (Shared+1080);  // Processing_2 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_3__implode_Cons_0__0 = (char*) (Shared+1200);  // Processing_3 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_4__implode_Cons_0__0 = (char*) (Shared+1320);  // Processing_4 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_5__implode_Cons_0__0 = (char*) (Shared+1440);  // Processing_5 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_6__implode_Cons_0__0 = (char*) (Shared+1560);  // Processing_6 > implode_Cons_0_cons_input size:= 120*char
unsigned char *const prod_output__input__0 = (unsigned char*) (Shared+0);  // Prod_0_prod_output > explode_Prod_0_prod_output_input size:= 840*unsigned char
unsigned char *const prod_output_0__input__0 = (unsigned char*) (Shared+0);  // explode_Prod_0_prod_output_prod_output_0 > Processing_0_input size:= 120*unsigned char
unsigned char *const prod_output_1__input__0 = (unsigned char*) (Shared+120);  // explode_Prod_0_prod_output_prod_output_1 > Processing_1_input size:= 120*unsigned char
unsigned char *const prod_output_2__input__0 = (unsigned char*) (Shared+240);  // explode_Prod_0_prod_output_prod_output_2 > Processing_2_input size:= 120*unsigned char
unsigned char *const prod_output_3__input__0 = (unsigned char*) (Shared+360);  // explode_Prod_0_prod_output_prod_output_3 > Processing_3_input size:= 120*unsigned char
unsigned char *const prod_output_4__input__0 = (unsigned char*) (Shared+480);  // explode_Prod_0_prod_output_prod_output_4 > Processing_4_input size:= 120*unsigned char
unsigned char *const prod_output_5__input__0 = (unsigned char*) (Shared+600);  // explode_Prod_0_prod_output_prod_output_5 > Processing_5_input size:= 120*unsigned char
unsigned char *const prod_output_6__input__0 = (unsigned char*) (Shared+720);  // explode_Prod_0_prod_output_prod_output_6 > Processing_6_input size:= 120*unsigned char
unsigned char *const output__cons_input__0 = (unsigned char*) (Shared+840);  // implode_Cons_0_cons_input_output > Cons_0_cons_input size:= 840*unsigned char
unsigned char *const output__cons_input_0__0 = (unsigned char*) (Shared+840);  // Processing_0_output > implode_Cons_0_cons_input_cons_input_0 size:= 120*unsigned char
unsigned char *const output__cons_input_1__0 = (unsigned char*) (Shared+960);  // Processing_1_output > implode_Cons_0_cons_input_cons_input_1 size:= 120*unsigned char
unsigned char *const output__cons_input_2__0 = (unsigned char*) (Shared+1080);  // Processing_2_output > implode_Cons_0_cons_input_cons_input_2 size:= 120*unsigned char
unsigned char *const output__cons_input_3__0 = (unsigned char*) (Shared+1200);  // Processing_3_output > implode_Cons_0_cons_input_cons_input_3 size:= 120*unsigned char
unsigned char *const output__cons_input_4__0 = (unsigned char*) (Shared+1320);  // Processing_4_output > implode_Cons_0_cons_input_cons_input_4 size:= 120*unsigned char
unsigned char *const output__cons_input_5__0 = (unsigned char*) (Shared+1440);  // Processing_5_output > implode_Cons_0_cons_input_cons_input_5 size:= 120*unsigned char
unsigned char *const output__cons_input_6__0 = (unsigned char*) (Shared+1560);  // Processing_6_output > implode_Cons_0_cons_input_cons_input_6 size:= 120*unsigned char

//********** Core1 global definitions *****************

//********** Core2 global definitions *****************

//********** Core3 global definitions *****************




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		produce(840/*msg_size*/,prod_output__input__0); // Prod_0
		// Fork explode_Prod_0_prod_output
		{
		}
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____0
		sendEnd(); // Core0 > Core1: explode_Prod_0_prod_output____0
		// SyncComGroup = 0
		sendStart(0, 2); // Core0 > Core2: explode_Prod_0_prod_output____1
		sendEnd(); // Core0 > Core2: explode_Prod_0_prod_output____1
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____2
		sendEnd(); // Core0 > Core1: explode_Prod_0_prod_output____2
		// SyncComGroup = 0
		sendStart(0, 2); // Core0 > Core2: explode_Prod_0_prod_output____3
		sendEnd(); // Core0 > Core2: explode_Prod_0_prod_output____3
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____4
		sendEnd(); // Core0 > Core1: explode_Prod_0_prod_output____4
		// SyncComGroup = 0
		sendStart(0, 2); // Core0 > Core2: explode_Prod_0_prod_output____5
		sendEnd(); // Core0 > Core2: explode_Prod_0_prod_output____5
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____6
		sendEnd(); // Core0 > Core1: explode_Prod_0_prod_output____6
		receiveStart(); // Core1 > Core0: Processing_0__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(1, 0); // Core1 > Core0: Processing_0__implode_Cons_0__0
		receiveStart(); // Core2 > Core0: Processing_1__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(2, 0); // Core2 > Core0: Processing_1__implode_Cons_0__0
		receiveStart(); // Core1 > Core0: Processing_2__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(1, 0); // Core1 > Core0: Processing_2__implode_Cons_0__0
		receiveStart(); // Core2 > Core0: Processing_3__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(2, 0); // Core2 > Core0: Processing_3__implode_Cons_0__0
		receiveStart(); // Core1 > Core0: Processing_4__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(1, 0); // Core1 > Core0: Processing_4__implode_Cons_0__0
		receiveStart(); // Core2 > Core0: Processing_5__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(2, 0); // Core2 > Core0: Processing_5__implode_Cons_0__0
		receiveStart(); // Core1 > Core0: Processing_6__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(1, 0); // Core1 > Core0: Processing_6__implode_Cons_0__0
		// Join implode_Cons_0_cons_input
		{
		}
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: implode_Cons_0_cons_input__C__0
		sendEnd(); // Core0 > Core3: implode_Cons_0_cons_input__C__0
	}
}

//********** Core1 thread function *****************
void computationThread_Core1(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		receiveStart(); // Core0 > Core1: explode_Prod_0_prod_output____0
		// SyncComGroup = 0
		receiveEnd(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____0
		processing(120/*slice_size*/,prod_output_0__input__0,output__cons_input_0__0); // Processing_0
		// SyncComGroup = 1
		sendStart(1, 0); // Core1 > Core0: Processing_0__implode_Cons_0__0
		sendEnd(); // Core1 > Core0: Processing_0__implode_Cons_0__0
		receiveStart(); // Core0 > Core1: explode_Prod_0_prod_output____2
		// SyncComGroup = 2
		receiveEnd(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____2
		processing(120/*slice_size*/,prod_output_2__input__0,output__cons_input_2__0); // Processing_2
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Processing_2__implode_Cons_0__0
		sendEnd(); // Core1 > Core0: Processing_2__implode_Cons_0__0
		receiveStart(); // Core0 > Core1: explode_Prod_0_prod_output____4
		// SyncComGroup = 4
		receiveEnd(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____4
		processing(120/*slice_size*/,prod_output_4__input__0,output__cons_input_4__0); // Processing_4
		// SyncComGroup = 5
		sendStart(1, 0); // Core1 > Core0: Processing_4__implode_Cons_0__0
		sendEnd(); // Core1 > Core0: Processing_4__implode_Cons_0__0
		receiveStart(); // Core0 > Core1: explode_Prod_0_prod_output____6
		// SyncComGroup = 6
		receiveEnd(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____6
		processing(120/*slice_size*/,prod_output_6__input__0,output__cons_input_6__0); // Processing_6
		// SyncComGroup = 7
		sendStart(1, 0); // Core1 > Core0: Processing_6__implode_Cons_0__0
		sendEnd(); // Core1 > Core0: Processing_6__implode_Cons_0__0
	}
}

//********** Core2 thread function *****************
void computationThread_Core2(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		receiveStart(); // Core0 > Core2: explode_Prod_0_prod_output____1
		// SyncComGroup = 0
		receiveEnd(0, 2); // Core0 > Core2: explode_Prod_0_prod_output____1
		processing(120/*slice_size*/,prod_output_1__input__0,output__cons_input_1__0); // Processing_1
		// SyncComGroup = 1
		sendStart(2, 0); // Core2 > Core0: Processing_1__implode_Cons_0__0
		sendEnd(); // Core2 > Core0: Processing_1__implode_Cons_0__0
		receiveStart(); // Core0 > Core2: explode_Prod_0_prod_output____3
		// SyncComGroup = 2
		receiveEnd(0, 2); // Core0 > Core2: explode_Prod_0_prod_output____3
		processing(120/*slice_size*/,prod_output_3__input__0,output__cons_input_3__0); // Processing_3
		// SyncComGroup = 3
		sendStart(2, 0); // Core2 > Core0: Processing_3__implode_Cons_0__0
		sendEnd(); // Core2 > Core0: Processing_3__implode_Cons_0__0
		receiveStart(); // Core0 > Core2: explode_Prod_0_prod_output____5
		// SyncComGroup = 4
		receiveEnd(0, 2); // Core0 > Core2: explode_Prod_0_prod_output____5
		processing(120/*slice_size*/,prod_output_5__input__0,output__cons_input_5__0); // Processing_5
		// SyncComGroup = 5
		sendStart(2, 0); // Core2 > Core0: Processing_5__implode_Cons_0__0
		sendEnd(); // Core2 > Core0: Processing_5__implode_Cons_0__0
	}
}

//********** Core3 thread function *****************
void computationThread_Core3(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		receiveStart(); // Core0 > Core3: implode_Cons_0_cons_input__C__0
		// SyncComGroup = 0
		receiveEnd(0, 3); // Core0 > Core3: implode_Cons_0_cons_input__C__0
		consume(840/*msg_size*/,output__cons_input__0); // Cons_0
	}
}



int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    //Initializes semaphore
    communicationInit();
    barrier_init(&iter_barrier, NB_CORES); //4 is number of threads

    //Thread selection
    switch(core_id){
        case 0:
            printf("Core 0 starting\n");
            computationThread_Core0(NULL);
            printf("Core 0 terminated\n");
            break;
        case 1:
            printf("Core 1 starting\n");
            computationThread_Core1(NULL);
            printf("Core 1 terminated\n");
            break;
        case 2:
            printf("Core 2 starting\n");
            computationThread_Core2(NULL);
            printf("Core 2 terminated\n");
            break;
        case 3:
            printf("Core 3 starting\n");
            computationThread_Core3(NULL);
            printf("Core 3 terminated\n");
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}
