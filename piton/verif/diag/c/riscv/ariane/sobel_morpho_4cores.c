
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
char Core0[105600]; //  size:= 105600*char
char Shared[206272]; //  size:= 206272*char
char *const Read_YUV_0__display_0__0 = (char*) (Core0+0);  // Read_YUV_0 > display_0 size:= 50688*char
char *const Sobel_0__Dilation_0__0 = (char*) (Core0+50688);  // Sobel_0 > Dilation_0 size:= 28160*char
char *const Dilation_0__Erosion_0__0 = (char*) (Core0+78848);  // Dilation_0 > Erosion_0 size:= 26752*char
char *const Read_YUV_0__Split_0__0 = (char*) (Shared+1760);  // Read_YUV_0 > Split_0 size:= 101376*char
char *const explode_Split_0_output__Sobe__0 = (char*) (Shared+0);  // explode_Split_0_output > Sobel_0 size:= 28864*char
char *const explode_Split_0_output__Sobe__1 = (char*) (Shared+25344);  // explode_Split_0_output > Sobel_1 size:= 28864*char
char *const explode_Split_0_output__Sobe__2 = (char*) (Shared+50688);  // explode_Split_0_output > Sobel_2 size:= 28864*char
char *const explode_Split_0_output__Sobe__3 = (char*) (Shared+76032);  // explode_Split_0_output > Sobel_3 size:= 28864*char
char *const implode_display_0_y__display__0 = (char*) (Shared+104896);  // implode_display_0_y > display_0 size:= 101376*char
char *const Erosion_0__implode_display_0__0 = (char*) (Shared+104896);  // Erosion_0 > implode_display_0_y size:= 25344*char
char *const Erosion_1__implode_display_0__0 = (char*) (Shared+130240);  // Erosion_1 > implode_display_0_y size:= 25344*char
char *const Erosion_2__implode_display_0__0 = (char*) (Shared+155584);  // Erosion_2 > implode_display_0_y size:= 25344*char
char *const Erosion_3__implode_display_0__0 = (char*) (Shared+180928);  // Erosion_3 > implode_display_0_y size:= 25344*char
uchar *const u__u__0 = (uchar*) (Core0+0);  // Read_YUV_0_u > display_0_u size:= 25344*uchar
uchar *const v__v__0 = (uchar*) (Core0+25344);  // Read_YUV_0_v > display_0_v size:= 25344*uchar
uchar *const output__input__0 = (uchar*) (Core0+50688);  // Sobel_0_output > Dilation_0_input size:= 28160*uchar
uchar *const output__input__1 = (uchar*) (Core0+78848);  // Dilation_0_output > Erosion_0_input size:= 26752*uchar
uchar *const y__input__0 = (uchar*) (Shared+1760);  // Read_YUV_0_y > Split_0_input size:= 101376*uchar
uchar *const output_0__input__0 = (uchar*) (Shared+0);  // explode_Split_0_output_output_0 > Sobel_0_input size:= 28864*uchar
uchar *const output_1__input__0 = (uchar*) (Shared+25344);  // explode_Split_0_output_output_1 > Sobel_1_input size:= 28864*uchar
uchar *const output_2__input__0 = (uchar*) (Shared+50688);  // explode_Split_0_output_output_2 > Sobel_2_input size:= 28864*uchar
uchar *const output_3__input__0 = (uchar*) (Shared+76032);  // explode_Split_0_output_output_3 > Sobel_3_input size:= 28864*uchar
uchar *const output__y__0 = (uchar*) (Shared+104896);  // implode_display_0_y_output > display_0_y size:= 101376*uchar
uchar *const output__y_0__0 = (uchar*) (Shared+104896);  // Erosion_0_output > implode_display_0_y_y_0 size:= 25344*uchar
uchar *const output__y_1__0 = (uchar*) (Shared+130240);  // Erosion_1_output > implode_display_0_y_y_1 size:= 25344*uchar
uchar *const output__y_2__0 = (uchar*) (Shared+155584);  // Erosion_2_output > implode_display_0_y_y_2 size:= 25344*uchar
uchar *const output__y_3__0 = (uchar*) (Shared+180928);  // Erosion_3_output > implode_display_0_y_y_3 size:= 25344*uchar

//********** Core1 global definitions *****************
char Core1[54912]; //  size:= 54912*char
char *const Sobel_1__Dilation_1__0 = (char*) (Core1+0);  // Sobel_1 > Dilation_1 size:= 28160*char
char *const Dilation_1__Erosion_1__0 = (char*) (Core1+28160);  // Dilation_1 > Erosion_1 size:= 26752*char
uchar *const output__input__4 = (uchar*) (Core1+0);  // Sobel_1_output > Dilation_1_input size:= 28160*uchar
uchar *const output__input__5 = (uchar*) (Core1+28160);  // Dilation_1_output > Erosion_1_input size:= 26752*uchar

//********** Core2 global definitions *****************
char Core2[54912]; //  size:= 54912*char
char *const Sobel_2__Dilation_2__0 = (char*) (Core2+0);  // Sobel_2 > Dilation_2 size:= 28160*char
char *const Dilation_2__Erosion_2__0 = (char*) (Core2+28160);  // Dilation_2 > Erosion_2 size:= 26752*char
uchar *const output__input__6 = (uchar*) (Core2+0);  // Sobel_2_output > Dilation_2_input size:= 28160*uchar
uchar *const output__input__7 = (uchar*) (Core2+28160);  // Dilation_2_output > Erosion_2_input size:= 26752*uchar

//********** Core3 global definitions *****************
char Core3[54912]; //  size:= 54912*char
char *const Sobel_3__Dilation_3__0 = (char*) (Core3+0);  // Sobel_3 > Dilation_3 size:= 28160*char
char *const Dilation_3__Erosion_3__0 = (char*) (Core3+28160);  // Dilation_3 > Erosion_3 size:= 26752*char
uchar *const output__input__2 = (uchar*) (Core3+0);  // Sobel_3_output > Dilation_3_input size:= 28160*uchar
uchar *const output__input__3 = (uchar*) (Core3+28160);  // Dilation_3_output > Erosion_3_input size:= 26752*uchar




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	initReadYUV(352/*width*/,288/*height*/); // Read_YUV_0
	yuvDisplayInit(0/*id*/,352/*width*/,288/*height*/); // display_0

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		printf("Passou 1\n");
		readYUV(352/*width*/,288/*height*/,y__input__0,u__u__0,v__v__0); // Read_YUV_0
		split(4/*nbSlice*/,352/*width*/,288/*height*/,5/*overlap*/,y__input__0,NULL); // Split_0
		sendStart(0, 3); // Core0 > Core3: NULL
		sendEnd(); // Core0 > Core3: NULL
		receiveStart(); // Core3 > Core0: explode_Split_0_output__Sobe__0
		receiveEnd(3, 0); // Core3 > Core0: explode_Split_0_output__Sobe__0
		sobel(352/*width*/,82/*height*/,output_0__input__0,output__input__0); // Sobel_0
		dilation(80/*height*/,352/*width*/,2/*window*/,output__input__0,output__input__1); // Dilation_0
		erosion(76/*height*/,352/*width*/,2/*window*/,output__input__1,output__y_0__0); // Erosion_0
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
		printf("Passou 1\n");
		receiveStart(); // Core3 > Core1: explode_Split_0_output__Sobe__1
		receiveEnd(3, 1); // Core3 > Core1: explode_Split_0_output__Sobe__1
		sobel(352/*width*/,82/*height*/,output_1__input__0,output__input__4); // Sobel_1
		dilation(80/*height*/,352/*width*/,2/*window*/,output__input__4,output__input__5); // Dilation_1
		erosion(76/*height*/,352/*width*/,2/*window*/,output__input__5,output__y_1__0); // Erosion_1
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
		printf("Passou 1\n");
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Sobe__2
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Sobe__2
		sobel(352/*width*/,82/*height*/,output_2__input__0,output__input__6); // Sobel_2
		dilation(80/*height*/,352/*width*/,2/*window*/,output__input__6,output__input__7); // Dilation_2
		erosion(76/*height*/,352/*width*/,2/*window*/,output__input__7,output__y_2__0); // Erosion_2
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
		printf("Passou 1\n");
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
		sobel(352/*width*/,82/*height*/,output_3__input__0,output__input__2); // Sobel_3
		dilation(80/*height*/,352/*width*/,2/*window*/,output__input__2,output__input__3); // Dilation_3
		erosion(76/*height*/,352/*width*/,2/*window*/,output__input__3,output__y_3__0); // Erosion_3
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
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}
