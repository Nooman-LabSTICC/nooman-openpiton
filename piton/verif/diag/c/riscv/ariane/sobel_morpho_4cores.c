
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Dataflow application converted to run in OpenPiton
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "sobel_morpho_4cores_include.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

//Barrier descriptor
m_barrier iter_barrier;


//Core Global Definitions
//********** Core0 global definitions *****************
char Core0[320]; //  size:= 320*char
char Shared[416]; //  size:= 416*char
char *const Sobel_0__Dilation_0__0 = (char*) (Core0+0);  // Sobel_0 > Dilation_0 size:= 160*char
char *const Dilation_0__Erosion_0__0 = (char*) (Core0+160);  // Dilation_0 > Erosion_0 size:= 96*char
char *const Read_YUV_0__display_0__0 = (char*) (Core0+256);  // Read_YUV_0 > display_0 size:= 64*char
char *const Read_YUV_0__Split_0__0 = (char*) (Shared+80);  // Read_YUV_0 > Split_0 size:= 128*char
char *const explode_Split_0_output__Sobe__0 = (char*) (Shared+0);  // explode_Split_0_output > Sobel_0 size:= 192*char
char *const explode_Split_0_output__Sobe__1 = (char*) (Shared+32);  // explode_Split_0_output > Sobel_1 size:= 192*char
char *const explode_Split_0_output__Sobe__2 = (char*) (Shared+64);  // explode_Split_0_output > Sobel_2 size:= 192*char
char *const explode_Split_0_output__Sobe__3 = (char*) (Shared+96);  // explode_Split_0_output > Sobel_3 size:= 192*char
char *const implode_display_0_y__display__0 = (char*) (Shared+288);  // implode_display_0_y > display_0 size:= 128*char
char *const Erosion_0__implode_display_0__0 = (char*) (Shared+288);  // Erosion_0 > implode_display_0_y size:= 32*char
char *const Erosion_1__implode_display_0__0 = (char*) (Shared+320);  // Erosion_1 > implode_display_0_y size:= 32*char
char *const Erosion_2__implode_display_0__0 = (char*) (Shared+352);  // Erosion_2 > implode_display_0_y size:= 32*char
char *const Erosion_3__implode_display_0__0 = (char*) (Shared+384);  // Erosion_3 > implode_display_0_y size:= 32*char
uchar *const output__input__0 = (uchar*) (Core0+0);  // Sobel_0_output > Dilation_0_input size:= 160*uchar
uchar *const output__input__1 = (uchar*) (Core0+160);  // Dilation_0_output > Erosion_0_input size:= 96*uchar
uchar *const u__u__0 = (uchar*) (Core0+256);  // Read_YUV_0_u > display_0_u size:= 32*uchar
uchar *const v__v__0 = (uchar*) (Core0+288);  // Read_YUV_0_v > display_0_v size:= 32*uchar
uchar *const y__input__0 = (uchar*) (Shared+80);  // Read_YUV_0_y > Split_0_input size:= 128*uchar
uchar *const output_0__input__0 = (uchar*) (Shared+0);  // explode_Split_0_output_output_0 > Sobel_0_input size:= 192*uchar
uchar *const output_1__input__0 = (uchar*) (Shared+32);  // explode_Split_0_output_output_1 > Sobel_1_input size:= 192*uchar
uchar *const output_2__input__0 = (uchar*) (Shared+64);  // explode_Split_0_output_output_2 > Sobel_2_input size:= 192*uchar
uchar *const output_3__input__0 = (uchar*) (Shared+96);  // explode_Split_0_output_output_3 > Sobel_3_input size:= 192*uchar
uchar *const output__y__0 = (uchar*) (Shared+288);  // implode_display_0_y_output > display_0_y size:= 128*uchar
uchar *const output__y_0__0 = (uchar*) (Shared+288);  // Erosion_0_output > implode_display_0_y_y_0 size:= 32*uchar
uchar *const output__y_1__0 = (uchar*) (Shared+320);  // Erosion_1_output > implode_display_0_y_y_1 size:= 32*uchar
uchar *const output__y_2__0 = (uchar*) (Shared+352);  // Erosion_2_output > implode_display_0_y_y_2 size:= 32*uchar
uchar *const output__y_3__0 = (uchar*) (Shared+384);  // Erosion_3_output > implode_display_0_y_y_3 size:= 32*uchar

//********** Core1 global definitions *****************
char Core1[256]; //  size:= 256*char
char *const Sobel_1__Dilation_1__0 = (char*) (Core1+0);  // Sobel_1 > Dilation_1 size:= 160*char
char *const Dilation_1__Erosion_1__0 = (char*) (Core1+160);  // Dilation_1 > Erosion_1 size:= 96*char
uchar *const output__input__4 = (uchar*) (Core1+0);  // Sobel_1_output > Dilation_1_input size:= 160*uchar
uchar *const output__input__5 = (uchar*) (Core1+160);  // Dilation_1_output > Erosion_1_input size:= 96*uchar

//********** Core2 global definitions *****************
char Core2[256]; //  size:= 256*char
char *const Sobel_2__Dilation_2__0 = (char*) (Core2+0);  // Sobel_2 > Dilation_2 size:= 160*char
char *const Dilation_2__Erosion_2__0 = (char*) (Core2+160);  // Dilation_2 > Erosion_2 size:= 96*char
uchar *const output__input__6 = (uchar*) (Core2+0);  // Sobel_2_output > Dilation_2_input size:= 160*uchar
uchar *const output__input__7 = (uchar*) (Core2+160);  // Dilation_2_output > Erosion_2_input size:= 96*uchar

//********** Core3 global definitions *****************
char Core3[256]; //  size:= 256*char
char *const Sobel_3__Dilation_3__0 = (char*) (Core3+0);  // Sobel_3 > Dilation_3 size:= 160*char
char *const Dilation_3__Erosion_3__0 = (char*) (Core3+160);  // Dilation_3 > Erosion_3 size:= 96*char
uchar *const output__input__2 = (uchar*) (Core3+0);  // Sobel_3_output > Dilation_3_input size:= 160*uchar
uchar *const output__input__3 = (uchar*) (Core3+160);  // Dilation_3_output > Erosion_3_input size:= 96*uchar




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	initReadYUV(16/*width*/,8/*height*/); // Read_YUV_0
	yuvDisplayInit(0/*id*/,16/*width*/,8/*height*/); // display_0

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		readYUV(16/*width*/,8/*height*/,y__input__0,u__u__0,v__v__0); // Read_YUV_0
		split(4/*nbSlice*/,16/*width*/,8/*height*/,5/*overlap*/,y__input__0,NULL); // Split_0
		sendStart(0, 3); // Core0 > Core3: NULL
		sendEnd(); // Core0 > Core3: NULL
		receiveStart(); // Core3 > Core0: explode_Split_0_output__Sobe__0
		receiveEnd(3, 0); // Core3 > Core0: explode_Split_0_output__Sobe__0
		sobel(16/*width*/,12/*height*/,output_0__input__0,output__input__0); // Sobel_0
		dilation(10/*height*/,16/*width*/,2/*window*/,output__input__0,output__input__1); // Dilation_0
		erosion(6/*height*/,16/*width*/,2/*window*/,output__input__1,output__y_0__0); // Erosion_0
		sendStart(0, 3); // Core0 > Core3: Erosion_0__implode_display_0__0
		sendEnd(); // Core0 > Core3: Erosion_0__implode_display_0__0
		receiveStart(); // Core3 > Core0: implode_display_0_y__display__0
		receiveEnd(3, 0); // Core3 > Core0: implode_display_0_y__display__0
		yuvDisplay(0/*id*/,output__y__0,u__u__0,v__v__0); // display_0
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
		receiveStart(); // Core3 > Core1: explode_Split_0_output__Sobe__1
		receiveEnd(3, 1); // Core3 > Core1: explode_Split_0_output__Sobe__1
		sobel(16/*width*/,12/*height*/,output_1__input__0,output__input__4); // Sobel_1
		dilation(10/*height*/,16/*width*/,2/*window*/,output__input__4,output__input__5); // Dilation_1
		erosion(6/*height*/,16/*width*/,2/*window*/,output__input__5,output__y_1__0); // Erosion_1
		sendStart(1, 3); // Core1 > Core3: Erosion_1__implode_display_0__0
		sendEnd(); // Core1 > Core3: Erosion_1__implode_display_0__0
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
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Sobe__2
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Sobe__2
		sobel(16/*width*/,12/*height*/,output_2__input__0,output__input__6); // Sobel_2
		dilation(10/*height*/,16/*width*/,2/*window*/,output__input__6,output__input__7); // Dilation_2
		erosion(6/*height*/,16/*width*/,2/*window*/,output__input__7,output__y_2__0); // Erosion_2
		sendStart(2, 3); // Core2 > Core3: Erosion_2__implode_display_0__0
		sendEnd(); // Core2 > Core3: Erosion_2__implode_display_0__0
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
		receiveStart(); // Core0 > Core3: NULL
		receiveEnd(0, 3); // Core0 > Core3: NULL
		// Fork explode_Split_0_output
		{
		}
		sendStart(3, 0); // Core3 > Core0: explode_Split_0_output__Sobe__0
		sendEnd(); // Core3 > Core0: explode_Split_0_output__Sobe__0
		sendStart(3, 1); // Core3 > Core1: explode_Split_0_output__Sobe__1
		sendEnd(); // Core3 > Core1: explode_Split_0_output__Sobe__1
		sendStart(3, 2); // Core3 > Core2: explode_Split_0_output__Sobe__2
		sendEnd(); // Core3 > Core2: explode_Split_0_output__Sobe__2
		sobel(16/*width*/,12/*height*/,output_3__input__0,output__input__2); // Sobel_3
		dilation(10/*height*/,16/*width*/,2/*window*/,output__input__2,output__input__3); // Dilation_3
		erosion(6/*height*/,16/*width*/,2/*window*/,output__input__3,output__y_3__0); // Erosion_3
		receiveStart(); // Core0 > Core3: Erosion_0__implode_display_0__0
		receiveEnd(0, 3); // Core0 > Core3: Erosion_0__implode_display_0__0
		receiveStart(); // Core1 > Core3: Erosion_1__implode_display_0__0
		receiveEnd(1, 3); // Core1 > Core3: Erosion_1__implode_display_0__0
		receiveStart(); // Core2 > Core3: Erosion_2__implode_display_0__0
		receiveEnd(2, 3); // Core2 > Core3: Erosion_2__implode_display_0__0
		// Join implode_display_0_y
		{
		}
		sendStart(3, 0); // Core3 > Core0: implode_display_0_y__display__0
		sendEnd(); // Core3 > Core0: implode_display_0_y__display__0
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
