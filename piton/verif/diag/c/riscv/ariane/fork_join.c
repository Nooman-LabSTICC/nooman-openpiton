
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Dataflow application converted to run in OpenPiton
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "fork_join_defines.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

//Barrier descriptor
m_barrier iter_barrier;


//Core Global Definitions
//********** Core0 global definitions *****************
char Shared[120]; //  size:= 120*char
char *const Prod_0__explode_Prod_0_prod___0 = (char*) (Shared+0);  // Prod_0 > explode_Prod_0_prod_output size:= 30*char
char *const explode_Prod_0_prod_output____0 = (char*) (Shared+30);  // explode_Prod_0_prod_output > Processing_0 size:= 15*char
char *const explode_Prod_0_prod_output____1 = (char*) (Shared+45);  // explode_Prod_0_prod_output > Processing_1 size:= 15*char
char *const Processing_0__implode_Cons_0__0 = (char*) (Shared+60);  // Processing_0 > implode_Cons_0_cons_input size:= 15*char
char *const Processing_1__implode_Cons_0__0 = (char*) (Shared+75);  // Processing_1 > implode_Cons_0_cons_input size:= 15*char
char *const implode_Cons_0_cons_input__C__0 = (char*) (Shared+90);  // implode_Cons_0_cons_input > Cons_0 size:= 30*char
uchar *const prod_output__input__0 = (uchar*) (Shared+0);  // Prod_0_prod_output > explode_Prod_0_prod_output_input size:= 30*uchar
uchar *const prod_output_0__input__0 = (uchar*) (Shared+30);  // explode_Prod_0_prod_output_prod_output_0 > Processing_0_input size:= 15*uchar
uchar *const prod_output_1__input__0 = (uchar*) (Shared+45);  // explode_Prod_0_prod_output_prod_output_1 > Processing_1_input size:= 15*uchar
uchar *const output__cons_input_0__0 = (uchar*) (Shared+60);  // Processing_0_output > implode_Cons_0_cons_input_cons_input_0 size:= 15*uchar
uchar *const output__cons_input_1__0 = (uchar*) (Shared+75);  // Processing_1_output > implode_Cons_0_cons_input_cons_input_1 size:= 15*uchar
uchar *const output__cons_input__0 = (uchar*) (Shared+90);  // implode_Cons_0_cons_input_output > Cons_0_cons_input size:= 30*uchar

//********** Core1 global definitions *****************




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
		
		produce(30/*msg_size*/,prod_output__input__0); // Prod_0
		// Fork explode_Prod_0_prod_output
		{
			memcpy(prod_output_0__input__0+0, prod_output__input__0+0, 15*sizeof(uchar));
			memcpy(prod_output_1__input__0+0, prod_output__input__0+15, 15*sizeof(uchar));
		}
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____1
		sendEnd(); // Core0 > Core1: explode_Prod_0_prod_output____1
		processing(15/*slice_size*/,prod_output_0__input__0,output__cons_input_0__0); // Processing_0
		receiveStart(); // Core1 > Core0: Processing_1__implode_Cons_0__0
		// SyncComGroup = 1
		receiveEnd(1, 0); // Core1 > Core0: Processing_1__implode_Cons_0__0
		// Join implode_Cons_0_cons_input
		{
			memcpy(output__cons_input__0+0, output__cons_input_0__0+0, 15*sizeof(uchar));
			memcpy(output__cons_input__0+15, output__cons_input_1__0+0, 15*sizeof(uchar));
		}
		consume(30/*msg_size*/,output__cons_input__0); // Cons_0
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
		
		receiveStart(); // Core0 > Core1: explode_Prod_0_prod_output____1
		// SyncComGroup = 0
		receiveEnd(0, 1); // Core0 > Core1: explode_Prod_0_prod_output____1
		processing(15/*slice_size*/,prod_output_1__input__0,output__cons_input_1__0); // Processing_1
		// SyncComGroup = 1
		sendStart(1, 0); // Core1 > Core0: Processing_1__implode_Cons_0__0
		sendEnd(); // Core1 > Core0: Processing_1__implode_Cons_0__0
	}
	
}



int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    //Initializes semaphore
    communicationInit();
    barrier_init(&iter_barrier, NB_CORES); //2 is number of threads

    //Thread selection
    switch(core_id){
        case 0:
            computationThread_Core0(NULL);
            break;
        case 1:
            computationThread_Core1(NULL);
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}
