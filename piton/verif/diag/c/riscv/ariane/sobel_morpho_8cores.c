
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
char Core0[80256]; //  size:= 80256*char
char Shared[209088]; //  size:= 209088*char
char *const Read_YUV_0__display_0__0 = (char*) (Core0+0);  // Read_YUV_0 > display_0 size:= 50688*char
char *const Sobel_0__Dilation_0__0 = (char*) (Core0+50688);  // Sobel_0 > Dilation_0 size:= 15488*char
char *const Dilation_0__Erosion_0__0 = (char*) (Core0+66176);  // Dilation_0 > Erosion_0 size:= 14080*char
char *const Read_YUV_0__Split_0__0 = (char*) (Shared+1760);  // Read_YUV_0 > Split_0 size:= 101376*char
char *const explode_Split_0_output__Sobe__0 = (char*) (Shared+0);  // explode_Split_0_output > Sobel_0 size:= 16192*char
char *const explode_Split_0_output__Sobe__1 = (char*) (Shared+12672);  // explode_Split_0_output > Sobel_1 size:= 16192*char
char *const explode_Split_0_output__Sobe__2 = (char*) (Shared+25344);  // explode_Split_0_output > Sobel_2 size:= 16192*char
char *const explode_Split_0_output__Sobe__3 = (char*) (Shared+38016);  // explode_Split_0_output > Sobel_3 size:= 16192*char
char *const explode_Split_0_output__Sobe__4 = (char*) (Shared+50688);  // explode_Split_0_output > Sobel_4 size:= 16192*char
char *const explode_Split_0_output__Sobe__5 = (char*) (Shared+63360);  // explode_Split_0_output > Sobel_5 size:= 16192*char
char *const explode_Split_0_output__Sobe__6 = (char*) (Shared+76032);  // explode_Split_0_output > Sobel_6 size:= 16192*char
char *const explode_Split_0_output__Sobe__7 = (char*) (Shared+88704);  // explode_Split_0_output > Sobel_7 size:= 16192*char
char *const implode_display_0_y__display__0 = (char*) (Shared+104896);  // implode_display_0_y > display_0 size:= 101376*char
char *const Erosion_0__implode_display_0__0 = (char*) (Shared+104896);  // Erosion_0 > implode_display_0_y size:= 12672*char
char *const Erosion_1__implode_display_0__0 = (char*) (Shared+117568);  // Erosion_1 > implode_display_0_y size:= 12672*char
char *const Erosion_2__implode_display_0__0 = (char*) (Shared+130240);  // Erosion_2 > implode_display_0_y size:= 12672*char
char *const Erosion_3__implode_display_0__0 = (char*) (Shared+142912);  // Erosion_3 > implode_display_0_y size:= 12672*char
char *const Erosion_4__implode_display_0__0 = (char*) (Shared+155584);  // Erosion_4 > implode_display_0_y size:= 12672*char
char *const Erosion_5__implode_display_0__0 = (char*) (Shared+168256);  // Erosion_5 > implode_display_0_y size:= 12672*char
char *const Erosion_6__implode_display_0__0 = (char*) (Shared+180928);  // Erosion_6 > implode_display_0_y size:= 12672*char
char *const Erosion_7__implode_display_0__0 = (char*) (Shared+193600);  // Erosion_7 > implode_display_0_y size:= 12672*char
char *const Sobel_7__Dilation_7__0 = (char*) (Shared+193600);  // Sobel_7 > Dilation_7 size:= 15488*char
char *const Dilation_7__Erosion_7__0 = (char*) (Shared+0);  // Dilation_7 > Erosion_7 size:= 14080*char
uchar *const u__u__0 = (uchar*) (Core0+0);  // Read_YUV_0_u > display_0_u size:= 25344*uchar
uchar *const v__v__0 = (uchar*) (Core0+25344);  // Read_YUV_0_v > display_0_v size:= 25344*uchar
uchar *const output__input__0 = (uchar*) (Core0+50688);  // Sobel_0_output > Dilation_0_input size:= 15488*uchar
uchar *const output__input__1 = (uchar*) (Core0+66176);  // Dilation_0_output > Erosion_0_input size:= 14080*uchar
uchar *const y__input__0 = (uchar*) (Shared+1760);  // Read_YUV_0_y > Split_0_input size:= 101376*uchar
uchar *const output_0__input__0 = (uchar*) (Shared+0);  // explode_Split_0_output_output_0 > Sobel_0_input size:= 16192*uchar
uchar *const output_1__input__0 = (uchar*) (Shared+12672);  // explode_Split_0_output_output_1 > Sobel_1_input size:= 16192*uchar
uchar *const output_2__input__0 = (uchar*) (Shared+25344);  // explode_Split_0_output_output_2 > Sobel_2_input size:= 16192*uchar
uchar *const output_3__input__0 = (uchar*) (Shared+38016);  // explode_Split_0_output_output_3 > Sobel_3_input size:= 16192*uchar
uchar *const output_4__input__0 = (uchar*) (Shared+50688);  // explode_Split_0_output_output_4 > Sobel_4_input size:= 16192*uchar
uchar *const output_5__input__0 = (uchar*) (Shared+63360);  // explode_Split_0_output_output_5 > Sobel_5_input size:= 16192*uchar
uchar *const output_6__input__0 = (uchar*) (Shared+76032);  // explode_Split_0_output_output_6 > Sobel_6_input size:= 16192*uchar
uchar *const output_7__input__0 = (uchar*) (Shared+88704);  // explode_Split_0_output_output_7 > Sobel_7_input size:= 16192*uchar
uchar *const output__y__0 = (uchar*) (Shared+104896);  // implode_display_0_y_output > display_0_y size:= 101376*uchar
uchar *const output__y_0__0 = (uchar*) (Shared+104896);  // Erosion_0_output > implode_display_0_y_y_0 size:= 12672*uchar
uchar *const output__y_1__0 = (uchar*) (Shared+117568);  // Erosion_1_output > implode_display_0_y_y_1 size:= 12672*uchar
uchar *const output__y_2__0 = (uchar*) (Shared+130240);  // Erosion_2_output > implode_display_0_y_y_2 size:= 12672*uchar
uchar *const output__y_3__0 = (uchar*) (Shared+142912);  // Erosion_3_output > implode_display_0_y_y_3 size:= 12672*uchar
uchar *const output__y_4__0 = (uchar*) (Shared+155584);  // Erosion_4_output > implode_display_0_y_y_4 size:= 12672*uchar
uchar *const output__y_5__0 = (uchar*) (Shared+168256);  // Erosion_5_output > implode_display_0_y_y_5 size:= 12672*uchar
uchar *const output__y_6__0 = (uchar*) (Shared+180928);  // Erosion_6_output > implode_display_0_y_y_6 size:= 12672*uchar
uchar *const output__y_7__0 = (uchar*) (Shared+193600);  // Erosion_7_output > implode_display_0_y_y_7 size:= 12672*uchar
uchar *const output__input__2 = (uchar*) (Shared+193600);  // Sobel_7_output > Dilation_7_input size:= 15488*uchar
uchar *const output__input__3 = (uchar*) (Shared+0);  // Dilation_7_output > Erosion_7_input size:= 14080*uchar
uint64_t dumpedTimes[96]; //  size:= 96*uint64_t
int nbExec[96]; //  size:= 96*int
int idx;

//********** Core2 global definitions *****************
char Core2[29568]; //  size:= 29568*char
char *const Sobel_1__Dilation_1__0 = (char*) (Core2+0);  // Sobel_1 > Dilation_1 size:= 15488*char
char *const Dilation_1__Erosion_1__0 = (char*) (Core2+15488);  // Dilation_1 > Erosion_1 size:= 14080*char
uchar *const output__input__4 = (uchar*) (Core2+0);  // Sobel_1_output > Dilation_1_input size:= 15488*uchar
uchar *const output__input__5 = (uchar*) (Core2+15488);  // Dilation_1_output > Erosion_1_input size:= 14080*uchar
int idx;

void *computationThread_Core1(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+39) = 0;
		receiveStart(); // Core0 > Core2: explode_Split_0_output__Sobe__1
		*(nbExec+40) = 0;
		receiveEnd(0, 1); // Core0 > Core2: explode_Split_0_output__Sobe__1
		for(idx=0; idx<*(nbExec+41); idx++){
			sobel(352/*width*/,46/*height*/,output_1__input__0,output__input__4); // Sobel_1
		}
		for(idx=0; idx<*(nbExec+42); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__4,output__input__5); // Dilation_1
		}
		*(nbExec+43) = 0;
		receiveStart(); // Core0 > Core2: Sobel_7__Dilation_7__0
		*(nbExec+44) = 0;
		receiveEnd(0, 1); // Core0 > Core2: Sobel_7__Dilation_7__0
		for(idx=0; idx<*(nbExec+45); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__2,output__input__3); // Dilation_7
		}
		*(nbExec+46) = 0;
		sendStart(1, 2); // Core2 > Core3: Dilation_7__Erosion_7__0
		*(nbExec+47) = 0;
		sendEnd(); // Core2 > Core3: Dilation_7__Erosion_7__0
		for(idx=0; idx<*(nbExec+48); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__5,output__y_1__0); // Erosion_1
		}
		*(nbExec+49) = 0;
		sendStart(1, 0); // Core2 > Core0: Erosion_1__implode_display_0__0
		*(nbExec+50) = 0;
		sendEnd(); // Core2 > Core0: Erosion_1__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core3 global definitions *****************
char Core3[29568]; //  size:= 29568*char
char *const Sobel_2__Dilation_2__0 = (char*) (Core3+0);  // Sobel_2 > Dilation_2 size:= 15488*char
char *const Dilation_2__Erosion_2__0 = (char*) (Core3+15488);  // Dilation_2 > Erosion_2 size:= 14080*char
uchar *const output__input__6 = (uchar*) (Core3+0);  // Sobel_2_output > Dilation_2_input size:= 15488*uchar
uchar *const output__input__7 = (uchar*) (Core3+15488);  // Dilation_2_output > Erosion_2_input size:= 14080*uchar
int idx;

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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+52) = 0;
		receiveStart(); // Core0 > Core3: explode_Split_0_output__Sobe__2
		*(nbExec+53) = 0;
		receiveEnd(0, 2); // Core0 > Core3: explode_Split_0_output__Sobe__2
		for(idx=0; idx<*(nbExec+54); idx++){
			sobel(352/*width*/,46/*height*/,output_2__input__0,output__input__6); // Sobel_2
		}
		for(idx=0; idx<*(nbExec+55); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__6,output__input__7); // Dilation_2
		}
		for(idx=0; idx<*(nbExec+56); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__7,output__y_2__0); // Erosion_2
		}
		*(nbExec+57) = 0;
		sendStart(2, 0); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+58) = 0;
		sendEnd(); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+59) = 0;
		receiveStart(); // Core2 > Core3: Dilation_7__Erosion_7__0
		*(nbExec+60) = 0;
		receiveEnd(1, 2); // Core2 > Core3: Dilation_7__Erosion_7__0
		for(idx=0; idx<*(nbExec+61); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__3,output__y_7__0); // Erosion_7
		}
		*(nbExec+62) = 0;
		sendStart(2, 0); // Core3 > Core0: Erosion_7__implode_display_0__0
		*(nbExec+63) = 0;
		sendEnd(); // Core3 > Core0: Erosion_7__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core4 global definitions *****************
char Core4[29568]; //  size:= 29568*char
char *const Sobel_3__Dilation_3__0 = (char*) (Core4+0);  // Sobel_3 > Dilation_3 size:= 15488*char
char *const Dilation_3__Erosion_3__0 = (char*) (Core4+15488);  // Dilation_3 > Erosion_3 size:= 14080*char
uchar *const output__input__8 = (uchar*) (Core4+0);  // Sobel_3_output > Dilation_3_input size:= 15488*uchar
uchar *const output__input__9 = (uchar*) (Core4+15488);  // Dilation_3_output > Erosion_3_input size:= 14080*uchar
int idx;

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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+65) = 0;
		receiveStart(); // Core0 > Core4: explode_Split_0_output__Sobe__3
		*(nbExec+66) = 0;
		receiveEnd(0, 3); // Core0 > Core4: explode_Split_0_output__Sobe__3
		for(idx=0; idx<*(nbExec+67); idx++){
			sobel(352/*width*/,46/*height*/,output_3__input__0,output__input__8); // Sobel_3
		}
		for(idx=0; idx<*(nbExec+68); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__8,output__input__9); // Dilation_3
		}
		for(idx=0; idx<*(nbExec+69); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__9,output__y_3__0); // Erosion_3
		}
		*(nbExec+70) = 0;
		sendStart(3, 0); // Core4 > Core0: Erosion_3__implode_display_0__0
		*(nbExec+71) = 0;
		sendEnd(); // Core4 > Core0: Erosion_3__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core5 global definitions *****************
char Core5[29568]; //  size:= 29568*char
char *const Sobel_4__Dilation_4__0 = (char*) (Core5+0);  // Sobel_4 > Dilation_4 size:= 15488*char
char *const Dilation_4__Erosion_4__0 = (char*) (Core5+15488);  // Dilation_4 > Erosion_4 size:= 14080*char
uchar *const output__input__10 = (uchar*) (Core5+0);  // Sobel_4_output > Dilation_4_input size:= 15488*uchar
uchar *const output__input__11 = (uchar*) (Core5+15488);  // Dilation_4_output > Erosion_4_input size:= 14080*uchar
int idx;

void computationThread_Core4(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+73) = 0;
		receiveStart(); // Core0 > Core5: explode_Split_0_output__Sobe__4
		*(nbExec+74) = 0;
		receiveEnd(0, 4); // Core0 > Core5: explode_Split_0_output__Sobe__4
		for(idx=0; idx<*(nbExec+75); idx++){
			sobel(352/*width*/,46/*height*/,output_4__input__0,output__input__10); // Sobel_4
		}
		for(idx=0; idx<*(nbExec+76); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__10,output__input__11); // Dilation_4
		}
		for(idx=0; idx<*(nbExec+77); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__11,output__y_4__0); // Erosion_4
		}
		*(nbExec+78) = 0;
		sendStart(4, 0); // Core5 > Core0: Erosion_4__implode_display_0__0
		*(nbExec+79) = 0;
		sendEnd(); // Core5 > Core0: Erosion_4__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core6 global definitions *****************
char Core6[29568]; //  size:= 29568*char
char *const Sobel_5__Dilation_5__0 = (char*) (Core6+0);  // Sobel_5 > Dilation_5 size:= 15488*char
char *const Dilation_5__Erosion_5__0 = (char*) (Core6+15488);  // Dilation_5 > Erosion_5 size:= 14080*char
uchar *const output__input__12 = (uchar*) (Core6+0);  // Sobel_5_output > Dilation_5_input size:= 15488*uchar
uchar *const output__input__13 = (uchar*) (Core6+15488);  // Dilation_5_output > Erosion_5_input size:= 14080*uchar
int idx;

void computationThread_Core5(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+81) = 0;
		receiveStart(); // Core0 > Core6: explode_Split_0_output__Sobe__5
		*(nbExec+82) = 0;
		receiveEnd(0, 5); // Core0 > Core6: explode_Split_0_output__Sobe__5
		for(idx=0; idx<*(nbExec+83); idx++){
			sobel(352/*width*/,46/*height*/,output_5__input__0,output__input__12); // Sobel_5
		}
		for(idx=0; idx<*(nbExec+84); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__12,output__input__13); // Dilation_5
		}
		for(idx=0; idx<*(nbExec+85); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__13,output__y_5__0); // Erosion_5
		}
		*(nbExec+86) = 0;
		sendStart(5, 0); // Core6 > Core0: Erosion_5__implode_display_0__0
		*(nbExec+87) = 0;
		sendEnd(); // Core6 > Core0: Erosion_5__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core7 global definitions *****************
char Core7[29568]; //  size:= 29568*char
char *const Sobel_6__Dilation_6__0 = (char*) (Core7+0);  // Sobel_6 > Dilation_6 size:= 15488*char
char *const Dilation_6__Erosion_6__0 = (char*) (Core7+15488);  // Dilation_6 > Erosion_6 size:= 14080*char
uchar *const output__input__14 = (uchar*) (Core7+0);  // Sobel_6_output > Dilation_6_input size:= 15488*uchar
uchar *const output__input__15 = (uchar*) (Core7+15488);  // Dilation_6_output > Erosion_6_input size:= 14080*uchar
int idx;

void computationThread_Core6(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+89) = 0;
		receiveStart(); // Core0 > Core7: explode_Split_0_output__Sobe__6
		*(nbExec+90) = 0;
		receiveEnd(0, 6); // Core0 > Core7: explode_Split_0_output__Sobe__6
		for(idx=0; idx<*(nbExec+91); idx++){
			sobel(352/*width*/,46/*height*/,output_6__input__0,output__input__14); // Sobel_6
		}
		for(idx=0; idx<*(nbExec+92); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__14,output__input__15); // Dilation_6
		}
		for(idx=0; idx<*(nbExec+93); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__15,output__y_6__0); // Erosion_6
		}
		*(nbExec+94) = 0;
		sendStart(6, 0); // Core7 > Core0: Erosion_6__implode_display_0__0
		*(nbExec+95) = 0;
		sendEnd(); // Core7 > Core0: Erosion_6__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	initReadYUV(352/*width*/,288/*height*/); // Read_YUV_0
	yuvDisplayInit(0/*id*/,352/*width*/,288/*height*/); // display_0
	initNbExec(nbExec,96/*nbDump*/); // 

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		if(stopThreads){
			pthread_exit(NULL);
		}
		for(idx=0; idx<*(nbExec+1); idx++){
			readYUV(352/*width*/,288/*height*/,y__input__0,u__u__0,v__v__0); // Read_YUV_0
		}
		for(idx=0; idx<*(nbExec+2); idx++){
			split(8/*nbSlice*/,352/*width*/,288/*height*/,5/*overlap*/,y__input__0,NULL); // Split_0
		}
		for(idx=0; idx<*(nbExec+3); idx++){
			// Fork explode_Split_0_output
			{
			}
		}
		*(nbExec+4) = 0;
		sendStart(0, 1); // Core0 > Core2: explode_Split_0_output__Sobe__1
		*(nbExec+5) = 0;
		sendEnd(); // Core0 > Core2: explode_Split_0_output__Sobe__1
		*(nbExec+6) = 0;
		sendStart(0, 2); // Core0 > Core3: explode_Split_0_output__Sobe__2
		*(nbExec+7) = 0;
		sendEnd(); // Core0 > Core3: explode_Split_0_output__Sobe__2
		*(nbExec+8) = 0;
		sendStart(0, 3); // Core0 > Core4: explode_Split_0_output__Sobe__3
		*(nbExec+9) = 0;
		sendEnd(); // Core0 > Core4: explode_Split_0_output__Sobe__3
		*(nbExec+10) = 0;
		sendStart(0, 4); // Core0 > Core5: explode_Split_0_output__Sobe__4
		*(nbExec+11) = 0;
		sendEnd(); // Core0 > Core5: explode_Split_0_output__Sobe__4
		*(nbExec+12) = 0;
		sendStart(0, 5); // Core0 > Core6: explode_Split_0_output__Sobe__5
		*(nbExec+13) = 0;
		sendEnd(); // Core0 > Core6: explode_Split_0_output__Sobe__5
		*(nbExec+14) = 0;
		sendStart(0, 6); // Core0 > Core7: explode_Split_0_output__Sobe__6
		*(nbExec+15) = 0;
		sendEnd(); // Core0 > Core7: explode_Split_0_output__Sobe__6
		for(idx=0; idx<*(nbExec+16); idx++){
			sobel(352/*width*/,46/*height*/,output_0__input__0,output__input__0); // Sobel_0
		}
		for(idx=0; idx<*(nbExec+17); idx++){
			sobel(352/*width*/,46/*height*/,output_7__input__0,output__input__2); // Sobel_7
		}
		*(nbExec+18) = 0;
		sendStart(0, 1); // Core0 > Core2: Sobel_7__Dilation_7__0
		*(nbExec+19) = 0;
		sendEnd(); // Core0 > Core2: Sobel_7__Dilation_7__0
		for(idx=0; idx<*(nbExec+20); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__0,output__input__1); // Dilation_0
		}
		for(idx=0; idx<*(nbExec+21); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__1,output__y_0__0); // Erosion_0
		}
		*(nbExec+22) = 0;
		receiveStart(); // Core2 > Core0: Erosion_1__implode_display_0__0
		*(nbExec+23) = 0;
		receiveEnd(1, 0); // Core2 > Core0: Erosion_1__implode_display_0__0
		*(nbExec+24) = 0;
		receiveStart(); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+25) = 0;
		receiveEnd(2, 0); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+26) = 0;
		receiveStart(); // Core4 > Core0: Erosion_3__implode_display_0__0
		*(nbExec+27) = 0;
		receiveEnd(3, 0); // Core4 > Core0: Erosion_3__implode_display_0__0
		*(nbExec+28) = 0;
		receiveStart(); // Core5 > Core0: Erosion_4__implode_display_0__0
		*(nbExec+29) = 0;
		receiveEnd(4, 0); // Core5 > Core0: Erosion_4__implode_display_0__0
		*(nbExec+30) = 0;
		receiveStart(); // Core6 > Core0: Erosion_5__implode_display_0__0
		*(nbExec+31) = 0;
		receiveEnd(5, 0); // Core6 > Core0: Erosion_5__implode_display_0__0
		*(nbExec+32) = 0;
		receiveStart(); // Core7 > Core0: Erosion_6__implode_display_0__0
		*(nbExec+33) = 0;
		receiveEnd(6, 0); // Core7 > Core0: Erosion_6__implode_display_0__0
		*(nbExec+34) = 0;
		receiveStart(); // Core3 > Core0: Erosion_7__implode_display_0__0
		*(nbExec+35) = 0;
		receiveEnd(2, 0); // Core3 > Core0: Erosion_7__implode_display_0__0
		for(idx=0; idx<*(nbExec+36); idx++){
			// Join implode_display_0_y
			{
			}
		}
		for(idx=0; idx<*(nbExec+37); idx++){
			yuvDisplay(0/*id*/,output__y__0,u__u__0,v__v__0); // display_0
		}
		barrier_wait(&iter_barrier);
		writeTime(dumpedTimes,96/*nbDump*/, nbExec);
	}
	return NULL;
}

//********** Core2 thread function *****************
//********** Core3 thread function *****************
//********** Core4 thread function *****************
//********** Core5 thread function *****************
//********** Core6 thread function *****************
//********** Core7 thread function *****************


int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    //Initializes semaphore
    communicationInit();
    barrier_init(&iter_barrier, NB_CORES); //7 is number of threads

    //Thread selection
    switch(core_id){
        case 0:
            computationThread_Core0(NULL);
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
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}

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
char Core0[80256]; //  size:= 80256*char
char Shared[209088]; //  size:= 209088*char
char *const Read_YUV_0__display_0__0 = (char*) (Core0+0);  // Read_YUV_0 > display_0 size:= 50688*char
char *const Sobel_0__Dilation_0__0 = (char*) (Core0+50688);  // Sobel_0 > Dilation_0 size:= 15488*char
char *const Dilation_0__Erosion_0__0 = (char*) (Core0+66176);  // Dilation_0 > Erosion_0 size:= 14080*char
char *const Read_YUV_0__Split_0__0 = (char*) (Shared+1760);  // Read_YUV_0 > Split_0 size:= 101376*char
char *const explode_Split_0_output__Sobe__0 = (char*) (Shared+0);  // explode_Split_0_output > Sobel_0 size:= 16192*char
char *const explode_Split_0_output__Sobe__1 = (char*) (Shared+12672);  // explode_Split_0_output > Sobel_1 size:= 16192*char
char *const explode_Split_0_output__Sobe__2 = (char*) (Shared+25344);  // explode_Split_0_output > Sobel_2 size:= 16192*char
char *const explode_Split_0_output__Sobe__3 = (char*) (Shared+38016);  // explode_Split_0_output > Sobel_3 size:= 16192*char
char *const explode_Split_0_output__Sobe__4 = (char*) (Shared+50688);  // explode_Split_0_output > Sobel_4 size:= 16192*char
char *const explode_Split_0_output__Sobe__5 = (char*) (Shared+63360);  // explode_Split_0_output > Sobel_5 size:= 16192*char
char *const explode_Split_0_output__Sobe__6 = (char*) (Shared+76032);  // explode_Split_0_output > Sobel_6 size:= 16192*char
char *const explode_Split_0_output__Sobe__7 = (char*) (Shared+88704);  // explode_Split_0_output > Sobel_7 size:= 16192*char
char *const implode_display_0_y__display__0 = (char*) (Shared+104896);  // implode_display_0_y > display_0 size:= 101376*char
char *const Erosion_0__implode_display_0__0 = (char*) (Shared+104896);  // Erosion_0 > implode_display_0_y size:= 12672*char
char *const Erosion_1__implode_display_0__0 = (char*) (Shared+117568);  // Erosion_1 > implode_display_0_y size:= 12672*char
char *const Erosion_2__implode_display_0__0 = (char*) (Shared+130240);  // Erosion_2 > implode_display_0_y size:= 12672*char
char *const Erosion_3__implode_display_0__0 = (char*) (Shared+142912);  // Erosion_3 > implode_display_0_y size:= 12672*char
char *const Erosion_4__implode_display_0__0 = (char*) (Shared+155584);  // Erosion_4 > implode_display_0_y size:= 12672*char
char *const Erosion_5__implode_display_0__0 = (char*) (Shared+168256);  // Erosion_5 > implode_display_0_y size:= 12672*char
char *const Erosion_6__implode_display_0__0 = (char*) (Shared+180928);  // Erosion_6 > implode_display_0_y size:= 12672*char
char *const Erosion_7__implode_display_0__0 = (char*) (Shared+193600);  // Erosion_7 > implode_display_0_y size:= 12672*char
char *const Sobel_7__Dilation_7__0 = (char*) (Shared+193600);  // Sobel_7 > Dilation_7 size:= 15488*char
char *const Dilation_7__Erosion_7__0 = (char*) (Shared+0);  // Dilation_7 > Erosion_7 size:= 14080*char
uchar *const u__u__0 = (uchar*) (Core0+0);  // Read_YUV_0_u > display_0_u size:= 25344*uchar
uchar *const v__v__0 = (uchar*) (Core0+25344);  // Read_YUV_0_v > display_0_v size:= 25344*uchar
uchar *const output__input__0 = (uchar*) (Core0+50688);  // Sobel_0_output > Dilation_0_input size:= 15488*uchar
uchar *const output__input__1 = (uchar*) (Core0+66176);  // Dilation_0_output > Erosion_0_input size:= 14080*uchar
uchar *const y__input__0 = (uchar*) (Shared+1760);  // Read_YUV_0_y > Split_0_input size:= 101376*uchar
uchar *const output_0__input__0 = (uchar*) (Shared+0);  // explode_Split_0_output_output_0 > Sobel_0_input size:= 16192*uchar
uchar *const output_1__input__0 = (uchar*) (Shared+12672);  // explode_Split_0_output_output_1 > Sobel_1_input size:= 16192*uchar
uchar *const output_2__input__0 = (uchar*) (Shared+25344);  // explode_Split_0_output_output_2 > Sobel_2_input size:= 16192*uchar
uchar *const output_3__input__0 = (uchar*) (Shared+38016);  // explode_Split_0_output_output_3 > Sobel_3_input size:= 16192*uchar
uchar *const output_4__input__0 = (uchar*) (Shared+50688);  // explode_Split_0_output_output_4 > Sobel_4_input size:= 16192*uchar
uchar *const output_5__input__0 = (uchar*) (Shared+63360);  // explode_Split_0_output_output_5 > Sobel_5_input size:= 16192*uchar
uchar *const output_6__input__0 = (uchar*) (Shared+76032);  // explode_Split_0_output_output_6 > Sobel_6_input size:= 16192*uchar
uchar *const output_7__input__0 = (uchar*) (Shared+88704);  // explode_Split_0_output_output_7 > Sobel_7_input size:= 16192*uchar
uchar *const output__y__0 = (uchar*) (Shared+104896);  // implode_display_0_y_output > display_0_y size:= 101376*uchar
uchar *const output__y_0__0 = (uchar*) (Shared+104896);  // Erosion_0_output > implode_display_0_y_y_0 size:= 12672*uchar
uchar *const output__y_1__0 = (uchar*) (Shared+117568);  // Erosion_1_output > implode_display_0_y_y_1 size:= 12672*uchar
uchar *const output__y_2__0 = (uchar*) (Shared+130240);  // Erosion_2_output > implode_display_0_y_y_2 size:= 12672*uchar
uchar *const output__y_3__0 = (uchar*) (Shared+142912);  // Erosion_3_output > implode_display_0_y_y_3 size:= 12672*uchar
uchar *const output__y_4__0 = (uchar*) (Shared+155584);  // Erosion_4_output > implode_display_0_y_y_4 size:= 12672*uchar
uchar *const output__y_5__0 = (uchar*) (Shared+168256);  // Erosion_5_output > implode_display_0_y_y_5 size:= 12672*uchar
uchar *const output__y_6__0 = (uchar*) (Shared+180928);  // Erosion_6_output > implode_display_0_y_y_6 size:= 12672*uchar
uchar *const output__y_7__0 = (uchar*) (Shared+193600);  // Erosion_7_output > implode_display_0_y_y_7 size:= 12672*uchar
uchar *const output__input__2 = (uchar*) (Shared+193600);  // Sobel_7_output > Dilation_7_input size:= 15488*uchar
uchar *const output__input__3 = (uchar*) (Shared+0);  // Dilation_7_output > Erosion_7_input size:= 14080*uchar
uint64_t dumpedTimes[96]; //  size:= 96*uint64_t
int nbExec[96]; //  size:= 96*int
int idx;

//********** Core2 global definitions *****************
char Core2[29568]; //  size:= 29568*char
char *const Sobel_1__Dilation_1__0 = (char*) (Core2+0);  // Sobel_1 > Dilation_1 size:= 15488*char
char *const Dilation_1__Erosion_1__0 = (char*) (Core2+15488);  // Dilation_1 > Erosion_1 size:= 14080*char
uchar *const output__input__4 = (uchar*) (Core2+0);  // Sobel_1_output > Dilation_1_input size:= 15488*uchar
uchar *const output__input__5 = (uchar*) (Core2+15488);  // Dilation_1_output > Erosion_1_input size:= 14080*uchar
int idx;

void *computationThread_Core1(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+39) = 0;
		receiveStart(); // Core0 > Core2: explode_Split_0_output__Sobe__1
		*(nbExec+40) = 0;
		receiveEnd(0, 1); // Core0 > Core2: explode_Split_0_output__Sobe__1
		for(idx=0; idx<*(nbExec+41); idx++){
			sobel(352/*width*/,46/*height*/,output_1__input__0,output__input__4); // Sobel_1
		}
		for(idx=0; idx<*(nbExec+42); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__4,output__input__5); // Dilation_1
		}
		*(nbExec+43) = 0;
		receiveStart(); // Core0 > Core2: Sobel_7__Dilation_7__0
		*(nbExec+44) = 0;
		receiveEnd(0, 1); // Core0 > Core2: Sobel_7__Dilation_7__0
		for(idx=0; idx<*(nbExec+45); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__2,output__input__3); // Dilation_7
		}
		*(nbExec+46) = 0;
		sendStart(1, 2); // Core2 > Core3: Dilation_7__Erosion_7__0
		*(nbExec+47) = 0;
		sendEnd(); // Core2 > Core3: Dilation_7__Erosion_7__0
		for(idx=0; idx<*(nbExec+48); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__5,output__y_1__0); // Erosion_1
		}
		*(nbExec+49) = 0;
		sendStart(1, 0); // Core2 > Core0: Erosion_1__implode_display_0__0
		*(nbExec+50) = 0;
		sendEnd(); // Core2 > Core0: Erosion_1__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core3 global definitions *****************
char Core3[29568]; //  size:= 29568*char
char *const Sobel_2__Dilation_2__0 = (char*) (Core3+0);  // Sobel_2 > Dilation_2 size:= 15488*char
char *const Dilation_2__Erosion_2__0 = (char*) (Core3+15488);  // Dilation_2 > Erosion_2 size:= 14080*char
uchar *const output__input__6 = (uchar*) (Core3+0);  // Sobel_2_output > Dilation_2_input size:= 15488*uchar
uchar *const output__input__7 = (uchar*) (Core3+15488);  // Dilation_2_output > Erosion_2_input size:= 14080*uchar
int idx;

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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+52) = 0;
		receiveStart(); // Core0 > Core3: explode_Split_0_output__Sobe__2
		*(nbExec+53) = 0;
		receiveEnd(0, 2); // Core0 > Core3: explode_Split_0_output__Sobe__2
		for(idx=0; idx<*(nbExec+54); idx++){
			sobel(352/*width*/,46/*height*/,output_2__input__0,output__input__6); // Sobel_2
		}
		for(idx=0; idx<*(nbExec+55); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__6,output__input__7); // Dilation_2
		}
		for(idx=0; idx<*(nbExec+56); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__7,output__y_2__0); // Erosion_2
		}
		*(nbExec+57) = 0;
		sendStart(2, 0); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+58) = 0;
		sendEnd(); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+59) = 0;
		receiveStart(); // Core2 > Core3: Dilation_7__Erosion_7__0
		*(nbExec+60) = 0;
		receiveEnd(1, 2); // Core2 > Core3: Dilation_7__Erosion_7__0
		for(idx=0; idx<*(nbExec+61); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__3,output__y_7__0); // Erosion_7
		}
		*(nbExec+62) = 0;
		sendStart(2, 0); // Core3 > Core0: Erosion_7__implode_display_0__0
		*(nbExec+63) = 0;
		sendEnd(); // Core3 > Core0: Erosion_7__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core4 global definitions *****************
char Core4[29568]; //  size:= 29568*char
char *const Sobel_3__Dilation_3__0 = (char*) (Core4+0);  // Sobel_3 > Dilation_3 size:= 15488*char
char *const Dilation_3__Erosion_3__0 = (char*) (Core4+15488);  // Dilation_3 > Erosion_3 size:= 14080*char
uchar *const output__input__8 = (uchar*) (Core4+0);  // Sobel_3_output > Dilation_3_input size:= 15488*uchar
uchar *const output__input__9 = (uchar*) (Core4+15488);  // Dilation_3_output > Erosion_3_input size:= 14080*uchar
int idx;

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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+65) = 0;
		receiveStart(); // Core0 > Core4: explode_Split_0_output__Sobe__3
		*(nbExec+66) = 0;
		receiveEnd(0, 3); // Core0 > Core4: explode_Split_0_output__Sobe__3
		for(idx=0; idx<*(nbExec+67); idx++){
			sobel(352/*width*/,46/*height*/,output_3__input__0,output__input__8); // Sobel_3
		}
		for(idx=0; idx<*(nbExec+68); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__8,output__input__9); // Dilation_3
		}
		for(idx=0; idx<*(nbExec+69); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__9,output__y_3__0); // Erosion_3
		}
		*(nbExec+70) = 0;
		sendStart(3, 0); // Core4 > Core0: Erosion_3__implode_display_0__0
		*(nbExec+71) = 0;
		sendEnd(); // Core4 > Core0: Erosion_3__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core5 global definitions *****************
char Core5[29568]; //  size:= 29568*char
char *const Sobel_4__Dilation_4__0 = (char*) (Core5+0);  // Sobel_4 > Dilation_4 size:= 15488*char
char *const Dilation_4__Erosion_4__0 = (char*) (Core5+15488);  // Dilation_4 > Erosion_4 size:= 14080*char
uchar *const output__input__10 = (uchar*) (Core5+0);  // Sobel_4_output > Dilation_4_input size:= 15488*uchar
uchar *const output__input__11 = (uchar*) (Core5+15488);  // Dilation_4_output > Erosion_4_input size:= 14080*uchar
int idx;

void computationThread_Core4(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+73) = 0;
		receiveStart(); // Core0 > Core5: explode_Split_0_output__Sobe__4
		*(nbExec+74) = 0;
		receiveEnd(0, 4); // Core0 > Core5: explode_Split_0_output__Sobe__4
		for(idx=0; idx<*(nbExec+75); idx++){
			sobel(352/*width*/,46/*height*/,output_4__input__0,output__input__10); // Sobel_4
		}
		for(idx=0; idx<*(nbExec+76); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__10,output__input__11); // Dilation_4
		}
		for(idx=0; idx<*(nbExec+77); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__11,output__y_4__0); // Erosion_4
		}
		*(nbExec+78) = 0;
		sendStart(4, 0); // Core5 > Core0: Erosion_4__implode_display_0__0
		*(nbExec+79) = 0;
		sendEnd(); // Core5 > Core0: Erosion_4__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core6 global definitions *****************
char Core6[29568]; //  size:= 29568*char
char *const Sobel_5__Dilation_5__0 = (char*) (Core6+0);  // Sobel_5 > Dilation_5 size:= 15488*char
char *const Dilation_5__Erosion_5__0 = (char*) (Core6+15488);  // Dilation_5 > Erosion_5 size:= 14080*char
uchar *const output__input__12 = (uchar*) (Core6+0);  // Sobel_5_output > Dilation_5_input size:= 15488*uchar
uchar *const output__input__13 = (uchar*) (Core6+15488);  // Dilation_5_output > Erosion_5_input size:= 14080*uchar
int idx;

void computationThread_Core5(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+81) = 0;
		receiveStart(); // Core0 > Core6: explode_Split_0_output__Sobe__5
		*(nbExec+82) = 0;
		receiveEnd(0, 5); // Core0 > Core6: explode_Split_0_output__Sobe__5
		for(idx=0; idx<*(nbExec+83); idx++){
			sobel(352/*width*/,46/*height*/,output_5__input__0,output__input__12); // Sobel_5
		}
		for(idx=0; idx<*(nbExec+84); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__12,output__input__13); // Dilation_5
		}
		for(idx=0; idx<*(nbExec+85); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__13,output__y_5__0); // Erosion_5
		}
		*(nbExec+86) = 0;
		sendStart(5, 0); // Core6 > Core0: Erosion_5__implode_display_0__0
		*(nbExec+87) = 0;
		sendEnd(); // Core6 > Core0: Erosion_5__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}

//********** Core7 global definitions *****************
char Core7[29568]; //  size:= 29568*char
char *const Sobel_6__Dilation_6__0 = (char*) (Core7+0);  // Sobel_6 > Dilation_6 size:= 15488*char
char *const Dilation_6__Erosion_6__0 = (char*) (Core7+15488);  // Dilation_6 > Erosion_6 size:= 14080*char
uchar *const output__input__14 = (uchar*) (Core7+0);  // Sobel_6_output > Dilation_6_input size:= 15488*uchar
uchar *const output__input__15 = (uchar*) (Core7+15488);  // Dilation_6_output > Erosion_6_input size:= 14080*uchar
int idx;

void computationThread_Core6(void *arg){
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
		if(stopThreads){
			pthread_exit(NULL);
		}
		*(nbExec+89) = 0;
		receiveStart(); // Core0 > Core7: explode_Split_0_output__Sobe__6
		*(nbExec+90) = 0;
		receiveEnd(0, 6); // Core0 > Core7: explode_Split_0_output__Sobe__6
		for(idx=0; idx<*(nbExec+91); idx++){
			sobel(352/*width*/,46/*height*/,output_6__input__0,output__input__14); // Sobel_6
		}
		for(idx=0; idx<*(nbExec+92); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__14,output__input__15); // Dilation_6
		}
		for(idx=0; idx<*(nbExec+93); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__15,output__y_6__0); // Erosion_6
		}
		*(nbExec+94) = 0;
		sendStart(6, 0); // Core7 > Core0: Erosion_6__implode_display_0__0
		*(nbExec+95) = 0;
		sendEnd(); // Core7 > Core0: Erosion_6__implode_display_0__0
		barrier_wait(&iter_barrier);
	}
	return NULL;
}




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	initReadYUV(352/*width*/,288/*height*/); // Read_YUV_0
	yuvDisplayInit(0/*id*/,352/*width*/,288/*height*/); // display_0
	initNbExec(nbExec,96/*nbDump*/); // 

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		if(stopThreads){
			pthread_exit(NULL);
		}
		for(idx=0; idx<*(nbExec+1); idx++){
			readYUV(352/*width*/,288/*height*/,y__input__0,u__u__0,v__v__0); // Read_YUV_0
		}
		for(idx=0; idx<*(nbExec+2); idx++){
			split(8/*nbSlice*/,352/*width*/,288/*height*/,5/*overlap*/,y__input__0,NULL); // Split_0
		}
		for(idx=0; idx<*(nbExec+3); idx++){
			// Fork explode_Split_0_output
			{
			}
		}
		*(nbExec+4) = 0;
		sendStart(0, 1); // Core0 > Core2: explode_Split_0_output__Sobe__1
		*(nbExec+5) = 0;
		sendEnd(); // Core0 > Core2: explode_Split_0_output__Sobe__1
		*(nbExec+6) = 0;
		sendStart(0, 2); // Core0 > Core3: explode_Split_0_output__Sobe__2
		*(nbExec+7) = 0;
		sendEnd(); // Core0 > Core3: explode_Split_0_output__Sobe__2
		*(nbExec+8) = 0;
		sendStart(0, 3); // Core0 > Core4: explode_Split_0_output__Sobe__3
		*(nbExec+9) = 0;
		sendEnd(); // Core0 > Core4: explode_Split_0_output__Sobe__3
		*(nbExec+10) = 0;
		sendStart(0, 4); // Core0 > Core5: explode_Split_0_output__Sobe__4
		*(nbExec+11) = 0;
		sendEnd(); // Core0 > Core5: explode_Split_0_output__Sobe__4
		*(nbExec+12) = 0;
		sendStart(0, 5); // Core0 > Core6: explode_Split_0_output__Sobe__5
		*(nbExec+13) = 0;
		sendEnd(); // Core0 > Core6: explode_Split_0_output__Sobe__5
		*(nbExec+14) = 0;
		sendStart(0, 6); // Core0 > Core7: explode_Split_0_output__Sobe__6
		*(nbExec+15) = 0;
		sendEnd(); // Core0 > Core7: explode_Split_0_output__Sobe__6
		for(idx=0; idx<*(nbExec+16); idx++){
			sobel(352/*width*/,46/*height*/,output_0__input__0,output__input__0); // Sobel_0
		}
		for(idx=0; idx<*(nbExec+17); idx++){
			sobel(352/*width*/,46/*height*/,output_7__input__0,output__input__2); // Sobel_7
		}
		*(nbExec+18) = 0;
		sendStart(0, 1); // Core0 > Core2: Sobel_7__Dilation_7__0
		*(nbExec+19) = 0;
		sendEnd(); // Core0 > Core2: Sobel_7__Dilation_7__0
		for(idx=0; idx<*(nbExec+20); idx++){
			dilation(44/*height*/,352/*width*/,2/*window*/,output__input__0,output__input__1); // Dilation_0
		}
		for(idx=0; idx<*(nbExec+21); idx++){
			erosion(40/*height*/,352/*width*/,2/*window*/,output__input__1,output__y_0__0); // Erosion_0
		}
		*(nbExec+22) = 0;
		receiveStart(); // Core2 > Core0: Erosion_1__implode_display_0__0
		*(nbExec+23) = 0;
		receiveEnd(1, 0); // Core2 > Core0: Erosion_1__implode_display_0__0
		*(nbExec+24) = 0;
		receiveStart(); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+25) = 0;
		receiveEnd(2, 0); // Core3 > Core0: Erosion_2__implode_display_0__0
		*(nbExec+26) = 0;
		receiveStart(); // Core4 > Core0: Erosion_3__implode_display_0__0
		*(nbExec+27) = 0;
		receiveEnd(3, 0); // Core4 > Core0: Erosion_3__implode_display_0__0
		*(nbExec+28) = 0;
		receiveStart(); // Core5 > Core0: Erosion_4__implode_display_0__0
		*(nbExec+29) = 0;
		receiveEnd(4, 0); // Core5 > Core0: Erosion_4__implode_display_0__0
		*(nbExec+30) = 0;
		receiveStart(); // Core6 > Core0: Erosion_5__implode_display_0__0
		*(nbExec+31) = 0;
		receiveEnd(5, 0); // Core6 > Core0: Erosion_5__implode_display_0__0
		*(nbExec+32) = 0;
		receiveStart(); // Core7 > Core0: Erosion_6__implode_display_0__0
		*(nbExec+33) = 0;
		receiveEnd(6, 0); // Core7 > Core0: Erosion_6__implode_display_0__0
		*(nbExec+34) = 0;
		receiveStart(); // Core3 > Core0: Erosion_7__implode_display_0__0
		*(nbExec+35) = 0;
		receiveEnd(2, 0); // Core3 > Core0: Erosion_7__implode_display_0__0
		for(idx=0; idx<*(nbExec+36); idx++){
			// Join implode_display_0_y
			{
			}
		}
		for(idx=0; idx<*(nbExec+37); idx++){
			yuvDisplay(0/*id*/,output__y__0,u__u__0,v__v__0); // display_0
		}
		barrier_wait(&iter_barrier);
		writeTime(dumpedTimes,96/*nbDump*/, nbExec);
	}
	return NULL;
}

//********** Core2 thread function *****************
//********** Core3 thread function *****************
//********** Core4 thread function *****************
//********** Core5 thread function *****************
//********** Core6 thread function *****************
//********** Core7 thread function *****************


int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    //Initializes semaphore
    communicationInit();
    barrier_init(&iter_barrier, NB_CORES); //7 is number of threads

    //Thread selection
    switch(core_id){
        case 0:
            computationThread_Core0(NULL);
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
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }
    


    return 0;

}
