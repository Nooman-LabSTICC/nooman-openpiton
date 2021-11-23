
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
char Shared[512]; //  size:= 512*char
char *const Prod_0__explode_Prod_0_prod_output__0 = (char*) (Shared + 0); // Prod_0 > explode_Prod_0_prod_output size:= 256*char
char *const explode_Prod_0_prod_output__Processing_0__0 = (char*) (Shared + 0); // explode_Prod_0_prod_output > Processing_0 size:= 128*char
char *const explode_Prod_0_prod_output__Processing_1__0 = (char*) (Shared + 128); // explode_Prod_0_prod_output > Processing_1 size:= 128*char
char *const implode_Cons_0_cons_input__Cons_0__0 = (char*) (Shared + 256); // implode_Cons_0_cons_input > Cons_0 size:= 256*char
char *const Processing_0__implode_Cons_0_cons_input__0 = (char*) (Shared + 256); // Processing_0 > implode_Cons_0_cons_input size:= 128*char
char *const Processing_1__implode_Cons_0_cons_input__0 = (char*) (Shared + 384); // Processing_1 > implode_Cons_0_cons_input size:= 128*char
unsigned char *const prod_output__input__0 = (unsigned char*) (Shared + 0); // Prod_0_prod_output > explode_Prod_0_prod_output_input size:= 256*unsigned char
unsigned char *const prod_output_0__input__0 = (unsigned char*) (Shared + 0); // explode_Prod_0_prod_output_prod_output_0 > Processing_0_input size:= 128*unsigned char
unsigned char *const prod_output_1__input__0 = (unsigned char*) (Shared + 128); // explode_Prod_0_prod_output_prod_output_1 > Processing_1_input size:= 128*unsigned char
unsigned char *const output__cons_input__0 = (unsigned char*) (Shared + 256); // implode_Cons_0_cons_input_output > Cons_0_cons_input size:= 256*unsigned char
unsigned char *const output__cons_input_0__0 = (unsigned char*) (Shared + 256); // Processing_0_output > implode_Cons_0_cons_input_cons_input_0 size:= 128*unsigned char
unsigned char *const output__cons_input_1__0 = (unsigned char*) (Shared + 384); // Processing_1_output > implode_Cons_0_cons_input_cons_input_1 size:= 128*unsigned char

//********** Core1 global definitions *****************

//********** Core2 global definitions *****************

//********** Core3 global definitions *****************




//Core functions
//********** Core0 thread function *****************
void* computationThread_Core0(void *arg) {

  // Initialisation(s)

  // Begin the execution loop
  barrier_wait(&iter_barrier);
#ifdef PREESM_LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){
#else // Default case of an infinite loop
  while (!preesmStopThreads) {
#endif
    // loop body
    produce(256/*msg_size*/, prod_output__input__0); // Prod_0

    // Fork explode_Prod_0_prod_output

    {
    }
    sendStart(0, 1); // Core0 > Core1
    sendEnd(); // Core0 > Core1
    sendStart(0, 2); // Core0 > Core2
    sendEnd(); // Core0 > Core2
    receiveStart(); // Core1 > Core0
    receiveEnd(1, 0); // Core1 > Core0
    receiveStart(); // Core2 > Core0
    receiveEnd(2, 0); // Core2 > Core0
    // Join implode_Cons_0_cons_input

    {
    }
    sendStart(0, 3); // Core0 > Core3
    sendEnd(); // Core0 > Core3
    // loop footer
    barrier_wait(&iter_barrier);

  }

  return NULL;
}

//********** Core1 thread function *****************
void* computationThread_Core1(void *arg) {

  // Initialisation(s)

  // Begin the execution loop
  barrier_wait(&iter_barrier);
#ifdef PREESM_LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){
#else // Default case of an infinite loop
  while (!preesmStopThreads) {
#endif
    // loop body
    receiveStart(); // Core0 > Core1
    receiveEnd(0, 1); // Core0 > Core1
    processing(128/*slice_size*/, prod_output_0__input__0, output__cons_input_0__0); // Processing_0

    sendStart(1, 0); // Core1 > Core0
    sendEnd(); // Core1 > Core0
    // loop footer
    barrier_wait(&iter_barrier);

  }

  return NULL;
}

//********** Core2 thread function *****************
void* computationThread_Core2(void *arg) {

  // Initialisation(s)

  // Begin the execution loop
  barrier_wait(&iter_barrier);
#ifdef PREESM_LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){
#else // Default case of an infinite loop
  while (!preesmStopThreads) {
#endif
    // loop body
    receiveStart(); // Core0 > Core2
    receiveEnd(0, 2); // Core0 > Core2
    processing(128/*slice_size*/, prod_output_1__input__0, output__cons_input_1__0); // Processing_1

    sendStart(2, 0); // Core2 > Core0
    sendEnd(); // Core2 > Core0
    // loop footer
    barrier_wait(&iter_barrier);

  }

  return NULL;
}

//********** Core3 thread function *****************
void* computationThread_Core3(void *arg) {

#ifdef PREESM_MD5_UPDATE
	PREESM_MD5_CTX preesm_md5_ctx_output__cons_input__0;
	PREESM_MD5_Init(&preesm_md5_ctx_output__cons_input__0);
#endif
  // Initialisation(s)

  // Begin the execution loop
  barrier_wait(&iter_barrier);
#ifdef PREESM_LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<PREESM_LOOP_SIZE && !preesmStopThreads;index++){
#else // Default case of an infinite loop
  while (!preesmStopThreads) {
#endif
    // loop body
    receiveStart(); // Core0 > Core3
    receiveEnd(0, 3); // Core0 > Core3
    consume(256/*msg_size*/, output__cons_input__0); // Cons_0
#ifdef PREESM_MD5_UPDATE
		PREESM_MD5_Update(&preesm_md5_ctx_output__cons_input__0,(char *)output__cons_input__0, 256);
		#endif

    // loop footer
    barrier_wait(&iter_barrier);

  }

#ifdef PREESM_MD5_UPDATE
	// Print MD5
	rk_sema_wait(&preesmPrintSema);
	unsigned char preesm_md5_chars_final[20] = { 0 };
	PREESM_MD5_Final(preesm_md5_chars_final, &preesm_md5_ctx_output__cons_input__0);
	printf("preesm_md5_output__cons_input__0 : ");
	for (int i = 16; i > 0; i -= 1){
		printf("%02x", *(preesm_md5_chars_final + i - 1));
	}
	printf("\n");
	fflush(stdout);
	rk_sema_post(&preesmPrintSema);
#endif

  return NULL;
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
            computationThread_Core0(0);
            break;
        case 1:
            computationThread_Core1(1);
            break;
        case 2:
            computationThread_Core2(2);
            break;
        case 3:
            computationThread_Core3(3);
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}
