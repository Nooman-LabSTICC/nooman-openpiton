
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Simple dataflow application implementing prod cons
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "preesm_defines.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

#define N 5

m_barrier iter_barrier;

// Core Global Definitions
char Shared[25]; //  size:= 25*char
char *const Prod_0__Cons_0__0 = (char*) (Shared + 0);  // Prod_0 > Cons_0 size:= 25*char
uchar *const prod_output__cons_input__0 = (uchar*) (Shared + 0); // Prod_0_prod_output > Cons_0_cons_input size:= 25*uchar



void Core1(){
    
    barrier_wait(&iter_barrier);

	int index;
	for (index = 0; index < PREESM_LOOP_SIZE; index++) {
		// loop body
		produce(25/*msg_size*/, prod_output__cons_input__0); // Prod_0

		sendStart(1, 0); // Core1 > Core0
		sendEnd(); // Core1 > Core0
		// loop footer
		barrier_wait(&iter_barrier);
	}

}

void Core0(){

    // Begin the execution loop
	barrier_wait(&iter_barrier);

	int index;
	for (index = 0; index < PREESM_LOOP_SIZE; index++) {

		// loop body
		receiveStart(); // Core1 > Core0
		receiveEnd(1, 0); // Core1 > Core0
		consume(25/*msg_size*/, prod_output__cons_input__0); // Cons_0

		// loop footer
		barrier_wait(&iter_barrier);
	}

}

int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    //Initializes semaphore
    communicationInit();
    barrier_init(&iter_barrier, 2); //2 is number of threads


    switch(core_id){
        case 0:
            Core0();
            break;
        case 1:
            Core1();
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }


    return 0;

}
