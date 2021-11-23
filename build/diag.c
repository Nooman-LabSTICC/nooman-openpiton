
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Dataflow application converted to run in OpenPiton
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "preesm_defines.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

//Barrier descriptor
m_barrier iter_barrier;


//Core Global Definitions
//********** Core0 global definitions *****************
char Shared[1680]; //  size:= 1680*char
char *const Prod_0__explode_Prod_0_prod_output__0 = (char*) (Shared + 0); // Prod_0 > explode_Prod_0_prod_output size:= 840*char
char *const explode_Prod_0_prod_output__Processing_0__0 = (char*) (Shared + 0); // explode_Prod_0_prod_output > Processing_0 size:= 120*char
char *const explode_Prod_0_prod_output__Processing_1__0 = (char*) (Shared + 120); // explode_Prod_0_prod_output > Processing_1 size:= 120*char
char *const explode_Prod_0_prod_output__Processing_2__0 = (char*) (Shared + 240); // explode_Prod_0_prod_output > Processing_2 size:= 120*char
char *const explode_Prod_0_prod_output__Processing_3__0 = (char*) (Shared + 360); // explode_Prod_0_prod_output > Processing_3 size:= 120*char
char *const explode_Prod_0_prod_output__Processing_4__0 = (char*) (Shared + 480); // explode_Prod_0_prod_output > Processing_4 size:= 120*char
char *const explode_Prod_0_prod_output__Processing_5__0 = (char*) (Shared + 600); // explode_Prod_0_prod_output > Processing_5 size:= 120*char
char *const explode_Prod_0_prod_output__Processing_6__0 = (char*) (Shared + 720); // explode_Prod_0_prod_output > Processing_6 size:= 120*char
char *const implode_Cons_0_cons_input__Cons_0__0 = (char*) (Shared + 840); // implode_Cons_0_cons_input > Cons_0 size:= 840*char
char *const Processing_0__implode_Cons_0_cons_input__0 = (char*) (Shared + 840); // Processing_0 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_1__implode_Cons_0_cons_input__0 = (char*) (Shared + 960); // Processing_1 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_2__implode_Cons_0_cons_input__0 = (char*) (Shared + 1080); // Processing_2 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_3__implode_Cons_0_cons_input__0 = (char*) (Shared + 1200); // Processing_3 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_4__implode_Cons_0_cons_input__0 = (char*) (Shared + 1320); // Processing_4 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_5__implode_Cons_0_cons_input__0 = (char*) (Shared + 1440); // Processing_5 > implode_Cons_0_cons_input size:= 120*char
char *const Processing_6__implode_Cons_0_cons_input__0 = (char*) (Shared + 1560); // Processing_6 > implode_Cons_0_cons_input size:= 120*char
unsigned char *const prod_output__input__0 = (unsigned char*) (Shared + 0); // Prod_0_prod_output > explode_Prod_0_prod_output_input size:= 840*unsigned char
unsigned char *const prod_output_0__input__0 = (unsigned char*) (Shared + 0); // explode_Prod_0_prod_output_prod_output_0 > Processing_0_input size:= 120*unsigned char
unsigned char *const prod_output_1__input__0 = (unsigned char*) (Shared + 120); // explode_Prod_0_prod_output_prod_output_1 > Processing_1_input size:= 120*unsigned char
unsigned char *const prod_output_2__input__0 = (unsigned char*) (Shared + 240); // explode_Prod_0_prod_output_prod_output_2 > Processing_2_input size:= 120*unsigned char
unsigned char *const prod_output_3__input__0 = (unsigned char*) (Shared + 360); // explode_Prod_0_prod_output_prod_output_3 > Processing_3_input size:= 120*unsigned char
unsigned char *const prod_output_4__input__0 = (unsigned char*) (Shared + 480); // explode_Prod_0_prod_output_prod_output_4 > Processing_4_input size:= 120*unsigned char
unsigned char *const prod_output_5__input__0 = (unsigned char*) (Shared + 600); // explode_Prod_0_prod_output_prod_output_5 > Processing_5_input size:= 120*unsigned char
unsigned char *const prod_output_6__input__0 = (unsigned char*) (Shared + 720); // explode_Prod_0_prod_output_prod_output_6 > Processing_6_input size:= 120*unsigned char
unsigned char *const output__cons_input__0 = (unsigned char*) (Shared + 840); // implode_Cons_0_cons_input_output > Cons_0_cons_input size:= 840*unsigned char
unsigned char *const output__cons_input_0__0 = (unsigned char*) (Shared + 840); // Processing_0_output > implode_Cons_0_cons_input_cons_input_0 size:= 120*unsigned char
unsigned char *const output__cons_input_1__0 = (unsigned char*) (Shared + 960); // Processing_1_output > implode_Cons_0_cons_input_cons_input_1 size:= 120*unsigned char
unsigned char *const output__cons_input_2__0 = (unsigned char*) (Shared + 1080); // Processing_2_output > implode_Cons_0_cons_input_cons_input_2 size:= 120*unsigned char
unsigned char *const output__cons_input_3__0 = (unsigned char*) (Shared + 1200); // Processing_3_output > implode_Cons_0_cons_input_cons_input_3 size:= 120*unsigned char
unsigned char *const output__cons_input_4__0 = (unsigned char*) (Shared + 1320); // Processing_4_output > implode_Cons_0_cons_input_cons_input_4 size:= 120*unsigned char
unsigned char *const output__cons_input_5__0 = (unsigned char*) (Shared + 1440); // Processing_5_output > implode_Cons_0_cons_input_cons_input_5 size:= 120*unsigned char
unsigned char *const output__cons_input_6__0 = (unsigned char*) (Shared + 1560); // Processing_6_output > implode_Cons_0_cons_input_cons_input_6 size:= 120*unsigned char

//********** Core1 global definitions *****************

//********** Core2 global definitions *****************

//********** Core3 global definitions *****************

//********** Core4 global definitions *****************

//********** Core5 global definitions *****************

//********** Core6 global definitions *****************

//********** Core7 global definitions *****************

//********** Core8 global definitions *****************




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg) {

  // Initialisation(s)
  printf("Starting core producer\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){
        printf("Prod start\n");
    // loop body
    produce(840/*msg_size*/, prod_output__input__0); // Prod_0
    printf("Prod end\n");
    // Fork explode_Prod_0_prod_output

    {
    }
    sendStart(0, 1); // Core0 > Core1
    sendEnd(); // Core0 > Core1
    printf("Sent to 1\n");
    sendStart(0, 2); // Core0 > Core2
    sendEnd(); // Core0 > Core2
    printf("Sent to 2\n");
    sendStart(0, 3); // Core0 > Core3
    sendEnd(); // Core0 > Core3
    printf("Sent to 3\n");
    sendStart(0, 4); // Core0 > Core4
    sendEnd(); // Core0 > Core4
    sendStart(0, 5); // Core0 > Core5
    sendEnd(); // Core0 > Core5
    sendStart(0, 6); // Core0 > Core6
    sendEnd(); // Core0 > Core6
    sendStart(0, 7); // Core0 > Core7
    sendEnd(); // Core0 > Core7
    receiveStart(); // Core1 > Core0
    receiveEnd(1, 0); // Core1 > Core0
    receiveStart(); // Core2 > Core0
    receiveEnd(2, 0); // Core2 > Core0
    receiveStart(); // Core3 > Core0
    receiveEnd(3, 0); // Core3 > Core0
    receiveStart(); // Core4 > Core0
    receiveEnd(4, 0); // Core4 > Core0
    receiveStart(); // Core5 > Core0
    receiveEnd(5, 0); // Core5 > Core0
    receiveStart(); // Core6 > Core0
    receiveEnd(6, 0); // Core6 > Core0
    receiveStart(); // Core7 > Core0
    receiveEnd(7, 0); // Core7 > Core0
    // Join implode_Cons_0_cons_input

    {
    }
    sendStart(0, 8); // Core0 > Core8
    sendEnd(); // Core0 > Core8
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core1 thread function *****************
void computationThread_Core1(void *arg) {
  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core1
    receiveEnd(0, 1); // Core0 > Core1
    processing(120/*slice_size*/, prod_output_0__input__0, output__cons_input_0__0); // Processing_0

    sendStart(1, 0); // Core1 > Core0
    sendEnd(); // Core1 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core2 thread function *****************
void computationThread_Core2(void *arg) {

  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core2
    receiveEnd(0, 2); // Core0 > Core2
    processing(120/*slice_size*/, prod_output_1__input__0, output__cons_input_1__0); // Processing_1

    sendStart(2, 0); // Core2 > Core0
    sendEnd(); // Core2 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core3 thread function *****************
void computationThread_Core3(void *arg) {

  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core3
    receiveEnd(0, 3); // Core0 > Core3
    processing(120/*slice_size*/, prod_output_2__input__0, output__cons_input_2__0); // Processing_2

    sendStart(3, 0); // Core3 > Core0
    sendEnd(); // Core3 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core4 thread function *****************
void computationThread_Core4(void *arg) {

  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core4
    receiveEnd(0, 4); // Core0 > Core4
    processing(120/*slice_size*/, prod_output_3__input__0, output__cons_input_3__0); // Processing_3

    sendStart(4, 0); // Core4 > Core0
    sendEnd(); // Core4 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core5 thread function *****************
void computationThread_Core5(void *arg) {


  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core5
    receiveEnd(0, 5); // Core0 > Core5
    processing(120/*slice_size*/, prod_output_4__input__0, output__cons_input_4__0); // Processing_4

    sendStart(5, 0); // Core5 > Core0
    sendEnd(); // Core5 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core6 thread function *****************
void computationThread_Core6(void *arg) {

  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core6
    receiveEnd(0, 6); // Core0 > Core6
    processing(120/*slice_size*/, prod_output_5__input__0, output__cons_input_5__0); // Processing_5

    sendStart(6, 0); // Core6 > Core0
    sendEnd(); // Core6 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core7 thread function *****************
void computationThread_Core7(void *arg) {

  // Initialisation(s)
  printf("Starting core\n");


  // Begin the execution loop
  //barrier_wait(&iter_barrier);
	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core7
    receiveEnd(0, 7); // Core0 > Core7
    processing(120/*slice_size*/, prod_output_6__input__0, output__cons_input_6__0); // Processing_6

    sendStart(7, 0); // Core7 > Core0
    sendEnd(); // Core7 > Core0
    // loop footer
    //barrier_wait(&iter_barrier);

  }

}

//********** Core8 thread function *****************
void computationThread_Core8(void *arg) {

  // Initialisation(s)
  printf("Starting core\n");

  // Begin the execution loop
  //barrier_wait(&iter_barrier);

	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){

    // loop body
    receiveStart(); // Core0 > Core8
    receiveEnd(0, 8); // Core0 > Core8
    consume(840/*msg_size*/, output__cons_input__0); // Cons_0


    // loop footer
    //barrier_wait(&iter_barrier);

  }

}



int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    printf("Hello world\n");

    //Initializes semaphore
    communicationInit();
    barrier_init(&iter_barrier, NB_CORES); //9 is number of threads

    //Thread selection
    switch(core_id){
        case 0:
            computationThread_Core0(NULL);
            break;
        case 1:
            computationThread_Core1(NULL);
            break;
        case 2:
            computationThread_Core2(NULL);
            break;
        case 3:
            computationThread_Core3(NULL);
            break;
        case 4:
            computationThread_Core4(NULL);
            break;
        case 5:
            computationThread_Core5(NULL);
            break;
        case 6:
            computationThread_Core6(NULL);
            break;
        case 7:
            computationThread_Core7(NULL);
            break;
        case 8:
            computationThread_Core8(NULL);
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}
