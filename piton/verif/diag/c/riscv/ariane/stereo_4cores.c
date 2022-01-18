
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Dataflow application converted to run in OpenPiton
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "stereo_4cores_include.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

//Barrier descriptor
m_barrier iter_barrier;


//Core Global Definitions
//********** Core0 global definitions *****************
char Shared[59348]; //  size:= 59348*char
char Core0[2424]; //  size:= 2424*char
char *const Cost_Parallel_Work_1_implode__0 = (char*) (Shared+128);  // Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in > Cost_Parallel_Work_1_Broadcast2_0 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__0 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_0 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__1 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_1 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__2 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_2 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__3 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_3 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__4 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_4 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__5 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_5 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__6 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_6 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__7 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_7 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__8 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_8 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__9 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_9 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__10 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_10 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__11 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_11 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__12 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_12 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__13 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_13 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__14 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_14 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__15 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_15 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__16 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_16 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__17 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_17 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__18 = (char*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0 > Cost_Parallel_Work_1_AggregateCost_18 size:= 7200*char
char *const Cost_Parallel_Work_1_Compute__0 = (char*) (Shared+128);  // Cost_Parallel_Work_1_ComputeVertWeights_0 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__1 = (char*) (Shared+3008);  // Cost_Parallel_Work_1_ComputeVertWeights_2 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__2 = (char*) (Shared+5888);  // Cost_Parallel_Work_1_ComputeVertWeights_4 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_implode__1 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in > Cost_Parallel_Work_1_Broadcast3_0 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__19 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_0 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__20 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_1 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__21 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_2 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__22 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_3 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__23 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_4 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__24 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_5 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__25 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_6 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__26 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_7 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__27 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_8 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__28 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_9 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__29 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_10 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__30 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_11 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__31 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_12 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__32 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_13 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__33 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_14 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__34 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_15 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__35 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_16 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__36 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_17 size:= 7200*char
char *const Cost_Parallel_Work_1_Broadca__37 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0 > Cost_Parallel_Work_1_AggregateCost_18 size:= 7200*char
char *const Cost_Parallel_Work_1_Compute__3 = (char*) (Shared+7488);  // Cost_Parallel_Work_1_ComputeHorWeights_0 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__4 = (char*) (Shared+10368);  // Cost_Parallel_Work_1_ComputeHorWeights_2 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__5 = (char*) (Shared+13248);  // Cost_Parallel_Work_1_ComputeHorWeights_4 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_implode__0 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in > Cost_Parallel_Work_2_Broadcast2_0 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__0 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_0 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__1 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_1 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__2 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_2 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__3 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_3 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__4 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_4 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__5 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_5 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__6 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_6 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__7 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_7 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__8 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_8 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__9 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_9 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__10 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_10 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__11 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_11 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__12 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_12 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__13 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_13 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__14 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_14 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__15 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_15 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__16 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_16 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__17 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_17 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__18 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0 > Cost_Parallel_Work_2_AggregateCost_18 size:= 7200*char
char *const Cost_Parallel_Work_2_Compute__0 = (char*) (Shared+14848);  // Cost_Parallel_Work_2_ComputeVertWeights_0 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__1 = (char*) (Shared+17728);  // Cost_Parallel_Work_2_ComputeVertWeights_2 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__2 = (char*) (Shared+20608);  // Cost_Parallel_Work_2_ComputeVertWeights_4 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_implode__1 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in > Cost_Parallel_Work_2_Broadcast3_0 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__19 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_0 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__20 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_1 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__21 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_2 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__22 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_3 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__23 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_4 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__24 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_5 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__25 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_6 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__26 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_7 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__27 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_8 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__28 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_9 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__29 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_10 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__30 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_11 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__31 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_12 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__32 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_13 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__33 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_14 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__34 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_15 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__35 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_16 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__36 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_17 size:= 7200*char
char *const Cost_Parallel_Work_2_Broadca__37 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0 > Cost_Parallel_Work_2_AggregateCost_18 size:= 7200*char
char *const Cost_Parallel_Work_2_Compute__3 = (char*) (Shared+22208);  // Cost_Parallel_Work_2_ComputeHorWeights_0 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__4 = (char*) (Shared+25088);  // Cost_Parallel_Work_2_ComputeHorWeights_2 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__5 = (char*) (Shared+27968);  // Cost_Parallel_Work_2_ComputeHorWeights_4 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_implode__0 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in > Cost_Parallel_Work_0_Broadcast2_0 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__0 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_0 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__1 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_1 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__2 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_2 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__3 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_3 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__4 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_4 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__5 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_5 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__6 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_6 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__7 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_7 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__8 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_8 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__9 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_9 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__10 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_10 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__11 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_11 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__12 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_12 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__13 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_13 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__14 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_14 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__15 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_15 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__16 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_16 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__17 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_17 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__18 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0 > Cost_Parallel_Work_0_AggregateCost_18 size:= 7200*char
char *const Cost_Parallel_Work_0_Compute__0 = (char*) (Shared+29568);  // Cost_Parallel_Work_0_ComputeVertWeights_0 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__1 = (char*) (Shared+32448);  // Cost_Parallel_Work_0_ComputeVertWeights_2 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__2 = (char*) (Shared+35328);  // Cost_Parallel_Work_0_ComputeVertWeights_4 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_implode__1 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in > Cost_Parallel_Work_0_Broadcast3_0 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__19 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_0 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__20 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_1 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__21 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_2 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__22 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_3 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__23 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_4 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__24 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_5 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__25 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_6 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__26 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_7 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__27 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_8 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__28 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_9 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__29 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_10 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__30 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_11 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__31 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_12 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__32 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_13 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__33 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_14 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__34 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_15 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__35 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_16 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__36 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_17 size:= 7200*char
char *const Cost_Parallel_Work_0_Broadca__37 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0 > Cost_Parallel_Work_0_AggregateCost_18 size:= 7200*char
char *const Cost_Parallel_Work_0_Compute__3 = (char*) (Shared+36928);  // Cost_Parallel_Work_0_ComputeHorWeights_0 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__4 = (char*) (Shared+39808);  // Cost_Parallel_Work_0_ComputeHorWeights_2 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__5 = (char*) (Shared+42688);  // Cost_Parallel_Work_0_ComputeHorWeights_4 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__6 = (char*) (Shared+44160);  // Cost_Parallel_Work_0_ComputeVertWeights_1 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__7 = (char*) (Shared+45632);  // Cost_Parallel_Work_0_ComputeHorWeights_1 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__8 = (char*) (Shared+47104);  // Cost_Parallel_Work_0_ComputeVertWeights_3 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_Compute__9 = (char*) (Shared+48576);  // Cost_Parallel_Work_0_ComputeHorWeights_3 > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in size:= 1440*char
char *const BR_Cost_Parallel_Work_1__gra__0 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_9 size:= 480*char
char *const broadcast2_1__BR_Cost_Parall__0 = (char*) (Shared+50176);  // broadcast2_1 > BR_Cost_Parallel_Work_1__grayR size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__1 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_0 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__2 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_1 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__3 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_2 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__4 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_3 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__5 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_4 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__6 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_5 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__7 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_6 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__8 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_7 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__9 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_8 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__10 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_10 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__11 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_11 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__12 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_12 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__13 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_13 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__14 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_14 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__15 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_15 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__16 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_16 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__17 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_17 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__18 = (char*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR > Cost_Parallel_Work_1_CostConstruction_18 size:= 480*char
char *const RGB2Gray_R_1__broadcast2_1__0 = (char*) (Shared+50176);  // RGB2Gray_R_1 > broadcast2_1 size:= 480*char
char *const broadcast2_1__Census_R_1__0 = (char*) (Shared+50176);  // broadcast2_1 > Census_R_1 size:= 480*char
char *const Read_PPM1_1__RGB2Gray_R_1__0 = (char*) (Shared+50296);  // Read_PPM1_1 > RGB2Gray_R_1 size:= 360*char
char *const BR_Cost_Parallel_Work_2__gra__0 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_9 size:= 480*char
char *const broadcast2_2__BR_Cost_Parall__0 = (char*) (Shared+50816);  // broadcast2_2 > BR_Cost_Parallel_Work_2__grayR size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__1 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_0 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__2 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_1 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__3 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_2 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__4 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_3 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__5 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_4 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__6 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_5 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__7 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_6 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__8 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_7 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__9 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_8 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__10 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_10 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__11 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_11 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__12 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_12 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__13 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_13 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__14 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_14 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__15 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_15 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__16 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_16 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__17 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_17 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__18 = (char*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR > Cost_Parallel_Work_2_CostConstruction_18 size:= 480*char
char *const RGB2Gray_R_2__broadcast2_2__0 = (char*) (Shared+50816);  // RGB2Gray_R_2 > broadcast2_2 size:= 480*char
char *const broadcast2_2__Census_R_2__0 = (char*) (Shared+50816);  // broadcast2_2 > Census_R_2 size:= 480*char
char *const Read_PPM1_2__RGB2Gray_R_2__0 = (char*) (Shared+50936);  // Read_PPM1_2 > RGB2Gray_R_2 size:= 360*char
char *const BR_Cost_Parallel_Work_0__gra__0 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_9 size:= 480*char
char *const broadcast1_0__BR_Cost_Parall__0 = (char*) (Shared+51456);  // broadcast1_0 > BR_Cost_Parallel_Work_0__grayL size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__1 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_0 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__2 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_1 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__3 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_2 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__4 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_3 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__5 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_4 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__6 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_5 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__7 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_6 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__8 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_7 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__9 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_8 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__10 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_10 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__11 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_11 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__12 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_12 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__13 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_13 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__14 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_14 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__15 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_15 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__16 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_16 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__17 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_17 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__18 = (char*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL > Cost_Parallel_Work_0_CostConstruction_18 size:= 480*char
char *const RGB2Gray_L_0__broadcast1_0__0 = (char*) (Shared+51456);  // RGB2Gray_L_0 > broadcast1_0 size:= 480*char
char *const broadcast1_0__Census_L_0__0 = (char*) (Shared+51456);  // broadcast1_0 > Census_L_0 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__19 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_9 size:= 480*char
char *const broadcast1_1__BR_Cost_Parall__0 = (char*) (Shared+52096);  // broadcast1_1 > BR_Cost_Parallel_Work_1__grayL size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__20 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_0 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__21 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_1 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__22 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_2 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__23 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_3 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__24 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_4 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__25 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_5 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__26 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_6 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__27 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_7 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__28 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_8 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__29 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_10 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__30 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_11 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__31 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_12 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__32 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_13 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__33 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_14 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__34 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_15 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__35 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_16 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__36 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_17 size:= 480*char
char *const BR_Cost_Parallel_Work_1__gra__37 = (char*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL > Cost_Parallel_Work_1_CostConstruction_18 size:= 480*char
char *const RGB2Gray_L_1__broadcast1_1__0 = (char*) (Shared+52096);  // RGB2Gray_L_1 > broadcast1_1 size:= 480*char
char *const broadcast1_1__Census_L_1__0 = (char*) (Shared+52096);  // broadcast1_1 > Census_L_1 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__19 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_9 size:= 480*char
char *const broadcast1_2__BR_Cost_Parall__0 = (char*) (Shared+52736);  // broadcast1_2 > BR_Cost_Parallel_Work_2__grayL size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__20 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_0 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__21 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_1 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__22 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_2 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__23 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_3 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__24 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_4 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__25 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_5 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__26 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_6 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__27 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_7 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__28 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_8 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__29 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_10 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__30 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_11 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__31 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_12 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__32 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_13 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__33 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_14 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__34 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_15 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__35 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_16 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__36 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_17 size:= 480*char
char *const BR_Cost_Parallel_Work_2__gra__37 = (char*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL > Cost_Parallel_Work_2_CostConstruction_18 size:= 480*char
char *const RGB2Gray_L_2__broadcast1_2__0 = (char*) (Shared+52736);  // RGB2Gray_L_2 > broadcast1_2 size:= 480*char
char *const broadcast1_2__Census_L_2__0 = (char*) (Shared+52736);  // broadcast1_2 > Census_L_2 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__19 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_9 size:= 480*char
char *const broadcast2_0__BR_Cost_Parall__0 = (char*) (Shared+53376);  // broadcast2_0 > BR_Cost_Parallel_Work_0__grayR size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__20 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_0 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__21 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_1 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__22 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_2 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__23 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_3 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__24 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_4 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__25 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_5 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__26 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_6 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__27 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_7 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__28 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_8 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__29 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_10 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__30 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_11 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__31 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_12 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__32 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_13 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__33 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_14 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__34 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_15 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__35 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_16 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__36 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_17 size:= 480*char
char *const BR_Cost_Parallel_Work_0__gra__37 = (char*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR > Cost_Parallel_Work_0_CostConstruction_18 size:= 480*char
char *const RGB2Gray_R_0__broadcast2_0__0 = (char*) (Shared+53376);  // RGB2Gray_R_0 > broadcast2_0 size:= 480*char
char *const broadcast2_0__Census_R_0__0 = (char*) (Shared+53376);  // broadcast2_0 > Census_R_0 size:= 480*char
char *const Read_PPM1_0__RGB2Gray_R_0__0 = (char*) (Shared+53496);  // Read_PPM1_0 > RGB2Gray_R_0 size:= 360*char
char *const Cost_Parallel_Work_1_dispari__0 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_8 > Cost_Parallel_Work_1_disparitySelect_9 size:= 484*char
char *const Cost_Parallel_Work_init_in_d__0 = (char*) (Shared+54016);  // Cost_Parallel_Work_init_in_disparitySelect_bestCostFeed > Cost_Parallel_Work_0_disparitySelect_0 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__0 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_0 > Cost_Parallel_Work_0_disparitySelect_1 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__1 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_1 > Cost_Parallel_Work_0_disparitySelect_2 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__2 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_2 > Cost_Parallel_Work_0_disparitySelect_3 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__3 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_3 > Cost_Parallel_Work_0_disparitySelect_4 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__4 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_4 > Cost_Parallel_Work_0_disparitySelect_5 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__5 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_5 > Cost_Parallel_Work_0_disparitySelect_6 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__6 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_6 > Cost_Parallel_Work_0_disparitySelect_7 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__7 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_7 > Cost_Parallel_Work_0_disparitySelect_8 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__8 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_8 > Cost_Parallel_Work_0_disparitySelect_9 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__9 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_9 > Cost_Parallel_Work_0_disparitySelect_10 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__10 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_10 > Cost_Parallel_Work_0_disparitySelect_11 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__11 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_11 > Cost_Parallel_Work_0_disparitySelect_12 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__12 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_12 > Cost_Parallel_Work_0_disparitySelect_13 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__13 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_13 > Cost_Parallel_Work_0_disparitySelect_14 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__14 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_14 > Cost_Parallel_Work_0_disparitySelect_15 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__15 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_15 > Cost_Parallel_Work_0_disparitySelect_16 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__16 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_16 > Cost_Parallel_Work_0_disparitySelect_17 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__17 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_17 > Cost_Parallel_Work_0_disparitySelect_18 size:= 484*char
char *const Cost_Parallel_Work_0_dispari__18 = (char*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_18 > Cost_Parallel_Work_1_disparitySelect_0 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__1 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_0 > Cost_Parallel_Work_1_disparitySelect_1 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__2 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_1 > Cost_Parallel_Work_1_disparitySelect_2 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__3 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_2 > Cost_Parallel_Work_1_disparitySelect_3 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__4 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_3 > Cost_Parallel_Work_1_disparitySelect_4 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__5 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_4 > Cost_Parallel_Work_1_disparitySelect_5 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__6 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_5 > Cost_Parallel_Work_1_disparitySelect_6 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__7 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_6 > Cost_Parallel_Work_1_disparitySelect_7 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__8 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_7 > Cost_Parallel_Work_1_disparitySelect_8 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__9 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_9 > Cost_Parallel_Work_1_disparitySelect_10 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__10 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_10 > Cost_Parallel_Work_1_disparitySelect_11 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__11 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_11 > Cost_Parallel_Work_1_disparitySelect_12 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__12 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_12 > Cost_Parallel_Work_1_disparitySelect_13 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__13 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_13 > Cost_Parallel_Work_1_disparitySelect_14 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__14 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_14 > Cost_Parallel_Work_1_disparitySelect_15 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__15 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_15 > Cost_Parallel_Work_1_disparitySelect_16 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__16 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_16 > Cost_Parallel_Work_1_disparitySelect_17 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__17 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_17 > Cost_Parallel_Work_1_disparitySelect_18 size:= 484*char
char *const Cost_Parallel_Work_1_dispari__18 = (char*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_18 > Cost_Parallel_Work_2_disparitySelect_0 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__0 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_0 > Cost_Parallel_Work_2_disparitySelect_1 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__1 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_1 > Cost_Parallel_Work_2_disparitySelect_2 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__2 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_2 > Cost_Parallel_Work_2_disparitySelect_3 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__3 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_3 > Cost_Parallel_Work_2_disparitySelect_4 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__4 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_4 > Cost_Parallel_Work_2_disparitySelect_5 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__5 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_5 > Cost_Parallel_Work_2_disparitySelect_6 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__6 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_6 > Cost_Parallel_Work_2_disparitySelect_7 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__7 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_7 > Cost_Parallel_Work_2_disparitySelect_8 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__8 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_8 > Cost_Parallel_Work_2_disparitySelect_9 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__9 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_9 > Cost_Parallel_Work_2_disparitySelect_10 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__10 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_10 > Cost_Parallel_Work_2_disparitySelect_11 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__11 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_11 > Cost_Parallel_Work_2_disparitySelect_12 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__12 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_12 > Cost_Parallel_Work_2_disparitySelect_13 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__13 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_13 > Cost_Parallel_Work_2_disparitySelect_14 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__14 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_14 > Cost_Parallel_Work_2_disparitySelect_15 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__15 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_15 > Cost_Parallel_Work_2_disparitySelect_16 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__16 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_16 > Cost_Parallel_Work_2_disparitySelect_17 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__17 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_17 > Cost_Parallel_Work_2_disparitySelect_18 size:= 484*char
char *const Cost_Parallel_Work_2_dispari__18 = (char*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_18 > Cost_Parallel_Work_end_out_disparitySelect_backBestCost size:= 484*char
char *const Split_1__explode_Split_1_out__0 = (char*) (Shared+53376);  // Split_1 > explode_Split_1_output size:= 480*char
char *const explode_Split_1_output__Medi__0 = (char*) (Shared+53400);  // explode_Split_1_output > Median_Filter_14 size:= 36*char
char *const explode_Split_1_output__Medi__1 = (char*) (Shared+53436);  // explode_Split_1_output > Median_Filter_15 size:= 36*char
char *const explode_Split_1_output__Medi__2 = (char*) (Shared+53472);  // explode_Split_1_output > Median_Filter_16 size:= 36*char
char *const explode_Split_1_output__Medi__3 = (char*) (Shared+53508);  // explode_Split_1_output > Median_Filter_17 size:= 36*char
char *const explode_Split_1_output__Medi__4 = (char*) (Shared+53544);  // explode_Split_1_output > Median_Filter_18 size:= 36*char
char *const explode_Split_1_output__Medi__5 = (char*) (Shared+53580);  // explode_Split_1_output > Median_Filter_19 size:= 36*char
char *const explode_Split_1_output__Medi__6 = (char*) (Shared+53616);  // explode_Split_1_output > Median_Filter_20 size:= 36*char
char *const explode_Split_1_output__Medi__7 = (char*) (Shared+53652);  // explode_Split_1_output > Median_Filter_21 size:= 36*char
char *const explode_Split_1_output__Medi__8 = (char*) (Shared+53688);  // explode_Split_1_output > Median_Filter_22 size:= 36*char
char *const explode_Split_1_output__Medi__9 = (char*) (Shared+53724);  // explode_Split_1_output > Median_Filter_23 size:= 36*char
char *const explode_Split_1_output__Medi__10 = (char*) (Shared+53760);  // explode_Split_1_output > Median_Filter_24 size:= 36*char
char *const explode_Split_1_output__Medi__11 = (char*) (Shared+53796);  // explode_Split_1_output > Median_Filter_25 size:= 36*char
char *const explode_Split_2_output__impl__0 = (char*) (Shared+128);  // explode_Split_2_output > implode_Median_Filter_26_rawDisparity size:= 12*char
char *const Split_2__explode_Split_2_out__0 = (char*) (Shared+128);  // Split_2 > explode_Split_2_output size:= 480*char
char *const explode_Split_2_output__Medi__0 = (char*) (Shared+140);  // explode_Split_2_output > Median_Filter_27 size:= 36*char
char *const explode_Split_2_output__Medi__1 = (char*) (Shared+176);  // explode_Split_2_output > Median_Filter_28 size:= 36*char
char *const explode_Split_2_output__Medi__2 = (char*) (Shared+212);  // explode_Split_2_output > Median_Filter_29 size:= 36*char
char *const explode_Split_2_output__Medi__3 = (char*) (Shared+248);  // explode_Split_2_output > Median_Filter_30 size:= 36*char
char *const explode_Split_2_output__Medi__4 = (char*) (Shared+284);  // explode_Split_2_output > Median_Filter_31 size:= 36*char
char *const explode_Split_2_output__Medi__5 = (char*) (Shared+320);  // explode_Split_2_output > Median_Filter_32 size:= 36*char
char *const explode_Split_2_output__Medi__6 = (char*) (Shared+356);  // explode_Split_2_output > Median_Filter_33 size:= 36*char
char *const explode_Split_2_output__Medi__7 = (char*) (Shared+392);  // explode_Split_2_output > Median_Filter_34 size:= 36*char
char *const explode_Split_2_output__Medi__8 = (char*) (Shared+428);  // explode_Split_2_output > Median_Filter_35 size:= 36*char
char *const explode_Split_2_output__Medi__9 = (char*) (Shared+464);  // explode_Split_2_output > Median_Filter_36 size:= 36*char
char *const explode_Split_2_output__Medi__10 = (char*) (Shared+500);  // explode_Split_2_output > Median_Filter_37 size:= 36*char
char *const explode_Split_2_output__Medi__11 = (char*) (Shared+536);  // explode_Split_2_output > Median_Filter_38 size:= 36*char
char *const explode_Split_2_output__Medi__12 = (char*) (Shared+572);  // explode_Split_2_output > Median_Filter_39 size:= 36*char
char *const explode_Split_0_output__impl__0 = (char*) (Shared+51904);  // explode_Split_0_output > implode_Median_Filter_13_rawDisparity size:= 12*char
char *const Split_0__explode_Split_0_out__0 = (char*) (Shared+51436);  // Split_0 > explode_Split_0_output size:= 480*char
char *const explode_Split_0_output__Medi__0 = (char*) (Shared+51436);  // explode_Split_0_output > Median_Filter_0 size:= 36*char
char *const explode_Split_0_output__Medi__1 = (char*) (Shared+51472);  // explode_Split_0_output > Median_Filter_1 size:= 36*char
char *const explode_Split_0_output__Medi__2 = (char*) (Shared+51508);  // explode_Split_0_output > Median_Filter_2 size:= 36*char
char *const explode_Split_0_output__Medi__3 = (char*) (Shared+51544);  // explode_Split_0_output > Median_Filter_3 size:= 36*char
char *const explode_Split_0_output__Medi__4 = (char*) (Shared+51580);  // explode_Split_0_output > Median_Filter_4 size:= 36*char
char *const explode_Split_0_output__Medi__5 = (char*) (Shared+51616);  // explode_Split_0_output > Median_Filter_5 size:= 36*char
char *const explode_Split_0_output__Medi__6 = (char*) (Shared+51652);  // explode_Split_0_output > Median_Filter_6 size:= 36*char
char *const explode_Split_0_output__Medi__7 = (char*) (Shared+51688);  // explode_Split_0_output > Median_Filter_7 size:= 36*char
char *const explode_Split_0_output__Medi__8 = (char*) (Shared+51724);  // explode_Split_0_output > Median_Filter_8 size:= 36*char
char *const explode_Split_0_output__Medi__9 = (char*) (Shared+51760);  // explode_Split_0_output > Median_Filter_9 size:= 36*char
char *const explode_Split_0_output__Medi__10 = (char*) (Shared+51796);  // explode_Split_0_output > Median_Filter_10 size:= 36*char
char *const explode_Split_0_output__Medi__11 = (char*) (Shared+51832);  // explode_Split_0_output > Median_Filter_11 size:= 36*char
char *const explode_Split_0_output__Medi__12 = (char*) (Shared+51868);  // explode_Split_0_output > Median_Filter_12 size:= 36*char
char *const BR_Cost_Parallel_Work_0__rgb__0 = (char*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL > Cost_Parallel_Work_0_Broadcast1_4 size:= 360*char
char *const Broadcast0_0__BR_Cost_Parall__0 = (char*) (Shared+1728);  // Broadcast0_0 > BR_Cost_Parallel_Work_0__rgbL size:= 360*char
char *const Read_PPM0_0__Broadcast0_0__0 = (char*) (Shared+1728);  // Read_PPM0_0 > Broadcast0_0 size:= 360*char
char *const Broadcast0_0__Display_rgb0_0__0 = (char*) (Shared+1728);  // Broadcast0_0 > Display_rgb0_0 size:= 360*char
char *const Broadcast0_0__RGB2Gray_L_0__0 = (char*) (Shared+1728);  // Broadcast0_0 > RGB2Gray_L_0 size:= 360*char
char *const BR_Cost_Parallel_Work_0__rgb__1 = (char*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL > Cost_Parallel_Work_0_Broadcast1_0 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__38 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_0 > Cost_Parallel_Work_0_ComputeVertWeights_0 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__39 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_0 > Cost_Parallel_Work_0_ComputeHorWeights_0 size:= 360*char
char *const BR_Cost_Parallel_Work_0__rgb__2 = (char*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL > Cost_Parallel_Work_0_Broadcast1_1 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__40 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_1 > Cost_Parallel_Work_0_ComputeVertWeights_1 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__41 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_1 > Cost_Parallel_Work_0_ComputeHorWeights_1 size:= 360*char
char *const BR_Cost_Parallel_Work_0__rgb__3 = (char*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL > Cost_Parallel_Work_0_Broadcast1_2 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__42 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_2 > Cost_Parallel_Work_0_ComputeVertWeights_2 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__43 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_2 > Cost_Parallel_Work_0_ComputeHorWeights_2 size:= 360*char
char *const BR_Cost_Parallel_Work_0__rgb__4 = (char*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL > Cost_Parallel_Work_0_Broadcast1_3 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__44 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_3 > Cost_Parallel_Work_0_ComputeVertWeights_3 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__45 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_3 > Cost_Parallel_Work_0_ComputeHorWeights_3 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__46 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_4 > Cost_Parallel_Work_0_ComputeVertWeights_4 size:= 360*char
char *const Cost_Parallel_Work_0_Broadca__47 = (char*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_4 > Cost_Parallel_Work_0_ComputeHorWeights_4 size:= 360*char
char *const BR_Cost_Parallel_Work_1__rgb__0 = (char*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL > Cost_Parallel_Work_1_Broadcast1_4 size:= 360*char
char *const Broadcast0_1__BR_Cost_Parall__0 = (char*) (Shared+2240);  // Broadcast0_1 > BR_Cost_Parallel_Work_1__rgbL size:= 360*char
char *const Read_PPM0_1__Broadcast0_1__0 = (char*) (Shared+2240);  // Read_PPM0_1 > Broadcast0_1 size:= 360*char
char *const Broadcast0_1__Display_rgb0_1__0 = (char*) (Shared+2240);  // Broadcast0_1 > Display_rgb0_1 size:= 360*char
char *const Broadcast0_1__RGB2Gray_L_1__0 = (char*) (Shared+2240);  // Broadcast0_1 > RGB2Gray_L_1 size:= 360*char
char *const BR_Cost_Parallel_Work_1__rgb__1 = (char*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL > Cost_Parallel_Work_1_Broadcast1_0 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__38 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_0 > Cost_Parallel_Work_1_ComputeVertWeights_0 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__39 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_0 > Cost_Parallel_Work_1_ComputeHorWeights_0 size:= 360*char
char *const BR_Cost_Parallel_Work_1__rgb__2 = (char*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL > Cost_Parallel_Work_1_Broadcast1_1 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__40 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_1 > Cost_Parallel_Work_1_ComputeVertWeights_1 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__41 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_1 > Cost_Parallel_Work_1_ComputeHorWeights_1 size:= 360*char
char *const BR_Cost_Parallel_Work_1__rgb__3 = (char*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL > Cost_Parallel_Work_1_Broadcast1_2 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__42 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_2 > Cost_Parallel_Work_1_ComputeVertWeights_2 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__43 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_2 > Cost_Parallel_Work_1_ComputeHorWeights_2 size:= 360*char
char *const BR_Cost_Parallel_Work_1__rgb__4 = (char*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL > Cost_Parallel_Work_1_Broadcast1_3 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__44 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_3 > Cost_Parallel_Work_1_ComputeVertWeights_3 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__45 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_3 > Cost_Parallel_Work_1_ComputeHorWeights_3 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__46 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_4 > Cost_Parallel_Work_1_ComputeVertWeights_4 size:= 360*char
char *const Cost_Parallel_Work_1_Broadca__47 = (char*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_4 > Cost_Parallel_Work_1_ComputeHorWeights_4 size:= 360*char
char *const BR_Cost_Parallel_Work_2__rgb__0 = (char*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL > Cost_Parallel_Work_2_Broadcast1_4 size:= 360*char
char *const Broadcast0_2__BR_Cost_Parall__0 = (char*) (Shared+4608);  // Broadcast0_2 > BR_Cost_Parallel_Work_2__rgbL size:= 360*char
char *const Read_PPM0_2__Broadcast0_2__0 = (char*) (Shared+4608);  // Read_PPM0_2 > Broadcast0_2 size:= 360*char
char *const Broadcast0_2__Display_rgb0_2__0 = (char*) (Shared+4608);  // Broadcast0_2 > Display_rgb0_2 size:= 360*char
char *const Broadcast0_2__RGB2Gray_L_2__0 = (char*) (Shared+4608);  // Broadcast0_2 > RGB2Gray_L_2 size:= 360*char
char *const BR_Cost_Parallel_Work_2__rgb__1 = (char*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL > Cost_Parallel_Work_2_Broadcast1_0 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__38 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_0 > Cost_Parallel_Work_2_ComputeVertWeights_0 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__39 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_0 > Cost_Parallel_Work_2_ComputeHorWeights_0 size:= 360*char
char *const BR_Cost_Parallel_Work_2__rgb__2 = (char*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL > Cost_Parallel_Work_2_Broadcast1_1 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__40 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_1 > Cost_Parallel_Work_2_ComputeVertWeights_1 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__41 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_1 > Cost_Parallel_Work_2_ComputeHorWeights_1 size:= 360*char
char *const BR_Cost_Parallel_Work_2__rgb__3 = (char*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL > Cost_Parallel_Work_2_Broadcast1_2 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__42 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_2 > Cost_Parallel_Work_2_ComputeVertWeights_2 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__43 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_2 > Cost_Parallel_Work_2_ComputeHorWeights_2 size:= 360*char
char *const BR_Cost_Parallel_Work_2__rgb__4 = (char*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL > Cost_Parallel_Work_2_Broadcast1_3 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__44 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_3 > Cost_Parallel_Work_2_ComputeVertWeights_3 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__45 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_3 > Cost_Parallel_Work_2_ComputeHorWeights_3 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__46 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_4 > Cost_Parallel_Work_2_ComputeVertWeights_4 size:= 360*char
char *const Cost_Parallel_Work_2_Broadca__47 = (char*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_4 > Cost_Parallel_Work_2_ComputeHorWeights_4 size:= 360*char
char *const Cost_Parallel_Work_0_CostCon__0 = (char*) (Shared+45632);  // Cost_Parallel_Work_0_CostConstruction_6 > Cost_Parallel_Work_0_AggregateCost_6 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__1 = (char*) (Shared+54528);  // Cost_Parallel_Work_0_CostConstruction_4 > Cost_Parallel_Work_0_AggregateCost_4 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__2 = (char*) (Shared+44160);  // Cost_Parallel_Work_0_CostConstruction_5 > Cost_Parallel_Work_0_AggregateCost_5 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__3 = (char*) (Shared+55040);  // Cost_Parallel_Work_0_CostConstruction_7 > Cost_Parallel_Work_0_AggregateCost_7 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__0 = (char*) (Shared+44672);  // Cost_Parallel_Work_0_AggregateCost_2 > Cost_Parallel_Work_0_disparitySelect_2 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__1 = (char*) (Shared+46144);  // Cost_Parallel_Work_0_AggregateCost_4 > Cost_Parallel_Work_0_disparitySelect_4 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__2 = (char*) (Shared+54528);  // Cost_Parallel_Work_0_AggregateCost_7 > Cost_Parallel_Work_0_disparitySelect_7 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__3 = (char*) (Shared+46656);  // Cost_Parallel_Work_0_AggregateCost_1 > Cost_Parallel_Work_0_disparitySelect_1 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__4 = (char*) (Shared+47168);  // Cost_Parallel_Work_0_AggregateCost_3 > Cost_Parallel_Work_0_disparitySelect_3 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__5 = (char*) (Shared+47680);  // Cost_Parallel_Work_0_AggregateCost_5 > Cost_Parallel_Work_0_disparitySelect_5 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__6 = (char*) (Shared+48192);  // Cost_Parallel_Work_0_AggregateCost_6 > Cost_Parallel_Work_0_disparitySelect_6 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__7 = (char*) (Shared+45184);  // Cost_Parallel_Work_0_AggregateCost_8 > Cost_Parallel_Work_0_disparitySelect_8 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__8 = (char*) (Shared+44160);  // Cost_Parallel_Work_0_AggregateCost_9 > Cost_Parallel_Work_0_disparitySelect_9 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__9 = (char*) (Shared+44672);  // Cost_Parallel_Work_0_AggregateCost_10 > Cost_Parallel_Work_0_disparitySelect_10 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__10 = (char*) (Shared+46656);  // Cost_Parallel_Work_0_AggregateCost_11 > Cost_Parallel_Work_0_disparitySelect_11 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__11 = (char*) (Shared+46144);  // Cost_Parallel_Work_0_AggregateCost_12 > Cost_Parallel_Work_0_disparitySelect_12 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__12 = (char*) (Shared+47168);  // Cost_Parallel_Work_0_AggregateCost_13 > Cost_Parallel_Work_0_disparitySelect_13 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__13 = (char*) (Shared+47680);  // Cost_Parallel_Work_0_AggregateCost_14 > Cost_Parallel_Work_0_disparitySelect_14 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__14 = (char*) (Shared+48192);  // Cost_Parallel_Work_0_AggregateCost_15 > Cost_Parallel_Work_0_disparitySelect_15 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__15 = (char*) (Shared+45184);  // Cost_Parallel_Work_0_AggregateCost_16 > Cost_Parallel_Work_0_disparitySelect_16 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__16 = (char*) (Shared+44160);  // Cost_Parallel_Work_0_AggregateCost_17 > Cost_Parallel_Work_0_disparitySelect_17 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__17 = (char*) (Shared+44672);  // Cost_Parallel_Work_0_AggregateCost_18 > Cost_Parallel_Work_0_disparitySelect_18 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__0 = (char*) (Shared+46656);  // Cost_Parallel_Work_1_AggregateCost_0 > Cost_Parallel_Work_1_disparitySelect_0 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__1 = (char*) (Shared+45696);  // Cost_Parallel_Work_1_AggregateCost_1 > Cost_Parallel_Work_1_disparitySelect_1 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__2 = (char*) (Shared+47168);  // Cost_Parallel_Work_1_AggregateCost_2 > Cost_Parallel_Work_1_disparitySelect_2 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__3 = (char*) (Shared+47680);  // Cost_Parallel_Work_1_AggregateCost_3 > Cost_Parallel_Work_1_disparitySelect_3 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__4 = (char*) (Shared+48192);  // Cost_Parallel_Work_1_AggregateCost_4 > Cost_Parallel_Work_1_disparitySelect_4 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__5 = (char*) (Shared+45184);  // Cost_Parallel_Work_1_AggregateCost_5 > Cost_Parallel_Work_1_disparitySelect_5 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__6 = (char*) (Shared+44160);  // Cost_Parallel_Work_1_AggregateCost_6 > Cost_Parallel_Work_1_disparitySelect_6 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__7 = (char*) (Shared+44672);  // Cost_Parallel_Work_1_AggregateCost_7 > Cost_Parallel_Work_1_disparitySelect_7 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__8 = (char*) (Shared+53248);  // Cost_Parallel_Work_1_AggregateCost_8 > Cost_Parallel_Work_1_disparitySelect_8 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__9 = (char*) (Shared+51328);  // Cost_Parallel_Work_1_AggregateCost_9 > Cost_Parallel_Work_1_disparitySelect_9 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__10 = (char*) (Shared+48704);  // Cost_Parallel_Work_1_AggregateCost_10 > Cost_Parallel_Work_1_disparitySelect_10 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__11 = (char*) (Shared+49216);  // Cost_Parallel_Work_1_AggregateCost_11 > Cost_Parallel_Work_1_disparitySelect_11 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__12 = (char*) (Shared+45696);  // Cost_Parallel_Work_1_AggregateCost_12 > Cost_Parallel_Work_1_disparitySelect_12 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__13 = (char*) (Shared+45184);  // Cost_Parallel_Work_1_AggregateCost_13 > Cost_Parallel_Work_1_disparitySelect_13 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__14 = (char*) (Shared+46208);  // Cost_Parallel_Work_1_AggregateCost_14 > Cost_Parallel_Work_1_disparitySelect_14 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__15 = (char*) (Shared+46720);  // Cost_Parallel_Work_1_AggregateCost_15 > Cost_Parallel_Work_1_disparitySelect_15 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__16 = (char*) (Shared+53248);  // Cost_Parallel_Work_1_AggregateCost_16 > Cost_Parallel_Work_1_disparitySelect_16 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__17 = (char*) (Shared+51328);  // Cost_Parallel_Work_1_AggregateCost_17 > Cost_Parallel_Work_1_disparitySelect_17 size:= 480*char
char *const Cost_Parallel_Work_1_Aggrega__18 = (char*) (Shared+47232);  // Cost_Parallel_Work_1_AggregateCost_18 > Cost_Parallel_Work_1_disparitySelect_18 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__0 = (char*) (Shared+47744);  // Cost_Parallel_Work_2_AggregateCost_0 > Cost_Parallel_Work_2_disparitySelect_0 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__1 = (char*) (Shared+45696);  // Cost_Parallel_Work_2_AggregateCost_1 > Cost_Parallel_Work_2_disparitySelect_1 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__2 = (char*) (Shared+48256);  // Cost_Parallel_Work_2_AggregateCost_2 > Cost_Parallel_Work_2_disparitySelect_2 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__3 = (char*) (Shared+46208);  // Cost_Parallel_Work_2_AggregateCost_3 > Cost_Parallel_Work_2_disparitySelect_3 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__4 = (char*) (Shared+46720);  // Cost_Parallel_Work_2_AggregateCost_4 > Cost_Parallel_Work_2_disparitySelect_4 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__5 = (char*) (Shared+48768);  // Cost_Parallel_Work_2_AggregateCost_5 > Cost_Parallel_Work_2_disparitySelect_5 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__6 = (char*) (Shared+51328);  // Cost_Parallel_Work_2_AggregateCost_6 > Cost_Parallel_Work_2_disparitySelect_6 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__7 = (char*) (Shared+47232);  // Cost_Parallel_Work_2_AggregateCost_7 > Cost_Parallel_Work_2_disparitySelect_7 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__8 = (char*) (Shared+47744);  // Cost_Parallel_Work_2_AggregateCost_8 > Cost_Parallel_Work_2_disparitySelect_8 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__9 = (char*) (Shared+51968);  // Cost_Parallel_Work_2_AggregateCost_9 > Cost_Parallel_Work_2_disparitySelect_9 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__10 = (char*) (Shared+48256);  // Cost_Parallel_Work_2_AggregateCost_10 > Cost_Parallel_Work_2_disparitySelect_10 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__11 = (char*) (Shared+49280);  // Cost_Parallel_Work_2_AggregateCost_11 > Cost_Parallel_Work_2_disparitySelect_11 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__12 = (char*) (Shared+49792);  // Cost_Parallel_Work_2_AggregateCost_12 > Cost_Parallel_Work_2_disparitySelect_12 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__13 = (char*) (Shared+48768);  // Cost_Parallel_Work_2_AggregateCost_13 > Cost_Parallel_Work_2_disparitySelect_13 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__14 = (char*) (Shared+50304);  // Cost_Parallel_Work_2_AggregateCost_14 > Cost_Parallel_Work_2_disparitySelect_14 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__15 = (char*) (Shared+51328);  // Cost_Parallel_Work_2_AggregateCost_15 > Cost_Parallel_Work_2_disparitySelect_15 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__16 = (char*) (Shared+0);  // Cost_Parallel_Work_2_AggregateCost_16 > Cost_Parallel_Work_2_disparitySelect_16 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__17 = (char*) (Shared+51968);  // Cost_Parallel_Work_2_AggregateCost_17 > Cost_Parallel_Work_2_disparitySelect_17 size:= 480*char
char *const Cost_Parallel_Work_2_Aggrega__18 = (char*) (Shared+512);  // Cost_Parallel_Work_2_AggregateCost_18 > Cost_Parallel_Work_2_disparitySelect_18 size:= 480*char
char *const BR_Cost_Parallel_Work_0__cen__0 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_9 size:= 120*char
char *const Census_L_0__BR_Cost_Parallel__0 = (char*) (Shared+55680);  // Census_L_0 > BR_Cost_Parallel_Work_0__cenL size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__1 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_0 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__2 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_1 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__3 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_2 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__4 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_3 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__5 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_4 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__6 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_5 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__7 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_6 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__8 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_7 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__9 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_8 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__10 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_10 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__11 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_11 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__12 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_12 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__13 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_13 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__14 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_14 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__15 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_15 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__16 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_16 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__17 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_17 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__18 = (char*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL > Cost_Parallel_Work_0_CostConstruction_18 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__19 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_9 size:= 120*char
char *const Census_R_0__BR_Cost_Parallel__0 = (char*) (Shared+55936);  // Census_R_0 > BR_Cost_Parallel_Work_0__cenR size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__20 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_0 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__21 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_1 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__22 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_2 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__23 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_3 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__24 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_4 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__25 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_5 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__26 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_6 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__27 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_7 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__28 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_8 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__29 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_10 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__30 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_11 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__31 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_12 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__32 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_13 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__33 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_14 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__34 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_15 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__35 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_16 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__36 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_17 size:= 120*char
char *const BR_Cost_Parallel_Work_0__cen__37 = (char*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR > Cost_Parallel_Work_0_CostConstruction_18 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__0 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_9 size:= 120*char
char *const Census_R_1__BR_Cost_Parallel__0 = (char*) (Shared+56192);  // Census_R_1 > BR_Cost_Parallel_Work_1__cenR size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__1 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_0 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__2 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_1 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__3 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_2 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__4 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_3 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__5 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_4 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__6 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_5 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__7 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_6 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__8 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_7 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__9 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_8 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__10 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_10 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__11 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_11 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__12 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_12 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__13 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_13 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__14 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_14 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__15 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_15 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__16 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_16 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__17 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_17 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__18 = (char*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR > Cost_Parallel_Work_1_CostConstruction_18 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__0 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_9 size:= 120*char
char *const Census_R_2__BR_Cost_Parallel__0 = (char*) (Shared+56448);  // Census_R_2 > BR_Cost_Parallel_Work_2__cenR size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__1 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_0 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__2 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_1 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__3 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_2 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__4 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_3 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__5 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_4 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__6 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_5 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__7 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_6 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__8 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_7 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__9 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_8 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__10 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_10 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__11 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_11 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__12 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_12 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__13 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_13 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__14 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_14 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__15 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_15 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__16 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_16 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__17 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_17 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__18 = (char*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR > Cost_Parallel_Work_2_CostConstruction_18 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__19 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_9 size:= 120*char
char *const Census_L_1__BR_Cost_Parallel__0 = (char*) (Shared+56704);  // Census_L_1 > BR_Cost_Parallel_Work_1__cenL size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__20 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_0 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__21 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_1 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__22 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_2 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__23 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_3 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__24 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_4 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__25 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_5 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__26 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_6 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__27 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_7 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__28 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_8 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__29 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_10 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__30 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_11 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__31 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_12 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__32 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_13 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__33 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_14 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__34 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_15 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__35 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_16 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__36 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_17 size:= 120*char
char *const BR_Cost_Parallel_Work_1__cen__37 = (char*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL > Cost_Parallel_Work_1_CostConstruction_18 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__19 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_9 size:= 120*char
char *const Census_L_2__BR_Cost_Parallel__0 = (char*) (Shared+56960);  // Census_L_2 > BR_Cost_Parallel_Work_2__cenL size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__20 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_0 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__21 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_1 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__22 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_2 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__23 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_3 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__24 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_4 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__25 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_5 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__26 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_6 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__27 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_7 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__28 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_8 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__29 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_10 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__30 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_11 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__31 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_12 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__32 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_13 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__33 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_14 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__34 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_15 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__35 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_16 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__36 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_17 size:= 120*char
char *const BR_Cost_Parallel_Work_2__cen__37 = (char*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL > Cost_Parallel_Work_2_CostConstruction_18 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__19 = (char*) (Shared+54656);  // Cost_Parallel_Work_0_disparitySelect_11 > Cost_Parallel_Work_0_Broadcast5_11 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__48 = (char*) (Shared+54656);  // Cost_Parallel_Work_0_Broadcast5_11 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_dispari__20 = (char*) (Shared+54912);  // Cost_Parallel_Work_0_disparitySelect_12 > Cost_Parallel_Work_0_Broadcast5_12 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__49 = (char*) (Shared+54912);  // Cost_Parallel_Work_0_Broadcast5_12 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_dispari__21 = (char*) (Shared+46336);  // Cost_Parallel_Work_0_disparitySelect_13 > Cost_Parallel_Work_0_Broadcast5_13 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__50 = (char*) (Shared+46336);  // Cost_Parallel_Work_0_Broadcast5_13 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_dispari__22 = (char*) (Shared+55168);  // Cost_Parallel_Work_0_disparitySelect_14 > Cost_Parallel_Work_0_Broadcast5_14 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__51 = (char*) (Shared+55168);  // Cost_Parallel_Work_0_Broadcast5_14 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_dispari__23 = (char*) (Shared+55424);  // Cost_Parallel_Work_0_disparitySelect_15 > Cost_Parallel_Work_0_Broadcast5_15 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__52 = (char*) (Shared+55424);  // Cost_Parallel_Work_0_Broadcast5_15 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_dispari__24 = (char*) (Shared+48832);  // Cost_Parallel_Work_0_disparitySelect_16 > Cost_Parallel_Work_0_Broadcast5_16 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__53 = (char*) (Shared+48832);  // Cost_Parallel_Work_0_Broadcast5_16 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_dispari__25 = (char*) (Shared+49088);  // Cost_Parallel_Work_0_disparitySelect_17 > Cost_Parallel_Work_0_Broadcast5_17 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__54 = (char*) (Shared+49088);  // Cost_Parallel_Work_0_Broadcast5_17 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const RB_Cost_Parallel_Work_0__raw__0 = (char*) (Shared+55680);  // RB_Cost_Parallel_Work_0__rawDisparity > Split_0 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__55 = (char*) (Shared+55680);  // Cost_Parallel_Work_0_Broadcast5_18 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__19 = (char*) (Shared+53888);  // Cost_Parallel_Work_1_disparitySelect_11 > Cost_Parallel_Work_1_Broadcast5_11 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__48 = (char*) (Shared+53888);  // Cost_Parallel_Work_1_Broadcast5_11 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__20 = (char*) (Shared+49408);  // Cost_Parallel_Work_1_disparitySelect_12 > Cost_Parallel_Work_1_Broadcast5_12 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__49 = (char*) (Shared+49408);  // Cost_Parallel_Work_1_Broadcast5_12 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__21 = (char*) (Shared+49664);  // Cost_Parallel_Work_1_disparitySelect_13 > Cost_Parallel_Work_1_Broadcast5_13 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__50 = (char*) (Shared+49664);  // Cost_Parallel_Work_1_Broadcast5_13 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__22 = (char*) (Shared+54656);  // Cost_Parallel_Work_1_disparitySelect_14 > Cost_Parallel_Work_1_Broadcast5_14 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__51 = (char*) (Shared+54656);  // Cost_Parallel_Work_1_Broadcast5_14 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__23 = (char*) (Shared+54912);  // Cost_Parallel_Work_1_disparitySelect_15 > Cost_Parallel_Work_1_Broadcast5_15 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__52 = (char*) (Shared+54912);  // Cost_Parallel_Work_1_Broadcast5_15 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__24 = (char*) (Shared+55168);  // Cost_Parallel_Work_1_disparitySelect_16 > Cost_Parallel_Work_1_Broadcast5_16 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__53 = (char*) (Shared+55168);  // Cost_Parallel_Work_1_Broadcast5_16 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_dispari__25 = (char*) (Shared+53376);  // Cost_Parallel_Work_1_disparitySelect_17 > Cost_Parallel_Work_1_Broadcast5_17 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__54 = (char*) (Shared+53376);  // Cost_Parallel_Work_1_Broadcast5_17 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const RB_Cost_Parallel_Work_1__raw__0 = (char*) (Shared+56704);  // RB_Cost_Parallel_Work_1__rawDisparity > Split_1 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__55 = (char*) (Shared+56704);  // Cost_Parallel_Work_1_Broadcast5_18 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_dispari__19 = (char*) (Shared+52096);  // Cost_Parallel_Work_2_disparitySelect_18 > Cost_Parallel_Work_2_Broadcast5_18 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__48 = (char*) (Shared+52096);  // Cost_Parallel_Work_2_Broadcast5_18 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const implode_lum2RGB_0_in__lum2RG__0 = (char*) (Shared+55424);  // implode_lum2RGB_0_in > lum2RGB_0 size:= 120*char
char *const lum2RGB_0__Display_RGB1_0__0 = (char*) (Shared+55424);  // lum2RGB_0 > Display_RGB1_0 size:= 120*char
char *const lum2RGB_0__Write_PPM_0__0 = (char*) (Shared+55424);  // lum2RGB_0 > Write_PPM_0 size:= 120*char
char *const Median_Filter_0__implode_lum__0 = (char*) (Shared+55424);  // Median_Filter_0 > implode_lum2RGB_0_in size:= 12*char
char *const implode_lum2RGB_2_in__lum2RG__0 = (char*) (Shared+52608);  // implode_lum2RGB_2_in > lum2RGB_2 size:= 120*char
char *const lum2RGB_2__Display_RGB1_2__0 = (char*) (Shared+52608);  // lum2RGB_2 > Display_RGB1_2 size:= 120*char
char *const lum2RGB_2__Write_PPM_2__0 = (char*) (Shared+52608);  // lum2RGB_2 > Write_PPM_2 size:= 120*char
char *const Median_Filter_20__implode_lu__0 = (char*) (Shared+52608);  // Median_Filter_20 > implode_lum2RGB_2_in size:= 12*char
char *const implode_lum2RGB_3_in__lum2RG__0 = (char*) (Shared+52288);  // implode_lum2RGB_3_in > lum2RGB_3 size:= 120*char
char *const lum2RGB_3__Display_RGB1_3__0 = (char*) (Shared+52288);  // lum2RGB_3 > Display_RGB1_3 size:= 120*char
char *const lum2RGB_3__Write_PPM_3__0 = (char*) (Shared+52288);  // lum2RGB_3 > Write_PPM_3 size:= 120*char
char *const Median_Filter_30__implode_lu__0 = (char*) (Shared+52288);  // Median_Filter_30 > implode_lum2RGB_3_in size:= 12*char
char *const Cost_Parallel_Work_0_OffsetG__0 = (char*) (Shared+2752);  // Cost_Parallel_Work_0_OffsetGen_0 > Cost_Parallel_Work_0_Broadcast0_0 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__56 = (char*) (Shared+2752);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeVertWeights_0 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__57 = (char*) (Shared+2756);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeVertWeights_1 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__58 = (char*) (Shared+2760);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeVertWeights_2 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__59 = (char*) (Shared+2764);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeVertWeights_3 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__60 = (char*) (Shared+2768);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeVertWeights_4 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__61 = (char*) (Shared+2752);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeHorWeights_0 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__62 = (char*) (Shared+2756);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeHorWeights_1 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__63 = (char*) (Shared+2760);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeHorWeights_2 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__64 = (char*) (Shared+2764);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeHorWeights_3 size:= 4*char
char *const Cost_Parallel_Work_0_Broadca__65 = (char*) (Shared+2768);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_ComputeHorWeights_4 size:= 4*char
char *const Cost_Parallel_Work_init_in_C__0 = (char*) (Shared+57216);  // Cost_Parallel_Work_init_in_CostConstruction_back > Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back size:= 8*char
char *const Cost_Parallel_Work_0_explode__0 = (char*) (Shared+57216);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_0 size:= 1*char
char *const Cost_Parallel_Work_2_implode__2 = (char*) (Shared+56704);  // Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back > Cost_Parallel_Work_end_out_Broadcast5_back size:= 8*char
char *const Cost_Parallel_Work_2_Broadca__49 = (char*) (Shared+56704);  // Cost_Parallel_Work_2_Broadcast5_11 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__50 = (char*) (Shared+56705);  // Cost_Parallel_Work_2_Broadcast5_12 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__51 = (char*) (Shared+56706);  // Cost_Parallel_Work_2_Broadcast5_13 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__52 = (char*) (Shared+56707);  // Cost_Parallel_Work_2_Broadcast5_14 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__53 = (char*) (Shared+56708);  // Cost_Parallel_Work_2_Broadcast5_15 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__54 = (char*) (Shared+56709);  // Cost_Parallel_Work_2_Broadcast5_16 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__55 = (char*) (Shared+56710);  // Cost_Parallel_Work_2_Broadcast5_17 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__66 = (char*) (Shared+57408);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_9 size:= 1*char
char *const Cost_Parallel_Work_0_Dispari__0 = (char*) (Shared+57399);  // Cost_Parallel_Work_0_DisparityGen_0 > Cost_Parallel_Work_0_Broadcast4_0 size:= 19*char
char *const Cost_Parallel_Work_0_Broadca__67 = (char*) (Shared+57399);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_0 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__68 = (char*) (Shared+57400);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_1 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__69 = (char*) (Shared+57401);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_2 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__70 = (char*) (Shared+57402);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_3 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__71 = (char*) (Shared+57403);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_4 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__72 = (char*) (Shared+57404);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_5 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__73 = (char*) (Shared+57405);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_6 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__74 = (char*) (Shared+57406);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_7 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__75 = (char*) (Shared+57407);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_8 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__76 = (char*) (Shared+57408);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_9 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__77 = (char*) (Shared+57409);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_10 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__78 = (char*) (Shared+57410);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_11 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__79 = (char*) (Shared+57411);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_12 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__80 = (char*) (Shared+57412);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_13 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__81 = (char*) (Shared+57413);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_14 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__82 = (char*) (Shared+57414);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_15 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__83 = (char*) (Shared+57415);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_16 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__84 = (char*) (Shared+57416);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_17 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__85 = (char*) (Shared+57417);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_CostConstruction_18 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__86 = (char*) (Shared+57399);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_0 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__87 = (char*) (Shared+57400);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_1 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__88 = (char*) (Shared+57401);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_2 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__89 = (char*) (Shared+57402);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_3 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__90 = (char*) (Shared+57403);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_4 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__91 = (char*) (Shared+57404);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_5 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__92 = (char*) (Shared+57405);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_6 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__93 = (char*) (Shared+57406);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_7 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__94 = (char*) (Shared+57407);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_8 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__95 = (char*) (Shared+57409);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_10 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__96 = (char*) (Shared+57410);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_11 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__97 = (char*) (Shared+57411);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_12 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__98 = (char*) (Shared+57412);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_13 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__99 = (char*) (Shared+57413);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_14 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__100 = (char*) (Shared+57414);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_15 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__101 = (char*) (Shared+57415);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_16 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__102 = (char*) (Shared+57416);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_17 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__103 = (char*) (Shared+57417);  // Cost_Parallel_Work_0_Broadcast4_0 > Cost_Parallel_Work_0_disparitySelect_18 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__56 = (char*) (Shared+57600);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_9 size:= 1*char
char *const Cost_Parallel_Work_1_Dispari__0 = (char*) (Shared+57591);  // Cost_Parallel_Work_1_DisparityGen_0 > Cost_Parallel_Work_1_Broadcast4_0 size:= 19*char
char *const Cost_Parallel_Work_1_Broadca__57 = (char*) (Shared+57591);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_0 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__58 = (char*) (Shared+57592);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_1 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__59 = (char*) (Shared+57593);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_2 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__60 = (char*) (Shared+57594);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_3 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__61 = (char*) (Shared+57595);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_4 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__62 = (char*) (Shared+57596);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_5 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__63 = (char*) (Shared+57597);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_6 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__64 = (char*) (Shared+57598);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_7 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__65 = (char*) (Shared+57599);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_8 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__66 = (char*) (Shared+57600);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_9 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__67 = (char*) (Shared+57601);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_10 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__68 = (char*) (Shared+57602);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_11 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__69 = (char*) (Shared+57603);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_12 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__70 = (char*) (Shared+57604);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_13 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__71 = (char*) (Shared+57605);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_14 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__72 = (char*) (Shared+57606);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_15 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__73 = (char*) (Shared+57607);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_16 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__74 = (char*) (Shared+57608);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_17 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__75 = (char*) (Shared+57609);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_CostConstruction_18 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__76 = (char*) (Shared+57591);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_0 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__77 = (char*) (Shared+57592);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_1 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__78 = (char*) (Shared+57593);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_2 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__79 = (char*) (Shared+57594);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_3 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__80 = (char*) (Shared+57595);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_4 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__81 = (char*) (Shared+57596);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_5 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__82 = (char*) (Shared+57597);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_6 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__83 = (char*) (Shared+57598);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_7 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__84 = (char*) (Shared+57599);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_8 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__85 = (char*) (Shared+57601);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_10 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__86 = (char*) (Shared+57602);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_11 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__87 = (char*) (Shared+57603);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_12 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__88 = (char*) (Shared+57604);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_13 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__89 = (char*) (Shared+57605);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_14 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__90 = (char*) (Shared+57606);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_15 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__91 = (char*) (Shared+57607);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_16 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__92 = (char*) (Shared+57608);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_17 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__93 = (char*) (Shared+57609);  // Cost_Parallel_Work_1_Broadcast4_0 > Cost_Parallel_Work_1_disparitySelect_18 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__56 = (char*) (Shared+57792);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_9 size:= 1*char
char *const Cost_Parallel_Work_2_Dispari__0 = (char*) (Shared+57783);  // Cost_Parallel_Work_2_DisparityGen_0 > Cost_Parallel_Work_2_Broadcast4_0 size:= 19*char
char *const Cost_Parallel_Work_2_Broadca__57 = (char*) (Shared+57783);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_0 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__58 = (char*) (Shared+57784);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_1 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__59 = (char*) (Shared+57785);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_2 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__60 = (char*) (Shared+57786);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_3 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__61 = (char*) (Shared+57787);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_4 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__62 = (char*) (Shared+57788);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_5 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__63 = (char*) (Shared+57789);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_6 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__64 = (char*) (Shared+57790);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_7 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__65 = (char*) (Shared+57791);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_8 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__66 = (char*) (Shared+57792);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_9 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__67 = (char*) (Shared+57793);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_10 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__68 = (char*) (Shared+57794);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_11 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__69 = (char*) (Shared+57795);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_12 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__70 = (char*) (Shared+57796);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_13 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__71 = (char*) (Shared+57797);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_14 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__72 = (char*) (Shared+57798);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_15 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__73 = (char*) (Shared+57799);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_16 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__74 = (char*) (Shared+57800);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_17 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__75 = (char*) (Shared+57801);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_CostConstruction_18 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__76 = (char*) (Shared+57783);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_0 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__77 = (char*) (Shared+57784);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_1 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__78 = (char*) (Shared+57785);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_2 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__79 = (char*) (Shared+57786);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_3 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__80 = (char*) (Shared+57787);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_4 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__81 = (char*) (Shared+57788);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_5 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__82 = (char*) (Shared+57789);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_6 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__83 = (char*) (Shared+57790);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_7 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__84 = (char*) (Shared+57791);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_8 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__85 = (char*) (Shared+57793);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_10 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__86 = (char*) (Shared+57794);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_11 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__87 = (char*) (Shared+57795);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_12 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__88 = (char*) (Shared+57796);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_13 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__89 = (char*) (Shared+57797);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_14 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__90 = (char*) (Shared+57798);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_15 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__91 = (char*) (Shared+57799);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_16 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__92 = (char*) (Shared+57800);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_17 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__93 = (char*) (Shared+57801);  // Cost_Parallel_Work_2_Broadcast4_0 > Cost_Parallel_Work_2_disparitySelect_18 size:= 1*char
char *const Cost_Parallel_Work_init_in_d__1 = (char*) (Shared+0);  // Cost_Parallel_Work_init_in_disparitySelect_currentResult > Cost_Parallel_Work_0_disparitySelect_0 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__104 = (char*) (Shared+0);  // Cost_Parallel_Work_0_Broadcast5_0 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__105 = (char*) (Shared+7360);  // Cost_Parallel_Work_0_Broadcast5_1 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__106 = (char*) (Shared+14720);  // Cost_Parallel_Work_0_Broadcast5_2 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__107 = (char*) (Shared+22080);  // Cost_Parallel_Work_0_Broadcast5_3 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__108 = (char*) (Shared+29440);  // Cost_Parallel_Work_0_Broadcast5_4 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__109 = (char*) (Shared+36800);  // Cost_Parallel_Work_0_Broadcast5_5 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__110 = (char*) (Shared+48704);  // Cost_Parallel_Work_0_Broadcast5_6 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__111 = (char*) (Shared+48960);  // Cost_Parallel_Work_0_Broadcast5_7 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__112 = (char*) (Shared+50688);  // Cost_Parallel_Work_0_Broadcast5_8 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__113 = (char*) (Shared+51328);  // Cost_Parallel_Work_0_Broadcast5_9 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__114 = (char*) (Shared+51968);  // Cost_Parallel_Work_0_Broadcast5_10 > RB_Cost_Parallel_Work_0__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__94 = (char*) (Shared+52608);  // Cost_Parallel_Work_1_Broadcast5_0 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__95 = (char*) (Shared+53760);  // Cost_Parallel_Work_1_Broadcast5_1 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__96 = (char*) (Shared+54528);  // Cost_Parallel_Work_1_Broadcast5_2 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__97 = (char*) (Shared+54784);  // Cost_Parallel_Work_1_Broadcast5_3 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__98 = (char*) (Shared+55040);  // Cost_Parallel_Work_1_Broadcast5_4 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__99 = (char*) (Shared+55296);  // Cost_Parallel_Work_1_Broadcast5_5 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__100 = (char*) (Shared+55552);  // Cost_Parallel_Work_1_Broadcast5_6 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__101 = (char*) (Shared+56320);  // Cost_Parallel_Work_1_Broadcast5_7 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__102 = (char*) (Shared+7360);  // Cost_Parallel_Work_1_Broadcast5_8 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__103 = (char*) (Shared+14720);  // Cost_Parallel_Work_1_Broadcast5_9 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__104 = (char*) (Shared+22080);  // Cost_Parallel_Work_1_Broadcast5_10 > RB_Cost_Parallel_Work_1__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__94 = (char*) (Shared+0);  // Cost_Parallel_Work_2_Broadcast5_18 > Cost_Parallel_Work_end_out_Broadcast5_out1 size:= 120*char
char *const implode_Median_Filter_26_raw__0 = (char*) (Shared+51840);  // implode_Median_Filter_26_rawDisparity > Median_Filter_26 size:= 36*char
char *const explode_Split_1_output__impl__0 = (char*) (Shared+51840);  // explode_Split_1_output > implode_Median_Filter_26_rawDisparity size:= 24*char
char *const Cost_Parallel_Work_0_Broadca__115 = (char*) (Shared+57280);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_0 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__116 = (char*) (Shared+57472);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_1 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__117 = (char*) (Shared+57664);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_3 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__118 = (char*) (Shared+36800);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_5 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__119 = (char*) (Shared+50048);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_6 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__120 = (char*) (Shared+50112);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_8 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__121 = (char*) (Shared+51328);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_9 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__122 = (char*) (Shared+52608);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_11 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__123 = (char*) (Shared+52672);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_13 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__124 = (char*) (Shared+53248);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_15 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__125 = (char*) (Shared+53312);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_17 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__105 = (char*) (Shared+53888);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_0 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__106 = (char*) (Shared+53952);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_1 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__107 = (char*) (Shared+55552);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_2 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__108 = (char*) (Shared+55616);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_3 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__109 = (char*) (Shared+55808);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_4 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__110 = (char*) (Shared+55872);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_5 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__111 = (char*) (Shared+56064);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_6 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__112 = (char*) (Shared+56128);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_7 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__113 = (char*) (Shared+56576);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_8 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__114 = (char*) (Shared+56640);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_9 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__115 = (char*) (Shared+56832);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_10 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__116 = (char*) (Shared+56896);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_11 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__117 = (char*) (Shared+57088);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_12 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__118 = (char*) (Shared+57152);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_13 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__119 = (char*) (Shared+57856);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_14 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__120 = (char*) (Shared+57920);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_15 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__121 = (char*) (Shared+57984);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_16 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__122 = (char*) (Shared+58048);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_17 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__123 = (char*) (Shared+58112);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_AggregateCost_18 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__95 = (char*) (Shared+58176);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_0 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__96 = (char*) (Shared+58240);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_1 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__97 = (char*) (Shared+58304);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_2 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__98 = (char*) (Shared+58368);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_3 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__99 = (char*) (Shared+58432);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_4 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__100 = (char*) (Shared+58496);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_5 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__101 = (char*) (Shared+58560);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_6 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__102 = (char*) (Shared+58624);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_7 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__103 = (char*) (Shared+58688);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_8 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__104 = (char*) (Shared+58752);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_9 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__105 = (char*) (Shared+58816);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_10 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__106 = (char*) (Shared+58880);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_11 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__107 = (char*) (Shared+58944);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_12 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__108 = (char*) (Shared+59008);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_13 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__109 = (char*) (Shared+59072);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_14 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__110 = (char*) (Shared+59136);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_15 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__111 = (char*) (Shared+59200);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_16 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__112 = (char*) (Shared+59264);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_17 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__113 = (char*) (Shared+59328);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_AggregateCost_18 size:= 20*char
char *const Median_Filter_3__implode_lum__0 = (char*) (Shared+51328);  // Median_Filter_3 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_4__implode_lum__0 = (char*) (Shared+53952);  // Median_Filter_4 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_5__implode_lum__0 = (char*) (Shared+56128);  // Median_Filter_5 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_6__implode_lum__0 = (char*) (Shared+51584);  // Median_Filter_6 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_7__implode_lum__0 = (char*) (Shared+57664);  // Median_Filter_7 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_8__implode_lum__0 = (char*) (Shared+51648);  // Median_Filter_8 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_21__implode_lu__0 = (char*) (Shared+22080);  // Median_Filter_21 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_22__implode_lu__0 = (char*) (Shared+22144);  // Median_Filter_22 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_23__implode_lu__0 = (char*) (Shared+52480);  // Median_Filter_23 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_25__implode_lu__0 = (char*) (Shared+52544);  // Median_Filter_25 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_24__implode_lu__0 = (char*) (Shared+58240);  // Median_Filter_24 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_34__implode_lu__0 = (char*) (Shared+52416);  // Median_Filter_34 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_38__implode_lu__0 = (char*) (Shared+51968);  // Median_Filter_38 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_27__implode_lu__0 = (char*) (Shared+52032);  // Median_Filter_27 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_28__implode_lu__0 = (char*) (Shared+52096);  // Median_Filter_28 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_29__implode_lu__0 = (char*) (Shared+51904);  // Median_Filter_29 > implode_lum2RGB_2_in size:= 12*char
char *const Median_Filter_32__implode_lu__0 = (char*) (Shared+52160);  // Median_Filter_32 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_33__implode_lu__0 = (char*) (Shared+52224);  // Median_Filter_33 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_36__implode_lu__0 = (char*) (Shared+52736);  // Median_Filter_36 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_37__implode_lu__0 = (char*) (Shared+52800);  // Median_Filter_37 > implode_lum2RGB_3_in size:= 12*char
char *const Cost_Parallel_Work_0_explode__1 = (char*) (Shared+36864);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_1 size:= 1*char
char *const Cost_Parallel_Work_0_explode__2 = (char*) (Shared+51392);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_3 size:= 1*char
char *const Cost_Parallel_Work_0_explode__3 = (char*) (Shared+7360);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_4 size:= 1*char
char *const Cost_Parallel_Work_0_explode__4 = (char*) (Shared+22080);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_5 size:= 1*char
char *const Cost_Parallel_Work_0_explode__5 = (char*) (Shared+7424);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_7 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__126 = (char*) (Shared+48832);  // Cost_Parallel_Work_0_Broadcast5_0 > Cost_Parallel_Work_0_CostConstruction_8 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__127 = (char*) (Shared+48896);  // Cost_Parallel_Work_0_Broadcast5_1 > Cost_Parallel_Work_0_CostConstruction_9 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__128 = (char*) (Shared+57472);  // Cost_Parallel_Work_0_Broadcast5_2 > Cost_Parallel_Work_0_CostConstruction_10 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__129 = (char*) (Shared+57664);  // Cost_Parallel_Work_0_Broadcast5_3 > Cost_Parallel_Work_0_CostConstruction_11 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__130 = (char*) (Shared+56320);  // Cost_Parallel_Work_0_Broadcast5_4 > Cost_Parallel_Work_0_CostConstruction_12 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__131 = (char*) (Shared+56384);  // Cost_Parallel_Work_0_Broadcast5_5 > Cost_Parallel_Work_0_CostConstruction_13 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__132 = (char*) (Shared+57216);  // Cost_Parallel_Work_0_Broadcast5_6 > Cost_Parallel_Work_0_CostConstruction_14 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__133 = (char*) (Shared+57280);  // Cost_Parallel_Work_0_Broadcast5_7 > Cost_Parallel_Work_0_CostConstruction_15 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__134 = (char*) (Shared+48832);  // Cost_Parallel_Work_0_Broadcast5_8 > Cost_Parallel_Work_0_CostConstruction_16 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__135 = (char*) (Shared+57344);  // Cost_Parallel_Work_0_Broadcast5_9 > Cost_Parallel_Work_0_CostConstruction_17 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__136 = (char*) (Shared+57472);  // Cost_Parallel_Work_0_Broadcast5_10 > Cost_Parallel_Work_0_CostConstruction_18 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__137 = (char*) (Shared+52608);  // Cost_Parallel_Work_0_Broadcast5_11 > Cost_Parallel_Work_1_CostConstruction_0 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__138 = (char*) (Shared+56320);  // Cost_Parallel_Work_0_Broadcast5_12 > Cost_Parallel_Work_1_CostConstruction_1 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__139 = (char*) (Shared+56384);  // Cost_Parallel_Work_0_Broadcast5_13 > Cost_Parallel_Work_1_CostConstruction_2 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__140 = (char*) (Shared+57216);  // Cost_Parallel_Work_0_Broadcast5_14 > Cost_Parallel_Work_1_CostConstruction_3 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__141 = (char*) (Shared+53248);  // Cost_Parallel_Work_0_Broadcast5_15 > Cost_Parallel_Work_1_CostConstruction_4 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__142 = (char*) (Shared+57280);  // Cost_Parallel_Work_0_Broadcast5_16 > Cost_Parallel_Work_1_CostConstruction_5 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__143 = (char*) (Shared+53312);  // Cost_Parallel_Work_0_Broadcast5_17 > Cost_Parallel_Work_1_CostConstruction_6 size:= 1*char
char *const Cost_Parallel_Work_0_Broadca__144 = (char*) (Shared+57664);  // Cost_Parallel_Work_0_Broadcast5_18 > Cost_Parallel_Work_1_CostConstruction_7 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__124 = (char*) (Shared+53888);  // Cost_Parallel_Work_1_Broadcast5_0 > Cost_Parallel_Work_1_CostConstruction_8 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__125 = (char*) (Shared+55936);  // Cost_Parallel_Work_1_Broadcast5_1 > Cost_Parallel_Work_1_CostConstruction_9 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__126 = (char*) (Shared+56000);  // Cost_Parallel_Work_1_Broadcast5_2 > Cost_Parallel_Work_1_CostConstruction_10 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__127 = (char*) (Shared+57216);  // Cost_Parallel_Work_1_Broadcast5_3 > Cost_Parallel_Work_1_CostConstruction_11 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__128 = (char*) (Shared+55808);  // Cost_Parallel_Work_1_Broadcast5_4 > Cost_Parallel_Work_1_CostConstruction_12 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__129 = (char*) (Shared+55872);  // Cost_Parallel_Work_1_Broadcast5_5 > Cost_Parallel_Work_1_CostConstruction_13 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__130 = (char*) (Shared+56064);  // Cost_Parallel_Work_1_Broadcast5_6 > Cost_Parallel_Work_1_CostConstruction_14 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__131 = (char*) (Shared+57280);  // Cost_Parallel_Work_1_Broadcast5_7 > Cost_Parallel_Work_1_CostConstruction_15 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__132 = (char*) (Shared+56576);  // Cost_Parallel_Work_1_Broadcast5_8 > Cost_Parallel_Work_1_CostConstruction_16 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__133 = (char*) (Shared+55936);  // Cost_Parallel_Work_1_Broadcast5_9 > Cost_Parallel_Work_1_CostConstruction_17 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__134 = (char*) (Shared+51840);  // Cost_Parallel_Work_1_Broadcast5_10 > Cost_Parallel_Work_1_CostConstruction_18 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__135 = (char*) (Shared+56000);  // Cost_Parallel_Work_1_Broadcast5_11 > Cost_Parallel_Work_2_CostConstruction_0 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__136 = (char*) (Shared+56128);  // Cost_Parallel_Work_1_Broadcast5_12 > Cost_Parallel_Work_2_CostConstruction_1 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__137 = (char*) (Shared+56640);  // Cost_Parallel_Work_1_Broadcast5_13 > Cost_Parallel_Work_2_CostConstruction_2 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__138 = (char*) (Shared+56064);  // Cost_Parallel_Work_1_Broadcast5_14 > Cost_Parallel_Work_2_CostConstruction_3 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__139 = (char*) (Shared+57664);  // Cost_Parallel_Work_1_Broadcast5_15 > Cost_Parallel_Work_2_CostConstruction_4 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__140 = (char*) (Shared+56576);  // Cost_Parallel_Work_1_Broadcast5_16 > Cost_Parallel_Work_2_CostConstruction_5 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__141 = (char*) (Shared+0);  // Cost_Parallel_Work_1_Broadcast5_17 > Cost_Parallel_Work_2_CostConstruction_6 size:= 1*char
char *const Cost_Parallel_Work_1_Broadca__142 = (char*) (Shared+49280);  // Cost_Parallel_Work_1_Broadcast5_18 > Cost_Parallel_Work_2_CostConstruction_7 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__114 = (char*) (Shared+53248);  // Cost_Parallel_Work_2_Broadcast5_0 > Cost_Parallel_Work_2_CostConstruction_8 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__115 = (char*) (Shared+49344);  // Cost_Parallel_Work_2_Broadcast5_1 > Cost_Parallel_Work_2_CostConstruction_9 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__116 = (char*) (Shared+53312);  // Cost_Parallel_Work_2_Broadcast5_2 > Cost_Parallel_Work_2_CostConstruction_10 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__117 = (char*) (Shared+56640);  // Cost_Parallel_Work_2_Broadcast5_3 > Cost_Parallel_Work_2_CostConstruction_11 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__118 = (char*) (Shared+56832);  // Cost_Parallel_Work_2_Broadcast5_4 > Cost_Parallel_Work_2_CostConstruction_12 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__119 = (char*) (Shared+56576);  // Cost_Parallel_Work_2_Broadcast5_5 > Cost_Parallel_Work_2_CostConstruction_13 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__120 = (char*) (Shared+56896);  // Cost_Parallel_Work_2_Broadcast5_6 > Cost_Parallel_Work_2_CostConstruction_14 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__121 = (char*) (Shared+57856);  // Cost_Parallel_Work_2_Broadcast5_7 > Cost_Parallel_Work_2_CostConstruction_15 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__122 = (char*) (Shared+53248);  // Cost_Parallel_Work_2_Broadcast5_8 > Cost_Parallel_Work_2_CostConstruction_16 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__123 = (char*) (Shared+52672);  // Cost_Parallel_Work_2_Broadcast5_9 > Cost_Parallel_Work_2_CostConstruction_17 size:= 1*char
char *const Cost_Parallel_Work_2_Broadca__124 = (char*) (Shared+53312);  // Cost_Parallel_Work_2_Broadcast5_10 > Cost_Parallel_Work_2_CostConstruction_18 size:= 1*char
char *const FIFO_Head_Cost_Parallel_Work__0 = (char*) (Shared+640);  // FIFO_Head_Cost_Parallel_Work_end_out_disparitySelect_backBestCost > Cost_Parallel_Work_init_in_disparitySelect_bestCostFeed size:= 484*char
char *const FIFO_Head_Cost_Parallel_Work__1 = (char*) (Shared+0);  // FIFO_Head_Cost_Parallel_Work_end_out_Broadcast5_out1 > Cost_Parallel_Work_init_in_disparitySelect_currentResult size:= 120*char
char *const FIFO_Head_Cost_Parallel_Work__2 = (char*) (Shared+57472);  // FIFO_Head_Cost_Parallel_Work_end_out_Broadcast5_back > Cost_Parallel_Work_init_in_CostConstruction_back size:= 8*char
char *const Cost_Parallel_Work_0_CostCon__12 = (char*) (Core0+0);  // Cost_Parallel_Work_0_CostConstruction_0 > Cost_Parallel_Work_0_AggregateCost_0 size:= 480*char
char *const Cost_Parallel_Work_0_Aggrega__18 = (char*) (Core0+512);  // Cost_Parallel_Work_0_AggregateCost_0 > Cost_Parallel_Work_0_disparitySelect_0 size:= 480*char
char *const Cost_Parallel_Work_0_dispari__26 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_0 > Cost_Parallel_Work_0_Broadcast5_0 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__153 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_0 > Cost_Parallel_Work_0_disparitySelect_1 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__27 = (char*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_1 > Cost_Parallel_Work_0_Broadcast5_1 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__154 = (char*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_1 > Cost_Parallel_Work_0_disparitySelect_2 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__28 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_2 > Cost_Parallel_Work_0_Broadcast5_2 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__155 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_2 > Cost_Parallel_Work_0_disparitySelect_3 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__29 = (char*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_3 > Cost_Parallel_Work_0_Broadcast5_3 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__156 = (char*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_3 > Cost_Parallel_Work_0_disparitySelect_4 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__30 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_4 > Cost_Parallel_Work_0_Broadcast5_4 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__157 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_4 > Cost_Parallel_Work_0_disparitySelect_5 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__31 = (char*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_5 > Cost_Parallel_Work_0_Broadcast5_5 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__158 = (char*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_5 > Cost_Parallel_Work_0_disparitySelect_6 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__32 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_6 > Cost_Parallel_Work_0_Broadcast5_6 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__159 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_6 > Cost_Parallel_Work_0_disparitySelect_7 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__33 = (char*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_7 > Cost_Parallel_Work_0_Broadcast5_7 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__160 = (char*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_7 > Cost_Parallel_Work_0_disparitySelect_8 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__34 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_8 > Cost_Parallel_Work_0_Broadcast5_8 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__161 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_8 > Cost_Parallel_Work_0_disparitySelect_9 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__35 = (char*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_9 > Cost_Parallel_Work_0_Broadcast5_9 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__162 = (char*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_9 > Cost_Parallel_Work_0_disparitySelect_10 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__36 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_10 > Cost_Parallel_Work_0_Broadcast5_10 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__163 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_10 > Cost_Parallel_Work_0_disparitySelect_11 size:= 120*char
char *const Cost_Parallel_Work_0_dispari__37 = (char*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_18 > Cost_Parallel_Work_0_Broadcast5_18 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__164 = (char*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_18 > Cost_Parallel_Work_1_disparitySelect_0 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__26 = (char*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_0 > Cost_Parallel_Work_1_Broadcast5_0 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__153 = (char*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_0 > Cost_Parallel_Work_1_disparitySelect_1 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__27 = (char*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_1 > Cost_Parallel_Work_1_Broadcast5_1 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__154 = (char*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_1 > Cost_Parallel_Work_1_disparitySelect_2 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__28 = (char*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_2 > Cost_Parallel_Work_1_Broadcast5_2 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__155 = (char*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_2 > Cost_Parallel_Work_1_disparitySelect_3 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__29 = (char*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_3 > Cost_Parallel_Work_1_Broadcast5_3 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__156 = (char*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_3 > Cost_Parallel_Work_1_disparitySelect_4 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__30 = (char*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_4 > Cost_Parallel_Work_1_Broadcast5_4 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__157 = (char*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_4 > Cost_Parallel_Work_1_disparitySelect_5 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__31 = (char*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_5 > Cost_Parallel_Work_1_Broadcast5_5 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__158 = (char*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_5 > Cost_Parallel_Work_1_disparitySelect_6 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__32 = (char*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_6 > Cost_Parallel_Work_1_Broadcast5_6 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__159 = (char*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_6 > Cost_Parallel_Work_1_disparitySelect_7 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__33 = (char*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_7 > Cost_Parallel_Work_1_Broadcast5_7 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__160 = (char*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_7 > Cost_Parallel_Work_1_disparitySelect_8 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__34 = (char*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_8 > Cost_Parallel_Work_1_Broadcast5_8 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__161 = (char*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_8 > Cost_Parallel_Work_1_disparitySelect_9 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__35 = (char*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_9 > Cost_Parallel_Work_1_Broadcast5_9 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__162 = (char*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_9 > Cost_Parallel_Work_1_disparitySelect_10 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__36 = (char*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_10 > Cost_Parallel_Work_1_Broadcast5_10 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__163 = (char*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_10 > Cost_Parallel_Work_1_disparitySelect_11 size:= 120*char
char *const Cost_Parallel_Work_1_dispari__37 = (char*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_18 > Cost_Parallel_Work_1_Broadcast5_18 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__164 = (char*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_18 > Cost_Parallel_Work_2_disparitySelect_0 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__20 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_0 > Cost_Parallel_Work_2_Broadcast5_0 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__135 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_0 > Cost_Parallel_Work_2_disparitySelect_1 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__21 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_1 > Cost_Parallel_Work_2_Broadcast5_1 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__136 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_1 > Cost_Parallel_Work_2_disparitySelect_2 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__22 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_2 > Cost_Parallel_Work_2_Broadcast5_2 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__137 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_2 > Cost_Parallel_Work_2_disparitySelect_3 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__23 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_3 > Cost_Parallel_Work_2_Broadcast5_3 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__138 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_3 > Cost_Parallel_Work_2_disparitySelect_4 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__24 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_4 > Cost_Parallel_Work_2_Broadcast5_4 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__139 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_4 > Cost_Parallel_Work_2_disparitySelect_5 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__25 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_5 > Cost_Parallel_Work_2_Broadcast5_5 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__140 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_5 > Cost_Parallel_Work_2_disparitySelect_6 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__26 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_6 > Cost_Parallel_Work_2_Broadcast5_6 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__141 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_6 > Cost_Parallel_Work_2_disparitySelect_7 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__27 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_7 > Cost_Parallel_Work_2_Broadcast5_7 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__142 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_7 > Cost_Parallel_Work_2_disparitySelect_8 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__28 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_8 > Cost_Parallel_Work_2_Broadcast5_8 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__143 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_8 > Cost_Parallel_Work_2_disparitySelect_9 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__29 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_9 > Cost_Parallel_Work_2_Broadcast5_9 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__144 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_9 > Cost_Parallel_Work_2_disparitySelect_10 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__30 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_10 > Cost_Parallel_Work_2_Broadcast5_10 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__145 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_10 > Cost_Parallel_Work_2_disparitySelect_11 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__31 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_11 > Cost_Parallel_Work_2_Broadcast5_11 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__146 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_11 > Cost_Parallel_Work_2_disparitySelect_12 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__32 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_12 > Cost_Parallel_Work_2_Broadcast5_12 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__147 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_12 > Cost_Parallel_Work_2_disparitySelect_13 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__33 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_13 > Cost_Parallel_Work_2_Broadcast5_13 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__148 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_13 > Cost_Parallel_Work_2_disparitySelect_14 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__34 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_14 > Cost_Parallel_Work_2_Broadcast5_14 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__149 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_14 > Cost_Parallel_Work_2_disparitySelect_15 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__35 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_15 > Cost_Parallel_Work_2_Broadcast5_15 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__150 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_15 > Cost_Parallel_Work_2_disparitySelect_16 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__36 = (char*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_16 > Cost_Parallel_Work_2_Broadcast5_16 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__151 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_16 > Cost_Parallel_Work_2_disparitySelect_17 size:= 120*char
char *const Cost_Parallel_Work_2_dispari__37 = (char*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_17 > Cost_Parallel_Work_2_Broadcast5_17 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__152 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_17 > Cost_Parallel_Work_2_disparitySelect_18 size:= 120*char
char *const RB_Cost_Parallel_Work_2__raw__0 = (char*) (Core0+128);  // RB_Cost_Parallel_Work_2__rawDisparity > Split_2 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__153 = (char*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_18 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__165 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_11 > Cost_Parallel_Work_0_disparitySelect_12 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__166 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_12 > Cost_Parallel_Work_0_disparitySelect_13 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__167 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_13 > Cost_Parallel_Work_0_disparitySelect_14 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__168 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_14 > Cost_Parallel_Work_0_disparitySelect_15 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__169 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_15 > Cost_Parallel_Work_0_disparitySelect_16 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__170 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_16 > Cost_Parallel_Work_0_disparitySelect_17 size:= 120*char
char *const Cost_Parallel_Work_0_Broadca__171 = (char*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_17 > Cost_Parallel_Work_0_disparitySelect_18 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__165 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_11 > Cost_Parallel_Work_1_disparitySelect_12 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__166 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_12 > Cost_Parallel_Work_1_disparitySelect_13 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__167 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_13 > Cost_Parallel_Work_1_disparitySelect_14 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__168 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_14 > Cost_Parallel_Work_1_disparitySelect_15 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__169 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_15 > Cost_Parallel_Work_1_disparitySelect_16 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__170 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_16 > Cost_Parallel_Work_1_disparitySelect_17 size:= 120*char
char *const Cost_Parallel_Work_1_Broadca__171 = (char*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_17 > Cost_Parallel_Work_1_disparitySelect_18 size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__154 = (char*) (Core0+0);  // Cost_Parallel_Work_2_Broadcast5_0 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__155 = (char*) (Core0+256);  // Cost_Parallel_Work_2_Broadcast5_1 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__156 = (char*) (Core0+512);  // Cost_Parallel_Work_2_Broadcast5_2 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__157 = (char*) (Core0+640);  // Cost_Parallel_Work_2_Broadcast5_3 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__158 = (char*) (Core0+768);  // Cost_Parallel_Work_2_Broadcast5_4 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__159 = (char*) (Core0+896);  // Cost_Parallel_Work_2_Broadcast5_5 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__160 = (char*) (Core0+1024);  // Cost_Parallel_Work_2_Broadcast5_6 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__161 = (char*) (Core0+1152);  // Cost_Parallel_Work_2_Broadcast5_7 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__162 = (char*) (Core0+1280);  // Cost_Parallel_Work_2_Broadcast5_8 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__163 = (char*) (Core0+1408);  // Cost_Parallel_Work_2_Broadcast5_9 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__164 = (char*) (Core0+1536);  // Cost_Parallel_Work_2_Broadcast5_10 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__165 = (char*) (Core0+1664);  // Cost_Parallel_Work_2_Broadcast5_11 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__166 = (char*) (Core0+1792);  // Cost_Parallel_Work_2_Broadcast5_12 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__167 = (char*) (Core0+1920);  // Cost_Parallel_Work_2_Broadcast5_13 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__168 = (char*) (Core0+2048);  // Cost_Parallel_Work_2_Broadcast5_14 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__169 = (char*) (Core0+2176);  // Cost_Parallel_Work_2_Broadcast5_15 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__170 = (char*) (Core0+2304);  // Cost_Parallel_Work_2_Broadcast5_16 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Cost_Parallel_Work_2_Broadca__171 = (char*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_17 > RB_Cost_Parallel_Work_2__rawDisparity size:= 120*char
char *const Median_Filter_26__implode_lu__0 = (char*) (Core0+0);  // Median_Filter_26 > implode_lum2RGB_2_in size:= 12*char
float *const weights__in__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in_weights > Cost_Parallel_Work_1_Broadcast2_0_in size:= 1800*float
float *const out_0_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_0_18 > Cost_Parallel_Work_1_AggregateCost_0_vWeights size:= 1800*float
float *const out_1_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_1_18 > Cost_Parallel_Work_1_AggregateCost_1_vWeights size:= 1800*float
float *const out_2_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_2_18 > Cost_Parallel_Work_1_AggregateCost_2_vWeights size:= 1800*float
float *const out_3_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_3_18 > Cost_Parallel_Work_1_AggregateCost_3_vWeights size:= 1800*float
float *const out_4_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_4_18 > Cost_Parallel_Work_1_AggregateCost_4_vWeights size:= 1800*float
float *const out_5_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_5_18 > Cost_Parallel_Work_1_AggregateCost_5_vWeights size:= 1800*float
float *const out_6_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_6_18 > Cost_Parallel_Work_1_AggregateCost_6_vWeights size:= 1800*float
float *const out_7_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_7_18 > Cost_Parallel_Work_1_AggregateCost_7_vWeights size:= 1800*float
float *const out_8_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_8_18 > Cost_Parallel_Work_1_AggregateCost_8_vWeights size:= 1800*float
float *const out_9_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_9_18 > Cost_Parallel_Work_1_AggregateCost_9_vWeights size:= 1800*float
float *const out_10_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_10_18 > Cost_Parallel_Work_1_AggregateCost_10_vWeights size:= 1800*float
float *const out_11_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_11_18 > Cost_Parallel_Work_1_AggregateCost_11_vWeights size:= 1800*float
float *const out_12_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_12_18 > Cost_Parallel_Work_1_AggregateCost_12_vWeights size:= 1800*float
float *const out_13_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_13_18 > Cost_Parallel_Work_1_AggregateCost_13_vWeights size:= 1800*float
float *const out_14_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_14_18 > Cost_Parallel_Work_1_AggregateCost_14_vWeights size:= 1800*float
float *const out_15_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_15_18 > Cost_Parallel_Work_1_AggregateCost_15_vWeights size:= 1800*float
float *const out_16_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_16_18 > Cost_Parallel_Work_1_AggregateCost_16_vWeights size:= 1800*float
float *const out_17_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_17_18 > Cost_Parallel_Work_1_AggregateCost_17_vWeights size:= 1800*float
float *const out_18_18__vWeights__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_Broadcast2_0_out_18_18 > Cost_Parallel_Work_1_AggregateCost_18_vWeights size:= 1800*float
float *const weights__in_0__0 = (float*) (Shared+128);  // Cost_Parallel_Work_1_ComputeVertWeights_0_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in_in_0 size:= 360*float
float *const weights__in_2__0 = (float*) (Shared+3008);  // Cost_Parallel_Work_1_ComputeVertWeights_2_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in_in_2 size:= 360*float
float *const weights__in_4__0 = (float*) (Shared+5888);  // Cost_Parallel_Work_1_ComputeVertWeights_4_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in_in_4 size:= 360*float
float *const weights__in__1 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in_weights > Cost_Parallel_Work_1_Broadcast3_0_in size:= 1800*float
float *const out_0_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_0_18 > Cost_Parallel_Work_1_AggregateCost_0_hWeights size:= 1800*float
float *const out_1_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_1_18 > Cost_Parallel_Work_1_AggregateCost_1_hWeights size:= 1800*float
float *const out_2_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_2_18 > Cost_Parallel_Work_1_AggregateCost_2_hWeights size:= 1800*float
float *const out_3_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_3_18 > Cost_Parallel_Work_1_AggregateCost_3_hWeights size:= 1800*float
float *const out_4_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_4_18 > Cost_Parallel_Work_1_AggregateCost_4_hWeights size:= 1800*float
float *const out_5_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_5_18 > Cost_Parallel_Work_1_AggregateCost_5_hWeights size:= 1800*float
float *const out_6_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_6_18 > Cost_Parallel_Work_1_AggregateCost_6_hWeights size:= 1800*float
float *const out_7_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_7_18 > Cost_Parallel_Work_1_AggregateCost_7_hWeights size:= 1800*float
float *const out_8_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_8_18 > Cost_Parallel_Work_1_AggregateCost_8_hWeights size:= 1800*float
float *const out_9_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_9_18 > Cost_Parallel_Work_1_AggregateCost_9_hWeights size:= 1800*float
float *const out_10_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_10_18 > Cost_Parallel_Work_1_AggregateCost_10_hWeights size:= 1800*float
float *const out_11_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_11_18 > Cost_Parallel_Work_1_AggregateCost_11_hWeights size:= 1800*float
float *const out_12_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_12_18 > Cost_Parallel_Work_1_AggregateCost_12_hWeights size:= 1800*float
float *const out_13_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_13_18 > Cost_Parallel_Work_1_AggregateCost_13_hWeights size:= 1800*float
float *const out_14_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_14_18 > Cost_Parallel_Work_1_AggregateCost_14_hWeights size:= 1800*float
float *const out_15_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_15_18 > Cost_Parallel_Work_1_AggregateCost_15_hWeights size:= 1800*float
float *const out_16_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_16_18 > Cost_Parallel_Work_1_AggregateCost_16_hWeights size:= 1800*float
float *const out_17_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_17_18 > Cost_Parallel_Work_1_AggregateCost_17_hWeights size:= 1800*float
float *const out_18_18__hWeights__0 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_Broadcast3_0_out_18_18 > Cost_Parallel_Work_1_AggregateCost_18_hWeights size:= 1800*float
float *const weights__in_0__1 = (float*) (Shared+7488);  // Cost_Parallel_Work_1_ComputeHorWeights_0_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in_in_0 size:= 360*float
float *const weights__in_2__1 = (float*) (Shared+10368);  // Cost_Parallel_Work_1_ComputeHorWeights_2_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in_in_2 size:= 360*float
float *const weights__in_4__1 = (float*) (Shared+13248);  // Cost_Parallel_Work_1_ComputeHorWeights_4_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in_in_4 size:= 360*float
float *const weights__in__2 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in_weights > Cost_Parallel_Work_2_Broadcast2_0_in size:= 1800*float
float *const out_0_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_0_18 > Cost_Parallel_Work_2_AggregateCost_0_vWeights size:= 1800*float
float *const out_1_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_1_18 > Cost_Parallel_Work_2_AggregateCost_1_vWeights size:= 1800*float
float *const out_2_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_2_18 > Cost_Parallel_Work_2_AggregateCost_2_vWeights size:= 1800*float
float *const out_3_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_3_18 > Cost_Parallel_Work_2_AggregateCost_3_vWeights size:= 1800*float
float *const out_4_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_4_18 > Cost_Parallel_Work_2_AggregateCost_4_vWeights size:= 1800*float
float *const out_5_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_5_18 > Cost_Parallel_Work_2_AggregateCost_5_vWeights size:= 1800*float
float *const out_6_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_6_18 > Cost_Parallel_Work_2_AggregateCost_6_vWeights size:= 1800*float
float *const out_7_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_7_18 > Cost_Parallel_Work_2_AggregateCost_7_vWeights size:= 1800*float
float *const out_8_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_8_18 > Cost_Parallel_Work_2_AggregateCost_8_vWeights size:= 1800*float
float *const out_9_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_9_18 > Cost_Parallel_Work_2_AggregateCost_9_vWeights size:= 1800*float
float *const out_10_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_10_18 > Cost_Parallel_Work_2_AggregateCost_10_vWeights size:= 1800*float
float *const out_11_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_11_18 > Cost_Parallel_Work_2_AggregateCost_11_vWeights size:= 1800*float
float *const out_12_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_12_18 > Cost_Parallel_Work_2_AggregateCost_12_vWeights size:= 1800*float
float *const out_13_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_13_18 > Cost_Parallel_Work_2_AggregateCost_13_vWeights size:= 1800*float
float *const out_14_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_14_18 > Cost_Parallel_Work_2_AggregateCost_14_vWeights size:= 1800*float
float *const out_15_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_15_18 > Cost_Parallel_Work_2_AggregateCost_15_vWeights size:= 1800*float
float *const out_16_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_16_18 > Cost_Parallel_Work_2_AggregateCost_16_vWeights size:= 1800*float
float *const out_17_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_17_18 > Cost_Parallel_Work_2_AggregateCost_17_vWeights size:= 1800*float
float *const out_18_18__vWeights__1 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_Broadcast2_0_out_18_18 > Cost_Parallel_Work_2_AggregateCost_18_vWeights size:= 1800*float
float *const weights__in_0__2 = (float*) (Shared+14848);  // Cost_Parallel_Work_2_ComputeVertWeights_0_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in_in_0 size:= 360*float
float *const weights__in_2__2 = (float*) (Shared+17728);  // Cost_Parallel_Work_2_ComputeVertWeights_2_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in_in_2 size:= 360*float
float *const weights__in_4__2 = (float*) (Shared+20608);  // Cost_Parallel_Work_2_ComputeVertWeights_4_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in_in_4 size:= 360*float
float *const weights__in__3 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in_weights > Cost_Parallel_Work_2_Broadcast3_0_in size:= 1800*float
float *const out_0_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_0_18 > Cost_Parallel_Work_2_AggregateCost_0_hWeights size:= 1800*float
float *const out_1_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_1_18 > Cost_Parallel_Work_2_AggregateCost_1_hWeights size:= 1800*float
float *const out_2_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_2_18 > Cost_Parallel_Work_2_AggregateCost_2_hWeights size:= 1800*float
float *const out_3_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_3_18 > Cost_Parallel_Work_2_AggregateCost_3_hWeights size:= 1800*float
float *const out_4_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_4_18 > Cost_Parallel_Work_2_AggregateCost_4_hWeights size:= 1800*float
float *const out_5_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_5_18 > Cost_Parallel_Work_2_AggregateCost_5_hWeights size:= 1800*float
float *const out_6_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_6_18 > Cost_Parallel_Work_2_AggregateCost_6_hWeights size:= 1800*float
float *const out_7_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_7_18 > Cost_Parallel_Work_2_AggregateCost_7_hWeights size:= 1800*float
float *const out_8_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_8_18 > Cost_Parallel_Work_2_AggregateCost_8_hWeights size:= 1800*float
float *const out_9_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_9_18 > Cost_Parallel_Work_2_AggregateCost_9_hWeights size:= 1800*float
float *const out_10_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_10_18 > Cost_Parallel_Work_2_AggregateCost_10_hWeights size:= 1800*float
float *const out_11_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_11_18 > Cost_Parallel_Work_2_AggregateCost_11_hWeights size:= 1800*float
float *const out_12_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_12_18 > Cost_Parallel_Work_2_AggregateCost_12_hWeights size:= 1800*float
float *const out_13_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_13_18 > Cost_Parallel_Work_2_AggregateCost_13_hWeights size:= 1800*float
float *const out_14_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_14_18 > Cost_Parallel_Work_2_AggregateCost_14_hWeights size:= 1800*float
float *const out_15_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_15_18 > Cost_Parallel_Work_2_AggregateCost_15_hWeights size:= 1800*float
float *const out_16_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_16_18 > Cost_Parallel_Work_2_AggregateCost_16_hWeights size:= 1800*float
float *const out_17_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_17_18 > Cost_Parallel_Work_2_AggregateCost_17_hWeights size:= 1800*float
float *const out_18_18__hWeights__1 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_Broadcast3_0_out_18_18 > Cost_Parallel_Work_2_AggregateCost_18_hWeights size:= 1800*float
float *const weights__in_0__3 = (float*) (Shared+22208);  // Cost_Parallel_Work_2_ComputeHorWeights_0_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in_in_0 size:= 360*float
float *const weights__in_2__3 = (float*) (Shared+25088);  // Cost_Parallel_Work_2_ComputeHorWeights_2_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in_in_2 size:= 360*float
float *const weights__in_4__3 = (float*) (Shared+27968);  // Cost_Parallel_Work_2_ComputeHorWeights_4_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in_in_4 size:= 360*float
float *const weights__in__4 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in_weights > Cost_Parallel_Work_0_Broadcast2_0_in size:= 1800*float
float *const out_0_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_0_18 > Cost_Parallel_Work_0_AggregateCost_0_vWeights size:= 1800*float
float *const out_1_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_1_18 > Cost_Parallel_Work_0_AggregateCost_1_vWeights size:= 1800*float
float *const out_2_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_2_18 > Cost_Parallel_Work_0_AggregateCost_2_vWeights size:= 1800*float
float *const out_3_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_3_18 > Cost_Parallel_Work_0_AggregateCost_3_vWeights size:= 1800*float
float *const out_4_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_4_18 > Cost_Parallel_Work_0_AggregateCost_4_vWeights size:= 1800*float
float *const out_5_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_5_18 > Cost_Parallel_Work_0_AggregateCost_5_vWeights size:= 1800*float
float *const out_6_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_6_18 > Cost_Parallel_Work_0_AggregateCost_6_vWeights size:= 1800*float
float *const out_7_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_7_18 > Cost_Parallel_Work_0_AggregateCost_7_vWeights size:= 1800*float
float *const out_8_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_8_18 > Cost_Parallel_Work_0_AggregateCost_8_vWeights size:= 1800*float
float *const out_9_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_9_18 > Cost_Parallel_Work_0_AggregateCost_9_vWeights size:= 1800*float
float *const out_10_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_10_18 > Cost_Parallel_Work_0_AggregateCost_10_vWeights size:= 1800*float
float *const out_11_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_11_18 > Cost_Parallel_Work_0_AggregateCost_11_vWeights size:= 1800*float
float *const out_12_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_12_18 > Cost_Parallel_Work_0_AggregateCost_12_vWeights size:= 1800*float
float *const out_13_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_13_18 > Cost_Parallel_Work_0_AggregateCost_13_vWeights size:= 1800*float
float *const out_14_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_14_18 > Cost_Parallel_Work_0_AggregateCost_14_vWeights size:= 1800*float
float *const out_15_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_15_18 > Cost_Parallel_Work_0_AggregateCost_15_vWeights size:= 1800*float
float *const out_16_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_16_18 > Cost_Parallel_Work_0_AggregateCost_16_vWeights size:= 1800*float
float *const out_17_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_17_18 > Cost_Parallel_Work_0_AggregateCost_17_vWeights size:= 1800*float
float *const out_18_18__vWeights__2 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_Broadcast2_0_out_18_18 > Cost_Parallel_Work_0_AggregateCost_18_vWeights size:= 1800*float
float *const weights__in_0__4 = (float*) (Shared+29568);  // Cost_Parallel_Work_0_ComputeVertWeights_0_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in_in_0 size:= 360*float
float *const weights__in_2__4 = (float*) (Shared+32448);  // Cost_Parallel_Work_0_ComputeVertWeights_2_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in_in_2 size:= 360*float
float *const weights__in_4__4 = (float*) (Shared+35328);  // Cost_Parallel_Work_0_ComputeVertWeights_4_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in_in_4 size:= 360*float
float *const weights__in__5 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in_weights > Cost_Parallel_Work_0_Broadcast3_0_in size:= 1800*float
float *const out_0_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_0_18 > Cost_Parallel_Work_0_AggregateCost_0_hWeights size:= 1800*float
float *const out_1_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_1_18 > Cost_Parallel_Work_0_AggregateCost_1_hWeights size:= 1800*float
float *const out_2_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_2_18 > Cost_Parallel_Work_0_AggregateCost_2_hWeights size:= 1800*float
float *const out_3_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_3_18 > Cost_Parallel_Work_0_AggregateCost_3_hWeights size:= 1800*float
float *const out_4_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_4_18 > Cost_Parallel_Work_0_AggregateCost_4_hWeights size:= 1800*float
float *const out_5_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_5_18 > Cost_Parallel_Work_0_AggregateCost_5_hWeights size:= 1800*float
float *const out_6_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_6_18 > Cost_Parallel_Work_0_AggregateCost_6_hWeights size:= 1800*float
float *const out_7_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_7_18 > Cost_Parallel_Work_0_AggregateCost_7_hWeights size:= 1800*float
float *const out_8_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_8_18 > Cost_Parallel_Work_0_AggregateCost_8_hWeights size:= 1800*float
float *const out_9_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_9_18 > Cost_Parallel_Work_0_AggregateCost_9_hWeights size:= 1800*float
float *const out_10_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_10_18 > Cost_Parallel_Work_0_AggregateCost_10_hWeights size:= 1800*float
float *const out_11_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_11_18 > Cost_Parallel_Work_0_AggregateCost_11_hWeights size:= 1800*float
float *const out_12_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_12_18 > Cost_Parallel_Work_0_AggregateCost_12_hWeights size:= 1800*float
float *const out_13_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_13_18 > Cost_Parallel_Work_0_AggregateCost_13_hWeights size:= 1800*float
float *const out_14_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_14_18 > Cost_Parallel_Work_0_AggregateCost_14_hWeights size:= 1800*float
float *const out_15_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_15_18 > Cost_Parallel_Work_0_AggregateCost_15_hWeights size:= 1800*float
float *const out_16_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_16_18 > Cost_Parallel_Work_0_AggregateCost_16_hWeights size:= 1800*float
float *const out_17_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_17_18 > Cost_Parallel_Work_0_AggregateCost_17_hWeights size:= 1800*float
float *const out_18_18__hWeights__2 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_Broadcast3_0_out_18_18 > Cost_Parallel_Work_0_AggregateCost_18_hWeights size:= 1800*float
float *const weights__in_0__5 = (float*) (Shared+36928);  // Cost_Parallel_Work_0_ComputeHorWeights_0_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in_in_0 size:= 360*float
float *const weights__in_2__5 = (float*) (Shared+39808);  // Cost_Parallel_Work_0_ComputeHorWeights_2_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in_in_2 size:= 360*float
float *const weights__in_4__5 = (float*) (Shared+42688);  // Cost_Parallel_Work_0_ComputeHorWeights_4_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in_in_4 size:= 360*float
float *const weights__in_1__0 = (float*) (Shared+44160);  // Cost_Parallel_Work_0_ComputeVertWeights_1_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in_in_1 size:= 360*float
float *const weights__in_1__1 = (float*) (Shared+45632);  // Cost_Parallel_Work_0_ComputeHorWeights_1_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in_in_1 size:= 360*float
float *const weights__in_3__0 = (float*) (Shared+47104);  // Cost_Parallel_Work_0_ComputeVertWeights_3_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in_in_3 size:= 360*float
float *const weights__in_3__1 = (float*) (Shared+48576);  // Cost_Parallel_Work_0_ComputeHorWeights_3_weights > Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in_in_3 size:= 360*float
float *const grayR_9_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_9_18 > Cost_Parallel_Work_1_CostConstruction_9_grayR size:= 120*float
float *const out1_1__grayR__0 = (float*) (Shared+50176);  // broadcast2_1_out1_1 > BR_Cost_Parallel_Work_1__grayR_grayR size:= 120*float
float *const grayR_0_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_0_18 > Cost_Parallel_Work_1_CostConstruction_0_grayR size:= 120*float
float *const grayR_1_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_1_18 > Cost_Parallel_Work_1_CostConstruction_1_grayR size:= 120*float
float *const grayR_2_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_2_18 > Cost_Parallel_Work_1_CostConstruction_2_grayR size:= 120*float
float *const grayR_3_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_3_18 > Cost_Parallel_Work_1_CostConstruction_3_grayR size:= 120*float
float *const grayR_4_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_4_18 > Cost_Parallel_Work_1_CostConstruction_4_grayR size:= 120*float
float *const grayR_5_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_5_18 > Cost_Parallel_Work_1_CostConstruction_5_grayR size:= 120*float
float *const grayR_6_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_6_18 > Cost_Parallel_Work_1_CostConstruction_6_grayR size:= 120*float
float *const grayR_7_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_7_18 > Cost_Parallel_Work_1_CostConstruction_7_grayR size:= 120*float
float *const grayR_8_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_8_18 > Cost_Parallel_Work_1_CostConstruction_8_grayR size:= 120*float
float *const grayR_10_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_10_18 > Cost_Parallel_Work_1_CostConstruction_10_grayR size:= 120*float
float *const grayR_11_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_11_18 > Cost_Parallel_Work_1_CostConstruction_11_grayR size:= 120*float
float *const grayR_12_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_12_18 > Cost_Parallel_Work_1_CostConstruction_12_grayR size:= 120*float
float *const grayR_13_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_13_18 > Cost_Parallel_Work_1_CostConstruction_13_grayR size:= 120*float
float *const grayR_14_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_14_18 > Cost_Parallel_Work_1_CostConstruction_14_grayR size:= 120*float
float *const grayR_15_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_15_18 > Cost_Parallel_Work_1_CostConstruction_15_grayR size:= 120*float
float *const grayR_16_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_16_18 > Cost_Parallel_Work_1_CostConstruction_16_grayR size:= 120*float
float *const grayR_17_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_17_18 > Cost_Parallel_Work_1_CostConstruction_17_grayR size:= 120*float
float *const grayR_18_18__grayR__0 = (float*) (Shared+50176);  // BR_Cost_Parallel_Work_1__grayR_grayR_18_18 > Cost_Parallel_Work_1_CostConstruction_18_grayR size:= 120*float
float *const gray__in__0 = (float*) (Shared+50176);  // RGB2Gray_R_1_gray > broadcast2_1_in size:= 120*float
float *const out0_0__gray__0 = (float*) (Shared+50176);  // broadcast2_1_out0_0 > Census_R_1_gray size:= 120*float
uchar *const rgb__rgb__0 = (uchar*) (Shared+50296);  // Read_PPM1_1_rgb > RGB2Gray_R_1_rgb size:= 360*uchar
float *const grayR_9_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_9_18 > Cost_Parallel_Work_2_CostConstruction_9_grayR size:= 120*float
float *const out1_1__grayR__1 = (float*) (Shared+50816);  // broadcast2_2_out1_1 > BR_Cost_Parallel_Work_2__grayR_grayR size:= 120*float
float *const grayR_0_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_0_18 > Cost_Parallel_Work_2_CostConstruction_0_grayR size:= 120*float
float *const grayR_1_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_1_18 > Cost_Parallel_Work_2_CostConstruction_1_grayR size:= 120*float
float *const grayR_2_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_2_18 > Cost_Parallel_Work_2_CostConstruction_2_grayR size:= 120*float
float *const grayR_3_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_3_18 > Cost_Parallel_Work_2_CostConstruction_3_grayR size:= 120*float
float *const grayR_4_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_4_18 > Cost_Parallel_Work_2_CostConstruction_4_grayR size:= 120*float
float *const grayR_5_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_5_18 > Cost_Parallel_Work_2_CostConstruction_5_grayR size:= 120*float
float *const grayR_6_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_6_18 > Cost_Parallel_Work_2_CostConstruction_6_grayR size:= 120*float
float *const grayR_7_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_7_18 > Cost_Parallel_Work_2_CostConstruction_7_grayR size:= 120*float
float *const grayR_8_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_8_18 > Cost_Parallel_Work_2_CostConstruction_8_grayR size:= 120*float
float *const grayR_10_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_10_18 > Cost_Parallel_Work_2_CostConstruction_10_grayR size:= 120*float
float *const grayR_11_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_11_18 > Cost_Parallel_Work_2_CostConstruction_11_grayR size:= 120*float
float *const grayR_12_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_12_18 > Cost_Parallel_Work_2_CostConstruction_12_grayR size:= 120*float
float *const grayR_13_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_13_18 > Cost_Parallel_Work_2_CostConstruction_13_grayR size:= 120*float
float *const grayR_14_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_14_18 > Cost_Parallel_Work_2_CostConstruction_14_grayR size:= 120*float
float *const grayR_15_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_15_18 > Cost_Parallel_Work_2_CostConstruction_15_grayR size:= 120*float
float *const grayR_16_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_16_18 > Cost_Parallel_Work_2_CostConstruction_16_grayR size:= 120*float
float *const grayR_17_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_17_18 > Cost_Parallel_Work_2_CostConstruction_17_grayR size:= 120*float
float *const grayR_18_18__grayR__1 = (float*) (Shared+50816);  // BR_Cost_Parallel_Work_2__grayR_grayR_18_18 > Cost_Parallel_Work_2_CostConstruction_18_grayR size:= 120*float
float *const gray__in__1 = (float*) (Shared+50816);  // RGB2Gray_R_2_gray > broadcast2_2_in size:= 120*float
float *const out0_0__gray__1 = (float*) (Shared+50816);  // broadcast2_2_out0_0 > Census_R_2_gray size:= 120*float
uchar *const rgb__rgb__1 = (uchar*) (Shared+50936);  // Read_PPM1_2_rgb > RGB2Gray_R_2_rgb size:= 360*uchar
float *const grayL_9_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_9_18 > Cost_Parallel_Work_0_CostConstruction_9_grayL size:= 120*float
float *const out1_1__grayL__0 = (float*) (Shared+51456);  // broadcast1_0_out1_1 > BR_Cost_Parallel_Work_0__grayL_grayL size:= 120*float
float *const grayL_0_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_0_18 > Cost_Parallel_Work_0_CostConstruction_0_grayL size:= 120*float
float *const grayL_1_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_1_18 > Cost_Parallel_Work_0_CostConstruction_1_grayL size:= 120*float
float *const grayL_2_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_2_18 > Cost_Parallel_Work_0_CostConstruction_2_grayL size:= 120*float
float *const grayL_3_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_3_18 > Cost_Parallel_Work_0_CostConstruction_3_grayL size:= 120*float
float *const grayL_4_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_4_18 > Cost_Parallel_Work_0_CostConstruction_4_grayL size:= 120*float
float *const grayL_5_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_5_18 > Cost_Parallel_Work_0_CostConstruction_5_grayL size:= 120*float
float *const grayL_6_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_6_18 > Cost_Parallel_Work_0_CostConstruction_6_grayL size:= 120*float
float *const grayL_7_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_7_18 > Cost_Parallel_Work_0_CostConstruction_7_grayL size:= 120*float
float *const grayL_8_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_8_18 > Cost_Parallel_Work_0_CostConstruction_8_grayL size:= 120*float
float *const grayL_10_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_10_18 > Cost_Parallel_Work_0_CostConstruction_10_grayL size:= 120*float
float *const grayL_11_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_11_18 > Cost_Parallel_Work_0_CostConstruction_11_grayL size:= 120*float
float *const grayL_12_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_12_18 > Cost_Parallel_Work_0_CostConstruction_12_grayL size:= 120*float
float *const grayL_13_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_13_18 > Cost_Parallel_Work_0_CostConstruction_13_grayL size:= 120*float
float *const grayL_14_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_14_18 > Cost_Parallel_Work_0_CostConstruction_14_grayL size:= 120*float
float *const grayL_15_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_15_18 > Cost_Parallel_Work_0_CostConstruction_15_grayL size:= 120*float
float *const grayL_16_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_16_18 > Cost_Parallel_Work_0_CostConstruction_16_grayL size:= 120*float
float *const grayL_17_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_17_18 > Cost_Parallel_Work_0_CostConstruction_17_grayL size:= 120*float
float *const grayL_18_18__grayL__0 = (float*) (Shared+51456);  // BR_Cost_Parallel_Work_0__grayL_grayL_18_18 > Cost_Parallel_Work_0_CostConstruction_18_grayL size:= 120*float
float *const gray__in__2 = (float*) (Shared+51456);  // RGB2Gray_L_0_gray > broadcast1_0_in size:= 120*float
float *const out0_0__gray__2 = (float*) (Shared+51456);  // broadcast1_0_out0_0 > Census_L_0_gray size:= 120*float
float *const grayL_9_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_9_18 > Cost_Parallel_Work_1_CostConstruction_9_grayL size:= 120*float
float *const out1_1__grayL__1 = (float*) (Shared+52096);  // broadcast1_1_out1_1 > BR_Cost_Parallel_Work_1__grayL_grayL size:= 120*float
float *const grayL_0_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_0_18 > Cost_Parallel_Work_1_CostConstruction_0_grayL size:= 120*float
float *const grayL_1_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_1_18 > Cost_Parallel_Work_1_CostConstruction_1_grayL size:= 120*float
float *const grayL_2_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_2_18 > Cost_Parallel_Work_1_CostConstruction_2_grayL size:= 120*float
float *const grayL_3_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_3_18 > Cost_Parallel_Work_1_CostConstruction_3_grayL size:= 120*float
float *const grayL_4_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_4_18 > Cost_Parallel_Work_1_CostConstruction_4_grayL size:= 120*float
float *const grayL_5_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_5_18 > Cost_Parallel_Work_1_CostConstruction_5_grayL size:= 120*float
float *const grayL_6_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_6_18 > Cost_Parallel_Work_1_CostConstruction_6_grayL size:= 120*float
float *const grayL_7_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_7_18 > Cost_Parallel_Work_1_CostConstruction_7_grayL size:= 120*float
float *const grayL_8_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_8_18 > Cost_Parallel_Work_1_CostConstruction_8_grayL size:= 120*float
float *const grayL_10_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_10_18 > Cost_Parallel_Work_1_CostConstruction_10_grayL size:= 120*float
float *const grayL_11_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_11_18 > Cost_Parallel_Work_1_CostConstruction_11_grayL size:= 120*float
float *const grayL_12_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_12_18 > Cost_Parallel_Work_1_CostConstruction_12_grayL size:= 120*float
float *const grayL_13_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_13_18 > Cost_Parallel_Work_1_CostConstruction_13_grayL size:= 120*float
float *const grayL_14_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_14_18 > Cost_Parallel_Work_1_CostConstruction_14_grayL size:= 120*float
float *const grayL_15_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_15_18 > Cost_Parallel_Work_1_CostConstruction_15_grayL size:= 120*float
float *const grayL_16_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_16_18 > Cost_Parallel_Work_1_CostConstruction_16_grayL size:= 120*float
float *const grayL_17_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_17_18 > Cost_Parallel_Work_1_CostConstruction_17_grayL size:= 120*float
float *const grayL_18_18__grayL__1 = (float*) (Shared+52096);  // BR_Cost_Parallel_Work_1__grayL_grayL_18_18 > Cost_Parallel_Work_1_CostConstruction_18_grayL size:= 120*float
float *const gray__in__3 = (float*) (Shared+52096);  // RGB2Gray_L_1_gray > broadcast1_1_in size:= 120*float
float *const out0_0__gray__3 = (float*) (Shared+52096);  // broadcast1_1_out0_0 > Census_L_1_gray size:= 120*float
float *const grayL_9_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_9_18 > Cost_Parallel_Work_2_CostConstruction_9_grayL size:= 120*float
float *const out1_1__grayL__2 = (float*) (Shared+52736);  // broadcast1_2_out1_1 > BR_Cost_Parallel_Work_2__grayL_grayL size:= 120*float
float *const grayL_0_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_0_18 > Cost_Parallel_Work_2_CostConstruction_0_grayL size:= 120*float
float *const grayL_1_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_1_18 > Cost_Parallel_Work_2_CostConstruction_1_grayL size:= 120*float
float *const grayL_2_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_2_18 > Cost_Parallel_Work_2_CostConstruction_2_grayL size:= 120*float
float *const grayL_3_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_3_18 > Cost_Parallel_Work_2_CostConstruction_3_grayL size:= 120*float
float *const grayL_4_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_4_18 > Cost_Parallel_Work_2_CostConstruction_4_grayL size:= 120*float
float *const grayL_5_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_5_18 > Cost_Parallel_Work_2_CostConstruction_5_grayL size:= 120*float
float *const grayL_6_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_6_18 > Cost_Parallel_Work_2_CostConstruction_6_grayL size:= 120*float
float *const grayL_7_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_7_18 > Cost_Parallel_Work_2_CostConstruction_7_grayL size:= 120*float
float *const grayL_8_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_8_18 > Cost_Parallel_Work_2_CostConstruction_8_grayL size:= 120*float
float *const grayL_10_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_10_18 > Cost_Parallel_Work_2_CostConstruction_10_grayL size:= 120*float
float *const grayL_11_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_11_18 > Cost_Parallel_Work_2_CostConstruction_11_grayL size:= 120*float
float *const grayL_12_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_12_18 > Cost_Parallel_Work_2_CostConstruction_12_grayL size:= 120*float
float *const grayL_13_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_13_18 > Cost_Parallel_Work_2_CostConstruction_13_grayL size:= 120*float
float *const grayL_14_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_14_18 > Cost_Parallel_Work_2_CostConstruction_14_grayL size:= 120*float
float *const grayL_15_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_15_18 > Cost_Parallel_Work_2_CostConstruction_15_grayL size:= 120*float
float *const grayL_16_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_16_18 > Cost_Parallel_Work_2_CostConstruction_16_grayL size:= 120*float
float *const grayL_17_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_17_18 > Cost_Parallel_Work_2_CostConstruction_17_grayL size:= 120*float
float *const grayL_18_18__grayL__2 = (float*) (Shared+52736);  // BR_Cost_Parallel_Work_2__grayL_grayL_18_18 > Cost_Parallel_Work_2_CostConstruction_18_grayL size:= 120*float
float *const gray__in__4 = (float*) (Shared+52736);  // RGB2Gray_L_2_gray > broadcast1_2_in size:= 120*float
float *const out0_0__gray__4 = (float*) (Shared+52736);  // broadcast1_2_out0_0 > Census_L_2_gray size:= 120*float
float *const grayR_9_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_9_18 > Cost_Parallel_Work_0_CostConstruction_9_grayR size:= 120*float
float *const out1_1__grayR__2 = (float*) (Shared+53376);  // broadcast2_0_out1_1 > BR_Cost_Parallel_Work_0__grayR_grayR size:= 120*float
float *const grayR_0_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_0_18 > Cost_Parallel_Work_0_CostConstruction_0_grayR size:= 120*float
float *const grayR_1_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_1_18 > Cost_Parallel_Work_0_CostConstruction_1_grayR size:= 120*float
float *const grayR_2_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_2_18 > Cost_Parallel_Work_0_CostConstruction_2_grayR size:= 120*float
float *const grayR_3_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_3_18 > Cost_Parallel_Work_0_CostConstruction_3_grayR size:= 120*float
float *const grayR_4_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_4_18 > Cost_Parallel_Work_0_CostConstruction_4_grayR size:= 120*float
float *const grayR_5_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_5_18 > Cost_Parallel_Work_0_CostConstruction_5_grayR size:= 120*float
float *const grayR_6_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_6_18 > Cost_Parallel_Work_0_CostConstruction_6_grayR size:= 120*float
float *const grayR_7_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_7_18 > Cost_Parallel_Work_0_CostConstruction_7_grayR size:= 120*float
float *const grayR_8_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_8_18 > Cost_Parallel_Work_0_CostConstruction_8_grayR size:= 120*float
float *const grayR_10_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_10_18 > Cost_Parallel_Work_0_CostConstruction_10_grayR size:= 120*float
float *const grayR_11_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_11_18 > Cost_Parallel_Work_0_CostConstruction_11_grayR size:= 120*float
float *const grayR_12_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_12_18 > Cost_Parallel_Work_0_CostConstruction_12_grayR size:= 120*float
float *const grayR_13_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_13_18 > Cost_Parallel_Work_0_CostConstruction_13_grayR size:= 120*float
float *const grayR_14_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_14_18 > Cost_Parallel_Work_0_CostConstruction_14_grayR size:= 120*float
float *const grayR_15_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_15_18 > Cost_Parallel_Work_0_CostConstruction_15_grayR size:= 120*float
float *const grayR_16_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_16_18 > Cost_Parallel_Work_0_CostConstruction_16_grayR size:= 120*float
float *const grayR_17_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_17_18 > Cost_Parallel_Work_0_CostConstruction_17_grayR size:= 120*float
float *const grayR_18_18__grayR__2 = (float*) (Shared+53376);  // BR_Cost_Parallel_Work_0__grayR_grayR_18_18 > Cost_Parallel_Work_0_CostConstruction_18_grayR size:= 120*float
float *const gray__in__5 = (float*) (Shared+53376);  // RGB2Gray_R_0_gray > broadcast2_0_in size:= 120*float
float *const out0_0__gray__5 = (float*) (Shared+53376);  // broadcast2_0_out0_0 > Census_R_0_gray size:= 120*float
uchar *const rgb__rgb__2 = (uchar*) (Shared+53496);  // Read_PPM1_0_rgb > RGB2Gray_R_0_rgb size:= 360*uchar
float *const backBestCost__bestCostFeed__0 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_8_backBestCost > Cost_Parallel_Work_1_disparitySelect_9_bestCostFeed size:= 121*float
float *const bestCostFeed__bestCostFeed__0 = (float*) (Shared+54016);  // Cost_Parallel_Work_init_in_disparitySelect_bestCostFeed_bestCostFeed > Cost_Parallel_Work_0_disparitySelect_0_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__1 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_0_backBestCost > Cost_Parallel_Work_0_disparitySelect_1_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__2 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_1_backBestCost > Cost_Parallel_Work_0_disparitySelect_2_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__3 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_2_backBestCost > Cost_Parallel_Work_0_disparitySelect_3_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__4 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_3_backBestCost > Cost_Parallel_Work_0_disparitySelect_4_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__5 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_4_backBestCost > Cost_Parallel_Work_0_disparitySelect_5_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__6 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_5_backBestCost > Cost_Parallel_Work_0_disparitySelect_6_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__7 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_6_backBestCost > Cost_Parallel_Work_0_disparitySelect_7_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__8 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_7_backBestCost > Cost_Parallel_Work_0_disparitySelect_8_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__9 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_8_backBestCost > Cost_Parallel_Work_0_disparitySelect_9_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__10 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_9_backBestCost > Cost_Parallel_Work_0_disparitySelect_10_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__11 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_10_backBestCost > Cost_Parallel_Work_0_disparitySelect_11_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__12 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_11_backBestCost > Cost_Parallel_Work_0_disparitySelect_12_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__13 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_12_backBestCost > Cost_Parallel_Work_0_disparitySelect_13_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__14 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_13_backBestCost > Cost_Parallel_Work_0_disparitySelect_14_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__15 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_14_backBestCost > Cost_Parallel_Work_0_disparitySelect_15_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__16 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_15_backBestCost > Cost_Parallel_Work_0_disparitySelect_16_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__17 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_16_backBestCost > Cost_Parallel_Work_0_disparitySelect_17_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__18 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_17_backBestCost > Cost_Parallel_Work_0_disparitySelect_18_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__19 = (float*) (Shared+54016);  // Cost_Parallel_Work_0_disparitySelect_18_backBestCost > Cost_Parallel_Work_1_disparitySelect_0_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__20 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_0_backBestCost > Cost_Parallel_Work_1_disparitySelect_1_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__21 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_1_backBestCost > Cost_Parallel_Work_1_disparitySelect_2_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__22 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_2_backBestCost > Cost_Parallel_Work_1_disparitySelect_3_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__23 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_3_backBestCost > Cost_Parallel_Work_1_disparitySelect_4_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__24 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_4_backBestCost > Cost_Parallel_Work_1_disparitySelect_5_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__25 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_5_backBestCost > Cost_Parallel_Work_1_disparitySelect_6_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__26 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_6_backBestCost > Cost_Parallel_Work_1_disparitySelect_7_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__27 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_7_backBestCost > Cost_Parallel_Work_1_disparitySelect_8_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__28 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_9_backBestCost > Cost_Parallel_Work_1_disparitySelect_10_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__29 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_10_backBestCost > Cost_Parallel_Work_1_disparitySelect_11_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__30 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_11_backBestCost > Cost_Parallel_Work_1_disparitySelect_12_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__31 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_12_backBestCost > Cost_Parallel_Work_1_disparitySelect_13_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__32 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_13_backBestCost > Cost_Parallel_Work_1_disparitySelect_14_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__33 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_14_backBestCost > Cost_Parallel_Work_1_disparitySelect_15_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__34 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_15_backBestCost > Cost_Parallel_Work_1_disparitySelect_16_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__35 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_16_backBestCost > Cost_Parallel_Work_1_disparitySelect_17_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__36 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_17_backBestCost > Cost_Parallel_Work_1_disparitySelect_18_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__37 = (float*) (Shared+54016);  // Cost_Parallel_Work_1_disparitySelect_18_backBestCost > Cost_Parallel_Work_2_disparitySelect_0_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__38 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_0_backBestCost > Cost_Parallel_Work_2_disparitySelect_1_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__39 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_1_backBestCost > Cost_Parallel_Work_2_disparitySelect_2_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__40 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_2_backBestCost > Cost_Parallel_Work_2_disparitySelect_3_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__41 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_3_backBestCost > Cost_Parallel_Work_2_disparitySelect_4_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__42 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_4_backBestCost > Cost_Parallel_Work_2_disparitySelect_5_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__43 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_5_backBestCost > Cost_Parallel_Work_2_disparitySelect_6_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__44 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_6_backBestCost > Cost_Parallel_Work_2_disparitySelect_7_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__45 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_7_backBestCost > Cost_Parallel_Work_2_disparitySelect_8_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__46 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_8_backBestCost > Cost_Parallel_Work_2_disparitySelect_9_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__47 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_9_backBestCost > Cost_Parallel_Work_2_disparitySelect_10_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__48 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_10_backBestCost > Cost_Parallel_Work_2_disparitySelect_11_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__49 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_11_backBestCost > Cost_Parallel_Work_2_disparitySelect_12_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__50 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_12_backBestCost > Cost_Parallel_Work_2_disparitySelect_13_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__51 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_13_backBestCost > Cost_Parallel_Work_2_disparitySelect_14_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__52 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_14_backBestCost > Cost_Parallel_Work_2_disparitySelect_15_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__53 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_15_backBestCost > Cost_Parallel_Work_2_disparitySelect_16_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__54 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_16_backBestCost > Cost_Parallel_Work_2_disparitySelect_17_bestCostFeed size:= 121*float
float *const backBestCost__bestCostFeed__55 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_17_backBestCost > Cost_Parallel_Work_2_disparitySelect_18_bestCostFeed size:= 121*float
float *const backBestCost__backBestCost__0 = (float*) (Shared+54016);  // Cost_Parallel_Work_2_disparitySelect_18_backBestCost > Cost_Parallel_Work_end_out_disparitySelect_backBestCost_backBestCost size:= 121*float
uchar *const output__rawDisparity__0 = (uchar*) (Shared+53376);  // Split_1_output > explode_Split_1_output_rawDisparity size:= 480*uchar
uchar *const output_1__rawDisparity__0 = (uchar*) (Shared+53400);  // explode_Split_1_output_output_1 > Median_Filter_14_rawDisparity size:= 36*uchar
uchar *const output_2__rawDisparity__0 = (uchar*) (Shared+53436);  // explode_Split_1_output_output_2 > Median_Filter_15_rawDisparity size:= 36*uchar
uchar *const output_3__rawDisparity__0 = (uchar*) (Shared+53472);  // explode_Split_1_output_output_3 > Median_Filter_16_rawDisparity size:= 36*uchar
uchar *const output_4__rawDisparity__0 = (uchar*) (Shared+53508);  // explode_Split_1_output_output_4 > Median_Filter_17_rawDisparity size:= 36*uchar
uchar *const output_5__rawDisparity__0 = (uchar*) (Shared+53544);  // explode_Split_1_output_output_5 > Median_Filter_18_rawDisparity size:= 36*uchar
uchar *const output_6__rawDisparity__0 = (uchar*) (Shared+53580);  // explode_Split_1_output_output_6 > Median_Filter_19_rawDisparity size:= 36*uchar
uchar *const output_7__rawDisparity__0 = (uchar*) (Shared+53616);  // explode_Split_1_output_output_7 > Median_Filter_20_rawDisparity size:= 36*uchar
uchar *const output_8__rawDisparity__0 = (uchar*) (Shared+53652);  // explode_Split_1_output_output_8 > Median_Filter_21_rawDisparity size:= 36*uchar
uchar *const output_9__rawDisparity__0 = (uchar*) (Shared+53688);  // explode_Split_1_output_output_9 > Median_Filter_22_rawDisparity size:= 36*uchar
uchar *const output_10__rawDisparity__0 = (uchar*) (Shared+53724);  // explode_Split_1_output_output_10 > Median_Filter_23_rawDisparity size:= 36*uchar
uchar *const output_11__rawDisparity__0 = (uchar*) (Shared+53760);  // explode_Split_1_output_output_11 > Median_Filter_24_rawDisparity size:= 36*uchar
uchar *const output_12__rawDisparity__0 = (uchar*) (Shared+53796);  // explode_Split_1_output_output_12 > Median_Filter_25_rawDisparity size:= 36*uchar
uchar *const output_0__rawDisparity_1__0 = (uchar*) (Shared+128);  // explode_Split_2_output_output_0 > implode_Median_Filter_26_rawDisparity_rawDisparity_1 size:= 12*uchar
uchar *const output__rawDisparity__1 = (uchar*) (Shared+128);  // Split_2_output > explode_Split_2_output_rawDisparity size:= 480*uchar
uchar *const output_1__rawDisparity__1 = (uchar*) (Shared+140);  // explode_Split_2_output_output_1 > Median_Filter_27_rawDisparity size:= 36*uchar
uchar *const output_2__rawDisparity__1 = (uchar*) (Shared+176);  // explode_Split_2_output_output_2 > Median_Filter_28_rawDisparity size:= 36*uchar
uchar *const output_3__rawDisparity__1 = (uchar*) (Shared+212);  // explode_Split_2_output_output_3 > Median_Filter_29_rawDisparity size:= 36*uchar
uchar *const output_4__rawDisparity__1 = (uchar*) (Shared+248);  // explode_Split_2_output_output_4 > Median_Filter_30_rawDisparity size:= 36*uchar
uchar *const output_5__rawDisparity__1 = (uchar*) (Shared+284);  // explode_Split_2_output_output_5 > Median_Filter_31_rawDisparity size:= 36*uchar
uchar *const output_6__rawDisparity__1 = (uchar*) (Shared+320);  // explode_Split_2_output_output_6 > Median_Filter_32_rawDisparity size:= 36*uchar
uchar *const output_7__rawDisparity__1 = (uchar*) (Shared+356);  // explode_Split_2_output_output_7 > Median_Filter_33_rawDisparity size:= 36*uchar
uchar *const output_8__rawDisparity__1 = (uchar*) (Shared+392);  // explode_Split_2_output_output_8 > Median_Filter_34_rawDisparity size:= 36*uchar
uchar *const output_9__rawDisparity__1 = (uchar*) (Shared+428);  // explode_Split_2_output_output_9 > Median_Filter_35_rawDisparity size:= 36*uchar
uchar *const output_10__rawDisparity__1 = (uchar*) (Shared+464);  // explode_Split_2_output_output_10 > Median_Filter_36_rawDisparity size:= 36*uchar
uchar *const output_11__rawDisparity__1 = (uchar*) (Shared+500);  // explode_Split_2_output_output_11 > Median_Filter_37_rawDisparity size:= 36*uchar
uchar *const output_12__rawDisparity__1 = (uchar*) (Shared+536);  // explode_Split_2_output_output_12 > Median_Filter_38_rawDisparity size:= 36*uchar
uchar *const output_13__rawDisparity__0 = (uchar*) (Shared+572);  // explode_Split_2_output_output_13 > Median_Filter_39_rawDisparity size:= 36*uchar
uchar *const output_13__rawDisparity_0__0 = (uchar*) (Shared+51904);  // explode_Split_0_output_output_13 > implode_Median_Filter_13_rawDisparity_rawDisparity_0 size:= 12*uchar
uchar *const output__rawDisparity__2 = (uchar*) (Shared+51436);  // Split_0_output > explode_Split_0_output_rawDisparity size:= 480*uchar
uchar *const output_0__rawDisparity__0 = (uchar*) (Shared+51436);  // explode_Split_0_output_output_0 > Median_Filter_0_rawDisparity size:= 36*uchar
uchar *const output_1__rawDisparity__2 = (uchar*) (Shared+51472);  // explode_Split_0_output_output_1 > Median_Filter_1_rawDisparity size:= 36*uchar
uchar *const output_2__rawDisparity__2 = (uchar*) (Shared+51508);  // explode_Split_0_output_output_2 > Median_Filter_2_rawDisparity size:= 36*uchar
uchar *const output_3__rawDisparity__2 = (uchar*) (Shared+51544);  // explode_Split_0_output_output_3 > Median_Filter_3_rawDisparity size:= 36*uchar
uchar *const output_4__rawDisparity__2 = (uchar*) (Shared+51580);  // explode_Split_0_output_output_4 > Median_Filter_4_rawDisparity size:= 36*uchar
uchar *const output_5__rawDisparity__2 = (uchar*) (Shared+51616);  // explode_Split_0_output_output_5 > Median_Filter_5_rawDisparity size:= 36*uchar
uchar *const output_6__rawDisparity__2 = (uchar*) (Shared+51652);  // explode_Split_0_output_output_6 > Median_Filter_6_rawDisparity size:= 36*uchar
uchar *const output_7__rawDisparity__2 = (uchar*) (Shared+51688);  // explode_Split_0_output_output_7 > Median_Filter_7_rawDisparity size:= 36*uchar
uchar *const output_8__rawDisparity__2 = (uchar*) (Shared+51724);  // explode_Split_0_output_output_8 > Median_Filter_8_rawDisparity size:= 36*uchar
uchar *const output_9__rawDisparity__2 = (uchar*) (Shared+51760);  // explode_Split_0_output_output_9 > Median_Filter_9_rawDisparity size:= 36*uchar
uchar *const output_10__rawDisparity__2 = (uchar*) (Shared+51796);  // explode_Split_0_output_output_10 > Median_Filter_10_rawDisparity size:= 36*uchar
uchar *const output_11__rawDisparity__2 = (uchar*) (Shared+51832);  // explode_Split_0_output_output_11 > Median_Filter_11_rawDisparity size:= 36*uchar
uchar *const output_12__rawDisparity__2 = (uchar*) (Shared+51868);  // explode_Split_0_output_output_12 > Median_Filter_12_rawDisparity size:= 36*uchar
uchar *const rgbL_4_4__in__0 = (uchar*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL_rgbL_4_4 > Cost_Parallel_Work_0_Broadcast1_4_in size:= 360*uchar
uchar *const out2_1__rgbL__0 = (uchar*) (Shared+1728);  // Broadcast0_0_out2_1 > BR_Cost_Parallel_Work_0__rgbL_rgbL size:= 360*uchar
uchar *const rgb__in__0 = (uchar*) (Shared+1728);  // Read_PPM0_0_rgb > Broadcast0_0_in size:= 360*uchar
uchar *const out0_0__rgb__0 = (uchar*) (Shared+1728);  // Broadcast0_0_out0_0 > Display_rgb0_0_rgb size:= 360*uchar
uchar *const out1_2__rgb__0 = (uchar*) (Shared+1728);  // Broadcast0_0_out1_2 > RGB2Gray_L_0_rgb size:= 360*uchar
uchar *const rgbL_0_4__in__0 = (uchar*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL_rgbL_0_4 > Cost_Parallel_Work_0_Broadcast1_0_in size:= 360*uchar
uchar *const out0_0__rgbL__0 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_0_out0_0 > Cost_Parallel_Work_0_ComputeVertWeights_0_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__0 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_0_out1_1 > Cost_Parallel_Work_0_ComputeHorWeights_0_rgbL size:= 360*uchar
uchar *const rgbL_1_4__in__0 = (uchar*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL_rgbL_1_4 > Cost_Parallel_Work_0_Broadcast1_1_in size:= 360*uchar
uchar *const out0_0__rgbL__1 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_1_out0_0 > Cost_Parallel_Work_0_ComputeVertWeights_1_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__1 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_1_out1_1 > Cost_Parallel_Work_0_ComputeHorWeights_1_rgbL size:= 360*uchar
uchar *const rgbL_2_4__in__0 = (uchar*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL_rgbL_2_4 > Cost_Parallel_Work_0_Broadcast1_2_in size:= 360*uchar
uchar *const out0_0__rgbL__2 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_2_out0_0 > Cost_Parallel_Work_0_ComputeVertWeights_2_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__2 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_2_out1_1 > Cost_Parallel_Work_0_ComputeHorWeights_2_rgbL size:= 360*uchar
uchar *const rgbL_3_4__in__0 = (uchar*) (Shared+1728);  // BR_Cost_Parallel_Work_0__rgbL_rgbL_3_4 > Cost_Parallel_Work_0_Broadcast1_3_in size:= 360*uchar
uchar *const out0_0__rgbL__3 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_3_out0_0 > Cost_Parallel_Work_0_ComputeVertWeights_3_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__3 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_3_out1_1 > Cost_Parallel_Work_0_ComputeHorWeights_3_rgbL size:= 360*uchar
uchar *const out0_0__rgbL__4 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_4_out0_0 > Cost_Parallel_Work_0_ComputeVertWeights_4_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__4 = (uchar*) (Shared+1728);  // Cost_Parallel_Work_0_Broadcast1_4_out1_1 > Cost_Parallel_Work_0_ComputeHorWeights_4_rgbL size:= 360*uchar
uchar *const rgbL_4_4__in__1 = (uchar*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL_rgbL_4_4 > Cost_Parallel_Work_1_Broadcast1_4_in size:= 360*uchar
uchar *const out2_1__rgbL__1 = (uchar*) (Shared+2240);  // Broadcast0_1_out2_1 > BR_Cost_Parallel_Work_1__rgbL_rgbL size:= 360*uchar
uchar *const rgb__in__1 = (uchar*) (Shared+2240);  // Read_PPM0_1_rgb > Broadcast0_1_in size:= 360*uchar
uchar *const out0_0__rgb__1 = (uchar*) (Shared+2240);  // Broadcast0_1_out0_0 > Display_rgb0_1_rgb size:= 360*uchar
uchar *const out1_2__rgb__1 = (uchar*) (Shared+2240);  // Broadcast0_1_out1_2 > RGB2Gray_L_1_rgb size:= 360*uchar
uchar *const rgbL_0_4__in__1 = (uchar*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL_rgbL_0_4 > Cost_Parallel_Work_1_Broadcast1_0_in size:= 360*uchar
uchar *const out0_0__rgbL__5 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_0_out0_0 > Cost_Parallel_Work_1_ComputeVertWeights_0_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__5 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_0_out1_1 > Cost_Parallel_Work_1_ComputeHorWeights_0_rgbL size:= 360*uchar
uchar *const rgbL_1_4__in__1 = (uchar*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL_rgbL_1_4 > Cost_Parallel_Work_1_Broadcast1_1_in size:= 360*uchar
uchar *const out0_0__rgbL__6 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_1_out0_0 > Cost_Parallel_Work_1_ComputeVertWeights_1_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__6 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_1_out1_1 > Cost_Parallel_Work_1_ComputeHorWeights_1_rgbL size:= 360*uchar
uchar *const rgbL_2_4__in__1 = (uchar*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL_rgbL_2_4 > Cost_Parallel_Work_1_Broadcast1_2_in size:= 360*uchar
uchar *const out0_0__rgbL__7 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_2_out0_0 > Cost_Parallel_Work_1_ComputeVertWeights_2_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__7 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_2_out1_1 > Cost_Parallel_Work_1_ComputeHorWeights_2_rgbL size:= 360*uchar
uchar *const rgbL_3_4__in__1 = (uchar*) (Shared+2240);  // BR_Cost_Parallel_Work_1__rgbL_rgbL_3_4 > Cost_Parallel_Work_1_Broadcast1_3_in size:= 360*uchar
uchar *const out0_0__rgbL__8 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_3_out0_0 > Cost_Parallel_Work_1_ComputeVertWeights_3_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__8 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_3_out1_1 > Cost_Parallel_Work_1_ComputeHorWeights_3_rgbL size:= 360*uchar
uchar *const out0_0__rgbL__9 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_4_out0_0 > Cost_Parallel_Work_1_ComputeVertWeights_4_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__9 = (uchar*) (Shared+2240);  // Cost_Parallel_Work_1_Broadcast1_4_out1_1 > Cost_Parallel_Work_1_ComputeHorWeights_4_rgbL size:= 360*uchar
uchar *const rgbL_4_4__in__2 = (uchar*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL_rgbL_4_4 > Cost_Parallel_Work_2_Broadcast1_4_in size:= 360*uchar
uchar *const out2_1__rgbL__2 = (uchar*) (Shared+4608);  // Broadcast0_2_out2_1 > BR_Cost_Parallel_Work_2__rgbL_rgbL size:= 360*uchar
uchar *const rgb__in__2 = (uchar*) (Shared+4608);  // Read_PPM0_2_rgb > Broadcast0_2_in size:= 360*uchar
uchar *const out0_0__rgb__2 = (uchar*) (Shared+4608);  // Broadcast0_2_out0_0 > Display_rgb0_2_rgb size:= 360*uchar
uchar *const out1_2__rgb__2 = (uchar*) (Shared+4608);  // Broadcast0_2_out1_2 > RGB2Gray_L_2_rgb size:= 360*uchar
uchar *const rgbL_0_4__in__2 = (uchar*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL_rgbL_0_4 > Cost_Parallel_Work_2_Broadcast1_0_in size:= 360*uchar
uchar *const out0_0__rgbL__10 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_0_out0_0 > Cost_Parallel_Work_2_ComputeVertWeights_0_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__10 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_0_out1_1 > Cost_Parallel_Work_2_ComputeHorWeights_0_rgbL size:= 360*uchar
uchar *const rgbL_1_4__in__2 = (uchar*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL_rgbL_1_4 > Cost_Parallel_Work_2_Broadcast1_1_in size:= 360*uchar
uchar *const out0_0__rgbL__11 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_1_out0_0 > Cost_Parallel_Work_2_ComputeVertWeights_1_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__11 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_1_out1_1 > Cost_Parallel_Work_2_ComputeHorWeights_1_rgbL size:= 360*uchar
uchar *const rgbL_2_4__in__2 = (uchar*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL_rgbL_2_4 > Cost_Parallel_Work_2_Broadcast1_2_in size:= 360*uchar
uchar *const out0_0__rgbL__12 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_2_out0_0 > Cost_Parallel_Work_2_ComputeVertWeights_2_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__12 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_2_out1_1 > Cost_Parallel_Work_2_ComputeHorWeights_2_rgbL size:= 360*uchar
uchar *const rgbL_3_4__in__2 = (uchar*) (Shared+4608);  // BR_Cost_Parallel_Work_2__rgbL_rgbL_3_4 > Cost_Parallel_Work_2_Broadcast1_3_in size:= 360*uchar
uchar *const out0_0__rgbL__13 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_3_out0_0 > Cost_Parallel_Work_2_ComputeVertWeights_3_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__13 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_3_out1_1 > Cost_Parallel_Work_2_ComputeHorWeights_3_rgbL size:= 360*uchar
uchar *const out0_0__rgbL__14 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_4_out0_0 > Cost_Parallel_Work_2_ComputeVertWeights_4_rgbL size:= 360*uchar
uchar *const out1_1__rgbL__14 = (uchar*) (Shared+4608);  // Cost_Parallel_Work_2_Broadcast1_4_out1_1 > Cost_Parallel_Work_2_ComputeHorWeights_4_rgbL size:= 360*uchar
float *const disparityError__disparityErr__0 = (float*) (Shared+45632);  // Cost_Parallel_Work_0_CostConstruction_6_disparityError > Cost_Parallel_Work_0_AggregateCost_6_disparityError size:= 120*float
float *const disparityError__disparityErr__1 = (float*) (Shared+54528);  // Cost_Parallel_Work_0_CostConstruction_4_disparityError > Cost_Parallel_Work_0_AggregateCost_4_disparityError size:= 120*float
float *const disparityError__disparityErr__2 = (float*) (Shared+44160);  // Cost_Parallel_Work_0_CostConstruction_5_disparityError > Cost_Parallel_Work_0_AggregateCost_5_disparityError size:= 120*float
float *const disparityError__disparityErr__3 = (float*) (Shared+55040);  // Cost_Parallel_Work_0_CostConstruction_7_disparityError > Cost_Parallel_Work_0_AggregateCost_7_disparityError size:= 120*float
float *const aggregatedDisparity__aggrega__0 = (float*) (Shared+44672);  // Cost_Parallel_Work_0_AggregateCost_2_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_2_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__1 = (float*) (Shared+46144);  // Cost_Parallel_Work_0_AggregateCost_4_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_4_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__2 = (float*) (Shared+54528);  // Cost_Parallel_Work_0_AggregateCost_7_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_7_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__3 = (float*) (Shared+46656);  // Cost_Parallel_Work_0_AggregateCost_1_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_1_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__4 = (float*) (Shared+47168);  // Cost_Parallel_Work_0_AggregateCost_3_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_3_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__5 = (float*) (Shared+47680);  // Cost_Parallel_Work_0_AggregateCost_5_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_5_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__6 = (float*) (Shared+48192);  // Cost_Parallel_Work_0_AggregateCost_6_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_6_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__7 = (float*) (Shared+45184);  // Cost_Parallel_Work_0_AggregateCost_8_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_8_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__8 = (float*) (Shared+44160);  // Cost_Parallel_Work_0_AggregateCost_9_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_9_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__9 = (float*) (Shared+44672);  // Cost_Parallel_Work_0_AggregateCost_10_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_10_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__10 = (float*) (Shared+46656);  // Cost_Parallel_Work_0_AggregateCost_11_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_11_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__11 = (float*) (Shared+46144);  // Cost_Parallel_Work_0_AggregateCost_12_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_12_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__12 = (float*) (Shared+47168);  // Cost_Parallel_Work_0_AggregateCost_13_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_13_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__13 = (float*) (Shared+47680);  // Cost_Parallel_Work_0_AggregateCost_14_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_14_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__14 = (float*) (Shared+48192);  // Cost_Parallel_Work_0_AggregateCost_15_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_15_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__15 = (float*) (Shared+45184);  // Cost_Parallel_Work_0_AggregateCost_16_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_16_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__16 = (float*) (Shared+44160);  // Cost_Parallel_Work_0_AggregateCost_17_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_17_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__17 = (float*) (Shared+44672);  // Cost_Parallel_Work_0_AggregateCost_18_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_18_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__18 = (float*) (Shared+46656);  // Cost_Parallel_Work_1_AggregateCost_0_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_0_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__19 = (float*) (Shared+45696);  // Cost_Parallel_Work_1_AggregateCost_1_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_1_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__20 = (float*) (Shared+47168);  // Cost_Parallel_Work_1_AggregateCost_2_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_2_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__21 = (float*) (Shared+47680);  // Cost_Parallel_Work_1_AggregateCost_3_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_3_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__22 = (float*) (Shared+48192);  // Cost_Parallel_Work_1_AggregateCost_4_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_4_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__23 = (float*) (Shared+45184);  // Cost_Parallel_Work_1_AggregateCost_5_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_5_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__24 = (float*) (Shared+44160);  // Cost_Parallel_Work_1_AggregateCost_6_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_6_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__25 = (float*) (Shared+44672);  // Cost_Parallel_Work_1_AggregateCost_7_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_7_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__26 = (float*) (Shared+53248);  // Cost_Parallel_Work_1_AggregateCost_8_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_8_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__27 = (float*) (Shared+51328);  // Cost_Parallel_Work_1_AggregateCost_9_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_9_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__28 = (float*) (Shared+48704);  // Cost_Parallel_Work_1_AggregateCost_10_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_10_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__29 = (float*) (Shared+49216);  // Cost_Parallel_Work_1_AggregateCost_11_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_11_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__30 = (float*) (Shared+45696);  // Cost_Parallel_Work_1_AggregateCost_12_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_12_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__31 = (float*) (Shared+45184);  // Cost_Parallel_Work_1_AggregateCost_13_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_13_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__32 = (float*) (Shared+46208);  // Cost_Parallel_Work_1_AggregateCost_14_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_14_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__33 = (float*) (Shared+46720);  // Cost_Parallel_Work_1_AggregateCost_15_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_15_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__34 = (float*) (Shared+53248);  // Cost_Parallel_Work_1_AggregateCost_16_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_16_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__35 = (float*) (Shared+51328);  // Cost_Parallel_Work_1_AggregateCost_17_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_17_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__36 = (float*) (Shared+47232);  // Cost_Parallel_Work_1_AggregateCost_18_aggregatedDisparity > Cost_Parallel_Work_1_disparitySelect_18_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__37 = (float*) (Shared+47744);  // Cost_Parallel_Work_2_AggregateCost_0_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_0_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__38 = (float*) (Shared+45696);  // Cost_Parallel_Work_2_AggregateCost_1_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_1_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__39 = (float*) (Shared+48256);  // Cost_Parallel_Work_2_AggregateCost_2_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_2_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__40 = (float*) (Shared+46208);  // Cost_Parallel_Work_2_AggregateCost_3_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_3_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__41 = (float*) (Shared+46720);  // Cost_Parallel_Work_2_AggregateCost_4_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_4_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__42 = (float*) (Shared+48768);  // Cost_Parallel_Work_2_AggregateCost_5_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_5_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__43 = (float*) (Shared+51328);  // Cost_Parallel_Work_2_AggregateCost_6_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_6_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__44 = (float*) (Shared+47232);  // Cost_Parallel_Work_2_AggregateCost_7_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_7_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__45 = (float*) (Shared+47744);  // Cost_Parallel_Work_2_AggregateCost_8_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_8_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__46 = (float*) (Shared+51968);  // Cost_Parallel_Work_2_AggregateCost_9_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_9_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__47 = (float*) (Shared+48256);  // Cost_Parallel_Work_2_AggregateCost_10_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_10_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__48 = (float*) (Shared+49280);  // Cost_Parallel_Work_2_AggregateCost_11_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_11_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__49 = (float*) (Shared+49792);  // Cost_Parallel_Work_2_AggregateCost_12_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_12_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__50 = (float*) (Shared+48768);  // Cost_Parallel_Work_2_AggregateCost_13_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_13_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__51 = (float*) (Shared+50304);  // Cost_Parallel_Work_2_AggregateCost_14_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_14_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__52 = (float*) (Shared+51328);  // Cost_Parallel_Work_2_AggregateCost_15_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_15_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__53 = (float*) (Shared+0);  // Cost_Parallel_Work_2_AggregateCost_16_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_16_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__54 = (float*) (Shared+51968);  // Cost_Parallel_Work_2_AggregateCost_17_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_17_aggregatedDisparity size:= 120*float
float *const aggregatedDisparity__aggrega__55 = (float*) (Shared+512);  // Cost_Parallel_Work_2_AggregateCost_18_aggregatedDisparity > Cost_Parallel_Work_2_disparitySelect_18_aggregatedDisparity size:= 120*float
uchar *const cenL_9_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_9_18 > Cost_Parallel_Work_0_CostConstruction_9_cenL size:= 120*uchar
uchar *const cen__cenL__0 = (uchar*) (Shared+55680);  // Census_L_0_cen > BR_Cost_Parallel_Work_0__cenL_cenL size:= 120*uchar
uchar *const cenL_0_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_0_18 > Cost_Parallel_Work_0_CostConstruction_0_cenL size:= 120*uchar
uchar *const cenL_1_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_1_18 > Cost_Parallel_Work_0_CostConstruction_1_cenL size:= 120*uchar
uchar *const cenL_2_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_2_18 > Cost_Parallel_Work_0_CostConstruction_2_cenL size:= 120*uchar
uchar *const cenL_3_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_3_18 > Cost_Parallel_Work_0_CostConstruction_3_cenL size:= 120*uchar
uchar *const cenL_4_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_4_18 > Cost_Parallel_Work_0_CostConstruction_4_cenL size:= 120*uchar
uchar *const cenL_5_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_5_18 > Cost_Parallel_Work_0_CostConstruction_5_cenL size:= 120*uchar
uchar *const cenL_6_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_6_18 > Cost_Parallel_Work_0_CostConstruction_6_cenL size:= 120*uchar
uchar *const cenL_7_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_7_18 > Cost_Parallel_Work_0_CostConstruction_7_cenL size:= 120*uchar
uchar *const cenL_8_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_8_18 > Cost_Parallel_Work_0_CostConstruction_8_cenL size:= 120*uchar
uchar *const cenL_10_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_10_18 > Cost_Parallel_Work_0_CostConstruction_10_cenL size:= 120*uchar
uchar *const cenL_11_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_11_18 > Cost_Parallel_Work_0_CostConstruction_11_cenL size:= 120*uchar
uchar *const cenL_12_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_12_18 > Cost_Parallel_Work_0_CostConstruction_12_cenL size:= 120*uchar
uchar *const cenL_13_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_13_18 > Cost_Parallel_Work_0_CostConstruction_13_cenL size:= 120*uchar
uchar *const cenL_14_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_14_18 > Cost_Parallel_Work_0_CostConstruction_14_cenL size:= 120*uchar
uchar *const cenL_15_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_15_18 > Cost_Parallel_Work_0_CostConstruction_15_cenL size:= 120*uchar
uchar *const cenL_16_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_16_18 > Cost_Parallel_Work_0_CostConstruction_16_cenL size:= 120*uchar
uchar *const cenL_17_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_17_18 > Cost_Parallel_Work_0_CostConstruction_17_cenL size:= 120*uchar
uchar *const cenL_18_18__cenL__0 = (uchar*) (Shared+55680);  // BR_Cost_Parallel_Work_0__cenL_cenL_18_18 > Cost_Parallel_Work_0_CostConstruction_18_cenL size:= 120*uchar
uchar *const cenR_9_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_9_18 > Cost_Parallel_Work_0_CostConstruction_9_cenR size:= 120*uchar
uchar *const cen__cenR__0 = (uchar*) (Shared+55936);  // Census_R_0_cen > BR_Cost_Parallel_Work_0__cenR_cenR size:= 120*uchar
uchar *const cenR_0_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_0_18 > Cost_Parallel_Work_0_CostConstruction_0_cenR size:= 120*uchar
uchar *const cenR_1_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_1_18 > Cost_Parallel_Work_0_CostConstruction_1_cenR size:= 120*uchar
uchar *const cenR_2_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_2_18 > Cost_Parallel_Work_0_CostConstruction_2_cenR size:= 120*uchar
uchar *const cenR_3_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_3_18 > Cost_Parallel_Work_0_CostConstruction_3_cenR size:= 120*uchar
uchar *const cenR_4_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_4_18 > Cost_Parallel_Work_0_CostConstruction_4_cenR size:= 120*uchar
uchar *const cenR_5_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_5_18 > Cost_Parallel_Work_0_CostConstruction_5_cenR size:= 120*uchar
uchar *const cenR_6_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_6_18 > Cost_Parallel_Work_0_CostConstruction_6_cenR size:= 120*uchar
uchar *const cenR_7_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_7_18 > Cost_Parallel_Work_0_CostConstruction_7_cenR size:= 120*uchar
uchar *const cenR_8_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_8_18 > Cost_Parallel_Work_0_CostConstruction_8_cenR size:= 120*uchar
uchar *const cenR_10_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_10_18 > Cost_Parallel_Work_0_CostConstruction_10_cenR size:= 120*uchar
uchar *const cenR_11_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_11_18 > Cost_Parallel_Work_0_CostConstruction_11_cenR size:= 120*uchar
uchar *const cenR_12_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_12_18 > Cost_Parallel_Work_0_CostConstruction_12_cenR size:= 120*uchar
uchar *const cenR_13_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_13_18 > Cost_Parallel_Work_0_CostConstruction_13_cenR size:= 120*uchar
uchar *const cenR_14_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_14_18 > Cost_Parallel_Work_0_CostConstruction_14_cenR size:= 120*uchar
uchar *const cenR_15_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_15_18 > Cost_Parallel_Work_0_CostConstruction_15_cenR size:= 120*uchar
uchar *const cenR_16_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_16_18 > Cost_Parallel_Work_0_CostConstruction_16_cenR size:= 120*uchar
uchar *const cenR_17_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_17_18 > Cost_Parallel_Work_0_CostConstruction_17_cenR size:= 120*uchar
uchar *const cenR_18_18__cenR__0 = (uchar*) (Shared+55936);  // BR_Cost_Parallel_Work_0__cenR_cenR_18_18 > Cost_Parallel_Work_0_CostConstruction_18_cenR size:= 120*uchar
uchar *const cenR_9_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_9_18 > Cost_Parallel_Work_1_CostConstruction_9_cenR size:= 120*uchar
uchar *const cen__cenR__1 = (uchar*) (Shared+56192);  // Census_R_1_cen > BR_Cost_Parallel_Work_1__cenR_cenR size:= 120*uchar
uchar *const cenR_0_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_0_18 > Cost_Parallel_Work_1_CostConstruction_0_cenR size:= 120*uchar
uchar *const cenR_1_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_1_18 > Cost_Parallel_Work_1_CostConstruction_1_cenR size:= 120*uchar
uchar *const cenR_2_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_2_18 > Cost_Parallel_Work_1_CostConstruction_2_cenR size:= 120*uchar
uchar *const cenR_3_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_3_18 > Cost_Parallel_Work_1_CostConstruction_3_cenR size:= 120*uchar
uchar *const cenR_4_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_4_18 > Cost_Parallel_Work_1_CostConstruction_4_cenR size:= 120*uchar
uchar *const cenR_5_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_5_18 > Cost_Parallel_Work_1_CostConstruction_5_cenR size:= 120*uchar
uchar *const cenR_6_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_6_18 > Cost_Parallel_Work_1_CostConstruction_6_cenR size:= 120*uchar
uchar *const cenR_7_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_7_18 > Cost_Parallel_Work_1_CostConstruction_7_cenR size:= 120*uchar
uchar *const cenR_8_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_8_18 > Cost_Parallel_Work_1_CostConstruction_8_cenR size:= 120*uchar
uchar *const cenR_10_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_10_18 > Cost_Parallel_Work_1_CostConstruction_10_cenR size:= 120*uchar
uchar *const cenR_11_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_11_18 > Cost_Parallel_Work_1_CostConstruction_11_cenR size:= 120*uchar
uchar *const cenR_12_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_12_18 > Cost_Parallel_Work_1_CostConstruction_12_cenR size:= 120*uchar
uchar *const cenR_13_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_13_18 > Cost_Parallel_Work_1_CostConstruction_13_cenR size:= 120*uchar
uchar *const cenR_14_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_14_18 > Cost_Parallel_Work_1_CostConstruction_14_cenR size:= 120*uchar
uchar *const cenR_15_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_15_18 > Cost_Parallel_Work_1_CostConstruction_15_cenR size:= 120*uchar
uchar *const cenR_16_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_16_18 > Cost_Parallel_Work_1_CostConstruction_16_cenR size:= 120*uchar
uchar *const cenR_17_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_17_18 > Cost_Parallel_Work_1_CostConstruction_17_cenR size:= 120*uchar
uchar *const cenR_18_18__cenR__1 = (uchar*) (Shared+56192);  // BR_Cost_Parallel_Work_1__cenR_cenR_18_18 > Cost_Parallel_Work_1_CostConstruction_18_cenR size:= 120*uchar
uchar *const cenR_9_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_9_18 > Cost_Parallel_Work_2_CostConstruction_9_cenR size:= 120*uchar
uchar *const cen__cenR__2 = (uchar*) (Shared+56448);  // Census_R_2_cen > BR_Cost_Parallel_Work_2__cenR_cenR size:= 120*uchar
uchar *const cenR_0_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_0_18 > Cost_Parallel_Work_2_CostConstruction_0_cenR size:= 120*uchar
uchar *const cenR_1_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_1_18 > Cost_Parallel_Work_2_CostConstruction_1_cenR size:= 120*uchar
uchar *const cenR_2_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_2_18 > Cost_Parallel_Work_2_CostConstruction_2_cenR size:= 120*uchar
uchar *const cenR_3_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_3_18 > Cost_Parallel_Work_2_CostConstruction_3_cenR size:= 120*uchar
uchar *const cenR_4_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_4_18 > Cost_Parallel_Work_2_CostConstruction_4_cenR size:= 120*uchar
uchar *const cenR_5_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_5_18 > Cost_Parallel_Work_2_CostConstruction_5_cenR size:= 120*uchar
uchar *const cenR_6_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_6_18 > Cost_Parallel_Work_2_CostConstruction_6_cenR size:= 120*uchar
uchar *const cenR_7_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_7_18 > Cost_Parallel_Work_2_CostConstruction_7_cenR size:= 120*uchar
uchar *const cenR_8_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_8_18 > Cost_Parallel_Work_2_CostConstruction_8_cenR size:= 120*uchar
uchar *const cenR_10_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_10_18 > Cost_Parallel_Work_2_CostConstruction_10_cenR size:= 120*uchar
uchar *const cenR_11_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_11_18 > Cost_Parallel_Work_2_CostConstruction_11_cenR size:= 120*uchar
uchar *const cenR_12_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_12_18 > Cost_Parallel_Work_2_CostConstruction_12_cenR size:= 120*uchar
uchar *const cenR_13_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_13_18 > Cost_Parallel_Work_2_CostConstruction_13_cenR size:= 120*uchar
uchar *const cenR_14_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_14_18 > Cost_Parallel_Work_2_CostConstruction_14_cenR size:= 120*uchar
uchar *const cenR_15_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_15_18 > Cost_Parallel_Work_2_CostConstruction_15_cenR size:= 120*uchar
uchar *const cenR_16_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_16_18 > Cost_Parallel_Work_2_CostConstruction_16_cenR size:= 120*uchar
uchar *const cenR_17_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_17_18 > Cost_Parallel_Work_2_CostConstruction_17_cenR size:= 120*uchar
uchar *const cenR_18_18__cenR__2 = (uchar*) (Shared+56448);  // BR_Cost_Parallel_Work_2__cenR_cenR_18_18 > Cost_Parallel_Work_2_CostConstruction_18_cenR size:= 120*uchar
uchar *const cenL_9_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_9_18 > Cost_Parallel_Work_1_CostConstruction_9_cenL size:= 120*uchar
uchar *const cen__cenL__1 = (uchar*) (Shared+56704);  // Census_L_1_cen > BR_Cost_Parallel_Work_1__cenL_cenL size:= 120*uchar
uchar *const cenL_0_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_0_18 > Cost_Parallel_Work_1_CostConstruction_0_cenL size:= 120*uchar
uchar *const cenL_1_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_1_18 > Cost_Parallel_Work_1_CostConstruction_1_cenL size:= 120*uchar
uchar *const cenL_2_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_2_18 > Cost_Parallel_Work_1_CostConstruction_2_cenL size:= 120*uchar
uchar *const cenL_3_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_3_18 > Cost_Parallel_Work_1_CostConstruction_3_cenL size:= 120*uchar
uchar *const cenL_4_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_4_18 > Cost_Parallel_Work_1_CostConstruction_4_cenL size:= 120*uchar
uchar *const cenL_5_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_5_18 > Cost_Parallel_Work_1_CostConstruction_5_cenL size:= 120*uchar
uchar *const cenL_6_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_6_18 > Cost_Parallel_Work_1_CostConstruction_6_cenL size:= 120*uchar
uchar *const cenL_7_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_7_18 > Cost_Parallel_Work_1_CostConstruction_7_cenL size:= 120*uchar
uchar *const cenL_8_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_8_18 > Cost_Parallel_Work_1_CostConstruction_8_cenL size:= 120*uchar
uchar *const cenL_10_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_10_18 > Cost_Parallel_Work_1_CostConstruction_10_cenL size:= 120*uchar
uchar *const cenL_11_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_11_18 > Cost_Parallel_Work_1_CostConstruction_11_cenL size:= 120*uchar
uchar *const cenL_12_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_12_18 > Cost_Parallel_Work_1_CostConstruction_12_cenL size:= 120*uchar
uchar *const cenL_13_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_13_18 > Cost_Parallel_Work_1_CostConstruction_13_cenL size:= 120*uchar
uchar *const cenL_14_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_14_18 > Cost_Parallel_Work_1_CostConstruction_14_cenL size:= 120*uchar
uchar *const cenL_15_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_15_18 > Cost_Parallel_Work_1_CostConstruction_15_cenL size:= 120*uchar
uchar *const cenL_16_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_16_18 > Cost_Parallel_Work_1_CostConstruction_16_cenL size:= 120*uchar
uchar *const cenL_17_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_17_18 > Cost_Parallel_Work_1_CostConstruction_17_cenL size:= 120*uchar
uchar *const cenL_18_18__cenL__1 = (uchar*) (Shared+56704);  // BR_Cost_Parallel_Work_1__cenL_cenL_18_18 > Cost_Parallel_Work_1_CostConstruction_18_cenL size:= 120*uchar
uchar *const cenL_9_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_9_18 > Cost_Parallel_Work_2_CostConstruction_9_cenL size:= 120*uchar
uchar *const cen__cenL__2 = (uchar*) (Shared+56960);  // Census_L_2_cen > BR_Cost_Parallel_Work_2__cenL_cenL size:= 120*uchar
uchar *const cenL_0_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_0_18 > Cost_Parallel_Work_2_CostConstruction_0_cenL size:= 120*uchar
uchar *const cenL_1_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_1_18 > Cost_Parallel_Work_2_CostConstruction_1_cenL size:= 120*uchar
uchar *const cenL_2_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_2_18 > Cost_Parallel_Work_2_CostConstruction_2_cenL size:= 120*uchar
uchar *const cenL_3_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_3_18 > Cost_Parallel_Work_2_CostConstruction_3_cenL size:= 120*uchar
uchar *const cenL_4_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_4_18 > Cost_Parallel_Work_2_CostConstruction_4_cenL size:= 120*uchar
uchar *const cenL_5_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_5_18 > Cost_Parallel_Work_2_CostConstruction_5_cenL size:= 120*uchar
uchar *const cenL_6_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_6_18 > Cost_Parallel_Work_2_CostConstruction_6_cenL size:= 120*uchar
uchar *const cenL_7_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_7_18 > Cost_Parallel_Work_2_CostConstruction_7_cenL size:= 120*uchar
uchar *const cenL_8_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_8_18 > Cost_Parallel_Work_2_CostConstruction_8_cenL size:= 120*uchar
uchar *const cenL_10_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_10_18 > Cost_Parallel_Work_2_CostConstruction_10_cenL size:= 120*uchar
uchar *const cenL_11_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_11_18 > Cost_Parallel_Work_2_CostConstruction_11_cenL size:= 120*uchar
uchar *const cenL_12_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_12_18 > Cost_Parallel_Work_2_CostConstruction_12_cenL size:= 120*uchar
uchar *const cenL_13_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_13_18 > Cost_Parallel_Work_2_CostConstruction_13_cenL size:= 120*uchar
uchar *const cenL_14_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_14_18 > Cost_Parallel_Work_2_CostConstruction_14_cenL size:= 120*uchar
uchar *const cenL_15_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_15_18 > Cost_Parallel_Work_2_CostConstruction_15_cenL size:= 120*uchar
uchar *const cenL_16_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_16_18 > Cost_Parallel_Work_2_CostConstruction_16_cenL size:= 120*uchar
uchar *const cenL_17_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_17_18 > Cost_Parallel_Work_2_CostConstruction_17_cenL size:= 120*uchar
uchar *const cenL_18_18__cenL__2 = (uchar*) (Shared+56960);  // BR_Cost_Parallel_Work_2__cenL_cenL_18_18 > Cost_Parallel_Work_2_CostConstruction_18_cenL size:= 120*uchar
uchar *const result__in__0 = (uchar*) (Shared+54656);  // Cost_Parallel_Work_0_disparitySelect_11_result > Cost_Parallel_Work_0_Broadcast5_11_in size:= 120*uchar
uchar *const out0_0__rawDisparity_11_18__0 = (uchar*) (Shared+54656);  // Cost_Parallel_Work_0_Broadcast5_11_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_11_18 size:= 120*uchar
uchar *const result__in__1 = (uchar*) (Shared+54912);  // Cost_Parallel_Work_0_disparitySelect_12_result > Cost_Parallel_Work_0_Broadcast5_12_in size:= 120*uchar
uchar *const out0_0__rawDisparity_12_18__0 = (uchar*) (Shared+54912);  // Cost_Parallel_Work_0_Broadcast5_12_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_12_18 size:= 120*uchar
uchar *const result__in__2 = (uchar*) (Shared+46336);  // Cost_Parallel_Work_0_disparitySelect_13_result > Cost_Parallel_Work_0_Broadcast5_13_in size:= 120*uchar
uchar *const out0_0__rawDisparity_13_18__0 = (uchar*) (Shared+46336);  // Cost_Parallel_Work_0_Broadcast5_13_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_13_18 size:= 120*uchar
uchar *const result__in__3 = (uchar*) (Shared+55168);  // Cost_Parallel_Work_0_disparitySelect_14_result > Cost_Parallel_Work_0_Broadcast5_14_in size:= 120*uchar
uchar *const out0_0__rawDisparity_14_18__0 = (uchar*) (Shared+55168);  // Cost_Parallel_Work_0_Broadcast5_14_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_14_18 size:= 120*uchar
uchar *const result__in__4 = (uchar*) (Shared+55424);  // Cost_Parallel_Work_0_disparitySelect_15_result > Cost_Parallel_Work_0_Broadcast5_15_in size:= 120*uchar
uchar *const out0_0__rawDisparity_15_18__0 = (uchar*) (Shared+55424);  // Cost_Parallel_Work_0_Broadcast5_15_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_15_18 size:= 120*uchar
uchar *const result__in__5 = (uchar*) (Shared+48832);  // Cost_Parallel_Work_0_disparitySelect_16_result > Cost_Parallel_Work_0_Broadcast5_16_in size:= 120*uchar
uchar *const out0_0__rawDisparity_16_18__0 = (uchar*) (Shared+48832);  // Cost_Parallel_Work_0_Broadcast5_16_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_16_18 size:= 120*uchar
uchar *const result__in__6 = (uchar*) (Shared+49088);  // Cost_Parallel_Work_0_disparitySelect_17_result > Cost_Parallel_Work_0_Broadcast5_17_in size:= 120*uchar
uchar *const out0_0__rawDisparity_17_18__0 = (uchar*) (Shared+49088);  // Cost_Parallel_Work_0_Broadcast5_17_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_17_18 size:= 120*uchar
uchar *const rawDisparity__input__0 = (uchar*) (Shared+55680);  // RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity > Split_0_input size:= 120*uchar
uchar *const out0_0__rawDisparity_18_18__0 = (uchar*) (Shared+55680);  // Cost_Parallel_Work_0_Broadcast5_18_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_18_18 size:= 120*uchar
uchar *const result__in__7 = (uchar*) (Shared+53888);  // Cost_Parallel_Work_1_disparitySelect_11_result > Cost_Parallel_Work_1_Broadcast5_11_in size:= 120*uchar
uchar *const out0_0__rawDisparity_11_18__1 = (uchar*) (Shared+53888);  // Cost_Parallel_Work_1_Broadcast5_11_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_11_18 size:= 120*uchar
uchar *const result__in__8 = (uchar*) (Shared+49408);  // Cost_Parallel_Work_1_disparitySelect_12_result > Cost_Parallel_Work_1_Broadcast5_12_in size:= 120*uchar
uchar *const out0_0__rawDisparity_12_18__1 = (uchar*) (Shared+49408);  // Cost_Parallel_Work_1_Broadcast5_12_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_12_18 size:= 120*uchar
uchar *const result__in__9 = (uchar*) (Shared+49664);  // Cost_Parallel_Work_1_disparitySelect_13_result > Cost_Parallel_Work_1_Broadcast5_13_in size:= 120*uchar
uchar *const out0_0__rawDisparity_13_18__1 = (uchar*) (Shared+49664);  // Cost_Parallel_Work_1_Broadcast5_13_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_13_18 size:= 120*uchar
uchar *const result__in__10 = (uchar*) (Shared+54656);  // Cost_Parallel_Work_1_disparitySelect_14_result > Cost_Parallel_Work_1_Broadcast5_14_in size:= 120*uchar
uchar *const out0_0__rawDisparity_14_18__1 = (uchar*) (Shared+54656);  // Cost_Parallel_Work_1_Broadcast5_14_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_14_18 size:= 120*uchar
uchar *const result__in__11 = (uchar*) (Shared+54912);  // Cost_Parallel_Work_1_disparitySelect_15_result > Cost_Parallel_Work_1_Broadcast5_15_in size:= 120*uchar
uchar *const out0_0__rawDisparity_15_18__1 = (uchar*) (Shared+54912);  // Cost_Parallel_Work_1_Broadcast5_15_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_15_18 size:= 120*uchar
uchar *const result__in__12 = (uchar*) (Shared+55168);  // Cost_Parallel_Work_1_disparitySelect_16_result > Cost_Parallel_Work_1_Broadcast5_16_in size:= 120*uchar
uchar *const out0_0__rawDisparity_16_18__1 = (uchar*) (Shared+55168);  // Cost_Parallel_Work_1_Broadcast5_16_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_16_18 size:= 120*uchar
uchar *const result__in__13 = (uchar*) (Shared+53376);  // Cost_Parallel_Work_1_disparitySelect_17_result > Cost_Parallel_Work_1_Broadcast5_17_in size:= 120*uchar
uchar *const out0_0__rawDisparity_17_18__1 = (uchar*) (Shared+53376);  // Cost_Parallel_Work_1_Broadcast5_17_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_17_18 size:= 120*uchar
uchar *const rawDisparity__input__1 = (uchar*) (Shared+56704);  // RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity > Split_1_input size:= 120*uchar
uchar *const out0_0__rawDisparity_18_18__1 = (uchar*) (Shared+56704);  // Cost_Parallel_Work_1_Broadcast5_18_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_18_18 size:= 120*uchar
uchar *const result__in__14 = (uchar*) (Shared+52096);  // Cost_Parallel_Work_2_disparitySelect_18_result > Cost_Parallel_Work_2_Broadcast5_18_in size:= 120*uchar
uchar *const back_2__back_7__0 = (uchar*) (Shared+52096);  // Cost_Parallel_Work_2_Broadcast5_18_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_7 size:= 1*uchar
uchar *const filteredDisparity__in__0 = (uchar*) (Shared+55424);  // implode_lum2RGB_0_in_filteredDisparity > lum2RGB_0_in size:= 120*uchar
uchar *const out0_0__lum__0 = (uchar*) (Shared+55424);  // lum2RGB_0_out0_0 > Display_RGB1_0_lum size:= 120*uchar
uchar *const out1_1__gray__0 = (uchar*) (Shared+55424);  // lum2RGB_0_out1_1 > Write_PPM_0_gray size:= 120*uchar
uchar *const filteredDisparity__in_0__0 = (uchar*) (Shared+55424);  // Median_Filter_0_filteredDisparity > implode_lum2RGB_0_in_in_0 size:= 12*uchar
uchar *const filteredDisparity__in__1 = (uchar*) (Shared+52608);  // implode_lum2RGB_2_in_filteredDisparity > lum2RGB_2_in size:= 120*uchar
uchar *const out0_0__lum__1 = (uchar*) (Shared+52608);  // lum2RGB_2_out0_0 > Display_RGB1_2_lum size:= 120*uchar
uchar *const out1_1__gray__1 = (uchar*) (Shared+52608);  // lum2RGB_2_out1_1 > Write_PPM_2_gray size:= 120*uchar
uchar *const filteredDisparity__in_0__1 = (uchar*) (Shared+52608);  // Median_Filter_20_filteredDisparity > implode_lum2RGB_2_in_in_0 size:= 12*uchar
uchar *const filteredDisparity__in__2 = (uchar*) (Shared+52288);  // implode_lum2RGB_3_in_filteredDisparity > lum2RGB_3_in size:= 120*uchar
uchar *const out0_0__lum__2 = (uchar*) (Shared+52288);  // lum2RGB_3_out0_0 > Display_RGB1_3_lum size:= 120*uchar
uchar *const out1_1__gray__2 = (uchar*) (Shared+52288);  // lum2RGB_3_out1_1 > Write_PPM_3_gray size:= 120*uchar
uchar *const filteredDisparity__in_0__2 = (uchar*) (Shared+52288);  // Median_Filter_30_filteredDisparity > implode_lum2RGB_3_in_in_0 size:= 12*uchar
int *const offsets__in__0 = (int*) (Shared+2752);  // Cost_Parallel_Work_0_OffsetGen_0_offsets > Cost_Parallel_Work_0_Broadcast0_0_in size:= 5*int
int *const out1_0_22__offset__0 = (int*) (Shared+2752);  // Cost_Parallel_Work_0_Broadcast0_0_out1_0_22 > Cost_Parallel_Work_0_ComputeVertWeights_0_offset size:= 1*int
int *const out1_1_22__offset__0 = (int*) (Shared+2756);  // Cost_Parallel_Work_0_Broadcast0_0_out1_1_22 > Cost_Parallel_Work_0_ComputeVertWeights_1_offset size:= 1*int
int *const out1_2_22__offset__0 = (int*) (Shared+2760);  // Cost_Parallel_Work_0_Broadcast0_0_out1_2_22 > Cost_Parallel_Work_0_ComputeVertWeights_2_offset size:= 1*int
int *const out1_3_22__offset__0 = (int*) (Shared+2764);  // Cost_Parallel_Work_0_Broadcast0_0_out1_3_22 > Cost_Parallel_Work_0_ComputeVertWeights_3_offset size:= 1*int
int *const out1_4_22__offset__0 = (int*) (Shared+2768);  // Cost_Parallel_Work_0_Broadcast0_0_out1_4_22 > Cost_Parallel_Work_0_ComputeVertWeights_4_offset size:= 1*int
int *const out2_0_26__offset__0 = (int*) (Shared+2752);  // Cost_Parallel_Work_0_Broadcast0_0_out2_0_26 > Cost_Parallel_Work_0_ComputeHorWeights_0_offset size:= 1*int
int *const out2_1_26__offset__0 = (int*) (Shared+2756);  // Cost_Parallel_Work_0_Broadcast0_0_out2_1_26 > Cost_Parallel_Work_0_ComputeHorWeights_1_offset size:= 1*int
int *const out2_2_26__offset__0 = (int*) (Shared+2760);  // Cost_Parallel_Work_0_Broadcast0_0_out2_2_26 > Cost_Parallel_Work_0_ComputeHorWeights_2_offset size:= 1*int
int *const out2_3_26__offset__0 = (int*) (Shared+2764);  // Cost_Parallel_Work_0_Broadcast0_0_out2_3_26 > Cost_Parallel_Work_0_ComputeHorWeights_3_offset size:= 1*int
int *const out2_4_26__offset__0 = (int*) (Shared+2768);  // Cost_Parallel_Work_0_Broadcast0_0_out2_4_26 > Cost_Parallel_Work_0_ComputeHorWeights_4_offset size:= 1*int
uchar *const back__back__0 = (uchar*) (Shared+57216);  // Cost_Parallel_Work_init_in_CostConstruction_back_back > Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back size:= 8*uchar
uchar *const back_0__back__0 = (uchar*) (Shared+57216);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_0 > Cost_Parallel_Work_0_CostConstruction_0_back size:= 1*uchar
uchar *const back__back__1 = (uchar*) (Shared+56704);  // Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back > Cost_Parallel_Work_end_out_Broadcast5_back_back size:= 8*uchar
uchar *const back_2__back_0__0 = (uchar*) (Shared+56704);  // Cost_Parallel_Work_2_Broadcast5_11_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_0 size:= 1*uchar
uchar *const back_2__back_1__0 = (uchar*) (Shared+56705);  // Cost_Parallel_Work_2_Broadcast5_12_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_1 size:= 1*uchar
uchar *const back_2__back_2__0 = (uchar*) (Shared+56706);  // Cost_Parallel_Work_2_Broadcast5_13_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_2 size:= 1*uchar
uchar *const back_2__back_3__0 = (uchar*) (Shared+56707);  // Cost_Parallel_Work_2_Broadcast5_14_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_3 size:= 1*uchar
uchar *const back_2__back_4__0 = (uchar*) (Shared+56708);  // Cost_Parallel_Work_2_Broadcast5_15_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_4 size:= 1*uchar
uchar *const back_2__back_5__0 = (uchar*) (Shared+56709);  // Cost_Parallel_Work_2_Broadcast5_16_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_5 size:= 1*uchar
uchar *const back_2__back_6__0 = (uchar*) (Shared+56710);  // Cost_Parallel_Work_2_Broadcast5_17_back_2 > Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back_back_6 size:= 1*uchar
uchar *const out1_9_36__disparity__0 = (uchar*) (Shared+57408);  // Cost_Parallel_Work_0_Broadcast4_0_out1_9_36 > Cost_Parallel_Work_0_disparitySelect_9_disparity size:= 1*uchar
uchar *const disparities__in__0 = (uchar*) (Shared+57399);  // Cost_Parallel_Work_0_DisparityGen_0_disparities > Cost_Parallel_Work_0_Broadcast4_0_in size:= 19*uchar
uchar *const out0_0_18__disparity__0 = (uchar*) (Shared+57399);  // Cost_Parallel_Work_0_Broadcast4_0_out0_0_18 > Cost_Parallel_Work_0_CostConstruction_0_disparity size:= 1*uchar
uchar *const out0_1_18__disparity__0 = (uchar*) (Shared+57400);  // Cost_Parallel_Work_0_Broadcast4_0_out0_1_18 > Cost_Parallel_Work_0_CostConstruction_1_disparity size:= 1*uchar
uchar *const out0_2_18__disparity__0 = (uchar*) (Shared+57401);  // Cost_Parallel_Work_0_Broadcast4_0_out0_2_18 > Cost_Parallel_Work_0_CostConstruction_2_disparity size:= 1*uchar
uchar *const out0_3_18__disparity__0 = (uchar*) (Shared+57402);  // Cost_Parallel_Work_0_Broadcast4_0_out0_3_18 > Cost_Parallel_Work_0_CostConstruction_3_disparity size:= 1*uchar
uchar *const out0_4_18__disparity__0 = (uchar*) (Shared+57403);  // Cost_Parallel_Work_0_Broadcast4_0_out0_4_18 > Cost_Parallel_Work_0_CostConstruction_4_disparity size:= 1*uchar
uchar *const out0_5_18__disparity__0 = (uchar*) (Shared+57404);  // Cost_Parallel_Work_0_Broadcast4_0_out0_5_18 > Cost_Parallel_Work_0_CostConstruction_5_disparity size:= 1*uchar
uchar *const out0_6_18__disparity__0 = (uchar*) (Shared+57405);  // Cost_Parallel_Work_0_Broadcast4_0_out0_6_18 > Cost_Parallel_Work_0_CostConstruction_6_disparity size:= 1*uchar
uchar *const out0_7_18__disparity__0 = (uchar*) (Shared+57406);  // Cost_Parallel_Work_0_Broadcast4_0_out0_7_18 > Cost_Parallel_Work_0_CostConstruction_7_disparity size:= 1*uchar
uchar *const out0_8_18__disparity__0 = (uchar*) (Shared+57407);  // Cost_Parallel_Work_0_Broadcast4_0_out0_8_18 > Cost_Parallel_Work_0_CostConstruction_8_disparity size:= 1*uchar
uchar *const out0_9_18__disparity__0 = (uchar*) (Shared+57408);  // Cost_Parallel_Work_0_Broadcast4_0_out0_9_18 > Cost_Parallel_Work_0_CostConstruction_9_disparity size:= 1*uchar
uchar *const out0_10_18__disparity__0 = (uchar*) (Shared+57409);  // Cost_Parallel_Work_0_Broadcast4_0_out0_10_18 > Cost_Parallel_Work_0_CostConstruction_10_disparity size:= 1*uchar
uchar *const out0_11_18__disparity__0 = (uchar*) (Shared+57410);  // Cost_Parallel_Work_0_Broadcast4_0_out0_11_18 > Cost_Parallel_Work_0_CostConstruction_11_disparity size:= 1*uchar
uchar *const out0_12_18__disparity__0 = (uchar*) (Shared+57411);  // Cost_Parallel_Work_0_Broadcast4_0_out0_12_18 > Cost_Parallel_Work_0_CostConstruction_12_disparity size:= 1*uchar
uchar *const out0_13_18__disparity__0 = (uchar*) (Shared+57412);  // Cost_Parallel_Work_0_Broadcast4_0_out0_13_18 > Cost_Parallel_Work_0_CostConstruction_13_disparity size:= 1*uchar
uchar *const out0_14_18__disparity__0 = (uchar*) (Shared+57413);  // Cost_Parallel_Work_0_Broadcast4_0_out0_14_18 > Cost_Parallel_Work_0_CostConstruction_14_disparity size:= 1*uchar
uchar *const out0_15_18__disparity__0 = (uchar*) (Shared+57414);  // Cost_Parallel_Work_0_Broadcast4_0_out0_15_18 > Cost_Parallel_Work_0_CostConstruction_15_disparity size:= 1*uchar
uchar *const out0_16_18__disparity__0 = (uchar*) (Shared+57415);  // Cost_Parallel_Work_0_Broadcast4_0_out0_16_18 > Cost_Parallel_Work_0_CostConstruction_16_disparity size:= 1*uchar
uchar *const out0_17_18__disparity__0 = (uchar*) (Shared+57416);  // Cost_Parallel_Work_0_Broadcast4_0_out0_17_18 > Cost_Parallel_Work_0_CostConstruction_17_disparity size:= 1*uchar
uchar *const out0_18_18__disparity__0 = (uchar*) (Shared+57417);  // Cost_Parallel_Work_0_Broadcast4_0_out0_18_18 > Cost_Parallel_Work_0_CostConstruction_18_disparity size:= 1*uchar
uchar *const out1_0_36__disparity__0 = (uchar*) (Shared+57399);  // Cost_Parallel_Work_0_Broadcast4_0_out1_0_36 > Cost_Parallel_Work_0_disparitySelect_0_disparity size:= 1*uchar
uchar *const out1_1_36__disparity__0 = (uchar*) (Shared+57400);  // Cost_Parallel_Work_0_Broadcast4_0_out1_1_36 > Cost_Parallel_Work_0_disparitySelect_1_disparity size:= 1*uchar
uchar *const out1_2_36__disparity__0 = (uchar*) (Shared+57401);  // Cost_Parallel_Work_0_Broadcast4_0_out1_2_36 > Cost_Parallel_Work_0_disparitySelect_2_disparity size:= 1*uchar
uchar *const out1_3_36__disparity__0 = (uchar*) (Shared+57402);  // Cost_Parallel_Work_0_Broadcast4_0_out1_3_36 > Cost_Parallel_Work_0_disparitySelect_3_disparity size:= 1*uchar
uchar *const out1_4_36__disparity__0 = (uchar*) (Shared+57403);  // Cost_Parallel_Work_0_Broadcast4_0_out1_4_36 > Cost_Parallel_Work_0_disparitySelect_4_disparity size:= 1*uchar
uchar *const out1_5_36__disparity__0 = (uchar*) (Shared+57404);  // Cost_Parallel_Work_0_Broadcast4_0_out1_5_36 > Cost_Parallel_Work_0_disparitySelect_5_disparity size:= 1*uchar
uchar *const out1_6_36__disparity__0 = (uchar*) (Shared+57405);  // Cost_Parallel_Work_0_Broadcast4_0_out1_6_36 > Cost_Parallel_Work_0_disparitySelect_6_disparity size:= 1*uchar
uchar *const out1_7_36__disparity__0 = (uchar*) (Shared+57406);  // Cost_Parallel_Work_0_Broadcast4_0_out1_7_36 > Cost_Parallel_Work_0_disparitySelect_7_disparity size:= 1*uchar
uchar *const out1_8_36__disparity__0 = (uchar*) (Shared+57407);  // Cost_Parallel_Work_0_Broadcast4_0_out1_8_36 > Cost_Parallel_Work_0_disparitySelect_8_disparity size:= 1*uchar
uchar *const out1_10_36__disparity__0 = (uchar*) (Shared+57409);  // Cost_Parallel_Work_0_Broadcast4_0_out1_10_36 > Cost_Parallel_Work_0_disparitySelect_10_disparity size:= 1*uchar
uchar *const out1_11_36__disparity__0 = (uchar*) (Shared+57410);  // Cost_Parallel_Work_0_Broadcast4_0_out1_11_36 > Cost_Parallel_Work_0_disparitySelect_11_disparity size:= 1*uchar
uchar *const out1_12_36__disparity__0 = (uchar*) (Shared+57411);  // Cost_Parallel_Work_0_Broadcast4_0_out1_12_36 > Cost_Parallel_Work_0_disparitySelect_12_disparity size:= 1*uchar
uchar *const out1_13_36__disparity__0 = (uchar*) (Shared+57412);  // Cost_Parallel_Work_0_Broadcast4_0_out1_13_36 > Cost_Parallel_Work_0_disparitySelect_13_disparity size:= 1*uchar
uchar *const out1_14_36__disparity__0 = (uchar*) (Shared+57413);  // Cost_Parallel_Work_0_Broadcast4_0_out1_14_36 > Cost_Parallel_Work_0_disparitySelect_14_disparity size:= 1*uchar
uchar *const out1_15_36__disparity__0 = (uchar*) (Shared+57414);  // Cost_Parallel_Work_0_Broadcast4_0_out1_15_36 > Cost_Parallel_Work_0_disparitySelect_15_disparity size:= 1*uchar
uchar *const out1_16_36__disparity__0 = (uchar*) (Shared+57415);  // Cost_Parallel_Work_0_Broadcast4_0_out1_16_36 > Cost_Parallel_Work_0_disparitySelect_16_disparity size:= 1*uchar
uchar *const out1_17_36__disparity__0 = (uchar*) (Shared+57416);  // Cost_Parallel_Work_0_Broadcast4_0_out1_17_36 > Cost_Parallel_Work_0_disparitySelect_17_disparity size:= 1*uchar
uchar *const out1_18_36__disparity__0 = (uchar*) (Shared+57417);  // Cost_Parallel_Work_0_Broadcast4_0_out1_18_36 > Cost_Parallel_Work_0_disparitySelect_18_disparity size:= 1*uchar
uchar *const out1_9_36__disparity__1 = (uchar*) (Shared+57600);  // Cost_Parallel_Work_1_Broadcast4_0_out1_9_36 > Cost_Parallel_Work_1_disparitySelect_9_disparity size:= 1*uchar
uchar *const disparities__in__1 = (uchar*) (Shared+57591);  // Cost_Parallel_Work_1_DisparityGen_0_disparities > Cost_Parallel_Work_1_Broadcast4_0_in size:= 19*uchar
uchar *const out0_0_18__disparity__1 = (uchar*) (Shared+57591);  // Cost_Parallel_Work_1_Broadcast4_0_out0_0_18 > Cost_Parallel_Work_1_CostConstruction_0_disparity size:= 1*uchar
uchar *const out0_1_18__disparity__1 = (uchar*) (Shared+57592);  // Cost_Parallel_Work_1_Broadcast4_0_out0_1_18 > Cost_Parallel_Work_1_CostConstruction_1_disparity size:= 1*uchar
uchar *const out0_2_18__disparity__1 = (uchar*) (Shared+57593);  // Cost_Parallel_Work_1_Broadcast4_0_out0_2_18 > Cost_Parallel_Work_1_CostConstruction_2_disparity size:= 1*uchar
uchar *const out0_3_18__disparity__1 = (uchar*) (Shared+57594);  // Cost_Parallel_Work_1_Broadcast4_0_out0_3_18 > Cost_Parallel_Work_1_CostConstruction_3_disparity size:= 1*uchar
uchar *const out0_4_18__disparity__1 = (uchar*) (Shared+57595);  // Cost_Parallel_Work_1_Broadcast4_0_out0_4_18 > Cost_Parallel_Work_1_CostConstruction_4_disparity size:= 1*uchar
uchar *const out0_5_18__disparity__1 = (uchar*) (Shared+57596);  // Cost_Parallel_Work_1_Broadcast4_0_out0_5_18 > Cost_Parallel_Work_1_CostConstruction_5_disparity size:= 1*uchar
uchar *const out0_6_18__disparity__1 = (uchar*) (Shared+57597);  // Cost_Parallel_Work_1_Broadcast4_0_out0_6_18 > Cost_Parallel_Work_1_CostConstruction_6_disparity size:= 1*uchar
uchar *const out0_7_18__disparity__1 = (uchar*) (Shared+57598);  // Cost_Parallel_Work_1_Broadcast4_0_out0_7_18 > Cost_Parallel_Work_1_CostConstruction_7_disparity size:= 1*uchar
uchar *const out0_8_18__disparity__1 = (uchar*) (Shared+57599);  // Cost_Parallel_Work_1_Broadcast4_0_out0_8_18 > Cost_Parallel_Work_1_CostConstruction_8_disparity size:= 1*uchar
uchar *const out0_9_18__disparity__1 = (uchar*) (Shared+57600);  // Cost_Parallel_Work_1_Broadcast4_0_out0_9_18 > Cost_Parallel_Work_1_CostConstruction_9_disparity size:= 1*uchar
uchar *const out0_10_18__disparity__1 = (uchar*) (Shared+57601);  // Cost_Parallel_Work_1_Broadcast4_0_out0_10_18 > Cost_Parallel_Work_1_CostConstruction_10_disparity size:= 1*uchar
uchar *const out0_11_18__disparity__1 = (uchar*) (Shared+57602);  // Cost_Parallel_Work_1_Broadcast4_0_out0_11_18 > Cost_Parallel_Work_1_CostConstruction_11_disparity size:= 1*uchar
uchar *const out0_12_18__disparity__1 = (uchar*) (Shared+57603);  // Cost_Parallel_Work_1_Broadcast4_0_out0_12_18 > Cost_Parallel_Work_1_CostConstruction_12_disparity size:= 1*uchar
uchar *const out0_13_18__disparity__1 = (uchar*) (Shared+57604);  // Cost_Parallel_Work_1_Broadcast4_0_out0_13_18 > Cost_Parallel_Work_1_CostConstruction_13_disparity size:= 1*uchar
uchar *const out0_14_18__disparity__1 = (uchar*) (Shared+57605);  // Cost_Parallel_Work_1_Broadcast4_0_out0_14_18 > Cost_Parallel_Work_1_CostConstruction_14_disparity size:= 1*uchar
uchar *const out0_15_18__disparity__1 = (uchar*) (Shared+57606);  // Cost_Parallel_Work_1_Broadcast4_0_out0_15_18 > Cost_Parallel_Work_1_CostConstruction_15_disparity size:= 1*uchar
uchar *const out0_16_18__disparity__1 = (uchar*) (Shared+57607);  // Cost_Parallel_Work_1_Broadcast4_0_out0_16_18 > Cost_Parallel_Work_1_CostConstruction_16_disparity size:= 1*uchar
uchar *const out0_17_18__disparity__1 = (uchar*) (Shared+57608);  // Cost_Parallel_Work_1_Broadcast4_0_out0_17_18 > Cost_Parallel_Work_1_CostConstruction_17_disparity size:= 1*uchar
uchar *const out0_18_18__disparity__1 = (uchar*) (Shared+57609);  // Cost_Parallel_Work_1_Broadcast4_0_out0_18_18 > Cost_Parallel_Work_1_CostConstruction_18_disparity size:= 1*uchar
uchar *const out1_0_36__disparity__1 = (uchar*) (Shared+57591);  // Cost_Parallel_Work_1_Broadcast4_0_out1_0_36 > Cost_Parallel_Work_1_disparitySelect_0_disparity size:= 1*uchar
uchar *const out1_1_36__disparity__1 = (uchar*) (Shared+57592);  // Cost_Parallel_Work_1_Broadcast4_0_out1_1_36 > Cost_Parallel_Work_1_disparitySelect_1_disparity size:= 1*uchar
uchar *const out1_2_36__disparity__1 = (uchar*) (Shared+57593);  // Cost_Parallel_Work_1_Broadcast4_0_out1_2_36 > Cost_Parallel_Work_1_disparitySelect_2_disparity size:= 1*uchar
uchar *const out1_3_36__disparity__1 = (uchar*) (Shared+57594);  // Cost_Parallel_Work_1_Broadcast4_0_out1_3_36 > Cost_Parallel_Work_1_disparitySelect_3_disparity size:= 1*uchar
uchar *const out1_4_36__disparity__1 = (uchar*) (Shared+57595);  // Cost_Parallel_Work_1_Broadcast4_0_out1_4_36 > Cost_Parallel_Work_1_disparitySelect_4_disparity size:= 1*uchar
uchar *const out1_5_36__disparity__1 = (uchar*) (Shared+57596);  // Cost_Parallel_Work_1_Broadcast4_0_out1_5_36 > Cost_Parallel_Work_1_disparitySelect_5_disparity size:= 1*uchar
uchar *const out1_6_36__disparity__1 = (uchar*) (Shared+57597);  // Cost_Parallel_Work_1_Broadcast4_0_out1_6_36 > Cost_Parallel_Work_1_disparitySelect_6_disparity size:= 1*uchar
uchar *const out1_7_36__disparity__1 = (uchar*) (Shared+57598);  // Cost_Parallel_Work_1_Broadcast4_0_out1_7_36 > Cost_Parallel_Work_1_disparitySelect_7_disparity size:= 1*uchar
uchar *const out1_8_36__disparity__1 = (uchar*) (Shared+57599);  // Cost_Parallel_Work_1_Broadcast4_0_out1_8_36 > Cost_Parallel_Work_1_disparitySelect_8_disparity size:= 1*uchar
uchar *const out1_10_36__disparity__1 = (uchar*) (Shared+57601);  // Cost_Parallel_Work_1_Broadcast4_0_out1_10_36 > Cost_Parallel_Work_1_disparitySelect_10_disparity size:= 1*uchar
uchar *const out1_11_36__disparity__1 = (uchar*) (Shared+57602);  // Cost_Parallel_Work_1_Broadcast4_0_out1_11_36 > Cost_Parallel_Work_1_disparitySelect_11_disparity size:= 1*uchar
uchar *const out1_12_36__disparity__1 = (uchar*) (Shared+57603);  // Cost_Parallel_Work_1_Broadcast4_0_out1_12_36 > Cost_Parallel_Work_1_disparitySelect_12_disparity size:= 1*uchar
uchar *const out1_13_36__disparity__1 = (uchar*) (Shared+57604);  // Cost_Parallel_Work_1_Broadcast4_0_out1_13_36 > Cost_Parallel_Work_1_disparitySelect_13_disparity size:= 1*uchar
uchar *const out1_14_36__disparity__1 = (uchar*) (Shared+57605);  // Cost_Parallel_Work_1_Broadcast4_0_out1_14_36 > Cost_Parallel_Work_1_disparitySelect_14_disparity size:= 1*uchar
uchar *const out1_15_36__disparity__1 = (uchar*) (Shared+57606);  // Cost_Parallel_Work_1_Broadcast4_0_out1_15_36 > Cost_Parallel_Work_1_disparitySelect_15_disparity size:= 1*uchar
uchar *const out1_16_36__disparity__1 = (uchar*) (Shared+57607);  // Cost_Parallel_Work_1_Broadcast4_0_out1_16_36 > Cost_Parallel_Work_1_disparitySelect_16_disparity size:= 1*uchar
uchar *const out1_17_36__disparity__1 = (uchar*) (Shared+57608);  // Cost_Parallel_Work_1_Broadcast4_0_out1_17_36 > Cost_Parallel_Work_1_disparitySelect_17_disparity size:= 1*uchar
uchar *const out1_18_36__disparity__1 = (uchar*) (Shared+57609);  // Cost_Parallel_Work_1_Broadcast4_0_out1_18_36 > Cost_Parallel_Work_1_disparitySelect_18_disparity size:= 1*uchar
uchar *const out1_9_36__disparity__2 = (uchar*) (Shared+57792);  // Cost_Parallel_Work_2_Broadcast4_0_out1_9_36 > Cost_Parallel_Work_2_disparitySelect_9_disparity size:= 1*uchar
uchar *const disparities__in__2 = (uchar*) (Shared+57783);  // Cost_Parallel_Work_2_DisparityGen_0_disparities > Cost_Parallel_Work_2_Broadcast4_0_in size:= 19*uchar
uchar *const out0_0_18__disparity__2 = (uchar*) (Shared+57783);  // Cost_Parallel_Work_2_Broadcast4_0_out0_0_18 > Cost_Parallel_Work_2_CostConstruction_0_disparity size:= 1*uchar
uchar *const out0_1_18__disparity__2 = (uchar*) (Shared+57784);  // Cost_Parallel_Work_2_Broadcast4_0_out0_1_18 > Cost_Parallel_Work_2_CostConstruction_1_disparity size:= 1*uchar
uchar *const out0_2_18__disparity__2 = (uchar*) (Shared+57785);  // Cost_Parallel_Work_2_Broadcast4_0_out0_2_18 > Cost_Parallel_Work_2_CostConstruction_2_disparity size:= 1*uchar
uchar *const out0_3_18__disparity__2 = (uchar*) (Shared+57786);  // Cost_Parallel_Work_2_Broadcast4_0_out0_3_18 > Cost_Parallel_Work_2_CostConstruction_3_disparity size:= 1*uchar
uchar *const out0_4_18__disparity__2 = (uchar*) (Shared+57787);  // Cost_Parallel_Work_2_Broadcast4_0_out0_4_18 > Cost_Parallel_Work_2_CostConstruction_4_disparity size:= 1*uchar
uchar *const out0_5_18__disparity__2 = (uchar*) (Shared+57788);  // Cost_Parallel_Work_2_Broadcast4_0_out0_5_18 > Cost_Parallel_Work_2_CostConstruction_5_disparity size:= 1*uchar
uchar *const out0_6_18__disparity__2 = (uchar*) (Shared+57789);  // Cost_Parallel_Work_2_Broadcast4_0_out0_6_18 > Cost_Parallel_Work_2_CostConstruction_6_disparity size:= 1*uchar
uchar *const out0_7_18__disparity__2 = (uchar*) (Shared+57790);  // Cost_Parallel_Work_2_Broadcast4_0_out0_7_18 > Cost_Parallel_Work_2_CostConstruction_7_disparity size:= 1*uchar
uchar *const out0_8_18__disparity__2 = (uchar*) (Shared+57791);  // Cost_Parallel_Work_2_Broadcast4_0_out0_8_18 > Cost_Parallel_Work_2_CostConstruction_8_disparity size:= 1*uchar
uchar *const out0_9_18__disparity__2 = (uchar*) (Shared+57792);  // Cost_Parallel_Work_2_Broadcast4_0_out0_9_18 > Cost_Parallel_Work_2_CostConstruction_9_disparity size:= 1*uchar
uchar *const out0_10_18__disparity__2 = (uchar*) (Shared+57793);  // Cost_Parallel_Work_2_Broadcast4_0_out0_10_18 > Cost_Parallel_Work_2_CostConstruction_10_disparity size:= 1*uchar
uchar *const out0_11_18__disparity__2 = (uchar*) (Shared+57794);  // Cost_Parallel_Work_2_Broadcast4_0_out0_11_18 > Cost_Parallel_Work_2_CostConstruction_11_disparity size:= 1*uchar
uchar *const out0_12_18__disparity__2 = (uchar*) (Shared+57795);  // Cost_Parallel_Work_2_Broadcast4_0_out0_12_18 > Cost_Parallel_Work_2_CostConstruction_12_disparity size:= 1*uchar
uchar *const out0_13_18__disparity__2 = (uchar*) (Shared+57796);  // Cost_Parallel_Work_2_Broadcast4_0_out0_13_18 > Cost_Parallel_Work_2_CostConstruction_13_disparity size:= 1*uchar
uchar *const out0_14_18__disparity__2 = (uchar*) (Shared+57797);  // Cost_Parallel_Work_2_Broadcast4_0_out0_14_18 > Cost_Parallel_Work_2_CostConstruction_14_disparity size:= 1*uchar
uchar *const out0_15_18__disparity__2 = (uchar*) (Shared+57798);  // Cost_Parallel_Work_2_Broadcast4_0_out0_15_18 > Cost_Parallel_Work_2_CostConstruction_15_disparity size:= 1*uchar
uchar *const out0_16_18__disparity__2 = (uchar*) (Shared+57799);  // Cost_Parallel_Work_2_Broadcast4_0_out0_16_18 > Cost_Parallel_Work_2_CostConstruction_16_disparity size:= 1*uchar
uchar *const out0_17_18__disparity__2 = (uchar*) (Shared+57800);  // Cost_Parallel_Work_2_Broadcast4_0_out0_17_18 > Cost_Parallel_Work_2_CostConstruction_17_disparity size:= 1*uchar
uchar *const out0_18_18__disparity__2 = (uchar*) (Shared+57801);  // Cost_Parallel_Work_2_Broadcast4_0_out0_18_18 > Cost_Parallel_Work_2_CostConstruction_18_disparity size:= 1*uchar
uchar *const out1_0_36__disparity__2 = (uchar*) (Shared+57783);  // Cost_Parallel_Work_2_Broadcast4_0_out1_0_36 > Cost_Parallel_Work_2_disparitySelect_0_disparity size:= 1*uchar
uchar *const out1_1_36__disparity__2 = (uchar*) (Shared+57784);  // Cost_Parallel_Work_2_Broadcast4_0_out1_1_36 > Cost_Parallel_Work_2_disparitySelect_1_disparity size:= 1*uchar
uchar *const out1_2_36__disparity__2 = (uchar*) (Shared+57785);  // Cost_Parallel_Work_2_Broadcast4_0_out1_2_36 > Cost_Parallel_Work_2_disparitySelect_2_disparity size:= 1*uchar
uchar *const out1_3_36__disparity__2 = (uchar*) (Shared+57786);  // Cost_Parallel_Work_2_Broadcast4_0_out1_3_36 > Cost_Parallel_Work_2_disparitySelect_3_disparity size:= 1*uchar
uchar *const out1_4_36__disparity__2 = (uchar*) (Shared+57787);  // Cost_Parallel_Work_2_Broadcast4_0_out1_4_36 > Cost_Parallel_Work_2_disparitySelect_4_disparity size:= 1*uchar
uchar *const out1_5_36__disparity__2 = (uchar*) (Shared+57788);  // Cost_Parallel_Work_2_Broadcast4_0_out1_5_36 > Cost_Parallel_Work_2_disparitySelect_5_disparity size:= 1*uchar
uchar *const out1_6_36__disparity__2 = (uchar*) (Shared+57789);  // Cost_Parallel_Work_2_Broadcast4_0_out1_6_36 > Cost_Parallel_Work_2_disparitySelect_6_disparity size:= 1*uchar
uchar *const out1_7_36__disparity__2 = (uchar*) (Shared+57790);  // Cost_Parallel_Work_2_Broadcast4_0_out1_7_36 > Cost_Parallel_Work_2_disparitySelect_7_disparity size:= 1*uchar
uchar *const out1_8_36__disparity__2 = (uchar*) (Shared+57791);  // Cost_Parallel_Work_2_Broadcast4_0_out1_8_36 > Cost_Parallel_Work_2_disparitySelect_8_disparity size:= 1*uchar
uchar *const out1_10_36__disparity__2 = (uchar*) (Shared+57793);  // Cost_Parallel_Work_2_Broadcast4_0_out1_10_36 > Cost_Parallel_Work_2_disparitySelect_10_disparity size:= 1*uchar
uchar *const out1_11_36__disparity__2 = (uchar*) (Shared+57794);  // Cost_Parallel_Work_2_Broadcast4_0_out1_11_36 > Cost_Parallel_Work_2_disparitySelect_11_disparity size:= 1*uchar
uchar *const out1_12_36__disparity__2 = (uchar*) (Shared+57795);  // Cost_Parallel_Work_2_Broadcast4_0_out1_12_36 > Cost_Parallel_Work_2_disparitySelect_12_disparity size:= 1*uchar
uchar *const out1_13_36__disparity__2 = (uchar*) (Shared+57796);  // Cost_Parallel_Work_2_Broadcast4_0_out1_13_36 > Cost_Parallel_Work_2_disparitySelect_13_disparity size:= 1*uchar
uchar *const out1_14_36__disparity__2 = (uchar*) (Shared+57797);  // Cost_Parallel_Work_2_Broadcast4_0_out1_14_36 > Cost_Parallel_Work_2_disparitySelect_14_disparity size:= 1*uchar
uchar *const out1_15_36__disparity__2 = (uchar*) (Shared+57798);  // Cost_Parallel_Work_2_Broadcast4_0_out1_15_36 > Cost_Parallel_Work_2_disparitySelect_15_disparity size:= 1*uchar
uchar *const out1_16_36__disparity__2 = (uchar*) (Shared+57799);  // Cost_Parallel_Work_2_Broadcast4_0_out1_16_36 > Cost_Parallel_Work_2_disparitySelect_16_disparity size:= 1*uchar
uchar *const out1_17_36__disparity__2 = (uchar*) (Shared+57800);  // Cost_Parallel_Work_2_Broadcast4_0_out1_17_36 > Cost_Parallel_Work_2_disparitySelect_17_disparity size:= 1*uchar
uchar *const out1_18_36__disparity__2 = (uchar*) (Shared+57801);  // Cost_Parallel_Work_2_Broadcast4_0_out1_18_36 > Cost_Parallel_Work_2_disparitySelect_18_disparity size:= 1*uchar
uchar *const currentResult__currentResult__0 = (uchar*) (Shared+0);  // Cost_Parallel_Work_init_in_disparitySelect_currentResult_currentResult > Cost_Parallel_Work_0_disparitySelect_0_currentResult size:= 120*uchar
uchar *const out0_0__rawDisparity_0_18__0 = (uchar*) (Shared+0);  // Cost_Parallel_Work_0_Broadcast5_0_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_0_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_1_18__0 = (uchar*) (Shared+7360);  // Cost_Parallel_Work_0_Broadcast5_1_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_1_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_2_18__0 = (uchar*) (Shared+14720);  // Cost_Parallel_Work_0_Broadcast5_2_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_2_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_3_18__0 = (uchar*) (Shared+22080);  // Cost_Parallel_Work_0_Broadcast5_3_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_3_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_4_18__0 = (uchar*) (Shared+29440);  // Cost_Parallel_Work_0_Broadcast5_4_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_4_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_5_18__0 = (uchar*) (Shared+36800);  // Cost_Parallel_Work_0_Broadcast5_5_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_5_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_6_18__0 = (uchar*) (Shared+48704);  // Cost_Parallel_Work_0_Broadcast5_6_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_6_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_7_18__0 = (uchar*) (Shared+48960);  // Cost_Parallel_Work_0_Broadcast5_7_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_7_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_8_18__0 = (uchar*) (Shared+50688);  // Cost_Parallel_Work_0_Broadcast5_8_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_8_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_9_18__0 = (uchar*) (Shared+51328);  // Cost_Parallel_Work_0_Broadcast5_9_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_9_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_10_18__0 = (uchar*) (Shared+51968);  // Cost_Parallel_Work_0_Broadcast5_10_out0_0 > RB_Cost_Parallel_Work_0__rawDisparity_rawDisparity_10_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_0_18__1 = (uchar*) (Shared+52608);  // Cost_Parallel_Work_1_Broadcast5_0_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_0_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_1_18__1 = (uchar*) (Shared+53760);  // Cost_Parallel_Work_1_Broadcast5_1_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_1_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_2_18__1 = (uchar*) (Shared+54528);  // Cost_Parallel_Work_1_Broadcast5_2_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_2_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_3_18__1 = (uchar*) (Shared+54784);  // Cost_Parallel_Work_1_Broadcast5_3_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_3_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_4_18__1 = (uchar*) (Shared+55040);  // Cost_Parallel_Work_1_Broadcast5_4_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_4_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_5_18__1 = (uchar*) (Shared+55296);  // Cost_Parallel_Work_1_Broadcast5_5_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_5_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_6_18__1 = (uchar*) (Shared+55552);  // Cost_Parallel_Work_1_Broadcast5_6_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_6_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_7_18__1 = (uchar*) (Shared+56320);  // Cost_Parallel_Work_1_Broadcast5_7_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_7_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_8_18__1 = (uchar*) (Shared+7360);  // Cost_Parallel_Work_1_Broadcast5_8_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_8_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_9_18__1 = (uchar*) (Shared+14720);  // Cost_Parallel_Work_1_Broadcast5_9_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_9_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_10_18__1 = (uchar*) (Shared+22080);  // Cost_Parallel_Work_1_Broadcast5_10_out0_0 > RB_Cost_Parallel_Work_1__rawDisparity_rawDisparity_10_18 size:= 120*uchar
uchar *const out1_1_1__out1_1__0 = (uchar*) (Shared+0);  // Cost_Parallel_Work_2_Broadcast5_18_out1_1_1 > Cost_Parallel_Work_end_out_Broadcast5_out1_out1_1 size:= 120*uchar
uchar *const output__rawDisparity__3 = (uchar*) (Shared+51840);  // implode_Median_Filter_26_rawDisparity_output > Median_Filter_26_rawDisparity size:= 36*uchar
uchar *const output_13__rawDisparity_0__1 = (uchar*) (Shared+51840);  // explode_Split_1_output_output_13 > implode_Median_Filter_26_rawDisparity_rawDisparity_0 size:= 24*uchar
int *const out0_0_18__offsets__0 = (int*) (Shared+57280);  // Cost_Parallel_Work_0_Broadcast0_0_out0_0_18 > Cost_Parallel_Work_0_AggregateCost_0_offsets size:= 5*int
int *const out0_1_18__offsets__0 = (int*) (Shared+57472);  // Cost_Parallel_Work_0_Broadcast0_0_out0_1_18 > Cost_Parallel_Work_0_AggregateCost_1_offsets size:= 5*int
int *const out0_3_18__offsets__0 = (int*) (Shared+57664);  // Cost_Parallel_Work_0_Broadcast0_0_out0_3_18 > Cost_Parallel_Work_0_AggregateCost_3_offsets size:= 5*int
int *const out0_5_18__offsets__0 = (int*) (Shared+36800);  // Cost_Parallel_Work_0_Broadcast0_0_out0_5_18 > Cost_Parallel_Work_0_AggregateCost_5_offsets size:= 5*int
int *const out0_6_18__offsets__0 = (int*) (Shared+50048);  // Cost_Parallel_Work_0_Broadcast0_0_out0_6_18 > Cost_Parallel_Work_0_AggregateCost_6_offsets size:= 5*int
int *const out0_8_18__offsets__0 = (int*) (Shared+50112);  // Cost_Parallel_Work_0_Broadcast0_0_out0_8_18 > Cost_Parallel_Work_0_AggregateCost_8_offsets size:= 5*int
int *const out0_9_18__offsets__0 = (int*) (Shared+51328);  // Cost_Parallel_Work_0_Broadcast0_0_out0_9_18 > Cost_Parallel_Work_0_AggregateCost_9_offsets size:= 5*int
int *const out0_11_18__offsets__0 = (int*) (Shared+52608);  // Cost_Parallel_Work_0_Broadcast0_0_out0_11_18 > Cost_Parallel_Work_0_AggregateCost_11_offsets size:= 5*int
int *const out0_13_18__offsets__0 = (int*) (Shared+52672);  // Cost_Parallel_Work_0_Broadcast0_0_out0_13_18 > Cost_Parallel_Work_0_AggregateCost_13_offsets size:= 5*int
int *const out0_15_18__offsets__0 = (int*) (Shared+53248);  // Cost_Parallel_Work_0_Broadcast0_0_out0_15_18 > Cost_Parallel_Work_0_AggregateCost_15_offsets size:= 5*int
int *const out0_17_18__offsets__0 = (int*) (Shared+53312);  // Cost_Parallel_Work_0_Broadcast0_0_out0_17_18 > Cost_Parallel_Work_0_AggregateCost_17_offsets size:= 5*int
int *const out0_0_18__offsets__1 = (int*) (Shared+53888);  // Cost_Parallel_Work_1_Broadcast0_0_out0_0_18 > Cost_Parallel_Work_1_AggregateCost_0_offsets size:= 5*int
int *const out0_1_18__offsets__1 = (int*) (Shared+53952);  // Cost_Parallel_Work_1_Broadcast0_0_out0_1_18 > Cost_Parallel_Work_1_AggregateCost_1_offsets size:= 5*int
int *const out0_2_18__offsets__0 = (int*) (Shared+55552);  // Cost_Parallel_Work_1_Broadcast0_0_out0_2_18 > Cost_Parallel_Work_1_AggregateCost_2_offsets size:= 5*int
int *const out0_3_18__offsets__1 = (int*) (Shared+55616);  // Cost_Parallel_Work_1_Broadcast0_0_out0_3_18 > Cost_Parallel_Work_1_AggregateCost_3_offsets size:= 5*int
int *const out0_4_18__offsets__0 = (int*) (Shared+55808);  // Cost_Parallel_Work_1_Broadcast0_0_out0_4_18 > Cost_Parallel_Work_1_AggregateCost_4_offsets size:= 5*int
int *const out0_5_18__offsets__1 = (int*) (Shared+55872);  // Cost_Parallel_Work_1_Broadcast0_0_out0_5_18 > Cost_Parallel_Work_1_AggregateCost_5_offsets size:= 5*int
int *const out0_6_18__offsets__1 = (int*) (Shared+56064);  // Cost_Parallel_Work_1_Broadcast0_0_out0_6_18 > Cost_Parallel_Work_1_AggregateCost_6_offsets size:= 5*int
int *const out0_7_18__offsets__0 = (int*) (Shared+56128);  // Cost_Parallel_Work_1_Broadcast0_0_out0_7_18 > Cost_Parallel_Work_1_AggregateCost_7_offsets size:= 5*int
int *const out0_8_18__offsets__1 = (int*) (Shared+56576);  // Cost_Parallel_Work_1_Broadcast0_0_out0_8_18 > Cost_Parallel_Work_1_AggregateCost_8_offsets size:= 5*int
int *const out0_9_18__offsets__1 = (int*) (Shared+56640);  // Cost_Parallel_Work_1_Broadcast0_0_out0_9_18 > Cost_Parallel_Work_1_AggregateCost_9_offsets size:= 5*int
int *const out0_10_18__offsets__0 = (int*) (Shared+56832);  // Cost_Parallel_Work_1_Broadcast0_0_out0_10_18 > Cost_Parallel_Work_1_AggregateCost_10_offsets size:= 5*int
int *const out0_11_18__offsets__1 = (int*) (Shared+56896);  // Cost_Parallel_Work_1_Broadcast0_0_out0_11_18 > Cost_Parallel_Work_1_AggregateCost_11_offsets size:= 5*int
int *const out0_12_18__offsets__0 = (int*) (Shared+57088);  // Cost_Parallel_Work_1_Broadcast0_0_out0_12_18 > Cost_Parallel_Work_1_AggregateCost_12_offsets size:= 5*int
int *const out0_13_18__offsets__1 = (int*) (Shared+57152);  // Cost_Parallel_Work_1_Broadcast0_0_out0_13_18 > Cost_Parallel_Work_1_AggregateCost_13_offsets size:= 5*int
int *const out0_14_18__offsets__0 = (int*) (Shared+57856);  // Cost_Parallel_Work_1_Broadcast0_0_out0_14_18 > Cost_Parallel_Work_1_AggregateCost_14_offsets size:= 5*int
int *const out0_15_18__offsets__1 = (int*) (Shared+57920);  // Cost_Parallel_Work_1_Broadcast0_0_out0_15_18 > Cost_Parallel_Work_1_AggregateCost_15_offsets size:= 5*int
int *const out0_16_18__offsets__0 = (int*) (Shared+57984);  // Cost_Parallel_Work_1_Broadcast0_0_out0_16_18 > Cost_Parallel_Work_1_AggregateCost_16_offsets size:= 5*int
int *const out0_17_18__offsets__1 = (int*) (Shared+58048);  // Cost_Parallel_Work_1_Broadcast0_0_out0_17_18 > Cost_Parallel_Work_1_AggregateCost_17_offsets size:= 5*int
int *const out0_18_18__offsets__0 = (int*) (Shared+58112);  // Cost_Parallel_Work_1_Broadcast0_0_out0_18_18 > Cost_Parallel_Work_1_AggregateCost_18_offsets size:= 5*int
int *const out0_0_18__offsets__2 = (int*) (Shared+58176);  // Cost_Parallel_Work_2_Broadcast0_0_out0_0_18 > Cost_Parallel_Work_2_AggregateCost_0_offsets size:= 5*int
int *const out0_1_18__offsets__2 = (int*) (Shared+58240);  // Cost_Parallel_Work_2_Broadcast0_0_out0_1_18 > Cost_Parallel_Work_2_AggregateCost_1_offsets size:= 5*int
int *const out0_2_18__offsets__1 = (int*) (Shared+58304);  // Cost_Parallel_Work_2_Broadcast0_0_out0_2_18 > Cost_Parallel_Work_2_AggregateCost_2_offsets size:= 5*int
int *const out0_3_18__offsets__2 = (int*) (Shared+58368);  // Cost_Parallel_Work_2_Broadcast0_0_out0_3_18 > Cost_Parallel_Work_2_AggregateCost_3_offsets size:= 5*int
int *const out0_4_18__offsets__1 = (int*) (Shared+58432);  // Cost_Parallel_Work_2_Broadcast0_0_out0_4_18 > Cost_Parallel_Work_2_AggregateCost_4_offsets size:= 5*int
int *const out0_5_18__offsets__2 = (int*) (Shared+58496);  // Cost_Parallel_Work_2_Broadcast0_0_out0_5_18 > Cost_Parallel_Work_2_AggregateCost_5_offsets size:= 5*int
int *const out0_6_18__offsets__2 = (int*) (Shared+58560);  // Cost_Parallel_Work_2_Broadcast0_0_out0_6_18 > Cost_Parallel_Work_2_AggregateCost_6_offsets size:= 5*int
int *const out0_7_18__offsets__1 = (int*) (Shared+58624);  // Cost_Parallel_Work_2_Broadcast0_0_out0_7_18 > Cost_Parallel_Work_2_AggregateCost_7_offsets size:= 5*int
int *const out0_8_18__offsets__2 = (int*) (Shared+58688);  // Cost_Parallel_Work_2_Broadcast0_0_out0_8_18 > Cost_Parallel_Work_2_AggregateCost_8_offsets size:= 5*int
int *const out0_9_18__offsets__2 = (int*) (Shared+58752);  // Cost_Parallel_Work_2_Broadcast0_0_out0_9_18 > Cost_Parallel_Work_2_AggregateCost_9_offsets size:= 5*int
int *const out0_10_18__offsets__1 = (int*) (Shared+58816);  // Cost_Parallel_Work_2_Broadcast0_0_out0_10_18 > Cost_Parallel_Work_2_AggregateCost_10_offsets size:= 5*int
int *const out0_11_18__offsets__2 = (int*) (Shared+58880);  // Cost_Parallel_Work_2_Broadcast0_0_out0_11_18 > Cost_Parallel_Work_2_AggregateCost_11_offsets size:= 5*int
int *const out0_12_18__offsets__1 = (int*) (Shared+58944);  // Cost_Parallel_Work_2_Broadcast0_0_out0_12_18 > Cost_Parallel_Work_2_AggregateCost_12_offsets size:= 5*int
int *const out0_13_18__offsets__2 = (int*) (Shared+59008);  // Cost_Parallel_Work_2_Broadcast0_0_out0_13_18 > Cost_Parallel_Work_2_AggregateCost_13_offsets size:= 5*int
int *const out0_14_18__offsets__1 = (int*) (Shared+59072);  // Cost_Parallel_Work_2_Broadcast0_0_out0_14_18 > Cost_Parallel_Work_2_AggregateCost_14_offsets size:= 5*int
int *const out0_15_18__offsets__2 = (int*) (Shared+59136);  // Cost_Parallel_Work_2_Broadcast0_0_out0_15_18 > Cost_Parallel_Work_2_AggregateCost_15_offsets size:= 5*int
int *const out0_16_18__offsets__1 = (int*) (Shared+59200);  // Cost_Parallel_Work_2_Broadcast0_0_out0_16_18 > Cost_Parallel_Work_2_AggregateCost_16_offsets size:= 5*int
int *const out0_17_18__offsets__2 = (int*) (Shared+59264);  // Cost_Parallel_Work_2_Broadcast0_0_out0_17_18 > Cost_Parallel_Work_2_AggregateCost_17_offsets size:= 5*int
int *const out0_18_18__offsets__1 = (int*) (Shared+59328);  // Cost_Parallel_Work_2_Broadcast0_0_out0_18_18 > Cost_Parallel_Work_2_AggregateCost_18_offsets size:= 5*int
uchar *const filteredDisparity__in_3__0 = (uchar*) (Shared+51328);  // Median_Filter_3_filteredDisparity > implode_lum2RGB_0_in_in_3 size:= 12*uchar
uchar *const filteredDisparity__in_4__0 = (uchar*) (Shared+53952);  // Median_Filter_4_filteredDisparity > implode_lum2RGB_0_in_in_4 size:= 12*uchar
uchar *const filteredDisparity__in_5__0 = (uchar*) (Shared+56128);  // Median_Filter_5_filteredDisparity > implode_lum2RGB_0_in_in_5 size:= 12*uchar
uchar *const filteredDisparity__in_6__0 = (uchar*) (Shared+51584);  // Median_Filter_6_filteredDisparity > implode_lum2RGB_0_in_in_6 size:= 12*uchar
uchar *const filteredDisparity__in_7__0 = (uchar*) (Shared+57664);  // Median_Filter_7_filteredDisparity > implode_lum2RGB_0_in_in_7 size:= 12*uchar
uchar *const filteredDisparity__in_8__0 = (uchar*) (Shared+51648);  // Median_Filter_8_filteredDisparity > implode_lum2RGB_0_in_in_8 size:= 12*uchar
uchar *const filteredDisparity__in_1__0 = (uchar*) (Shared+22080);  // Median_Filter_21_filteredDisparity > implode_lum2RGB_2_in_in_1 size:= 12*uchar
uchar *const filteredDisparity__in_2__0 = (uchar*) (Shared+22144);  // Median_Filter_22_filteredDisparity > implode_lum2RGB_2_in_in_2 size:= 12*uchar
uchar *const filteredDisparity__in_3__1 = (uchar*) (Shared+52480);  // Median_Filter_23_filteredDisparity > implode_lum2RGB_2_in_in_3 size:= 12*uchar
uchar *const filteredDisparity__in_5__1 = (uchar*) (Shared+52544);  // Median_Filter_25_filteredDisparity > implode_lum2RGB_2_in_in_5 size:= 12*uchar
uchar *const filteredDisparity__in_4__1 = (uchar*) (Shared+58240);  // Median_Filter_24_filteredDisparity > implode_lum2RGB_2_in_in_4 size:= 12*uchar
uchar *const filteredDisparity__in_4__2 = (uchar*) (Shared+52416);  // Median_Filter_34_filteredDisparity > implode_lum2RGB_3_in_in_4 size:= 12*uchar
uchar *const filteredDisparity__in_8__1 = (uchar*) (Shared+51968);  // Median_Filter_38_filteredDisparity > implode_lum2RGB_3_in_in_8 size:= 12*uchar
uchar *const filteredDisparity__in_7__1 = (uchar*) (Shared+52032);  // Median_Filter_27_filteredDisparity > implode_lum2RGB_2_in_in_7 size:= 12*uchar
uchar *const filteredDisparity__in_8__2 = (uchar*) (Shared+52096);  // Median_Filter_28_filteredDisparity > implode_lum2RGB_2_in_in_8 size:= 12*uchar
uchar *const filteredDisparity__in_9__0 = (uchar*) (Shared+51904);  // Median_Filter_29_filteredDisparity > implode_lum2RGB_2_in_in_9 size:= 12*uchar
uchar *const filteredDisparity__in_2__1 = (uchar*) (Shared+52160);  // Median_Filter_32_filteredDisparity > implode_lum2RGB_3_in_in_2 size:= 12*uchar
uchar *const filteredDisparity__in_3__2 = (uchar*) (Shared+52224);  // Median_Filter_33_filteredDisparity > implode_lum2RGB_3_in_in_3 size:= 12*uchar
uchar *const filteredDisparity__in_6__1 = (uchar*) (Shared+52736);  // Median_Filter_36_filteredDisparity > implode_lum2RGB_3_in_in_6 size:= 12*uchar
uchar *const filteredDisparity__in_7__2 = (uchar*) (Shared+52800);  // Median_Filter_37_filteredDisparity > implode_lum2RGB_3_in_in_7 size:= 12*uchar
uchar *const back_1__back__0 = (uchar*) (Shared+36864);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_1 > Cost_Parallel_Work_0_CostConstruction_1_back size:= 1*uchar
uchar *const back_3__back__0 = (uchar*) (Shared+51392);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_3 > Cost_Parallel_Work_0_CostConstruction_3_back size:= 1*uchar
uchar *const back_4__back__0 = (uchar*) (Shared+7360);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_4 > Cost_Parallel_Work_0_CostConstruction_4_back size:= 1*uchar
uchar *const back_5__back__0 = (uchar*) (Shared+22080);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_5 > Cost_Parallel_Work_0_CostConstruction_5_back size:= 1*uchar
uchar *const back_7__back__0 = (uchar*) (Shared+7424);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_7 > Cost_Parallel_Work_0_CostConstruction_7_back size:= 1*uchar
uchar *const back_2__back__0 = (uchar*) (Shared+48832);  // Cost_Parallel_Work_0_Broadcast5_0_back_2 > Cost_Parallel_Work_0_CostConstruction_8_back size:= 1*uchar
uchar *const back_2__back__1 = (uchar*) (Shared+48896);  // Cost_Parallel_Work_0_Broadcast5_1_back_2 > Cost_Parallel_Work_0_CostConstruction_9_back size:= 1*uchar
uchar *const back_2__back__2 = (uchar*) (Shared+57472);  // Cost_Parallel_Work_0_Broadcast5_2_back_2 > Cost_Parallel_Work_0_CostConstruction_10_back size:= 1*uchar
uchar *const back_2__back__3 = (uchar*) (Shared+57664);  // Cost_Parallel_Work_0_Broadcast5_3_back_2 > Cost_Parallel_Work_0_CostConstruction_11_back size:= 1*uchar
uchar *const back_2__back__4 = (uchar*) (Shared+56320);  // Cost_Parallel_Work_0_Broadcast5_4_back_2 > Cost_Parallel_Work_0_CostConstruction_12_back size:= 1*uchar
uchar *const back_2__back__5 = (uchar*) (Shared+56384);  // Cost_Parallel_Work_0_Broadcast5_5_back_2 > Cost_Parallel_Work_0_CostConstruction_13_back size:= 1*uchar
uchar *const back_2__back__6 = (uchar*) (Shared+57216);  // Cost_Parallel_Work_0_Broadcast5_6_back_2 > Cost_Parallel_Work_0_CostConstruction_14_back size:= 1*uchar
uchar *const back_2__back__7 = (uchar*) (Shared+57280);  // Cost_Parallel_Work_0_Broadcast5_7_back_2 > Cost_Parallel_Work_0_CostConstruction_15_back size:= 1*uchar
uchar *const back_2__back__8 = (uchar*) (Shared+48832);  // Cost_Parallel_Work_0_Broadcast5_8_back_2 > Cost_Parallel_Work_0_CostConstruction_16_back size:= 1*uchar
uchar *const back_2__back__9 = (uchar*) (Shared+57344);  // Cost_Parallel_Work_0_Broadcast5_9_back_2 > Cost_Parallel_Work_0_CostConstruction_17_back size:= 1*uchar
uchar *const back_2__back__10 = (uchar*) (Shared+57472);  // Cost_Parallel_Work_0_Broadcast5_10_back_2 > Cost_Parallel_Work_0_CostConstruction_18_back size:= 1*uchar
uchar *const back_2_2__back__0 = (uchar*) (Shared+52608);  // Cost_Parallel_Work_0_Broadcast5_11_back_2_2 > Cost_Parallel_Work_1_CostConstruction_0_back size:= 1*uchar
uchar *const back_2_2__back__1 = (uchar*) (Shared+56320);  // Cost_Parallel_Work_0_Broadcast5_12_back_2_2 > Cost_Parallel_Work_1_CostConstruction_1_back size:= 1*uchar
uchar *const back_2_2__back__2 = (uchar*) (Shared+56384);  // Cost_Parallel_Work_0_Broadcast5_13_back_2_2 > Cost_Parallel_Work_1_CostConstruction_2_back size:= 1*uchar
uchar *const back_2_2__back__3 = (uchar*) (Shared+57216);  // Cost_Parallel_Work_0_Broadcast5_14_back_2_2 > Cost_Parallel_Work_1_CostConstruction_3_back size:= 1*uchar
uchar *const back_2_2__back__4 = (uchar*) (Shared+53248);  // Cost_Parallel_Work_0_Broadcast5_15_back_2_2 > Cost_Parallel_Work_1_CostConstruction_4_back size:= 1*uchar
uchar *const back_2_2__back__5 = (uchar*) (Shared+57280);  // Cost_Parallel_Work_0_Broadcast5_16_back_2_2 > Cost_Parallel_Work_1_CostConstruction_5_back size:= 1*uchar
uchar *const back_2_2__back__6 = (uchar*) (Shared+53312);  // Cost_Parallel_Work_0_Broadcast5_17_back_2_2 > Cost_Parallel_Work_1_CostConstruction_6_back size:= 1*uchar
uchar *const back_2_2__back__7 = (uchar*) (Shared+57664);  // Cost_Parallel_Work_0_Broadcast5_18_back_2_2 > Cost_Parallel_Work_1_CostConstruction_7_back size:= 1*uchar
uchar *const back_2__back__11 = (uchar*) (Shared+53888);  // Cost_Parallel_Work_1_Broadcast5_0_back_2 > Cost_Parallel_Work_1_CostConstruction_8_back size:= 1*uchar
uchar *const back_2__back__12 = (uchar*) (Shared+55936);  // Cost_Parallel_Work_1_Broadcast5_1_back_2 > Cost_Parallel_Work_1_CostConstruction_9_back size:= 1*uchar
uchar *const back_2__back__13 = (uchar*) (Shared+56000);  // Cost_Parallel_Work_1_Broadcast5_2_back_2 > Cost_Parallel_Work_1_CostConstruction_10_back size:= 1*uchar
uchar *const back_2__back__14 = (uchar*) (Shared+57216);  // Cost_Parallel_Work_1_Broadcast5_3_back_2 > Cost_Parallel_Work_1_CostConstruction_11_back size:= 1*uchar
uchar *const back_2__back__15 = (uchar*) (Shared+55808);  // Cost_Parallel_Work_1_Broadcast5_4_back_2 > Cost_Parallel_Work_1_CostConstruction_12_back size:= 1*uchar
uchar *const back_2__back__16 = (uchar*) (Shared+55872);  // Cost_Parallel_Work_1_Broadcast5_5_back_2 > Cost_Parallel_Work_1_CostConstruction_13_back size:= 1*uchar
uchar *const back_2__back__17 = (uchar*) (Shared+56064);  // Cost_Parallel_Work_1_Broadcast5_6_back_2 > Cost_Parallel_Work_1_CostConstruction_14_back size:= 1*uchar
uchar *const back_2__back__18 = (uchar*) (Shared+57280);  // Cost_Parallel_Work_1_Broadcast5_7_back_2 > Cost_Parallel_Work_1_CostConstruction_15_back size:= 1*uchar
uchar *const back_2__back__19 = (uchar*) (Shared+56576);  // Cost_Parallel_Work_1_Broadcast5_8_back_2 > Cost_Parallel_Work_1_CostConstruction_16_back size:= 1*uchar
uchar *const back_2__back__20 = (uchar*) (Shared+55936);  // Cost_Parallel_Work_1_Broadcast5_9_back_2 > Cost_Parallel_Work_1_CostConstruction_17_back size:= 1*uchar
uchar *const back_2__back__21 = (uchar*) (Shared+51840);  // Cost_Parallel_Work_1_Broadcast5_10_back_2 > Cost_Parallel_Work_1_CostConstruction_18_back size:= 1*uchar
uchar *const back_2_2__back__8 = (uchar*) (Shared+56000);  // Cost_Parallel_Work_1_Broadcast5_11_back_2_2 > Cost_Parallel_Work_2_CostConstruction_0_back size:= 1*uchar
uchar *const back_2_2__back__9 = (uchar*) (Shared+56128);  // Cost_Parallel_Work_1_Broadcast5_12_back_2_2 > Cost_Parallel_Work_2_CostConstruction_1_back size:= 1*uchar
uchar *const back_2_2__back__10 = (uchar*) (Shared+56640);  // Cost_Parallel_Work_1_Broadcast5_13_back_2_2 > Cost_Parallel_Work_2_CostConstruction_2_back size:= 1*uchar
uchar *const back_2_2__back__11 = (uchar*) (Shared+56064);  // Cost_Parallel_Work_1_Broadcast5_14_back_2_2 > Cost_Parallel_Work_2_CostConstruction_3_back size:= 1*uchar
uchar *const back_2_2__back__12 = (uchar*) (Shared+57664);  // Cost_Parallel_Work_1_Broadcast5_15_back_2_2 > Cost_Parallel_Work_2_CostConstruction_4_back size:= 1*uchar
uchar *const back_2_2__back__13 = (uchar*) (Shared+56576);  // Cost_Parallel_Work_1_Broadcast5_16_back_2_2 > Cost_Parallel_Work_2_CostConstruction_5_back size:= 1*uchar
uchar *const back_2_2__back__14 = (uchar*) (Shared+0);  // Cost_Parallel_Work_1_Broadcast5_17_back_2_2 > Cost_Parallel_Work_2_CostConstruction_6_back size:= 1*uchar
uchar *const back_2_2__back__15 = (uchar*) (Shared+49280);  // Cost_Parallel_Work_1_Broadcast5_18_back_2_2 > Cost_Parallel_Work_2_CostConstruction_7_back size:= 1*uchar
uchar *const back_2__back__22 = (uchar*) (Shared+53248);  // Cost_Parallel_Work_2_Broadcast5_0_back_2 > Cost_Parallel_Work_2_CostConstruction_8_back size:= 1*uchar
uchar *const back_2__back__23 = (uchar*) (Shared+49344);  // Cost_Parallel_Work_2_Broadcast5_1_back_2 > Cost_Parallel_Work_2_CostConstruction_9_back size:= 1*uchar
uchar *const back_2__back__24 = (uchar*) (Shared+53312);  // Cost_Parallel_Work_2_Broadcast5_2_back_2 > Cost_Parallel_Work_2_CostConstruction_10_back size:= 1*uchar
uchar *const back_2__back__25 = (uchar*) (Shared+56640);  // Cost_Parallel_Work_2_Broadcast5_3_back_2 > Cost_Parallel_Work_2_CostConstruction_11_back size:= 1*uchar
uchar *const back_2__back__26 = (uchar*) (Shared+56832);  // Cost_Parallel_Work_2_Broadcast5_4_back_2 > Cost_Parallel_Work_2_CostConstruction_12_back size:= 1*uchar
uchar *const back_2__back__27 = (uchar*) (Shared+56576);  // Cost_Parallel_Work_2_Broadcast5_5_back_2 > Cost_Parallel_Work_2_CostConstruction_13_back size:= 1*uchar
uchar *const back_2__back__28 = (uchar*) (Shared+56896);  // Cost_Parallel_Work_2_Broadcast5_6_back_2 > Cost_Parallel_Work_2_CostConstruction_14_back size:= 1*uchar
uchar *const back_2__back__29 = (uchar*) (Shared+57856);  // Cost_Parallel_Work_2_Broadcast5_7_back_2 > Cost_Parallel_Work_2_CostConstruction_15_back size:= 1*uchar
uchar *const back_2__back__30 = (uchar*) (Shared+53248);  // Cost_Parallel_Work_2_Broadcast5_8_back_2 > Cost_Parallel_Work_2_CostConstruction_16_back size:= 1*uchar
uchar *const back_2__back__31 = (uchar*) (Shared+52672);  // Cost_Parallel_Work_2_Broadcast5_9_back_2 > Cost_Parallel_Work_2_CostConstruction_17_back size:= 1*uchar
uchar *const back_2__back__32 = (uchar*) (Shared+53312);  // Cost_Parallel_Work_2_Broadcast5_10_back_2 > Cost_Parallel_Work_2_CostConstruction_18_back size:= 1*uchar
float *const disparityError__disparityErr__31 = (float*) (Core0+0);  // Cost_Parallel_Work_0_CostConstruction_0_disparityError > Cost_Parallel_Work_0_AggregateCost_0_disparityError size:= 120*float
float *const aggregatedDisparity__aggrega__56 = (float*) (Core0+512);  // Cost_Parallel_Work_0_AggregateCost_0_aggregatedDisparity > Cost_Parallel_Work_0_disparitySelect_0_aggregatedDisparity size:= 120*float
uchar *const result__in__15 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_0_result > Cost_Parallel_Work_0_Broadcast5_0_in size:= 120*uchar
uchar *const out1_1__currentResult__0 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_0_out1_1 > Cost_Parallel_Work_0_disparitySelect_1_currentResult size:= 120*uchar
uchar *const result__in__16 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_1_result > Cost_Parallel_Work_0_Broadcast5_1_in size:= 120*uchar
uchar *const out1_1__currentResult__1 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_1_out1_1 > Cost_Parallel_Work_0_disparitySelect_2_currentResult size:= 120*uchar
uchar *const result__in__17 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_2_result > Cost_Parallel_Work_0_Broadcast5_2_in size:= 120*uchar
uchar *const out1_1__currentResult__2 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_2_out1_1 > Cost_Parallel_Work_0_disparitySelect_3_currentResult size:= 120*uchar
uchar *const result__in__18 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_3_result > Cost_Parallel_Work_0_Broadcast5_3_in size:= 120*uchar
uchar *const out1_1__currentResult__3 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_3_out1_1 > Cost_Parallel_Work_0_disparitySelect_4_currentResult size:= 120*uchar
uchar *const result__in__19 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_4_result > Cost_Parallel_Work_0_Broadcast5_4_in size:= 120*uchar
uchar *const out1_1__currentResult__4 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_4_out1_1 > Cost_Parallel_Work_0_disparitySelect_5_currentResult size:= 120*uchar
uchar *const result__in__20 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_5_result > Cost_Parallel_Work_0_Broadcast5_5_in size:= 120*uchar
uchar *const out1_1__currentResult__5 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_5_out1_1 > Cost_Parallel_Work_0_disparitySelect_6_currentResult size:= 120*uchar
uchar *const result__in__21 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_6_result > Cost_Parallel_Work_0_Broadcast5_6_in size:= 120*uchar
uchar *const out1_1__currentResult__6 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_6_out1_1 > Cost_Parallel_Work_0_disparitySelect_7_currentResult size:= 120*uchar
uchar *const result__in__22 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_7_result > Cost_Parallel_Work_0_Broadcast5_7_in size:= 120*uchar
uchar *const out1_1__currentResult__7 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_7_out1_1 > Cost_Parallel_Work_0_disparitySelect_8_currentResult size:= 120*uchar
uchar *const result__in__23 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_8_result > Cost_Parallel_Work_0_Broadcast5_8_in size:= 120*uchar
uchar *const out1_1__currentResult__8 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_8_out1_1 > Cost_Parallel_Work_0_disparitySelect_9_currentResult size:= 120*uchar
uchar *const result__in__24 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_disparitySelect_9_result > Cost_Parallel_Work_0_Broadcast5_9_in size:= 120*uchar
uchar *const out1_1__currentResult__9 = (uchar*) (Core0+384);  // Cost_Parallel_Work_0_Broadcast5_9_out1_1 > Cost_Parallel_Work_0_disparitySelect_10_currentResult size:= 120*uchar
uchar *const result__in__25 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_10_result > Cost_Parallel_Work_0_Broadcast5_10_in size:= 120*uchar
uchar *const out1_1__currentResult__10 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_10_out1_1 > Cost_Parallel_Work_0_disparitySelect_11_currentResult size:= 120*uchar
uchar *const result__in__26 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_disparitySelect_18_result > Cost_Parallel_Work_0_Broadcast5_18_in size:= 120*uchar
uchar *const out1_1_1__currentResult__0 = (uchar*) (Core0+128);  // Cost_Parallel_Work_0_Broadcast5_18_out1_1_1 > Cost_Parallel_Work_1_disparitySelect_0_currentResult size:= 120*uchar
uchar *const result__in__27 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_0_result > Cost_Parallel_Work_1_Broadcast5_0_in size:= 120*uchar
uchar *const out1_1__currentResult__11 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_0_out1_1 > Cost_Parallel_Work_1_disparitySelect_1_currentResult size:= 120*uchar
uchar *const result__in__28 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_1_result > Cost_Parallel_Work_1_Broadcast5_1_in size:= 120*uchar
uchar *const out1_1__currentResult__12 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_1_out1_1 > Cost_Parallel_Work_1_disparitySelect_2_currentResult size:= 120*uchar
uchar *const result__in__29 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_2_result > Cost_Parallel_Work_1_Broadcast5_2_in size:= 120*uchar
uchar *const out1_1__currentResult__13 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_2_out1_1 > Cost_Parallel_Work_1_disparitySelect_3_currentResult size:= 120*uchar
uchar *const result__in__30 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_3_result > Cost_Parallel_Work_1_Broadcast5_3_in size:= 120*uchar
uchar *const out1_1__currentResult__14 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_3_out1_1 > Cost_Parallel_Work_1_disparitySelect_4_currentResult size:= 120*uchar
uchar *const result__in__31 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_4_result > Cost_Parallel_Work_1_Broadcast5_4_in size:= 120*uchar
uchar *const out1_1__currentResult__15 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_4_out1_1 > Cost_Parallel_Work_1_disparitySelect_5_currentResult size:= 120*uchar
uchar *const result__in__32 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_5_result > Cost_Parallel_Work_1_Broadcast5_5_in size:= 120*uchar
uchar *const out1_1__currentResult__16 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_5_out1_1 > Cost_Parallel_Work_1_disparitySelect_6_currentResult size:= 120*uchar
uchar *const result__in__33 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_6_result > Cost_Parallel_Work_1_Broadcast5_6_in size:= 120*uchar
uchar *const out1_1__currentResult__17 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_6_out1_1 > Cost_Parallel_Work_1_disparitySelect_7_currentResult size:= 120*uchar
uchar *const result__in__34 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_7_result > Cost_Parallel_Work_1_Broadcast5_7_in size:= 120*uchar
uchar *const out1_1__currentResult__18 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_7_out1_1 > Cost_Parallel_Work_1_disparitySelect_8_currentResult size:= 120*uchar
uchar *const result__in__35 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_8_result > Cost_Parallel_Work_1_Broadcast5_8_in size:= 120*uchar
uchar *const out1_1__currentResult__19 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_8_out1_1 > Cost_Parallel_Work_1_disparitySelect_9_currentResult size:= 120*uchar
uchar *const result__in__36 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_9_result > Cost_Parallel_Work_1_Broadcast5_9_in size:= 120*uchar
uchar *const out1_1__currentResult__20 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_9_out1_1 > Cost_Parallel_Work_1_disparitySelect_10_currentResult size:= 120*uchar
uchar *const result__in__37 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_disparitySelect_10_result > Cost_Parallel_Work_1_Broadcast5_10_in size:= 120*uchar
uchar *const out1_1__currentResult__21 = (uchar*) (Core0+384);  // Cost_Parallel_Work_1_Broadcast5_10_out1_1 > Cost_Parallel_Work_1_disparitySelect_11_currentResult size:= 120*uchar
uchar *const result__in__38 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_disparitySelect_18_result > Cost_Parallel_Work_1_Broadcast5_18_in size:= 120*uchar
uchar *const out1_1_1__currentResult__1 = (uchar*) (Core0+128);  // Cost_Parallel_Work_1_Broadcast5_18_out1_1_1 > Cost_Parallel_Work_2_disparitySelect_0_currentResult size:= 120*uchar
uchar *const result__in__39 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_0_result > Cost_Parallel_Work_2_Broadcast5_0_in size:= 120*uchar
uchar *const out1_1__currentResult__22 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_0_out1_1 > Cost_Parallel_Work_2_disparitySelect_1_currentResult size:= 120*uchar
uchar *const result__in__40 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_1_result > Cost_Parallel_Work_2_Broadcast5_1_in size:= 120*uchar
uchar *const out1_1__currentResult__23 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_1_out1_1 > Cost_Parallel_Work_2_disparitySelect_2_currentResult size:= 120*uchar
uchar *const result__in__41 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_2_result > Cost_Parallel_Work_2_Broadcast5_2_in size:= 120*uchar
uchar *const out1_1__currentResult__24 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_2_out1_1 > Cost_Parallel_Work_2_disparitySelect_3_currentResult size:= 120*uchar
uchar *const result__in__42 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_3_result > Cost_Parallel_Work_2_Broadcast5_3_in size:= 120*uchar
uchar *const out1_1__currentResult__25 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_3_out1_1 > Cost_Parallel_Work_2_disparitySelect_4_currentResult size:= 120*uchar
uchar *const result__in__43 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_4_result > Cost_Parallel_Work_2_Broadcast5_4_in size:= 120*uchar
uchar *const out1_1__currentResult__26 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_4_out1_1 > Cost_Parallel_Work_2_disparitySelect_5_currentResult size:= 120*uchar
uchar *const result__in__44 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_5_result > Cost_Parallel_Work_2_Broadcast5_5_in size:= 120*uchar
uchar *const out1_1__currentResult__27 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_5_out1_1 > Cost_Parallel_Work_2_disparitySelect_6_currentResult size:= 120*uchar
uchar *const result__in__45 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_6_result > Cost_Parallel_Work_2_Broadcast5_6_in size:= 120*uchar
uchar *const out1_1__currentResult__28 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_6_out1_1 > Cost_Parallel_Work_2_disparitySelect_7_currentResult size:= 120*uchar
uchar *const result__in__46 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_7_result > Cost_Parallel_Work_2_Broadcast5_7_in size:= 120*uchar
uchar *const out1_1__currentResult__29 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_7_out1_1 > Cost_Parallel_Work_2_disparitySelect_8_currentResult size:= 120*uchar
uchar *const result__in__47 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_8_result > Cost_Parallel_Work_2_Broadcast5_8_in size:= 120*uchar
uchar *const out1_1__currentResult__30 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_8_out1_1 > Cost_Parallel_Work_2_disparitySelect_9_currentResult size:= 120*uchar
uchar *const result__in__48 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_9_result > Cost_Parallel_Work_2_Broadcast5_9_in size:= 120*uchar
uchar *const out1_1__currentResult__31 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_9_out1_1 > Cost_Parallel_Work_2_disparitySelect_10_currentResult size:= 120*uchar
uchar *const result__in__49 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_10_result > Cost_Parallel_Work_2_Broadcast5_10_in size:= 120*uchar
uchar *const out1_1__currentResult__32 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_10_out1_1 > Cost_Parallel_Work_2_disparitySelect_11_currentResult size:= 120*uchar
uchar *const result__in__50 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_11_result > Cost_Parallel_Work_2_Broadcast5_11_in size:= 120*uchar
uchar *const out1_1__currentResult__33 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_11_out1_1 > Cost_Parallel_Work_2_disparitySelect_12_currentResult size:= 120*uchar
uchar *const result__in__51 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_12_result > Cost_Parallel_Work_2_Broadcast5_12_in size:= 120*uchar
uchar *const out1_1__currentResult__34 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_12_out1_1 > Cost_Parallel_Work_2_disparitySelect_13_currentResult size:= 120*uchar
uchar *const result__in__52 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_13_result > Cost_Parallel_Work_2_Broadcast5_13_in size:= 120*uchar
uchar *const out1_1__currentResult__35 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_13_out1_1 > Cost_Parallel_Work_2_disparitySelect_14_currentResult size:= 120*uchar
uchar *const result__in__53 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_14_result > Cost_Parallel_Work_2_Broadcast5_14_in size:= 120*uchar
uchar *const out1_1__currentResult__36 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_14_out1_1 > Cost_Parallel_Work_2_disparitySelect_15_currentResult size:= 120*uchar
uchar *const result__in__54 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_15_result > Cost_Parallel_Work_2_Broadcast5_15_in size:= 120*uchar
uchar *const out1_1__currentResult__37 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_15_out1_1 > Cost_Parallel_Work_2_disparitySelect_16_currentResult size:= 120*uchar
uchar *const result__in__55 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_disparitySelect_16_result > Cost_Parallel_Work_2_Broadcast5_16_in size:= 120*uchar
uchar *const out1_1__currentResult__38 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_16_out1_1 > Cost_Parallel_Work_2_disparitySelect_17_currentResult size:= 120*uchar
uchar *const result__in__56 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_disparitySelect_17_result > Cost_Parallel_Work_2_Broadcast5_17_in size:= 120*uchar
uchar *const out1_1__currentResult__39 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_17_out1_1 > Cost_Parallel_Work_2_disparitySelect_18_currentResult size:= 120*uchar
uchar *const rawDisparity__input__2 = (uchar*) (Core0+128);  // RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity > Split_2_input size:= 120*uchar
uchar *const out0_0__rawDisparity_18_18__2 = (uchar*) (Core0+128);  // Cost_Parallel_Work_2_Broadcast5_18_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_18_18 size:= 120*uchar
uchar *const out1_1__currentResult__40 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_11_out1_1 > Cost_Parallel_Work_0_disparitySelect_12_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__41 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_12_out1_1 > Cost_Parallel_Work_0_disparitySelect_13_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__42 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_13_out1_1 > Cost_Parallel_Work_0_disparitySelect_14_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__43 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_14_out1_1 > Cost_Parallel_Work_0_disparitySelect_15_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__44 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_15_out1_1 > Cost_Parallel_Work_0_disparitySelect_16_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__45 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_16_out1_1 > Cost_Parallel_Work_0_disparitySelect_17_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__46 = (uchar*) (Core0+0);  // Cost_Parallel_Work_0_Broadcast5_17_out1_1 > Cost_Parallel_Work_0_disparitySelect_18_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__47 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_11_out1_1 > Cost_Parallel_Work_1_disparitySelect_12_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__48 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_12_out1_1 > Cost_Parallel_Work_1_disparitySelect_13_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__49 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_13_out1_1 > Cost_Parallel_Work_1_disparitySelect_14_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__50 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_14_out1_1 > Cost_Parallel_Work_1_disparitySelect_15_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__51 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_15_out1_1 > Cost_Parallel_Work_1_disparitySelect_16_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__52 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_16_out1_1 > Cost_Parallel_Work_1_disparitySelect_17_currentResult size:= 120*uchar
uchar *const out1_1__currentResult__53 = (uchar*) (Core0+0);  // Cost_Parallel_Work_1_Broadcast5_17_out1_1 > Cost_Parallel_Work_1_disparitySelect_18_currentResult size:= 120*uchar
uchar *const out0_0__rawDisparity_0_18__2 = (uchar*) (Core0+0);  // Cost_Parallel_Work_2_Broadcast5_0_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_0_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_1_18__2 = (uchar*) (Core0+256);  // Cost_Parallel_Work_2_Broadcast5_1_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_1_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_2_18__2 = (uchar*) (Core0+512);  // Cost_Parallel_Work_2_Broadcast5_2_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_2_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_3_18__2 = (uchar*) (Core0+640);  // Cost_Parallel_Work_2_Broadcast5_3_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_3_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_4_18__2 = (uchar*) (Core0+768);  // Cost_Parallel_Work_2_Broadcast5_4_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_4_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_5_18__2 = (uchar*) (Core0+896);  // Cost_Parallel_Work_2_Broadcast5_5_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_5_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_6_18__2 = (uchar*) (Core0+1024);  // Cost_Parallel_Work_2_Broadcast5_6_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_6_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_7_18__2 = (uchar*) (Core0+1152);  // Cost_Parallel_Work_2_Broadcast5_7_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_7_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_8_18__2 = (uchar*) (Core0+1280);  // Cost_Parallel_Work_2_Broadcast5_8_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_8_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_9_18__2 = (uchar*) (Core0+1408);  // Cost_Parallel_Work_2_Broadcast5_9_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_9_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_10_18__2 = (uchar*) (Core0+1536);  // Cost_Parallel_Work_2_Broadcast5_10_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_10_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_11_18__2 = (uchar*) (Core0+1664);  // Cost_Parallel_Work_2_Broadcast5_11_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_11_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_12_18__2 = (uchar*) (Core0+1792);  // Cost_Parallel_Work_2_Broadcast5_12_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_12_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_13_18__2 = (uchar*) (Core0+1920);  // Cost_Parallel_Work_2_Broadcast5_13_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_13_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_14_18__2 = (uchar*) (Core0+2048);  // Cost_Parallel_Work_2_Broadcast5_14_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_14_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_15_18__2 = (uchar*) (Core0+2176);  // Cost_Parallel_Work_2_Broadcast5_15_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_15_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_16_18__2 = (uchar*) (Core0+2304);  // Cost_Parallel_Work_2_Broadcast5_16_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_16_18 size:= 120*uchar
uchar *const out0_0__rawDisparity_17_18__2 = (uchar*) (Core0+384);  // Cost_Parallel_Work_2_Broadcast5_17_out0_0 > RB_Cost_Parallel_Work_2__rawDisparity_rawDisparity_17_18 size:= 120*uchar
uchar *const filteredDisparity__in_6__3 = (uchar*) (Core0+0);  // Median_Filter_26_filteredDisparity > implode_lum2RGB_2_in_in_6 size:= 12*uchar

//********** Core1 global definitions *****************
char Core1[480]; //  size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__13 = (char*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_1 > Cost_Parallel_Work_0_AggregateCost_1 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__14 = (char*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_9 > Cost_Parallel_Work_0_AggregateCost_9 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__15 = (char*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_11 > Cost_Parallel_Work_0_AggregateCost_11 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__16 = (char*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_13 > Cost_Parallel_Work_0_AggregateCost_13 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__17 = (char*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_15 > Cost_Parallel_Work_0_AggregateCost_15 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__18 = (char*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_17 > Cost_Parallel_Work_0_AggregateCost_17 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__9 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_0 > Cost_Parallel_Work_1_AggregateCost_0 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__10 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_2 > Cost_Parallel_Work_1_AggregateCost_2 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__11 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_4 > Cost_Parallel_Work_1_AggregateCost_4 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__12 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_6 > Cost_Parallel_Work_1_AggregateCost_6 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__13 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_8 > Cost_Parallel_Work_1_AggregateCost_8 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__14 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_10 > Cost_Parallel_Work_1_AggregateCost_10 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__15 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_12 > Cost_Parallel_Work_1_AggregateCost_12 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__16 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_14 > Cost_Parallel_Work_1_AggregateCost_14 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__17 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_16 > Cost_Parallel_Work_1_AggregateCost_16 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__18 = (char*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_18 > Cost_Parallel_Work_1_AggregateCost_18 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__10 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_1 > Cost_Parallel_Work_2_AggregateCost_1 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__11 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_3 > Cost_Parallel_Work_2_AggregateCost_3 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__12 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_5 > Cost_Parallel_Work_2_AggregateCost_5 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__13 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_7 > Cost_Parallel_Work_2_AggregateCost_7 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__14 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_9 > Cost_Parallel_Work_2_AggregateCost_9 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__15 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_11 > Cost_Parallel_Work_2_AggregateCost_11 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__16 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_13 > Cost_Parallel_Work_2_AggregateCost_13 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__17 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_15 > Cost_Parallel_Work_2_AggregateCost_15 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__18 = (char*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_17 > Cost_Parallel_Work_2_AggregateCost_17 size:= 480*char
char *const Median_Filter_31__implode_lu__0 = (char*) (Core1+0);  // Median_Filter_31 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_35__implode_lu__0 = (char*) (Core1+64);  // Median_Filter_35 > implode_lum2RGB_3_in size:= 12*char
char *const Median_Filter_39__implode_lu__0 = (char*) (Core1+128);  // Median_Filter_39 > implode_lum2RGB_3_in size:= 12*char
float *const disparityError__disparityErr__32 = (float*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_1_disparityError > Cost_Parallel_Work_0_AggregateCost_1_disparityError size:= 120*float
float *const disparityError__disparityErr__33 = (float*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_9_disparityError > Cost_Parallel_Work_0_AggregateCost_9_disparityError size:= 120*float
float *const disparityError__disparityErr__34 = (float*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_11_disparityError > Cost_Parallel_Work_0_AggregateCost_11_disparityError size:= 120*float
float *const disparityError__disparityErr__35 = (float*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_13_disparityError > Cost_Parallel_Work_0_AggregateCost_13_disparityError size:= 120*float
float *const disparityError__disparityErr__36 = (float*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_15_disparityError > Cost_Parallel_Work_0_AggregateCost_15_disparityError size:= 120*float
float *const disparityError__disparityErr__37 = (float*) (Core1+0);  // Cost_Parallel_Work_0_CostConstruction_17_disparityError > Cost_Parallel_Work_0_AggregateCost_17_disparityError size:= 120*float
float *const disparityError__disparityErr__38 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_0_disparityError > Cost_Parallel_Work_1_AggregateCost_0_disparityError size:= 120*float
float *const disparityError__disparityErr__39 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_2_disparityError > Cost_Parallel_Work_1_AggregateCost_2_disparityError size:= 120*float
float *const disparityError__disparityErr__40 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_4_disparityError > Cost_Parallel_Work_1_AggregateCost_4_disparityError size:= 120*float
float *const disparityError__disparityErr__41 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_6_disparityError > Cost_Parallel_Work_1_AggregateCost_6_disparityError size:= 120*float
float *const disparityError__disparityErr__42 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_8_disparityError > Cost_Parallel_Work_1_AggregateCost_8_disparityError size:= 120*float
float *const disparityError__disparityErr__43 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_10_disparityError > Cost_Parallel_Work_1_AggregateCost_10_disparityError size:= 120*float
float *const disparityError__disparityErr__44 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_12_disparityError > Cost_Parallel_Work_1_AggregateCost_12_disparityError size:= 120*float
float *const disparityError__disparityErr__45 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_14_disparityError > Cost_Parallel_Work_1_AggregateCost_14_disparityError size:= 120*float
float *const disparityError__disparityErr__46 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_16_disparityError > Cost_Parallel_Work_1_AggregateCost_16_disparityError size:= 120*float
float *const disparityError__disparityErr__47 = (float*) (Core1+0);  // Cost_Parallel_Work_1_CostConstruction_18_disparityError > Cost_Parallel_Work_1_AggregateCost_18_disparityError size:= 120*float
float *const disparityError__disparityErr__48 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_1_disparityError > Cost_Parallel_Work_2_AggregateCost_1_disparityError size:= 120*float
float *const disparityError__disparityErr__49 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_3_disparityError > Cost_Parallel_Work_2_AggregateCost_3_disparityError size:= 120*float
float *const disparityError__disparityErr__50 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_5_disparityError > Cost_Parallel_Work_2_AggregateCost_5_disparityError size:= 120*float
float *const disparityError__disparityErr__51 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_7_disparityError > Cost_Parallel_Work_2_AggregateCost_7_disparityError size:= 120*float
float *const disparityError__disparityErr__52 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_9_disparityError > Cost_Parallel_Work_2_AggregateCost_9_disparityError size:= 120*float
float *const disparityError__disparityErr__53 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_11_disparityError > Cost_Parallel_Work_2_AggregateCost_11_disparityError size:= 120*float
float *const disparityError__disparityErr__54 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_13_disparityError > Cost_Parallel_Work_2_AggregateCost_13_disparityError size:= 120*float
float *const disparityError__disparityErr__55 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_15_disparityError > Cost_Parallel_Work_2_AggregateCost_15_disparityError size:= 120*float
float *const disparityError__disparityErr__56 = (float*) (Core1+0);  // Cost_Parallel_Work_2_CostConstruction_17_disparityError > Cost_Parallel_Work_2_AggregateCost_17_disparityError size:= 120*float
uchar *const filteredDisparity__in_1__3 = (uchar*) (Core1+0);  // Median_Filter_31_filteredDisparity > implode_lum2RGB_3_in_in_1 size:= 12*uchar
uchar *const filteredDisparity__in_5__3 = (uchar*) (Core1+64);  // Median_Filter_35_filteredDisparity > implode_lum2RGB_3_in_in_5 size:= 12*uchar
uchar *const filteredDisparity__in_9__3 = (uchar*) (Core1+128);  // Median_Filter_39_filteredDisparity > implode_lum2RGB_3_in_in_9 size:= 12*uchar

//********** Core2 global definitions *****************
char Core2[1089]; //  size:= 1089*char
char *const Cost_Parallel_Work_0_CostCon__6 = (char*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_2 > Cost_Parallel_Work_0_AggregateCost_2 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__7 = (char*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_10 > Cost_Parallel_Work_0_AggregateCost_10 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__8 = (char*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_12 > Cost_Parallel_Work_0_AggregateCost_12 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__9 = (char*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_14 > Cost_Parallel_Work_0_AggregateCost_14 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__10 = (char*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_16 > Cost_Parallel_Work_0_AggregateCost_16 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__11 = (char*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_18 > Cost_Parallel_Work_0_AggregateCost_18 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__0 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_1 > Cost_Parallel_Work_1_AggregateCost_1 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__1 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_3 > Cost_Parallel_Work_1_AggregateCost_3 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__2 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_5 > Cost_Parallel_Work_1_AggregateCost_5 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__3 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_7 > Cost_Parallel_Work_1_AggregateCost_7 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__4 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_9 > Cost_Parallel_Work_1_AggregateCost_9 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__5 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_11 > Cost_Parallel_Work_1_AggregateCost_11 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__6 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_13 > Cost_Parallel_Work_1_AggregateCost_13 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__7 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_15 > Cost_Parallel_Work_1_AggregateCost_15 size:= 480*char
char *const Cost_Parallel_Work_1_CostCon__8 = (char*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_17 > Cost_Parallel_Work_1_AggregateCost_17 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__0 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_0 > Cost_Parallel_Work_2_AggregateCost_0 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__1 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_2 > Cost_Parallel_Work_2_AggregateCost_2 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__2 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_4 > Cost_Parallel_Work_2_AggregateCost_4 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__3 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_6 > Cost_Parallel_Work_2_AggregateCost_6 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__4 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_8 > Cost_Parallel_Work_2_AggregateCost_8 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__5 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_10 > Cost_Parallel_Work_2_AggregateCost_10 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__6 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_12 > Cost_Parallel_Work_2_AggregateCost_12 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__7 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_14 > Cost_Parallel_Work_2_AggregateCost_14 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__8 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_16 > Cost_Parallel_Work_2_AggregateCost_16 size:= 480*char
char *const Cost_Parallel_Work_2_CostCon__9 = (char*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_18 > Cost_Parallel_Work_2_AggregateCost_18 size:= 480*char
char *const Cost_Parallel_Work_0_Broadca__145 = (char*) (Core2+512);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_2 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__146 = (char*) (Core2+576);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_4 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__147 = (char*) (Core2+640);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_7 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__148 = (char*) (Core2+704);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_10 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__149 = (char*) (Core2+768);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_12 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__150 = (char*) (Core2+832);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_14 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__151 = (char*) (Core2+896);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_16 size:= 20*char
char *const Cost_Parallel_Work_0_Broadca__152 = (char*) (Core2+960);  // Cost_Parallel_Work_0_Broadcast0_0 > Cost_Parallel_Work_0_AggregateCost_18 size:= 20*char
char *const Cost_Parallel_Work_0_explode__6 = (char*) (Core2+1024);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_2 size:= 1*char
char *const Cost_Parallel_Work_0_explode__7 = (char*) (Core2+1088);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back > Cost_Parallel_Work_0_CostConstruction_6 size:= 1*char
float *const disparityError__disparityErr__6 = (float*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_2_disparityError > Cost_Parallel_Work_0_AggregateCost_2_disparityError size:= 120*float
float *const disparityError__disparityErr__7 = (float*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_10_disparityError > Cost_Parallel_Work_0_AggregateCost_10_disparityError size:= 120*float
float *const disparityError__disparityErr__8 = (float*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_12_disparityError > Cost_Parallel_Work_0_AggregateCost_12_disparityError size:= 120*float
float *const disparityError__disparityErr__9 = (float*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_14_disparityError > Cost_Parallel_Work_0_AggregateCost_14_disparityError size:= 120*float
float *const disparityError__disparityErr__10 = (float*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_16_disparityError > Cost_Parallel_Work_0_AggregateCost_16_disparityError size:= 120*float
float *const disparityError__disparityErr__11 = (float*) (Core2+0);  // Cost_Parallel_Work_0_CostConstruction_18_disparityError > Cost_Parallel_Work_0_AggregateCost_18_disparityError size:= 120*float
float *const disparityError__disparityErr__12 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_1_disparityError > Cost_Parallel_Work_1_AggregateCost_1_disparityError size:= 120*float
float *const disparityError__disparityErr__13 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_3_disparityError > Cost_Parallel_Work_1_AggregateCost_3_disparityError size:= 120*float
float *const disparityError__disparityErr__14 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_5_disparityError > Cost_Parallel_Work_1_AggregateCost_5_disparityError size:= 120*float
float *const disparityError__disparityErr__15 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_7_disparityError > Cost_Parallel_Work_1_AggregateCost_7_disparityError size:= 120*float
float *const disparityError__disparityErr__16 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_9_disparityError > Cost_Parallel_Work_1_AggregateCost_9_disparityError size:= 120*float
float *const disparityError__disparityErr__17 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_11_disparityError > Cost_Parallel_Work_1_AggregateCost_11_disparityError size:= 120*float
float *const disparityError__disparityErr__18 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_13_disparityError > Cost_Parallel_Work_1_AggregateCost_13_disparityError size:= 120*float
float *const disparityError__disparityErr__19 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_15_disparityError > Cost_Parallel_Work_1_AggregateCost_15_disparityError size:= 120*float
float *const disparityError__disparityErr__20 = (float*) (Core2+0);  // Cost_Parallel_Work_1_CostConstruction_17_disparityError > Cost_Parallel_Work_1_AggregateCost_17_disparityError size:= 120*float
float *const disparityError__disparityErr__21 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_0_disparityError > Cost_Parallel_Work_2_AggregateCost_0_disparityError size:= 120*float
float *const disparityError__disparityErr__22 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_2_disparityError > Cost_Parallel_Work_2_AggregateCost_2_disparityError size:= 120*float
float *const disparityError__disparityErr__23 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_4_disparityError > Cost_Parallel_Work_2_AggregateCost_4_disparityError size:= 120*float
float *const disparityError__disparityErr__24 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_6_disparityError > Cost_Parallel_Work_2_AggregateCost_6_disparityError size:= 120*float
float *const disparityError__disparityErr__25 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_8_disparityError > Cost_Parallel_Work_2_AggregateCost_8_disparityError size:= 120*float
float *const disparityError__disparityErr__26 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_10_disparityError > Cost_Parallel_Work_2_AggregateCost_10_disparityError size:= 120*float
float *const disparityError__disparityErr__27 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_12_disparityError > Cost_Parallel_Work_2_AggregateCost_12_disparityError size:= 120*float
float *const disparityError__disparityErr__28 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_14_disparityError > Cost_Parallel_Work_2_AggregateCost_14_disparityError size:= 120*float
float *const disparityError__disparityErr__29 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_16_disparityError > Cost_Parallel_Work_2_AggregateCost_16_disparityError size:= 120*float
float *const disparityError__disparityErr__30 = (float*) (Core2+0);  // Cost_Parallel_Work_2_CostConstruction_18_disparityError > Cost_Parallel_Work_2_AggregateCost_18_disparityError size:= 120*float
int *const out0_2_18__offsets__2 = (int*) (Core2+512);  // Cost_Parallel_Work_0_Broadcast0_0_out0_2_18 > Cost_Parallel_Work_0_AggregateCost_2_offsets size:= 5*int
int *const out0_4_18__offsets__2 = (int*) (Core2+576);  // Cost_Parallel_Work_0_Broadcast0_0_out0_4_18 > Cost_Parallel_Work_0_AggregateCost_4_offsets size:= 5*int
int *const out0_7_18__offsets__2 = (int*) (Core2+640);  // Cost_Parallel_Work_0_Broadcast0_0_out0_7_18 > Cost_Parallel_Work_0_AggregateCost_7_offsets size:= 5*int
int *const out0_10_18__offsets__2 = (int*) (Core2+704);  // Cost_Parallel_Work_0_Broadcast0_0_out0_10_18 > Cost_Parallel_Work_0_AggregateCost_10_offsets size:= 5*int
int *const out0_12_18__offsets__2 = (int*) (Core2+768);  // Cost_Parallel_Work_0_Broadcast0_0_out0_12_18 > Cost_Parallel_Work_0_AggregateCost_12_offsets size:= 5*int
int *const out0_14_18__offsets__2 = (int*) (Core2+832);  // Cost_Parallel_Work_0_Broadcast0_0_out0_14_18 > Cost_Parallel_Work_0_AggregateCost_14_offsets size:= 5*int
int *const out0_16_18__offsets__2 = (int*) (Core2+896);  // Cost_Parallel_Work_0_Broadcast0_0_out0_16_18 > Cost_Parallel_Work_0_AggregateCost_16_offsets size:= 5*int
int *const out0_18_18__offsets__2 = (int*) (Core2+960);  // Cost_Parallel_Work_0_Broadcast0_0_out0_18_18 > Cost_Parallel_Work_0_AggregateCost_18_offsets size:= 5*int
uchar *const back_2__back__33 = (uchar*) (Core2+1024);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_2 > Cost_Parallel_Work_0_CostConstruction_2_back size:= 1*uchar
uchar *const back_6__back__0 = (uchar*) (Core2+1088);  // Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back_back_6 > Cost_Parallel_Work_0_CostConstruction_6_back size:= 1*uchar

//********** Core3 global definitions *****************
char Core3[11968]; //  size:= 11968*char
char *const Cost_Parallel_Work_1_Compute__6 = (char*) (Core3+0);  // Cost_Parallel_Work_1_ComputeVertWeights_1 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__7 = (char*) (Core3+1472);  // Cost_Parallel_Work_1_ComputeHorWeights_1 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__8 = (char*) (Core3+2944);  // Cost_Parallel_Work_1_ComputeVertWeights_3 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_1_Compute__9 = (char*) (Core3+4416);  // Cost_Parallel_Work_1_ComputeHorWeights_3 > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__6 = (char*) (Core3+5888);  // Cost_Parallel_Work_2_ComputeVertWeights_1 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__7 = (char*) (Core3+7360);  // Cost_Parallel_Work_2_ComputeHorWeights_1 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__8 = (char*) (Core3+8832);  // Cost_Parallel_Work_2_ComputeVertWeights_3 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in size:= 1440*char
char *const Cost_Parallel_Work_2_Compute__9 = (char*) (Core3+10304);  // Cost_Parallel_Work_2_ComputeHorWeights_3 > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in size:= 1440*char
char *const Cost_Parallel_Work_0_CostCon__4 = (char*) (Core3+0);  // Cost_Parallel_Work_0_CostConstruction_3 > Cost_Parallel_Work_0_AggregateCost_3 size:= 480*char
char *const Cost_Parallel_Work_0_CostCon__5 = (char*) (Core3+0);  // Cost_Parallel_Work_0_CostConstruction_8 > Cost_Parallel_Work_0_AggregateCost_8 size:= 480*char
char *const implode_lum2RGB_1_in__lum2RG__0 = (char*) (Core3+128);  // implode_lum2RGB_1_in > lum2RGB_1 size:= 120*char
char *const lum2RGB_1__Display_RGB1_1__0 = (char*) (Core3+128);  // lum2RGB_1 > Display_RGB1_1 size:= 120*char
char *const lum2RGB_1__Write_PPM_1__0 = (char*) (Core3+128);  // lum2RGB_1 > Write_PPM_1 size:= 120*char
char *const Median_Filter_10__implode_lu__0 = (char*) (Core3+128);  // Median_Filter_10 > implode_lum2RGB_1_in size:= 12*char
char *const Cost_Parallel_Work_1_OffsetG__0 = (char*) (Core3+6016);  // Cost_Parallel_Work_1_OffsetGen_0 > Cost_Parallel_Work_1_Broadcast0_0 size:= 20*char
char *const Cost_Parallel_Work_1_Broadca__143 = (char*) (Core3+6016);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeVertWeights_0 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__144 = (char*) (Core3+6020);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeVertWeights_1 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__145 = (char*) (Core3+6024);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeVertWeights_2 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__146 = (char*) (Core3+6028);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeVertWeights_3 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__147 = (char*) (Core3+6032);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeVertWeights_4 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__148 = (char*) (Core3+6016);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeHorWeights_0 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__149 = (char*) (Core3+6020);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeHorWeights_1 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__150 = (char*) (Core3+6024);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeHorWeights_2 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__151 = (char*) (Core3+6028);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeHorWeights_3 size:= 4*char
char *const Cost_Parallel_Work_1_Broadca__152 = (char*) (Core3+6032);  // Cost_Parallel_Work_1_Broadcast0_0 > Cost_Parallel_Work_1_ComputeHorWeights_4 size:= 4*char
char *const Cost_Parallel_Work_2_OffsetG__0 = (char*) (Core3+11904);  // Cost_Parallel_Work_2_OffsetGen_0 > Cost_Parallel_Work_2_Broadcast0_0 size:= 20*char
char *const Cost_Parallel_Work_2_Broadca__125 = (char*) (Core3+11904);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeVertWeights_0 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__126 = (char*) (Core3+11908);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeVertWeights_1 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__127 = (char*) (Core3+11912);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeVertWeights_2 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__128 = (char*) (Core3+11916);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeVertWeights_3 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__129 = (char*) (Core3+11920);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeVertWeights_4 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__130 = (char*) (Core3+11904);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeHorWeights_0 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__131 = (char*) (Core3+11908);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeHorWeights_1 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__132 = (char*) (Core3+11912);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeHorWeights_2 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__133 = (char*) (Core3+11916);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeHorWeights_3 size:= 4*char
char *const Cost_Parallel_Work_2_Broadca__134 = (char*) (Core3+11920);  // Cost_Parallel_Work_2_Broadcast0_0 > Cost_Parallel_Work_2_ComputeHorWeights_4 size:= 4*char
char *const implode_Median_Filter_13_raw__0 = (char*) (Core3+0);  // implode_Median_Filter_13_rawDisparity > Median_Filter_13 size:= 36*char
char *const explode_Split_1_output__impl__1 = (char*) (Core3+12);  // explode_Split_1_output > implode_Median_Filter_13_rawDisparity size:= 24*char
char *const Median_Filter_1__implode_lum__0 = (char*) (Core3+0);  // Median_Filter_1 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_2__implode_lum__0 = (char*) (Core3+64);  // Median_Filter_2 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_9__implode_lum__0 = (char*) (Core3+192);  // Median_Filter_9 > implode_lum2RGB_0_in size:= 12*char
char *const Median_Filter_11__implode_lu__0 = (char*) (Core3+256);  // Median_Filter_11 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_12__implode_lu__0 = (char*) (Core3+320);  // Median_Filter_12 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_14__implode_lu__0 = (char*) (Core3+64);  // Median_Filter_14 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_15__implode_lu__0 = (char*) (Core3+384);  // Median_Filter_15 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_16__implode_lu__0 = (char*) (Core3+448);  // Median_Filter_16 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_17__implode_lu__0 = (char*) (Core3+512);  // Median_Filter_17 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_18__implode_lu__0 = (char*) (Core3+576);  // Median_Filter_18 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_19__implode_lu__0 = (char*) (Core3+640);  // Median_Filter_19 > implode_lum2RGB_1_in size:= 12*char
char *const Median_Filter_13__implode_lu__0 = (char*) (Core3+704);  // Median_Filter_13 > implode_lum2RGB_1_in size:= 12*char
float *const weights__in_1__2 = (float*) (Core3+0);  // Cost_Parallel_Work_1_ComputeVertWeights_1_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in_in_1 size:= 360*float
float *const weights__in_1__3 = (float*) (Core3+1472);  // Cost_Parallel_Work_1_ComputeHorWeights_1_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in_in_1 size:= 360*float
float *const weights__in_3__2 = (float*) (Core3+2944);  // Cost_Parallel_Work_1_ComputeVertWeights_3_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in_in_3 size:= 360*float
float *const weights__in_3__3 = (float*) (Core3+4416);  // Cost_Parallel_Work_1_ComputeHorWeights_3_weights > Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in_in_3 size:= 360*float
float *const weights__in_1__4 = (float*) (Core3+5888);  // Cost_Parallel_Work_2_ComputeVertWeights_1_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in_in_1 size:= 360*float
float *const weights__in_1__5 = (float*) (Core3+7360);  // Cost_Parallel_Work_2_ComputeHorWeights_1_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in_in_1 size:= 360*float
float *const weights__in_3__4 = (float*) (Core3+8832);  // Cost_Parallel_Work_2_ComputeVertWeights_3_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in_in_3 size:= 360*float
float *const weights__in_3__5 = (float*) (Core3+10304);  // Cost_Parallel_Work_2_ComputeHorWeights_3_weights > Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in_in_3 size:= 360*float
float *const disparityError__disparityErr__4 = (float*) (Core3+0);  // Cost_Parallel_Work_0_CostConstruction_3_disparityError > Cost_Parallel_Work_0_AggregateCost_3_disparityError size:= 120*float
float *const disparityError__disparityErr__5 = (float*) (Core3+0);  // Cost_Parallel_Work_0_CostConstruction_8_disparityError > Cost_Parallel_Work_0_AggregateCost_8_disparityError size:= 120*float
uchar *const filteredDisparity__in__3 = (uchar*) (Core3+128);  // implode_lum2RGB_1_in_filteredDisparity > lum2RGB_1_in size:= 120*uchar
uchar *const out0_0__lum__3 = (uchar*) (Core3+128);  // lum2RGB_1_out0_0 > Display_RGB1_1_lum size:= 120*uchar
uchar *const out1_1__gray__3 = (uchar*) (Core3+128);  // lum2RGB_1_out1_1 > Write_PPM_1_gray size:= 120*uchar
uchar *const filteredDisparity__in_0__3 = (uchar*) (Core3+128);  // Median_Filter_10_filteredDisparity > implode_lum2RGB_1_in_in_0 size:= 12*uchar
int *const offsets__in__1 = (int*) (Core3+6016);  // Cost_Parallel_Work_1_OffsetGen_0_offsets > Cost_Parallel_Work_1_Broadcast0_0_in size:= 5*int
int *const out1_0_22__offset__1 = (int*) (Core3+6016);  // Cost_Parallel_Work_1_Broadcast0_0_out1_0_22 > Cost_Parallel_Work_1_ComputeVertWeights_0_offset size:= 1*int
int *const out1_1_22__offset__1 = (int*) (Core3+6020);  // Cost_Parallel_Work_1_Broadcast0_0_out1_1_22 > Cost_Parallel_Work_1_ComputeVertWeights_1_offset size:= 1*int
int *const out1_2_22__offset__1 = (int*) (Core3+6024);  // Cost_Parallel_Work_1_Broadcast0_0_out1_2_22 > Cost_Parallel_Work_1_ComputeVertWeights_2_offset size:= 1*int
int *const out1_3_22__offset__1 = (int*) (Core3+6028);  // Cost_Parallel_Work_1_Broadcast0_0_out1_3_22 > Cost_Parallel_Work_1_ComputeVertWeights_3_offset size:= 1*int
int *const out1_4_22__offset__1 = (int*) (Core3+6032);  // Cost_Parallel_Work_1_Broadcast0_0_out1_4_22 > Cost_Parallel_Work_1_ComputeVertWeights_4_offset size:= 1*int
int *const out2_0_26__offset__1 = (int*) (Core3+6016);  // Cost_Parallel_Work_1_Broadcast0_0_out2_0_26 > Cost_Parallel_Work_1_ComputeHorWeights_0_offset size:= 1*int
int *const out2_1_26__offset__1 = (int*) (Core3+6020);  // Cost_Parallel_Work_1_Broadcast0_0_out2_1_26 > Cost_Parallel_Work_1_ComputeHorWeights_1_offset size:= 1*int
int *const out2_2_26__offset__1 = (int*) (Core3+6024);  // Cost_Parallel_Work_1_Broadcast0_0_out2_2_26 > Cost_Parallel_Work_1_ComputeHorWeights_2_offset size:= 1*int
int *const out2_3_26__offset__1 = (int*) (Core3+6028);  // Cost_Parallel_Work_1_Broadcast0_0_out2_3_26 > Cost_Parallel_Work_1_ComputeHorWeights_3_offset size:= 1*int
int *const out2_4_26__offset__1 = (int*) (Core3+6032);  // Cost_Parallel_Work_1_Broadcast0_0_out2_4_26 > Cost_Parallel_Work_1_ComputeHorWeights_4_offset size:= 1*int
int *const offsets__in__2 = (int*) (Core3+11904);  // Cost_Parallel_Work_2_OffsetGen_0_offsets > Cost_Parallel_Work_2_Broadcast0_0_in size:= 5*int
int *const out1_0_22__offset__2 = (int*) (Core3+11904);  // Cost_Parallel_Work_2_Broadcast0_0_out1_0_22 > Cost_Parallel_Work_2_ComputeVertWeights_0_offset size:= 1*int
int *const out1_1_22__offset__2 = (int*) (Core3+11908);  // Cost_Parallel_Work_2_Broadcast0_0_out1_1_22 > Cost_Parallel_Work_2_ComputeVertWeights_1_offset size:= 1*int
int *const out1_2_22__offset__2 = (int*) (Core3+11912);  // Cost_Parallel_Work_2_Broadcast0_0_out1_2_22 > Cost_Parallel_Work_2_ComputeVertWeights_2_offset size:= 1*int
int *const out1_3_22__offset__2 = (int*) (Core3+11916);  // Cost_Parallel_Work_2_Broadcast0_0_out1_3_22 > Cost_Parallel_Work_2_ComputeVertWeights_3_offset size:= 1*int
int *const out1_4_22__offset__2 = (int*) (Core3+11920);  // Cost_Parallel_Work_2_Broadcast0_0_out1_4_22 > Cost_Parallel_Work_2_ComputeVertWeights_4_offset size:= 1*int
int *const out2_0_26__offset__2 = (int*) (Core3+11904);  // Cost_Parallel_Work_2_Broadcast0_0_out2_0_26 > Cost_Parallel_Work_2_ComputeHorWeights_0_offset size:= 1*int
int *const out2_1_26__offset__2 = (int*) (Core3+11908);  // Cost_Parallel_Work_2_Broadcast0_0_out2_1_26 > Cost_Parallel_Work_2_ComputeHorWeights_1_offset size:= 1*int
int *const out2_2_26__offset__2 = (int*) (Core3+11912);  // Cost_Parallel_Work_2_Broadcast0_0_out2_2_26 > Cost_Parallel_Work_2_ComputeHorWeights_2_offset size:= 1*int
int *const out2_3_26__offset__2 = (int*) (Core3+11916);  // Cost_Parallel_Work_2_Broadcast0_0_out2_3_26 > Cost_Parallel_Work_2_ComputeHorWeights_3_offset size:= 1*int
int *const out2_4_26__offset__2 = (int*) (Core3+11920);  // Cost_Parallel_Work_2_Broadcast0_0_out2_4_26 > Cost_Parallel_Work_2_ComputeHorWeights_4_offset size:= 1*int
uchar *const output__rawDisparity__4 = (uchar*) (Core3+0);  // implode_Median_Filter_13_rawDisparity_output > Median_Filter_13_rawDisparity size:= 36*uchar
uchar *const output_0__rawDisparity_1__1 = (uchar*) (Core3+12);  // explode_Split_1_output_output_0 > implode_Median_Filter_13_rawDisparity_rawDisparity_1 size:= 24*uchar
uchar *const filteredDisparity__in_1__1 = (uchar*) (Core3+0);  // Median_Filter_1_filteredDisparity > implode_lum2RGB_0_in_in_1 size:= 12*uchar
uchar *const filteredDisparity__in_2__2 = (uchar*) (Core3+64);  // Median_Filter_2_filteredDisparity > implode_lum2RGB_0_in_in_2 size:= 12*uchar
uchar *const filteredDisparity__in_9__1 = (uchar*) (Core3+192);  // Median_Filter_9_filteredDisparity > implode_lum2RGB_0_in_in_9 size:= 12*uchar
uchar *const filteredDisparity__in_1__2 = (uchar*) (Core3+256);  // Median_Filter_11_filteredDisparity > implode_lum2RGB_1_in_in_1 size:= 12*uchar
uchar *const filteredDisparity__in_2__3 = (uchar*) (Core3+320);  // Median_Filter_12_filteredDisparity > implode_lum2RGB_1_in_in_2 size:= 12*uchar
uchar *const filteredDisparity__in_4__3 = (uchar*) (Core3+64);  // Median_Filter_14_filteredDisparity > implode_lum2RGB_1_in_in_4 size:= 12*uchar
uchar *const filteredDisparity__in_5__2 = (uchar*) (Core3+384);  // Median_Filter_15_filteredDisparity > implode_lum2RGB_1_in_in_5 size:= 12*uchar
uchar *const filteredDisparity__in_6__2 = (uchar*) (Core3+448);  // Median_Filter_16_filteredDisparity > implode_lum2RGB_1_in_in_6 size:= 12*uchar
uchar *const filteredDisparity__in_7__3 = (uchar*) (Core3+512);  // Median_Filter_17_filteredDisparity > implode_lum2RGB_1_in_in_7 size:= 12*uchar
uchar *const filteredDisparity__in_8__3 = (uchar*) (Core3+576);  // Median_Filter_18_filteredDisparity > implode_lum2RGB_1_in_in_8 size:= 12*uchar
uchar *const filteredDisparity__in_9__2 = (uchar*) (Core3+640);  // Median_Filter_19_filteredDisparity > implode_lum2RGB_1_in_in_9 size:= 12*uchar
uchar *const filteredDisparity__in_3__3 = (uchar*) (Core3+704);  // Median_Filter_13_filteredDisparity > implode_lum2RGB_1_in_in_3 size:= 12*uchar




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	readPPMInit(0/*id*/,10/*height*/,12/*width*/); // Read_PPM0_0
	readPPMInit(0/*id*/,10/*height*/,12/*width*/); // Read_PPM0_1
	readPPMInit(0/*id*/,10/*height*/,12/*width*/); // Read_PPM0_2
	readPPMInit(1/*id*/,10/*height*/,12/*width*/); // Read_PPM1_0
	readPPMInit(1/*id*/,10/*height*/,12/*width*/); // Read_PPM1_1
	readPPMInit(1/*id*/,10/*height*/,12/*width*/); // Read_PPM1_2

	// Begin the execution loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
        printf("Chegou barrier\n");
		barrier_wait(&iter_barrier);
        printf("Passou barrier\n");
		readPPM(0/*id*/,10/*height*/,12/*width*/,rgb__in__0); // Read_PPM0_0
		readPPM(0/*id*/,10/*height*/,12/*width*/,rgb__in__1); // Read_PPM0_1
		sendStart(0, 3); // Core0 > Core3: Read_PPM0_1__Broadcast0_1__0
		sendEnd(); // Core0 > Core3: Read_PPM0_1__Broadcast0_1__0
		readPPM(0/*id*/,10/*height*/,12/*width*/,rgb__in__2); // Read_PPM0_2
		sendStart(0, 3); // Core0 > Core3: Read_PPM0_2__Broadcast0_2__0
		sendEnd(); // Core0 > Core3: Read_PPM0_2__Broadcast0_2__0
		readPPM(1/*id*/,10/*height*/,12/*width*/,rgb__rgb__2); // Read_PPM1_0
		sendStart(0, 1); // Core0 > Core1: Read_PPM1_0__RGB2Gray_R_0__0
		sendEnd(); // Core0 > Core1: Read_PPM1_0__RGB2Gray_R_0__0
		readPPM(1/*id*/,10/*height*/,12/*width*/,rgb__rgb__0); // Read_PPM1_1
		sendStart(0, 3); // Core0 > Core3: Read_PPM1_1__RGB2Gray_R_1__0
		sendEnd(); // Core0 > Core3: Read_PPM1_1__RGB2Gray_R_1__0
		readPPM(1/*id*/,10/*height*/,12/*width*/,rgb__rgb__1); // Read_PPM1_2
		sendStart(0, 3); // Core0 > Core3: Read_PPM1_2__RGB2Gray_R_2__0
		sendEnd(); // Core0 > Core3: Read_PPM1_2__RGB2Gray_R_2__0
		// Broadcast Broadcast0_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(0, 3); // Core0 > Core3: Broadcast0_0__Display_rgb0_0__0
		sendEnd(); // Core0 > Core3: Broadcast0_0__Display_rgb0_0__0
		sendStart(0, 2); // Core0 > Core2: Broadcast0_0__BR_Cost_Parall__0
		sendEnd(); // Core0 > Core2: Broadcast0_0__BR_Cost_Parall__0
		rgb2Gray(120/*size*/,out1_2__rgb__0,gray__in__2); // RGB2Gray_L_0
        printf("rgb2Gray\n");
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_init_in_d__0
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_init_in_d__0
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_init_in_d__1
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_init_in_d__1
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_explode__0
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_explode__0
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__58
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__58
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__115
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__115
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__64
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__64
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__67
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__67
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__86
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__86
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__87
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__87
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__88
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__88
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__89
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__89
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__90
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__90
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__91
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__91
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__92
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__92
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__93
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__93
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__94
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__94
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__66
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__66
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__95
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__95
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__96
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__96
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__97
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__97
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__98
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__98
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__99
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__99
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__100
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__100
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__101
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__101
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__102
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__102
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__103
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__103
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__42
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__42
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__45
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__45
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_3_26__offset__0,out1_1__rgbL__3,weights__in_3__1); // Cost_Parallel_Work_0_ComputeHorWeights_3
		printf("computeWeights\n");
        sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Compute__9
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Compute__9
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_2_22__offset__0,out0_0__rgbL__2,weights__in_2__4); // Cost_Parallel_Work_0_ComputeVertWeights_2
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Compute__1
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Compute__1
		// Broadcast broadcast1_0
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(0, 2); // Core0 > Core2: broadcast1_0__BR_Cost_Parall__0
		sendEnd(); // Core0 > Core2: broadcast1_0__BR_Cost_Parall__0
		census(10/*height*/,12/*width*/,out0_0__gray__2,cen__cenL__0); // Census_L_0
		printf("census\n");
        // Broadcast BR_Cost_Parallel_Work_0__cenL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__2
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__2
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__3
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__3
		sendStart(0, 3); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__4
		sendEnd(); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__4
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__5
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__5
		sendStart(0, 3); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__6
		sendEnd(); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__6
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__7
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__7
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__8
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__8
		sendStart(0, 3); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__9
		sendEnd(); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__9
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__0
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__0
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__10
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__10
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__11
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__11
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__12
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__12
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__13
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__13
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__14
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__14
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__15
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__15
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__16
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__16
		sendStart(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__17
		sendEnd(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__17
		sendStart(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__18
		sendEnd(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__18
		receiveStart(); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__20
		receiveEnd(2, 0); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__20
		receiveStart(); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__1
		receiveEnd(2, 0); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__1
		receiveStart(); // Core1 > Core0: BR_Cost_Parallel_Work_0__cen__20
		receiveEnd(1, 0); // Core1 > Core0: BR_Cost_Parallel_Work_0__cen__20
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_0_18__disparity__0,grayL_0_18__grayL__0,grayR_0_18__grayR__2,cenL_0_18__cenL__0,cenR_0_18__cenR__0,disparityError__disparityErr__31,back_0__back__0); // Cost_Parallel_Work_0_CostConstruction_0
		printf("costConstruction\n");
        receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__76
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__76
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__77
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__77
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__78
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__78
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__79
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__79
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__80
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__80
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__81
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__81
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__82
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__82
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__83
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__83
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__84
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__84
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__56
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__56
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__85
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__85
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__86
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__86
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__87
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__87
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__88
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__88
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__89
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__89
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__90
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__90
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__91
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__91
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__92
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__92
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__93
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__93
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__76
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__76
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__77
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__77
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__78
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__78
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__79
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__79
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__80
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__80
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__81
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__81
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__82
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__82
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__83
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__83
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__84
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__84
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__56
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__56
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__85
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__85
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__86
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__86
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__87
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__87
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__88
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__88
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__89
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__89
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__90
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__90
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__91
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__91
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__92
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__92
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__93
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__93
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_0_Broadca__0
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Broadca__0
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__19
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__19
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__31,out0_0_18__offsets__0,out_0_18__hWeights__2,out_0_18__vWeights__2,aggregatedDisparity__aggrega__56); // Cost_Parallel_Work_0_AggregateCost_0
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_0_36__disparity__0,aggregatedDisparity__aggrega__56,bestCostFeed__bestCostFeed__0,currentResult__currentResult__0,result__in__15,backBestCost__bestCostFeed__1); // Cost_Parallel_Work_0_disparitySelect_0
        printf("disparitySelect\n");
        // Broadcast Cost_Parallel_Work_0_Broadcast5_0
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__0+0, result__in__15+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_0_18__0+0, result__in__15+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_0_18__0+119, result__in__15+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__126
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__126
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__104
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__104
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__3
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__3
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_1_36__disparity__0,aggregatedDisparity__aggrega__3,backBestCost__bestCostFeed__1,out1_1__currentResult__0,result__in__16,backBestCost__bestCostFeed__2); // Cost_Parallel_Work_0_disparitySelect_1
		// Broadcast Cost_Parallel_Work_0_Broadcast5_1
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__1+0, result__in__16+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_1_18__0+0, result__in__16+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_1_18__0+119, result__in__16+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__127
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__127
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__105
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__105
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__0
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__0
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_2_36__disparity__0,aggregatedDisparity__aggrega__0,backBestCost__bestCostFeed__2,out1_1__currentResult__1,result__in__17,backBestCost__bestCostFeed__3); // Cost_Parallel_Work_0_disparitySelect_2
		// Broadcast Cost_Parallel_Work_0_Broadcast5_2
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__2+0, result__in__17+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_2_18__0+0, result__in__17+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_2_18__0+119, result__in__17+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__128
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__128
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__106
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__106
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__4
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__4
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_3_36__disparity__0,aggregatedDisparity__aggrega__4,backBestCost__bestCostFeed__3,out1_1__currentResult__2,result__in__18,backBestCost__bestCostFeed__4); // Cost_Parallel_Work_0_disparitySelect_3
		// Broadcast Cost_Parallel_Work_0_Broadcast5_3
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__3+0, result__in__18+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_3_18__0+0, result__in__18+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_3_18__0+119, result__in__18+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__129
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__129
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__107
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__107
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__1
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__1
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_4_36__disparity__0,aggregatedDisparity__aggrega__1,backBestCost__bestCostFeed__4,out1_1__currentResult__3,result__in__19,backBestCost__bestCostFeed__5); // Cost_Parallel_Work_0_disparitySelect_4
		// Broadcast Cost_Parallel_Work_0_Broadcast5_4
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__4+0, result__in__19+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_4_18__0+0, result__in__19+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_4_18__0+119, result__in__19+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__130
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__130
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__108
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__108
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__5
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__5
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_5_36__disparity__0,aggregatedDisparity__aggrega__5,backBestCost__bestCostFeed__5,out1_1__currentResult__4,result__in__20,backBestCost__bestCostFeed__6); // Cost_Parallel_Work_0_disparitySelect_5
		// Broadcast Cost_Parallel_Work_0_Broadcast5_5
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__5+0, result__in__20+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_5_18__0+0, result__in__20+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_5_18__0+119, result__in__20+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__131
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__131
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__109
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__109
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__6
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__6
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_6_36__disparity__0,aggregatedDisparity__aggrega__6,backBestCost__bestCostFeed__6,out1_1__currentResult__5,result__in__21,backBestCost__bestCostFeed__7); // Cost_Parallel_Work_0_disparitySelect_6
		// Broadcast Cost_Parallel_Work_0_Broadcast5_6
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__6+0, result__in__21+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_6_18__0+0, result__in__21+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_6_18__0+119, result__in__21+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__132
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__132
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__110
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__110
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__2
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__2
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_7_36__disparity__0,aggregatedDisparity__aggrega__2,backBestCost__bestCostFeed__7,out1_1__currentResult__6,result__in__22,backBestCost__bestCostFeed__8); // Cost_Parallel_Work_0_disparitySelect_7
		// Broadcast Cost_Parallel_Work_0_Broadcast5_7
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__7+0, result__in__22+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_7_18__0+0, result__in__22+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_7_18__0+119, result__in__22+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__133
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__133
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__111
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__111
		receiveStart(); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__7
		receiveEnd(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__7
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_8_36__disparity__0,aggregatedDisparity__aggrega__7,backBestCost__bestCostFeed__8,out1_1__currentResult__7,result__in__23,backBestCost__bestCostFeed__9); // Cost_Parallel_Work_0_disparitySelect_8
		// Broadcast Cost_Parallel_Work_0_Broadcast5_8
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__8+0, result__in__23+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_8_18__0+0, result__in__23+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_8_18__0+119, result__in__23+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__134
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__134
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__112
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__112
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__8
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__8
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_9_36__disparity__0,aggregatedDisparity__aggrega__8,backBestCost__bestCostFeed__9,out1_1__currentResult__8,result__in__24,backBestCost__bestCostFeed__10); // Cost_Parallel_Work_0_disparitySelect_9
		// Broadcast Cost_Parallel_Work_0_Broadcast5_9
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__9+0, result__in__24+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_9_18__0+0, result__in__24+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_9_18__0+119, result__in__24+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__135
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__135
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__113
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__113
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__9
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__9
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_10_36__disparity__0,aggregatedDisparity__aggrega__9,backBestCost__bestCostFeed__10,out1_1__currentResult__9,result__in__25,backBestCost__bestCostFeed__11); // Cost_Parallel_Work_0_disparitySelect_10
		printf("disparitySelect 2\n");
        // Broadcast Cost_Parallel_Work_0_Broadcast5_10
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__10+0, result__in__25+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_10_18__0+0, result__in__25+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_10_18__0+119, result__in__25+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__136
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__136
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__114
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__114
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__10
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__10
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_11_36__disparity__0,aggregatedDisparity__aggrega__10,backBestCost__bestCostFeed__11,out1_1__currentResult__10,result__in__0,backBestCost__bestCostFeed__12); // Cost_Parallel_Work_0_disparitySelect_11
		// Broadcast Cost_Parallel_Work_0_Broadcast5_11
		{
			// memcpy #0
			memcpy(out1_1__currentResult__40+0, result__in__0+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__0+0, result__in__0+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__48
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__48
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__137
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__137
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__11
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__11
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_12_36__disparity__0,aggregatedDisparity__aggrega__11,backBestCost__bestCostFeed__12,out1_1__currentResult__40,result__in__1,backBestCost__bestCostFeed__13); // Cost_Parallel_Work_0_disparitySelect_12
		// Broadcast Cost_Parallel_Work_0_Broadcast5_12
		{
			// memcpy #0
			memcpy(out1_1__currentResult__41+0, result__in__1+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__1+0, result__in__1+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__49
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__49
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__138
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__138
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__12
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__12
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_13_36__disparity__0,aggregatedDisparity__aggrega__12,backBestCost__bestCostFeed__13,out1_1__currentResult__41,result__in__2,backBestCost__bestCostFeed__14); // Cost_Parallel_Work_0_disparitySelect_13
		// Broadcast Cost_Parallel_Work_0_Broadcast5_13
		{
			// memcpy #0
			memcpy(out1_1__currentResult__42+0, result__in__2+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__2+0, result__in__2+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__50
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__50
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__139
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__139
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__13
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__13
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_14_36__disparity__0,aggregatedDisparity__aggrega__13,backBestCost__bestCostFeed__14,out1_1__currentResult__42,result__in__3,backBestCost__bestCostFeed__15); // Cost_Parallel_Work_0_disparitySelect_14
		// Broadcast Cost_Parallel_Work_0_Broadcast5_14
		{
			// memcpy #0
			memcpy(out1_1__currentResult__43+0, result__in__3+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__3+0, result__in__3+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__51
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__51
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__140
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__140
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__14
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__14
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_15_36__disparity__0,aggregatedDisparity__aggrega__14,backBestCost__bestCostFeed__15,out1_1__currentResult__43,result__in__4,backBestCost__bestCostFeed__16); // Cost_Parallel_Work_0_disparitySelect_15
		// Broadcast Cost_Parallel_Work_0_Broadcast5_15
		{
			// memcpy #0
			memcpy(out1_1__currentResult__44+0, result__in__4+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__4+0, result__in__4+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__52
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__52
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__141
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__141
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__15
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__15
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_16_36__disparity__0,aggregatedDisparity__aggrega__15,backBestCost__bestCostFeed__16,out1_1__currentResult__44,result__in__5,backBestCost__bestCostFeed__17); // Cost_Parallel_Work_0_disparitySelect_16
		// Broadcast Cost_Parallel_Work_0_Broadcast5_16
		{
			// memcpy #0
			memcpy(out1_1__currentResult__45+0, result__in__5+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__5+0, result__in__5+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__53
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__53
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__142
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__142
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__16
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__16
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_17_36__disparity__0,aggregatedDisparity__aggrega__16,backBestCost__bestCostFeed__17,out1_1__currentResult__45,result__in__6,backBestCost__bestCostFeed__18); // Cost_Parallel_Work_0_disparitySelect_17
		// Broadcast Cost_Parallel_Work_0_Broadcast5_17
		{
			// memcpy #0
			memcpy(out1_1__currentResult__46+0, result__in__6+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__6+0, result__in__6+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__54
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__54
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__143
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__143
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__17
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__17
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_18_36__disparity__0,aggregatedDisparity__aggrega__17,backBestCost__bestCostFeed__18,out1_1__currentResult__46,result__in__26,backBestCost__bestCostFeed__19); // Cost_Parallel_Work_0_disparitySelect_18
		// Broadcast Cost_Parallel_Work_0_Broadcast5_18
		{
			// memcpy #0
			memcpy(out0_0__rawDisparity_18_18__0+0, result__in__26+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__7+0, result__in__26+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__55
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__55
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__144
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__144
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__0
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__0
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_0_36__disparity__1,aggregatedDisparity__aggrega__18,backBestCost__bestCostFeed__19,out1_1_1__currentResult__0,result__in__27,backBestCost__bestCostFeed__20); // Cost_Parallel_Work_1_disparitySelect_0
		// Broadcast Cost_Parallel_Work_1_Broadcast5_0
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__11+0, result__in__27+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_0_18__1+0, result__in__27+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_0_18__1+119, result__in__27+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__124
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__124
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__94
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__94
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__1
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__1
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_1_36__disparity__1,aggregatedDisparity__aggrega__19,backBestCost__bestCostFeed__20,out1_1__currentResult__11,result__in__28,backBestCost__bestCostFeed__21); // Cost_Parallel_Work_1_disparitySelect_1
		printf("disparitySelect 3\n");
        // Broadcast Cost_Parallel_Work_1_Broadcast5_1
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__12+0, result__in__28+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_1_18__1+0, result__in__28+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_1_18__1+119, result__in__28+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__125
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__125
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__95
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__95
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__2
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__2
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_2_36__disparity__1,aggregatedDisparity__aggrega__20,backBestCost__bestCostFeed__21,out1_1__currentResult__12,result__in__29,backBestCost__bestCostFeed__22); // Cost_Parallel_Work_1_disparitySelect_2
		// Broadcast Cost_Parallel_Work_1_Broadcast5_2
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__13+0, result__in__29+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_2_18__1+0, result__in__29+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_2_18__1+119, result__in__29+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__126
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__126
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__96
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__96
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__3
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__3
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_3_36__disparity__1,aggregatedDisparity__aggrega__21,backBestCost__bestCostFeed__22,out1_1__currentResult__13,result__in__30,backBestCost__bestCostFeed__23); // Cost_Parallel_Work_1_disparitySelect_3
		// Broadcast Cost_Parallel_Work_1_Broadcast5_3
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__14+0, result__in__30+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_3_18__1+0, result__in__30+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_3_18__1+119, result__in__30+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__127
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__127
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__97
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__97
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__4
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__4
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_4_36__disparity__1,aggregatedDisparity__aggrega__22,backBestCost__bestCostFeed__23,out1_1__currentResult__14,result__in__31,backBestCost__bestCostFeed__24); // Cost_Parallel_Work_1_disparitySelect_4
		// Broadcast Cost_Parallel_Work_1_Broadcast5_4
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__15+0, result__in__31+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_4_18__1+0, result__in__31+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_4_18__1+119, result__in__31+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__128
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__128
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__98
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__98
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__5
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__5
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_5_36__disparity__1,aggregatedDisparity__aggrega__23,backBestCost__bestCostFeed__24,out1_1__currentResult__15,result__in__32,backBestCost__bestCostFeed__25); // Cost_Parallel_Work_1_disparitySelect_5
		// Broadcast Cost_Parallel_Work_1_Broadcast5_5
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__16+0, result__in__32+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_5_18__1+0, result__in__32+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_5_18__1+119, result__in__32+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__129
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__129
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__99
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__99
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__6
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__6
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_6_36__disparity__1,aggregatedDisparity__aggrega__24,backBestCost__bestCostFeed__25,out1_1__currentResult__16,result__in__33,backBestCost__bestCostFeed__26); // Cost_Parallel_Work_1_disparitySelect_6
		printf("disparitySelect 4\n");
        // Broadcast Cost_Parallel_Work_1_Broadcast5_6
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__17+0, result__in__33+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_6_18__1+0, result__in__33+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_6_18__1+119, result__in__33+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__130
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__130
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__100
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__100
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__7
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__7
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_7_36__disparity__1,aggregatedDisparity__aggrega__25,backBestCost__bestCostFeed__26,out1_1__currentResult__17,result__in__34,backBestCost__bestCostFeed__27); // Cost_Parallel_Work_1_disparitySelect_7
		// Broadcast Cost_Parallel_Work_1_Broadcast5_7
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__18+0, result__in__34+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_7_18__1+0, result__in__34+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_7_18__1+119, result__in__34+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__131
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__131
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__101
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__101
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__8
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__8
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_8_36__disparity__1,aggregatedDisparity__aggrega__26,backBestCost__bestCostFeed__27,out1_1__currentResult__18,result__in__35,backBestCost__bestCostFeed__0); // Cost_Parallel_Work_1_disparitySelect_8
		// Broadcast Cost_Parallel_Work_1_Broadcast5_8
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__19+0, result__in__35+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_8_18__1+0, result__in__35+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_8_18__1+119, result__in__35+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__132
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__132
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__102
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__102
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__9
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__9
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_9_36__disparity__1,aggregatedDisparity__aggrega__27,backBestCost__bestCostFeed__0,out1_1__currentResult__19,result__in__36,backBestCost__bestCostFeed__28); // Cost_Parallel_Work_1_disparitySelect_9
		// Broadcast Cost_Parallel_Work_1_Broadcast5_9
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__20+0, result__in__36+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_9_18__1+0, result__in__36+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_9_18__1+119, result__in__36+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__133
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__133
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__103
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__103
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__10
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__10
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_10_36__disparity__1,aggregatedDisparity__aggrega__28,backBestCost__bestCostFeed__28,out1_1__currentResult__20,result__in__37,backBestCost__bestCostFeed__29); // Cost_Parallel_Work_1_disparitySelect_10
		// Broadcast Cost_Parallel_Work_1_Broadcast5_10
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__21+0, result__in__37+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_10_18__1+0, result__in__37+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_10_18__1+119, result__in__37+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__134
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__134
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__104
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__104
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__11
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__11
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_11_36__disparity__1,aggregatedDisparity__aggrega__29,backBestCost__bestCostFeed__29,out1_1__currentResult__21,result__in__7,backBestCost__bestCostFeed__30); // Cost_Parallel_Work_1_disparitySelect_11
		// Broadcast Cost_Parallel_Work_1_Broadcast5_11
		{
			// memcpy #0
			memcpy(out1_1__currentResult__47+0, result__in__7+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__8+0, result__in__7+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__48
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__48
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__135
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__135
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__12
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__12
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_12_36__disparity__1,aggregatedDisparity__aggrega__30,backBestCost__bestCostFeed__30,out1_1__currentResult__47,result__in__8,backBestCost__bestCostFeed__31); // Cost_Parallel_Work_1_disparitySelect_12
        printf("disparitySelect 5\n");
        // Broadcast Cost_Parallel_Work_1_Broadcast5_12
		{
			// memcpy #0
			memcpy(out1_1__currentResult__48+0, result__in__8+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__9+0, result__in__8+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__49
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__49
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__136
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__136
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__13
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__13
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_13_36__disparity__1,aggregatedDisparity__aggrega__31,backBestCost__bestCostFeed__31,out1_1__currentResult__48,result__in__9,backBestCost__bestCostFeed__32); // Cost_Parallel_Work_1_disparitySelect_13
		// Broadcast Cost_Parallel_Work_1_Broadcast5_13
		{
			// memcpy #0
			memcpy(out1_1__currentResult__49+0, result__in__9+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__10+0, result__in__9+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__50
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__50
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__137
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__137
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__14
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__14
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_14_36__disparity__1,aggregatedDisparity__aggrega__32,backBestCost__bestCostFeed__32,out1_1__currentResult__49,result__in__10,backBestCost__bestCostFeed__33); // Cost_Parallel_Work_1_disparitySelect_14
		// Broadcast Cost_Parallel_Work_1_Broadcast5_14
		{
			// memcpy #0
			memcpy(out1_1__currentResult__50+0, result__in__10+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__11+0, result__in__10+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__51
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__51
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__138
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__138
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__15
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__15
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_15_36__disparity__1,aggregatedDisparity__aggrega__33,backBestCost__bestCostFeed__33,out1_1__currentResult__50,result__in__11,backBestCost__bestCostFeed__34); // Cost_Parallel_Work_1_disparitySelect_15
		// Broadcast Cost_Parallel_Work_1_Broadcast5_15
		{
			// memcpy #0
			memcpy(out1_1__currentResult__51+0, result__in__11+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__12+0, result__in__11+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__52
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__52
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__139
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__139
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__16
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__16
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_16_36__disparity__1,aggregatedDisparity__aggrega__34,backBestCost__bestCostFeed__34,out1_1__currentResult__51,result__in__12,backBestCost__bestCostFeed__35); // Cost_Parallel_Work_1_disparitySelect_16
		// Broadcast Cost_Parallel_Work_1_Broadcast5_16
		{
			// memcpy #0
			memcpy(out1_1__currentResult__52+0, result__in__12+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__13+0, result__in__12+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__53
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__53
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__140
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__140
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__17
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__17
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_17_36__disparity__1,aggregatedDisparity__aggrega__35,backBestCost__bestCostFeed__35,out1_1__currentResult__52,result__in__13,backBestCost__bestCostFeed__36); // Cost_Parallel_Work_1_disparitySelect_17
		// Broadcast Cost_Parallel_Work_1_Broadcast5_17
		{
			// memcpy #0
			memcpy(out1_1__currentResult__53+0, result__in__13+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__14+0, result__in__13+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__54
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__54
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__141
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__141
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__18
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__18
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_18_36__disparity__1,aggregatedDisparity__aggrega__36,backBestCost__bestCostFeed__36,out1_1__currentResult__53,result__in__38,backBestCost__bestCostFeed__37); // Cost_Parallel_Work_1_disparitySelect_18
		// Broadcast Cost_Parallel_Work_1_Broadcast5_18
		{
			// memcpy #0
			memcpy(out0_0__rawDisparity_18_18__1+0, result__in__38+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(back_2_2__back__15+0, result__in__38+0, 1*sizeof(uchar));
		}
		sendStart(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__55
		sendEnd(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__55
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__142
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__142
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__0
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__0
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_0_36__disparity__2,aggregatedDisparity__aggrega__37,backBestCost__bestCostFeed__37,out1_1_1__currentResult__1,result__in__39,backBestCost__bestCostFeed__38); // Cost_Parallel_Work_2_disparitySelect_0
		// Broadcast Cost_Parallel_Work_2_Broadcast5_0
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__22+0, result__in__39+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_0_18__2+0, result__in__39+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_0_18__2+119, result__in__39+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__114
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__114
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__1
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__1
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_1_36__disparity__2,aggregatedDisparity__aggrega__38,backBestCost__bestCostFeed__38,out1_1__currentResult__22,result__in__40,backBestCost__bestCostFeed__39); // Cost_Parallel_Work_2_disparitySelect_1
		printf("disparitySelect 6\n");
        // Broadcast Cost_Parallel_Work_2_Broadcast5_1
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__23+0, result__in__40+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_1_18__2+0, result__in__40+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_1_18__2+119, result__in__40+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__115
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__115
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__2
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__2
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_2_36__disparity__2,aggregatedDisparity__aggrega__39,backBestCost__bestCostFeed__39,out1_1__currentResult__23,result__in__41,backBestCost__bestCostFeed__40); // Cost_Parallel_Work_2_disparitySelect_2
		// Broadcast Cost_Parallel_Work_2_Broadcast5_2
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__24+0, result__in__41+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_2_18__2+0, result__in__41+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_2_18__2+119, result__in__41+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__116
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__116
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__3
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__3
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_3_36__disparity__2,aggregatedDisparity__aggrega__40,backBestCost__bestCostFeed__40,out1_1__currentResult__24,result__in__42,backBestCost__bestCostFeed__41); // Cost_Parallel_Work_2_disparitySelect_3
		// Broadcast Cost_Parallel_Work_2_Broadcast5_3
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__25+0, result__in__42+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_3_18__2+0, result__in__42+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_3_18__2+119, result__in__42+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__117
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__117
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__4
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__4
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_4_36__disparity__2,aggregatedDisparity__aggrega__41,backBestCost__bestCostFeed__41,out1_1__currentResult__25,result__in__43,backBestCost__bestCostFeed__42); // Cost_Parallel_Work_2_disparitySelect_4
		// Broadcast Cost_Parallel_Work_2_Broadcast5_4
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__26+0, result__in__43+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_4_18__2+0, result__in__43+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_4_18__2+119, result__in__43+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__118
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__118
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__5
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__5
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_5_36__disparity__2,aggregatedDisparity__aggrega__42,backBestCost__bestCostFeed__42,out1_1__currentResult__26,result__in__44,backBestCost__bestCostFeed__43); // Cost_Parallel_Work_2_disparitySelect_5
		// Broadcast Cost_Parallel_Work_2_Broadcast5_5
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__27+0, result__in__44+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_5_18__2+0, result__in__44+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_5_18__2+119, result__in__44+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__119
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__119
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__6
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__6
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_6_36__disparity__2,aggregatedDisparity__aggrega__43,backBestCost__bestCostFeed__43,out1_1__currentResult__27,result__in__45,backBestCost__bestCostFeed__44); // Cost_Parallel_Work_2_disparitySelect_6
		// Broadcast Cost_Parallel_Work_2_Broadcast5_6
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__28+0, result__in__45+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_6_18__2+0, result__in__45+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_6_18__2+119, result__in__45+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__120
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__120
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__7
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__7
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_7_36__disparity__2,aggregatedDisparity__aggrega__44,backBestCost__bestCostFeed__44,out1_1__currentResult__28,result__in__46,backBestCost__bestCostFeed__45); // Cost_Parallel_Work_2_disparitySelect_7
		// Broadcast Cost_Parallel_Work_2_Broadcast5_7
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__29+0, result__in__46+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_7_18__2+0, result__in__46+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_7_18__2+119, result__in__46+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__121
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__121
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__8
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__8
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_8_36__disparity__2,aggregatedDisparity__aggrega__45,backBestCost__bestCostFeed__45,out1_1__currentResult__29,result__in__47,backBestCost__bestCostFeed__46); // Cost_Parallel_Work_2_disparitySelect_8
		// Broadcast Cost_Parallel_Work_2_Broadcast5_8
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__30+0, result__in__47+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_8_18__2+0, result__in__47+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_8_18__2+119, result__in__47+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__122
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__122
		receiveStart(); // Core1 > Core0: Median_Filter_24__implode_lu__0
		receiveEnd(1, 0); // Core1 > Core0: Median_Filter_24__implode_lu__0
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__9
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__9
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_9_36__disparity__2,aggregatedDisparity__aggrega__46,backBestCost__bestCostFeed__46,out1_1__currentResult__30,result__in__48,backBestCost__bestCostFeed__47); // Cost_Parallel_Work_2_disparitySelect_9
		printf("disparitySelect 7\n");
        // Broadcast Cost_Parallel_Work_2_Broadcast5_9
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__31+0, result__in__48+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_9_18__2+0, result__in__48+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_9_18__2+119, result__in__48+0, 1*sizeof(uchar));
		}
		sendStart(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__123
		sendEnd(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__123
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__10
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__10
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_10_36__disparity__2,aggregatedDisparity__aggrega__47,backBestCost__bestCostFeed__47,out1_1__currentResult__31,result__in__49,backBestCost__bestCostFeed__48); // Cost_Parallel_Work_2_disparitySelect_10
		// Broadcast Cost_Parallel_Work_2_Broadcast5_10
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back__32+0, result__in__49+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_10_18__2+0, result__in__49+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_10_18__2+119, result__in__49+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__124
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__124
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__11
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__11
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_11_36__disparity__2,aggregatedDisparity__aggrega__48,backBestCost__bestCostFeed__48,out1_1__currentResult__32,result__in__50,backBestCost__bestCostFeed__49); // Cost_Parallel_Work_2_disparitySelect_11
		// Broadcast Cost_Parallel_Work_2_Broadcast5_11
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_0__0+0, result__in__50+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_11_18__2+0, result__in__50+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_11_18__2+119, result__in__50+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__49
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__49
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__12
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__12
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_12_36__disparity__2,aggregatedDisparity__aggrega__49,backBestCost__bestCostFeed__49,out1_1__currentResult__33,result__in__51,backBestCost__bestCostFeed__50); // Cost_Parallel_Work_2_disparitySelect_12
		// Broadcast Cost_Parallel_Work_2_Broadcast5_12
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_1__0+0, result__in__51+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_12_18__2+0, result__in__51+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_12_18__2+119, result__in__51+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__50
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__50
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__13
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__13
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_13_36__disparity__2,aggregatedDisparity__aggrega__50,backBestCost__bestCostFeed__50,out1_1__currentResult__34,result__in__52,backBestCost__bestCostFeed__51); // Cost_Parallel_Work_2_disparitySelect_13
		// Broadcast Cost_Parallel_Work_2_Broadcast5_13
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_2__0+0, result__in__52+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_13_18__2+0, result__in__52+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_13_18__2+119, result__in__52+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__51
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__51
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__14
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__14
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_14_36__disparity__2,aggregatedDisparity__aggrega__51,backBestCost__bestCostFeed__51,out1_1__currentResult__35,result__in__53,backBestCost__bestCostFeed__52); // Cost_Parallel_Work_2_disparitySelect_14
		// Broadcast Cost_Parallel_Work_2_Broadcast5_14
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_3__0+0, result__in__53+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_14_18__2+0, result__in__53+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_14_18__2+119, result__in__53+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__52
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__52
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__15
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__15
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_15_36__disparity__2,aggregatedDisparity__aggrega__52,backBestCost__bestCostFeed__52,out1_1__currentResult__36,result__in__54,backBestCost__bestCostFeed__53); // Cost_Parallel_Work_2_disparitySelect_15
		// Broadcast Cost_Parallel_Work_2_Broadcast5_15
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_4__0+0, result__in__54+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_15_18__2+0, result__in__54+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_15_18__2+119, result__in__54+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__53
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__53
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__16
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__16
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_16_36__disparity__2,aggregatedDisparity__aggrega__53,backBestCost__bestCostFeed__53,out1_1__currentResult__37,result__in__55,backBestCost__bestCostFeed__54); // Cost_Parallel_Work_2_disparitySelect_16
		// Broadcast Cost_Parallel_Work_2_Broadcast5_16
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_5__0+0, result__in__55+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_16_18__2+0, result__in__55+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_16_18__2+119, result__in__55+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__54
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__54
		receiveStart(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__17
		receiveEnd(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__17
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_17_36__disparity__2,aggregatedDisparity__aggrega__54,backBestCost__bestCostFeed__54,out1_1__currentResult__38,result__in__56,backBestCost__bestCostFeed__55); // Cost_Parallel_Work_2_disparitySelect_17
		// Broadcast Cost_Parallel_Work_2_Broadcast5_17
		{
			// memcpy #0
			// memcpy #0
			memcpy(back_2__back_6__0+0, result__in__56+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out0_0__rawDisparity_17_18__2+0, result__in__56+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_17_18__2+119, result__in__56+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__55
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__55
		receiveStart(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__18
		receiveEnd(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__18
		disparitySelect(10/*height*/,12/*width*/,19/*nbDisparities*/,4/*scale*/,0/*minDisparity*/,out1_18_36__disparity__2,aggregatedDisparity__aggrega__55,backBestCost__bestCostFeed__55,out1_1__currentResult__39,result__in__14,backBestCost__backBestCost__0); // Cost_Parallel_Work_2_disparitySelect_18
		printf("disparitySelect 8\n");
        sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_dispari__18
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_dispari__18
		// Broadcast Cost_Parallel_Work_2_Broadcast5_18
		{
			// memcpy #0
			// memcpy #0
			memcpy(out0_0__rawDisparity_18_18__2+0, result__in__14+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out0_0__rawDisparity_18_18__2+119, result__in__14+0, 1*sizeof(uchar));
			// memcpy #0
			memcpy(out1_1_1__out1_1__0+0, result__in__14+1, 119*sizeof(uchar));
			// memcpy #1
			memcpy(out1_1_1__out1_1__0+119, result__in__14+0, 1*sizeof(uchar));
		}
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__48
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__48
		sendStart(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__94
		sendEnd(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__94
		// RoundBuffer RB_Cost_Parallel_Work_2__rawDisparity
		{
			// memcpy #0
		}
		split(15/*nbSlice*/,12/*width*/,10/*height*/,rawDisparity__input__2,output__rawDisparity__1); // Split_2
		// Fork explode_Split_2_output
		{
		}
		sendStart(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__0
		sendEnd(); // Core0 > Core1: explode_Split_2_output__Medi__0
		sendStart(0, 2); // Core0 > Core2: explode_Split_2_output__Medi__1
		sendEnd(); // Core0 > Core2: explode_Split_2_output__Medi__1
		sendStart(0, 3); // Core0 > Core3: explode_Split_2_output__Medi__2
		sendEnd(); // Core0 > Core3: explode_Split_2_output__Medi__2
		sendStart(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__4
		sendEnd(); // Core0 > Core1: explode_Split_2_output__Medi__4
		sendStart(0, 2); // Core0 > Core2: explode_Split_2_output__Medi__5
		sendEnd(); // Core0 > Core2: explode_Split_2_output__Medi__5
		sendStart(0, 3); // Core0 > Core3: explode_Split_2_output__Medi__6
		sendEnd(); // Core0 > Core3: explode_Split_2_output__Medi__6
		sendStart(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__8
		sendEnd(); // Core0 > Core1: explode_Split_2_output__Medi__8
		sendStart(0, 2); // Core0 > Core2: explode_Split_2_output__Medi__9
		sendEnd(); // Core0 > Core2: explode_Split_2_output__Medi__9
		sendStart(0, 3); // Core0 > Core3: explode_Split_2_output__Medi__10
		sendEnd(); // Core0 > Core3: explode_Split_2_output__Medi__10
		sendStart(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__12
		sendEnd(); // Core0 > Core1: explode_Split_2_output__Medi__12
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_4__rawDisparity__1,filteredDisparity__in_0__2); // Median_Filter_30
		sendStart(0, 1); // Core0 > Core1: Median_Filter_30__implode_lu__0
		sendEnd(); // Core0 > Core1: Median_Filter_30__implode_lu__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_8__rawDisparity__1,filteredDisparity__in_4__2); // Median_Filter_34
		sendStart(0, 1); // Core0 > Core1: Median_Filter_34__implode_lu__0
		sendEnd(); // Core0 > Core1: Median_Filter_34__implode_lu__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_12__rawDisparity__1,filteredDisparity__in_8__1); // Median_Filter_38
		sendStart(0, 1); // Core0 > Core1: Median_Filter_38__implode_lu__0
		sendEnd(); // Core0 > Core1: Median_Filter_38__implode_lu__0
		receiveStart(); // Core3 > Core0: explode_Split_1_output__impl__0
		receiveEnd(3, 0); // Core3 > Core0: explode_Split_1_output__impl__0
		// Join implode_Median_Filter_26_rawDisparity
		{
			memcpy(output__rawDisparity__3+24, output_0__rawDisparity_1__0+0, 12*sizeof(uchar));
		}
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output__rawDisparity__3,filteredDisparity__in_6__3); // Median_Filter_26
		printf("medianFilter\n");
        receiveStart(); // Core3 > Core0: Median_Filter_20__implode_lu__0
		receiveEnd(3, 0); // Core3 > Core0: Median_Filter_20__implode_lu__0
		receiveStart(); // Core3 > Core0: Median_Filter_21__implode_lu__0
		receiveEnd(3, 0); // Core3 > Core0: Median_Filter_21__implode_lu__0
		receiveStart(); // Core3 > Core0: Median_Filter_22__implode_lu__0
		receiveEnd(3, 0); // Core3 > Core0: Median_Filter_22__implode_lu__0
		receiveStart(); // Core3 > Core0: Median_Filter_23__implode_lu__0
		receiveEnd(3, 0); // Core3 > Core0: Median_Filter_23__implode_lu__0
		receiveStart(); // Core3 > Core0: Median_Filter_25__implode_lu__0
		receiveEnd(3, 0); // Core3 > Core0: Median_Filter_25__implode_lu__0
		receiveStart(); // Core1 > Core0: Median_Filter_27__implode_lu__0
		receiveEnd(1, 0); // Core1 > Core0: Median_Filter_27__implode_lu__0
		receiveStart(); // Core2 > Core0: Median_Filter_28__implode_lu__0
		receiveEnd(2, 0); // Core2 > Core0: Median_Filter_28__implode_lu__0
		receiveStart(); // Core3 > Core0: Median_Filter_29__implode_lu__0
		receiveEnd(3, 0); // Core3 > Core0: Median_Filter_29__implode_lu__0
		// Join implode_lum2RGB_2_in
		{
			memcpy(filteredDisparity__in__1+12, filteredDisparity__in_1__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+24, filteredDisparity__in_2__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+36, filteredDisparity__in_3__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+48, filteredDisparity__in_4__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+60, filteredDisparity__in_5__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+72, filteredDisparity__in_6__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+84, filteredDisparity__in_7__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+96, filteredDisparity__in_8__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__1+108, filteredDisparity__in_9__0+0, 12*sizeof(uchar));
		}
		// Broadcast lum2RGB_2
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(0, 3); // Core0 > Core3: lum2RGB_2__Display_RGB1_2__0
		sendEnd(); // Core0 > Core3: lum2RGB_2__Display_RGB1_2__0
        printf("writePPM\n");
		writePPM(10/*height*/,12/*width*/,out1_1__gray__1); // Write_PPM_2
        
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
        printf("Chegou barrier\n");
		barrier_wait(&iter_barrier);
        printf("Passou barrier\n");
		receiveStart(); // Core0 > Core1: Read_PPM1_0__RGB2Gray_R_0__0
		receiveEnd(0, 1); // Core0 > Core1: Read_PPM1_0__RGB2Gray_R_0__0
		rgb2Gray(120/*size*/,rgb__rgb__2,gray__in__5); // RGB2Gray_R_0
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_explode__1
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_explode__1
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_explode__3
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_explode__3
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_explode__5
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_explode__5
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__59
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__59
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__116
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__116
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__118
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__118
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__121
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__121
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__122
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__122
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__123
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__123
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__124
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__124
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__125
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__125
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__65
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__65
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__68
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__68
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__71
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__71
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__74
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__74
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__76
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__76
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__78
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__78
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__80
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__80
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__82
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__82
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__84
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__84
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__44
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__44
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__47
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__47
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_4_26__offset__0,out1_1__rgbL__4,weights__in_4__5); // Cost_Parallel_Work_0_ComputeHorWeights_4
		sendStart(1, 2); // Core1 > Core2: Cost_Parallel_Work_0_Compute__5
		sendEnd(); // Core1 > Core2: Cost_Parallel_Work_0_Compute__5
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_3_22__offset__0,out0_0__rgbL__3,weights__in_3__0); // Cost_Parallel_Work_0_ComputeVertWeights_3
		sendStart(1, 3); // Core1 > Core3: Cost_Parallel_Work_0_Compute__8
		sendEnd(); // Core1 > Core3: Cost_Parallel_Work_0_Compute__8
		// Broadcast broadcast2_0
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(1, 2); // Core1 > Core2: broadcast2_0__BR_Cost_Parall__0
		sendEnd(); // Core1 > Core2: broadcast2_0__BR_Cost_Parall__0
		census(10/*height*/,12/*width*/,out0_0__gray__5,cen__cenR__0); // Census_R_0
		// Broadcast BR_Cost_Parallel_Work_0__cenR
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(1, 0); // Core1 > Core0: BR_Cost_Parallel_Work_0__cen__20
		sendEnd(); // Core1 > Core0: BR_Cost_Parallel_Work_0__cen__20
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__22
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__22
		sendStart(1, 3); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__23
		sendEnd(); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__23
		sendStart(1, 3); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__25
		sendEnd(); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__25
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__26
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__26
		sendStart(1, 3); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__28
		sendEnd(); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__28
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__29
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__29
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__31
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__31
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__33
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__33
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__35
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__35
		sendStart(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__37
		sendEnd(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__37
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__21
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__21
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__24
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__24
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__27
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__27
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__19
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__19
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__30
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__30
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__32
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__32
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__34
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__34
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__36
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__36
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__2
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__2
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__2
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__2
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_1_18__disparity__0,grayL_1_18__grayL__0,grayR_1_18__grayR__2,cenL_1_18__cenL__0,cenR_1_18__cenR__0,disparityError__disparityErr__32,back_1__back__0); // Cost_Parallel_Work_0_CostConstruction_1
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__5
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__5
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__5
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__5
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_4_18__disparity__0,grayL_4_18__grayL__0,grayR_4_18__grayR__2,cenL_4_18__cenL__0,cenR_4_18__cenR__0,disparityError__disparityErr__1,back_4__back__0); // Cost_Parallel_Work_0_CostConstruction_4
		sendStart(1, 2); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__1
		sendEnd(); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__1
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__8
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__8
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__8
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__8
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_7_18__disparity__0,grayL_7_18__grayL__0,grayR_7_18__grayR__2,cenL_7_18__cenL__0,cenR_7_18__cenR__0,disparityError__disparityErr__3,back_7__back__0); // Cost_Parallel_Work_0_CostConstruction_7
		sendStart(1, 2); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__3
		sendEnd(); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__3
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__105
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__105
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__107
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__107
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__109
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__109
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__111
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__111
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__113
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__113
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__115
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__115
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__117
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__117
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__119
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__119
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__121
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__121
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__123
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__123
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__57
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__57
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__59
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__59
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__61
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__61
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__63
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__63
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__65
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__65
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__67
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__67
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__69
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__69
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__71
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__71
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__73
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__73
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__75
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__75
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__96
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__96
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__98
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__98
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__100
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__100
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__102
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__102
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__104
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__104
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__106
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__106
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__108
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__108
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__110
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__110
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__112
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__112
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__58
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__58
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__60
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__60
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__62
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__62
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__64
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__64
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__66
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__66
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__68
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__68
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__70
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__70
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__72
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__72
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__74
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__74
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__1
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__1
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__3
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__3
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__5
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__5
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__7
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__7
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__9
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__9
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__10
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__10
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__12
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__12
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__14
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__14
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__16
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__16
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__18
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__18
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__2
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__2
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__4
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__4
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__6
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__6
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__8
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__8
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__0
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__0
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__11
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__11
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__13
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__13
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__15
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__15
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__17
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__17
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__20
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__20
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__22
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__22
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__24
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__24
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__26
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__26
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__28
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__28
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__29
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__29
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__31
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__31
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__33
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__33
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__35
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__35
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__37
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__37
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__21
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__21
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__23
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__23
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__25
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__25
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__27
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__27
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__19
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__19
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__30
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__30
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__32
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__32
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__34
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__34
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__36
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__36
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__1
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__1
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__0
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__0
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__11
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__11
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__13
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__13
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__15
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__15
		receiveStart(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__17
		receiveEnd(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__17
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__20
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__20
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__32,out0_1_18__offsets__0,out_1_18__hWeights__2,out_1_18__vWeights__2,aggregatedDisparity__aggrega__3); // Cost_Parallel_Work_0_AggregateCost_1
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__3
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__3
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__5
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__5
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__24
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__24
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__9
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__9
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__11
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__11
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__13
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__13
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__15
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__15
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__17
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__17
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__0
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__0
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__2
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__2
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__4
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__4
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__6
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__6
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__8
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__8
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__10
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__10
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__12
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__12
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__14
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__14
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__16
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__16
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__18
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__18
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__19
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__19
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__21
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__21
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__23
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__23
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__25
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__25
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__27
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__27
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__29
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__29
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__31
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__31
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__33
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__33
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__35
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__35
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__37
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__37
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__1
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__1
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__3
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__3
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__5
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__5
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__7
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__7
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__9
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__9
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__11
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__11
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__13
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__13
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__15
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__15
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__17
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__17
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__20
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__20
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__22
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__22
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__24
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__24
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__26
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__26
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__28
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__28
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__30
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__30
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__32
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__32
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__34
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__34
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__36
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__36
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__1
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__1
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__3
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__3
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__5
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__5
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__7
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__7
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__9
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__9
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__10
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__10
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__12
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__12
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__14
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__14
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__16
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__16
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__18
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__18
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__2
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__2
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__4
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__4
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__6
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__6
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__8
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__8
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__0
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__0
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__11
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__11
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__13
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__13
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__15
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__15
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__17
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__17
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__20
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__20
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__22
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__22
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__24
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__24
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__26
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__26
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__28
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__28
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__29
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__29
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__31
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__31
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__33
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__33
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__35
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__35
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__37
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__37
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__21
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__21
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__23
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__23
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__25
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__25
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__27
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__27
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__19
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__19
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__30
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__30
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__32
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__32
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__34
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__34
		receiveStart(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__36
		receiveEnd(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__36
		receiveStart(); // Core3 > Core1: Cost_Parallel_Work_0_CostCon__2
		receiveEnd(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_CostCon__2
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__2,out0_5_18__offsets__0,out_5_18__hWeights__2,out_5_18__vWeights__2,aggregatedDisparity__aggrega__5); // Cost_Parallel_Work_0_AggregateCost_5
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__5
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__5
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__0
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__0
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__11
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__11
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__13
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__13
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__15
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__15
		receiveStart(); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__17
		receiveEnd(0, 1); // Core0 > Core1: BR_Cost_Parallel_Work_0__cen__17
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__127
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__127
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_9_18__disparity__0,grayL_9_18__grayL__0,grayR_9_18__grayR__2,cenL_9_18__cenL__0,cenR_9_18__cenR__0,disparityError__disparityErr__33,back_2__back__1); // Cost_Parallel_Work_0_CostConstruction_9
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__28
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__28
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__33,out0_9_18__offsets__0,out_9_18__hWeights__2,out_9_18__vWeights__2,aggregatedDisparity__aggrega__8); // Cost_Parallel_Work_0_AggregateCost_9
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__8
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__8
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__129
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__129
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_11_18__disparity__0,grayL_11_18__grayL__0,grayR_11_18__grayR__2,cenL_11_18__cenL__0,cenR_11_18__cenR__0,disparityError__disparityErr__34,back_2__back__3); // Cost_Parallel_Work_0_CostConstruction_11
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__30
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__30
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__34,out0_11_18__offsets__0,out_11_18__hWeights__2,out_11_18__vWeights__2,aggregatedDisparity__aggrega__10); // Cost_Parallel_Work_0_AggregateCost_11
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__10
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__10
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__131
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__131
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_13_18__disparity__0,grayL_13_18__grayL__0,grayR_13_18__grayR__2,cenL_13_18__cenL__0,cenR_13_18__cenR__0,disparityError__disparityErr__35,back_2__back__5); // Cost_Parallel_Work_0_CostConstruction_13
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__32
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__32
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__35,out0_13_18__offsets__0,out_13_18__hWeights__2,out_13_18__vWeights__2,aggregatedDisparity__aggrega__12); // Cost_Parallel_Work_0_AggregateCost_13
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__12
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__12
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__133
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__133
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_15_18__disparity__0,grayL_15_18__grayL__0,grayR_15_18__grayR__2,cenL_15_18__cenL__0,cenR_15_18__cenR__0,disparityError__disparityErr__36,back_2__back__7); // Cost_Parallel_Work_0_CostConstruction_15
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__34
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__34
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__36,out0_15_18__offsets__0,out_15_18__hWeights__2,out_15_18__vWeights__2,aggregatedDisparity__aggrega__14); // Cost_Parallel_Work_0_AggregateCost_15
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__14
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__14
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__135
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__135
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_17_18__disparity__0,grayL_17_18__grayL__0,grayR_17_18__grayR__2,cenL_17_18__cenL__0,cenR_17_18__cenR__0,disparityError__disparityErr__37,back_2__back__9); // Cost_Parallel_Work_0_CostConstruction_17
		receiveStart(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__36
		receiveEnd(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__36
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__37,out0_17_18__offsets__0,out_17_18__hWeights__2,out_17_18__vWeights__2,aggregatedDisparity__aggrega__16); // Cost_Parallel_Work_0_AggregateCost_17
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__16
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_0_Aggrega__16
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__137
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__137
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_0_18__disparity__1,grayL_0_18__grayL__1,grayR_0_18__grayR__0,cenL_0_18__cenL__1,cenR_0_18__cenR__1,disparityError__disparityErr__38,back_2_2__back__0); // Cost_Parallel_Work_1_CostConstruction_0
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__38,out0_0_18__offsets__1,out_0_18__hWeights__0,out_0_18__vWeights__0,aggregatedDisparity__aggrega__18); // Cost_Parallel_Work_1_AggregateCost_0
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__0
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__0
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__139
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__139
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_2_18__disparity__1,grayL_2_18__grayL__1,grayR_2_18__grayR__0,cenL_2_18__cenL__1,cenR_2_18__cenR__1,disparityError__disparityErr__39,back_2_2__back__2); // Cost_Parallel_Work_1_CostConstruction_2
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__39,out0_2_18__offsets__0,out_2_18__hWeights__0,out_2_18__vWeights__0,aggregatedDisparity__aggrega__20); // Cost_Parallel_Work_1_AggregateCost_2
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__2
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__2
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__141
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__141
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_4_18__disparity__1,grayL_4_18__grayL__1,grayR_4_18__grayR__0,cenL_4_18__cenL__1,cenR_4_18__cenR__1,disparityError__disparityErr__40,back_2_2__back__4); // Cost_Parallel_Work_1_CostConstruction_4
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__40,out0_4_18__offsets__0,out_4_18__hWeights__0,out_4_18__vWeights__0,aggregatedDisparity__aggrega__22); // Cost_Parallel_Work_1_AggregateCost_4
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__4
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__4
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__143
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_0_Broadca__143
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_6_18__disparity__1,grayL_6_18__grayL__1,grayR_6_18__grayR__0,cenL_6_18__cenL__1,cenR_6_18__cenR__1,disparityError__disparityErr__41,back_2_2__back__6); // Cost_Parallel_Work_1_CostConstruction_6
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__41,out0_6_18__offsets__1,out_6_18__hWeights__0,out_6_18__vWeights__0,aggregatedDisparity__aggrega__24); // Cost_Parallel_Work_1_AggregateCost_6
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__6
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__6
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__124
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__124
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_8_18__disparity__1,grayL_8_18__grayL__1,grayR_8_18__grayR__0,cenL_8_18__cenL__1,cenR_8_18__cenR__1,disparityError__disparityErr__42,back_2__back__11); // Cost_Parallel_Work_1_CostConstruction_8
		receiveStart(); // Core3 > Core1: explode_Split_0_output__Medi__3
		receiveEnd(3, 1); // Core3 > Core1: explode_Split_0_output__Medi__3
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_3__rawDisparity__2,filteredDisparity__in_3__0); // Median_Filter_3
		sendStart(1, 3); // Core1 > Core3: Median_Filter_3__implode_lum__0
		sendEnd(); // Core1 > Core3: Median_Filter_3__implode_lum__0
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__42,out0_8_18__offsets__1,out_8_18__hWeights__0,out_8_18__vWeights__0,aggregatedDisparity__aggrega__26); // Cost_Parallel_Work_1_AggregateCost_8
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__8
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__8
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__126
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__126
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_10_18__disparity__1,grayL_10_18__grayL__1,grayR_10_18__grayR__0,cenL_10_18__cenL__1,cenR_10_18__cenR__1,disparityError__disparityErr__43,back_2__back__13); // Cost_Parallel_Work_1_CostConstruction_10
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__43,out0_10_18__offsets__0,out_10_18__hWeights__0,out_10_18__vWeights__0,aggregatedDisparity__aggrega__28); // Cost_Parallel_Work_1_AggregateCost_10
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__10
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__10
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__128
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__128
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_12_18__disparity__1,grayL_12_18__grayL__1,grayR_12_18__grayR__0,cenL_12_18__cenL__1,cenR_12_18__cenR__1,disparityError__disparityErr__44,back_2__back__15); // Cost_Parallel_Work_1_CostConstruction_12
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__44,out0_12_18__offsets__0,out_12_18__hWeights__0,out_12_18__vWeights__0,aggregatedDisparity__aggrega__30); // Cost_Parallel_Work_1_AggregateCost_12
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__12
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__12
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__130
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__130
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_14_18__disparity__1,grayL_14_18__grayL__1,grayR_14_18__grayR__0,cenL_14_18__cenL__1,cenR_14_18__cenR__1,disparityError__disparityErr__45,back_2__back__17); // Cost_Parallel_Work_1_CostConstruction_14
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__45,out0_14_18__offsets__0,out_14_18__hWeights__0,out_14_18__vWeights__0,aggregatedDisparity__aggrega__32); // Cost_Parallel_Work_1_AggregateCost_14
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__14
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__14
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__132
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__132
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_16_18__disparity__1,grayL_16_18__grayL__1,grayR_16_18__grayR__0,cenL_16_18__cenL__1,cenR_16_18__cenR__1,disparityError__disparityErr__46,back_2__back__19); // Cost_Parallel_Work_1_CostConstruction_16
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__46,out0_16_18__offsets__0,out_16_18__hWeights__0,out_16_18__vWeights__0,aggregatedDisparity__aggrega__34); // Cost_Parallel_Work_1_AggregateCost_16
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__16
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__16
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__134
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__134
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_18_18__disparity__1,grayL_18_18__grayL__1,grayR_18_18__grayR__0,cenL_18_18__cenL__1,cenR_18_18__cenR__1,disparityError__disparityErr__47,back_2__back__21); // Cost_Parallel_Work_1_CostConstruction_18
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__47,out0_18_18__offsets__0,out_18_18__hWeights__0,out_18_18__vWeights__0,aggregatedDisparity__aggrega__36); // Cost_Parallel_Work_1_AggregateCost_18
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__18
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_1_Aggrega__18
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__136
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__136
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_1_18__disparity__2,grayL_1_18__grayL__2,grayR_1_18__grayR__1,cenL_1_18__cenL__2,cenR_1_18__cenR__2,disparityError__disparityErr__48,back_2_2__back__9); // Cost_Parallel_Work_2_CostConstruction_1
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__48,out0_1_18__offsets__2,out_1_18__hWeights__1,out_1_18__vWeights__1,aggregatedDisparity__aggrega__38); // Cost_Parallel_Work_2_AggregateCost_1
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__1
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__1
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__138
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__138
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_3_18__disparity__2,grayL_3_18__grayL__2,grayR_3_18__grayR__1,cenL_3_18__cenL__2,cenR_3_18__cenR__2,disparityError__disparityErr__49,back_2_2__back__11); // Cost_Parallel_Work_2_CostConstruction_3
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__49,out0_3_18__offsets__2,out_3_18__hWeights__1,out_3_18__vWeights__1,aggregatedDisparity__aggrega__40); // Cost_Parallel_Work_2_AggregateCost_3
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__3
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__3
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__140
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__140
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_5_18__disparity__2,grayL_5_18__grayL__2,grayR_5_18__grayR__1,cenL_5_18__cenL__2,cenR_5_18__cenR__2,disparityError__disparityErr__50,back_2_2__back__13); // Cost_Parallel_Work_2_CostConstruction_5
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__50,out0_5_18__offsets__2,out_5_18__hWeights__1,out_5_18__vWeights__1,aggregatedDisparity__aggrega__42); // Cost_Parallel_Work_2_AggregateCost_5
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__5
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__5
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__142
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_1_Broadca__142
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_7_18__disparity__2,grayL_7_18__grayL__2,grayR_7_18__grayR__1,cenL_7_18__cenL__2,cenR_7_18__cenR__2,disparityError__disparityErr__51,back_2_2__back__15); // Cost_Parallel_Work_2_CostConstruction_7
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__51,out0_7_18__offsets__1,out_7_18__hWeights__1,out_7_18__vWeights__1,aggregatedDisparity__aggrega__44); // Cost_Parallel_Work_2_AggregateCost_7
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__7
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__7
		receiveStart(); // Core3 > Core1: explode_Split_1_output__Medi__10
		receiveEnd(3, 1); // Core3 > Core1: explode_Split_1_output__Medi__10
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_11__rawDisparity__0,filteredDisparity__in_4__1); // Median_Filter_24
		sendStart(1, 0); // Core1 > Core0: Median_Filter_24__implode_lu__0
		sendEnd(); // Core1 > Core0: Median_Filter_24__implode_lu__0
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__115
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__115
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_9_18__disparity__2,grayL_9_18__grayL__2,grayR_9_18__grayR__1,cenL_9_18__cenL__2,cenR_9_18__cenR__2,disparityError__disparityErr__52,back_2__back__23); // Cost_Parallel_Work_2_CostConstruction_9
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__52,out0_9_18__offsets__2,out_9_18__hWeights__1,out_9_18__vWeights__1,aggregatedDisparity__aggrega__46); // Cost_Parallel_Work_2_AggregateCost_9
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__9
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__9
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__117
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__117
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_11_18__disparity__2,grayL_11_18__grayL__2,grayR_11_18__grayR__1,cenL_11_18__cenL__2,cenR_11_18__cenR__2,disparityError__disparityErr__53,back_2__back__25); // Cost_Parallel_Work_2_CostConstruction_11
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__53,out0_11_18__offsets__2,out_11_18__hWeights__1,out_11_18__vWeights__1,aggregatedDisparity__aggrega__48); // Cost_Parallel_Work_2_AggregateCost_11
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__11
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__11
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__119
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__119
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_13_18__disparity__2,grayL_13_18__grayL__2,grayR_13_18__grayR__1,cenL_13_18__cenL__2,cenR_13_18__cenR__2,disparityError__disparityErr__54,back_2__back__27); // Cost_Parallel_Work_2_CostConstruction_13
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__54,out0_13_18__offsets__2,out_13_18__hWeights__1,out_13_18__vWeights__1,aggregatedDisparity__aggrega__50); // Cost_Parallel_Work_2_AggregateCost_13
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__13
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__13
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__121
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__121
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_15_18__disparity__2,grayL_15_18__grayL__2,grayR_15_18__grayR__1,cenL_15_18__cenL__2,cenR_15_18__cenR__2,disparityError__disparityErr__55,back_2__back__29); // Cost_Parallel_Work_2_CostConstruction_15
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__55,out0_15_18__offsets__2,out_15_18__hWeights__1,out_15_18__vWeights__1,aggregatedDisparity__aggrega__52); // Cost_Parallel_Work_2_AggregateCost_15
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__15
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__15
		receiveStart(); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__123
		receiveEnd(0, 1); // Core0 > Core1: Cost_Parallel_Work_2_Broadca__123
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_17_18__disparity__2,grayL_17_18__grayL__2,grayR_17_18__grayR__1,cenL_17_18__cenL__2,cenR_17_18__cenR__2,disparityError__disparityErr__56,back_2__back__31); // Cost_Parallel_Work_2_CostConstruction_17
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__56,out0_17_18__offsets__2,out_17_18__hWeights__1,out_17_18__vWeights__1,aggregatedDisparity__aggrega__54); // Cost_Parallel_Work_2_AggregateCost_17
		sendStart(1, 0); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__17
		sendEnd(); // Core1 > Core0: Cost_Parallel_Work_2_Aggrega__17
		receiveStart(); // Core0 > Core1: explode_Split_2_output__Medi__0
		receiveEnd(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_1__rawDisparity__1,filteredDisparity__in_7__1); // Median_Filter_27
		sendStart(1, 0); // Core1 > Core0: Median_Filter_27__implode_lu__0
		sendEnd(); // Core1 > Core0: Median_Filter_27__implode_lu__0
		receiveStart(); // Core0 > Core1: explode_Split_2_output__Medi__4
		receiveEnd(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__4
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_5__rawDisparity__1,filteredDisparity__in_1__3); // Median_Filter_31
		receiveStart(); // Core0 > Core1: explode_Split_2_output__Medi__8
		receiveEnd(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__8
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_9__rawDisparity__1,filteredDisparity__in_5__3); // Median_Filter_35
		receiveStart(); // Core0 > Core1: explode_Split_2_output__Medi__12
		receiveEnd(0, 1); // Core0 > Core1: explode_Split_2_output__Medi__12
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_13__rawDisparity__0,filteredDisparity__in_9__3); // Median_Filter_39
		receiveStart(); // Core0 > Core1: Median_Filter_30__implode_lu__0
		receiveEnd(0, 1); // Core0 > Core1: Median_Filter_30__implode_lu__0
		receiveStart(); // Core2 > Core1: Median_Filter_32__implode_lu__0
		receiveEnd(2, 1); // Core2 > Core1: Median_Filter_32__implode_lu__0
		receiveStart(); // Core3 > Core1: Median_Filter_33__implode_lu__0
		receiveEnd(3, 1); // Core3 > Core1: Median_Filter_33__implode_lu__0
		receiveStart(); // Core0 > Core1: Median_Filter_34__implode_lu__0
		receiveEnd(0, 1); // Core0 > Core1: Median_Filter_34__implode_lu__0
		receiveStart(); // Core2 > Core1: Median_Filter_36__implode_lu__0
		receiveEnd(2, 1); // Core2 > Core1: Median_Filter_36__implode_lu__0
		receiveStart(); // Core3 > Core1: Median_Filter_37__implode_lu__0
		receiveEnd(3, 1); // Core3 > Core1: Median_Filter_37__implode_lu__0
		receiveStart(); // Core0 > Core1: Median_Filter_38__implode_lu__0
		receiveEnd(0, 1); // Core0 > Core1: Median_Filter_38__implode_lu__0
		// Join implode_lum2RGB_3_in
		{
			memcpy(filteredDisparity__in__2+12, filteredDisparity__in_1__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+24, filteredDisparity__in_2__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+36, filteredDisparity__in_3__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+48, filteredDisparity__in_4__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+60, filteredDisparity__in_5__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+72, filteredDisparity__in_6__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+84, filteredDisparity__in_7__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+96, filteredDisparity__in_8__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__2+108, filteredDisparity__in_9__3+0, 12*sizeof(uchar));
		}
		// Broadcast lum2RGB_3
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(1, 3); // Core1 > Core3: lum2RGB_3__Display_RGB1_3__0
		sendEnd(); // Core1 > Core3: lum2RGB_3__Display_RGB1_3__0
		writePPM(10/*height*/,12/*width*/,out1_1__gray__2); // Write_PPM_3
	}
}

//********** Core2 thread function *****************
void computationThread_Core2(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	fifoInit(FIFO_Head_Cost_Parallel_Work__2, 8*sizeof(char), NULL, 0);
	fifoInit(FIFO_Head_Cost_Parallel_Work__0, 484*sizeof(char), NULL, 0);
	fifoInit(FIFO_Head_Cost_Parallel_Work__1, 120*sizeof(char), NULL, 0);

	// Begin the execution loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
        printf("Chegou barrier\n");
		barrier_wait(&iter_barrier);
        printf("Passou barrier\n");
		disparityGen(0/*minDisparity*/,19/*maxDisparity*/,disparities__in__0); // Cost_Parallel_Work_0_DisparityGen_0
		offsetGen(5/*nbIterations*/,offsets__in__0); // Cost_Parallel_Work_0_OffsetGen_0
		fifoPop(back__back__0, FIFO_Head_Cost_Parallel_Work__2, 8*sizeof(char), NULL, 0);
		fifoPop(bestCostFeed__bestCostFeed__0, FIFO_Head_Cost_Parallel_Work__0, 484*sizeof(char), NULL, 0);
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_init_in_d__0
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_init_in_d__0
		fifoPop(currentResult__currentResult__0, FIFO_Head_Cost_Parallel_Work__1, 120*sizeof(char), NULL, 0);
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_init_in_d__1
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_init_in_d__1
		// Fork Cost_Parallel_Work_0_explode_in_CostConstruction_back_init_0_back
		{
			memcpy(back_1__back__0+0, back__back__0+1, 1*sizeof(uchar));
			memcpy(back_2__back__33+0, back__back__0+2, 1*sizeof(uchar));
			memcpy(back_3__back__0+0, back__back__0+3, 1*sizeof(uchar));
			memcpy(back_4__back__0+0, back__back__0+4, 1*sizeof(uchar));
			memcpy(back_5__back__0+0, back__back__0+5, 1*sizeof(uchar));
			memcpy(back_6__back__0+0, back__back__0+6, 1*sizeof(uchar));
			memcpy(back_7__back__0+0, back__back__0+7, 1*sizeof(uchar));
		}
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_explode__0
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_explode__0
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_explode__1
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_explode__1
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_explode__2
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_explode__2
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_explode__3
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_explode__3
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_explode__4
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_explode__4
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_explode__5
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_explode__5
		// Broadcast Cost_Parallel_Work_0_Broadcast0_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			memcpy(out0_0_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_1_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_2_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_3_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_4_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_5_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_6_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_7_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_8_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_9_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_10_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_11_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_12_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_13_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_14_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_15_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_16_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_17_18__offsets__0+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_18_18__offsets__2+0, offsets__in__0+0, 5*sizeof(int));
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__56
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__56
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__58
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__58
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__59
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__59
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__60
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__60
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__115
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__115
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__116
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__116
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__117
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__117
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__118
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__118
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__119
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__119
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__120
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__120
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__121
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__121
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__122
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__122
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__123
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__123
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__124
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__124
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__125
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__125
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__62
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__62
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__64
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__64
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__65
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__65
		// Broadcast Cost_Parallel_Work_0_Broadcast4_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__67
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__67
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__68
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__68
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__70
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__70
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__71
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__71
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__72
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__72
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__74
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__74
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__75
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__75
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__76
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__76
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__78
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__78
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__80
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__80
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__82
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__82
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__84
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__84
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__86
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__86
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__87
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__87
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__88
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__88
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__89
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__89
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__90
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__90
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__91
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__91
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__92
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__92
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__93
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__93
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__94
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__94
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__66
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__66
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__95
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__95
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__96
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__96
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__97
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__97
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__98
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__98
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__99
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__99
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__100
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__100
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__101
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__101
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__102
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__102
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__103
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__103
		receiveStart(); // Core0 > Core2: Broadcast0_0__BR_Cost_Parall__0
		receiveEnd(0, 2); // Core0 > Core2: Broadcast0_0__BR_Cost_Parall__0
		// Broadcast BR_Cost_Parallel_Work_0__rgbL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_0_Broadcast1_0
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__38
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__38
		// Broadcast Cost_Parallel_Work_0_Broadcast1_1
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__41
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__41
		// Broadcast Cost_Parallel_Work_0_Broadcast1_2
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__42
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__42
		// Broadcast Cost_Parallel_Work_0_Broadcast1_3
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__44
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__44
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__45
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__45
		// Broadcast Cost_Parallel_Work_0_Broadcast1_4
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__46
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__46
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__47
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__47
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_0_26__offset__0,out1_1__rgbL__0,weights__in_0__5); // Cost_Parallel_Work_0_ComputeHorWeights_0
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_2_26__offset__0,out1_1__rgbL__2,weights__in_2__5); // Cost_Parallel_Work_0_ComputeHorWeights_2
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_1_22__offset__0,out0_0__rgbL__1,weights__in_1__0); // Cost_Parallel_Work_0_ComputeVertWeights_1
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Compute__6
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Compute__6
		receiveStart(); // Core1 > Core2: Cost_Parallel_Work_0_Compute__5
		receiveEnd(1, 2); // Core1 > Core2: Cost_Parallel_Work_0_Compute__5
		receiveStart(); // Core1 > Core2: broadcast2_0__BR_Cost_Parall__0
		receiveEnd(1, 2); // Core1 > Core2: broadcast2_0__BR_Cost_Parall__0
		// Broadcast BR_Cost_Parallel_Work_0__grayR
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 0); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__20
		sendEnd(); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__20
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__21
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__21
		sendStart(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__23
		sendEnd(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__23
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__24
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__24
		sendStart(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__25
		sendEnd(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__25
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__27
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__27
		sendStart(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__28
		sendEnd(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__28
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__19
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__19
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__30
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__30
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__32
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__32
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__34
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__34
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__36
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__36
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Compute__9
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Compute__9
		receiveStart(); // Core0 > Core2: broadcast1_0__BR_Cost_Parall__0
		receiveEnd(0, 2); // Core0 > Core2: broadcast1_0__BR_Cost_Parall__0
		// Broadcast BR_Cost_Parallel_Work_0__grayL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 0); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__1
		sendEnd(); // Core2 > Core0: BR_Cost_Parallel_Work_0__gra__1
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__2
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__2
		sendStart(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__4
		sendEnd(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__4
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__5
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__5
		sendStart(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__6
		sendEnd(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__6
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__8
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__8
		sendStart(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__9
		sendEnd(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__9
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__0
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__0
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__11
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__11
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__13
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__13
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__15
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__15
		sendStart(2, 1); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__17
		sendEnd(); // Core2 > Core1: BR_Cost_Parallel_Work_0__gra__17
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__106
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__106
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__108
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__108
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__110
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__110
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__112
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__112
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__114
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__114
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__116
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__116
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__118
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__118
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__120
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__120
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__122
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__122
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__58
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__58
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__60
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__60
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__62
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__62
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__64
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__64
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__66
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__66
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__68
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__68
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__70
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__70
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__72
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__72
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__74
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__74
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__95
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__95
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__97
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__97
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__99
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__99
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__101
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__101
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__103
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__103
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__105
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__105
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__107
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__107
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__109
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__109
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__111
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__111
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__113
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__113
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__57
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__57
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__59
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__59
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__61
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__61
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__63
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__63
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__65
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__65
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__67
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__67
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__69
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__69
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__71
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__71
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__73
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__73
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__75
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__75
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Compute__7
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Compute__7
		// Join Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast3_0_in
		{
			memcpy(weights__in__5+360, weights__in_1__1+0, 360*sizeof(float));
			memcpy(weights__in__5+1080, weights__in_3__1+0, 360*sizeof(float));
		}
		// Broadcast Cost_Parallel_Work_0_Broadcast3_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__19
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Broadca__19
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__20
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__20
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__22
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__22
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__24
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__24
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__25
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__25
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__27
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__27
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__28
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__28
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__30
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__30
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__32
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__32
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__34
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__34
		sendStart(2, 1); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__36
		sendEnd(); // Core2 > Core1: Cost_Parallel_Work_0_Broadca__36
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__22
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__22
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__3
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__3
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_2_18__disparity__0,grayL_2_18__grayL__0,grayR_2_18__grayR__2,cenL_2_18__cenL__0,cenR_2_18__cenR__0,disparityError__disparityErr__6,back_2__back__33); // Cost_Parallel_Work_0_CostConstruction_2
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__26
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__26
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__7
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__7
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_6_18__disparity__0,grayL_6_18__grayL__0,grayR_6_18__grayR__2,cenL_6_18__cenL__0,cenR_6_18__cenR__0,disparityError__disparityErr__0,back_6__back__0); // Cost_Parallel_Work_0_CostConstruction_6
		sendStart(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_CostCon__0
		sendEnd(); // Core2 > Core3: Cost_Parallel_Work_0_CostCon__0
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__2
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__2
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__4
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__4
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__6
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__6
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__8
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__8
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__0
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__0
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__11
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__11
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__13
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__13
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__15
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__15
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__17
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__17
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__1
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__1
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__3
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__3
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__5
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__5
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__7
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__7
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__9
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__9
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__10
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__10
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__12
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__12
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__14
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__14
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__16
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__16
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__18
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__18
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__21
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__21
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__23
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__23
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__25
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__25
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__27
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__27
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__19
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__19
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__30
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__30
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__32
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__32
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__34
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__34
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__36
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__36
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__20
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__20
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__22
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__22
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__24
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__24
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__26
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__26
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__28
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__28
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__29
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__29
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__31
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__31
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__33
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__33
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__35
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__35
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__37
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__37
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__2
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__2
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__6,out0_2_18__offsets__2,out_2_18__hWeights__2,out_2_18__vWeights__2,aggregatedDisparity__aggrega__0); // Cost_Parallel_Work_0_AggregateCost_2
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__0
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__0
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__4
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__4
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__29
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__29
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__31
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__31
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__33
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__33
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__35
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__35
		receiveStart(); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__37
		receiveEnd(1, 2); // Core1 > Core2: BR_Cost_Parallel_Work_0__cen__37
		receiveStart(); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__1
		receiveEnd(1, 2); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__1
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__1,out0_4_18__offsets__2,out_4_18__hWeights__2,out_4_18__vWeights__2,aggregatedDisparity__aggrega__1); // Cost_Parallel_Work_0_AggregateCost_4
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__1
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__1
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__7
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__7
		receiveStart(); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__3
		receiveEnd(1, 2); // Core1 > Core2: Cost_Parallel_Work_0_CostCon__3
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__3,out0_7_18__offsets__2,out_7_18__hWeights__2,out_7_18__vWeights__2,aggregatedDisparity__aggrega__2); // Cost_Parallel_Work_0_AggregateCost_7
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__2
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__2
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__10
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__10
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__12
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__12
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__14
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__14
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__16
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__16
		receiveStart(); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__18
		receiveEnd(0, 2); // Core0 > Core2: BR_Cost_Parallel_Work_0__cen__18
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__128
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__128
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_10_18__disparity__0,grayL_10_18__grayL__0,grayR_10_18__grayR__2,cenL_10_18__cenL__0,cenR_10_18__cenR__0,disparityError__disparityErr__7,back_2__back__2); // Cost_Parallel_Work_0_CostConstruction_10
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__10
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__10
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__7,out0_10_18__offsets__2,out_10_18__hWeights__2,out_10_18__vWeights__2,aggregatedDisparity__aggrega__9); // Cost_Parallel_Work_0_AggregateCost_10
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__9
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__9
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__130
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__130
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_12_18__disparity__0,grayL_12_18__grayL__0,grayR_12_18__grayR__2,cenL_12_18__cenL__0,cenR_12_18__cenR__0,disparityError__disparityErr__8,back_2__back__4); // Cost_Parallel_Work_0_CostConstruction_12
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__12
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__12
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__8,out0_12_18__offsets__2,out_12_18__hWeights__2,out_12_18__vWeights__2,aggregatedDisparity__aggrega__11); // Cost_Parallel_Work_0_AggregateCost_12
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__11
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__11
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__132
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__132
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_14_18__disparity__0,grayL_14_18__grayL__0,grayR_14_18__grayR__2,cenL_14_18__cenL__0,cenR_14_18__cenR__0,disparityError__disparityErr__9,back_2__back__6); // Cost_Parallel_Work_0_CostConstruction_14
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__14
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__14
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__9,out0_14_18__offsets__2,out_14_18__hWeights__2,out_14_18__vWeights__2,aggregatedDisparity__aggrega__13); // Cost_Parallel_Work_0_AggregateCost_14
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__13
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__13
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__134
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__134
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_16_18__disparity__0,grayL_16_18__grayL__0,grayR_16_18__grayR__2,cenL_16_18__cenL__0,cenR_16_18__cenR__0,disparityError__disparityErr__10,back_2__back__8); // Cost_Parallel_Work_0_CostConstruction_16
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__16
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__16
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__10,out0_16_18__offsets__2,out_16_18__hWeights__2,out_16_18__vWeights__2,aggregatedDisparity__aggrega__15); // Cost_Parallel_Work_0_AggregateCost_16
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__15
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__15
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__136
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__136
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_18_18__disparity__0,grayL_18_18__grayL__0,grayR_18_18__grayR__2,cenL_18_18__cenL__0,cenR_18_18__cenR__0,disparityError__disparityErr__11,back_2__back__10); // Cost_Parallel_Work_0_CostConstruction_18
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__18
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__18
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__11,out0_18_18__offsets__2,out_18_18__hWeights__2,out_18_18__vWeights__2,aggregatedDisparity__aggrega__17); // Cost_Parallel_Work_0_AggregateCost_18
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__17
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_0_Aggrega__17
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__1
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__1
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__3
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__3
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__5
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__5
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__7
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__7
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__9
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__9
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__11
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__11
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__13
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__13
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__15
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__15
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__17
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__17
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__20
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__20
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__22
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__22
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__24
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__24
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__26
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__26
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__28
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__28
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__30
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__30
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__32
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__32
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__34
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__34
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__36
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__36
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__0
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__0
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__2
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__2
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__4
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__4
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__6
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__6
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__8
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__8
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__10
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__10
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__12
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__12
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__14
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__14
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__16
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__16
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__18
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__18
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__19
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__19
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__21
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__21
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__23
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__23
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__25
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__25
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__27
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__27
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__29
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__29
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__31
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__31
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__33
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__33
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__35
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__35
		receiveStart(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__37
		receiveEnd(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__37
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__2
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__2
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__4
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__4
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__6
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__6
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__8
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__8
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__0
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__0
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__11
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__11
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__13
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__13
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__15
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__15
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__17
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__17
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__1
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__1
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__3
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__3
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__5
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__5
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__7
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__7
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__9
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__9
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__10
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__10
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__12
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__12
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__14
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__14
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__16
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__16
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__18
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__18
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__21
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__21
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__138
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__138
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_1_18__disparity__1,grayL_1_18__grayL__1,grayR_1_18__grayR__0,cenL_1_18__cenL__1,cenR_1_18__cenR__1,disparityError__disparityErr__12,back_2_2__back__1); // Cost_Parallel_Work_1_CostConstruction_1
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__12,out0_1_18__offsets__1,out_1_18__hWeights__0,out_1_18__vWeights__0,aggregatedDisparity__aggrega__19); // Cost_Parallel_Work_1_AggregateCost_1
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__1
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__1
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__23
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__23
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__140
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__140
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_3_18__disparity__1,grayL_3_18__grayL__1,grayR_3_18__grayR__0,cenL_3_18__cenL__1,cenR_3_18__cenR__1,disparityError__disparityErr__13,back_2_2__back__3); // Cost_Parallel_Work_1_CostConstruction_3
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__13,out0_3_18__offsets__1,out_3_18__hWeights__0,out_3_18__vWeights__0,aggregatedDisparity__aggrega__21); // Cost_Parallel_Work_1_AggregateCost_3
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__3
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__3
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__25
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__25
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__142
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__142
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_5_18__disparity__1,grayL_5_18__grayL__1,grayR_5_18__grayR__0,cenL_5_18__cenL__1,cenR_5_18__cenR__1,disparityError__disparityErr__14,back_2_2__back__5); // Cost_Parallel_Work_1_CostConstruction_5
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__14,out0_5_18__offsets__1,out_5_18__hWeights__0,out_5_18__vWeights__0,aggregatedDisparity__aggrega__23); // Cost_Parallel_Work_1_AggregateCost_5
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__5
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__5
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__27
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__27
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__144
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_0_Broadca__144
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_7_18__disparity__1,grayL_7_18__grayL__1,grayR_7_18__grayR__0,cenL_7_18__cenL__1,cenR_7_18__cenR__1,disparityError__disparityErr__15,back_2_2__back__7); // Cost_Parallel_Work_1_CostConstruction_7
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__15,out0_7_18__offsets__0,out_7_18__hWeights__0,out_7_18__vWeights__0,aggregatedDisparity__aggrega__25); // Cost_Parallel_Work_1_AggregateCost_7
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__7
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__7
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__19
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__19
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__30
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__30
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__32
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__32
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__34
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__34
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__36
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__36
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__20
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__20
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__22
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__22
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__24
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__24
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__26
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__26
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__28
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__28
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__29
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__29
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__31
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__31
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__33
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__33
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__35
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__35
		receiveStart(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__37
		receiveEnd(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__37
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Medi__4
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__4
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_4__rawDisparity__2,filteredDisparity__in_4__0); // Median_Filter_4
		sendStart(2, 3); // Core2 > Core3: Median_Filter_4__implode_lum__0
		sendEnd(); // Core2 > Core3: Median_Filter_4__implode_lum__0
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Medi__5
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__5
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_5__rawDisparity__2,filteredDisparity__in_5__0); // Median_Filter_5
		sendStart(2, 3); // Core2 > Core3: Median_Filter_5__implode_lum__0
		sendEnd(); // Core2 > Core3: Median_Filter_5__implode_lum__0
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Medi__6
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__6
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_6__rawDisparity__2,filteredDisparity__in_6__0); // Median_Filter_6
		sendStart(2, 3); // Core2 > Core3: Median_Filter_6__implode_lum__0
		sendEnd(); // Core2 > Core3: Median_Filter_6__implode_lum__0
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Medi__7
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__7
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_7__rawDisparity__2,filteredDisparity__in_7__0); // Median_Filter_7
		sendStart(2, 3); // Core2 > Core3: Median_Filter_7__implode_lum__0
		sendEnd(); // Core2 > Core3: Median_Filter_7__implode_lum__0
		receiveStart(); // Core3 > Core2: explode_Split_0_output__Medi__8
		receiveEnd(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__8
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_8__rawDisparity__2,filteredDisparity__in_8__0); // Median_Filter_8
		sendStart(2, 3); // Core2 > Core3: Median_Filter_8__implode_lum__0
		sendEnd(); // Core2 > Core3: Median_Filter_8__implode_lum__0
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__125
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__125
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_9_18__disparity__1,grayL_9_18__grayL__1,grayR_9_18__grayR__0,cenL_9_18__cenL__1,cenR_9_18__cenR__1,disparityError__disparityErr__16,back_2__back__12); // Cost_Parallel_Work_1_CostConstruction_9
		receiveStart(); // Core3 > Core2: implode_lum2RGB_0_in__lum2RG__0
		receiveEnd(3, 2); // Core3 > Core2: implode_lum2RGB_0_in__lum2RG__0
		// Broadcast lum2RGB_0
		{
			// memcpy #0
			// memcpy #0
		}
		sendStart(2, 3); // Core2 > Core3: lum2RGB_0__Display_RGB1_0__0
		sendEnd(); // Core2 > Core3: lum2RGB_0__Display_RGB1_0__0
		writePPM(10/*height*/,12/*width*/,out1_1__gray__0); // Write_PPM_0
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__16,out0_9_18__offsets__1,out_9_18__hWeights__0,out_9_18__vWeights__0,aggregatedDisparity__aggrega__27); // Cost_Parallel_Work_1_AggregateCost_9
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__9
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__9
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__127
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__127
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_11_18__disparity__1,grayL_11_18__grayL__1,grayR_11_18__grayR__0,cenL_11_18__cenL__1,cenR_11_18__cenR__1,disparityError__disparityErr__17,back_2__back__14); // Cost_Parallel_Work_1_CostConstruction_11
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__17,out0_11_18__offsets__1,out_11_18__hWeights__0,out_11_18__vWeights__0,aggregatedDisparity__aggrega__29); // Cost_Parallel_Work_1_AggregateCost_11
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__11
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__11
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__129
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__129
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_13_18__disparity__1,grayL_13_18__grayL__1,grayR_13_18__grayR__0,cenL_13_18__cenL__1,cenR_13_18__cenR__1,disparityError__disparityErr__18,back_2__back__16); // Cost_Parallel_Work_1_CostConstruction_13
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__18,out0_13_18__offsets__1,out_13_18__hWeights__0,out_13_18__vWeights__0,aggregatedDisparity__aggrega__31); // Cost_Parallel_Work_1_AggregateCost_13
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__13
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__13
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__131
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__131
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_15_18__disparity__1,grayL_15_18__grayL__1,grayR_15_18__grayR__0,cenL_15_18__cenL__1,cenR_15_18__cenR__1,disparityError__disparityErr__19,back_2__back__18); // Cost_Parallel_Work_1_CostConstruction_15
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__19,out0_15_18__offsets__1,out_15_18__hWeights__0,out_15_18__vWeights__0,aggregatedDisparity__aggrega__33); // Cost_Parallel_Work_1_AggregateCost_15
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__15
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__15
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__133
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__133
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_17_18__disparity__1,grayL_17_18__grayL__1,grayR_17_18__grayR__0,cenL_17_18__cenL__1,cenR_17_18__cenR__1,disparityError__disparityErr__20,back_2__back__20); // Cost_Parallel_Work_1_CostConstruction_17
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__20,out0_17_18__offsets__1,out_17_18__hWeights__0,out_17_18__vWeights__0,aggregatedDisparity__aggrega__35); // Cost_Parallel_Work_1_AggregateCost_17
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__17
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_1_Aggrega__17
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__135
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__135
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_0_18__disparity__2,grayL_0_18__grayL__2,grayR_0_18__grayR__1,cenL_0_18__cenL__2,cenR_0_18__cenR__2,disparityError__disparityErr__21,back_2_2__back__8); // Cost_Parallel_Work_2_CostConstruction_0
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__21,out0_0_18__offsets__2,out_0_18__hWeights__1,out_0_18__vWeights__1,aggregatedDisparity__aggrega__37); // Cost_Parallel_Work_2_AggregateCost_0
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__0
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__0
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__137
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__137
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_2_18__disparity__2,grayL_2_18__grayL__2,grayR_2_18__grayR__1,cenL_2_18__cenL__2,cenR_2_18__cenR__2,disparityError__disparityErr__22,back_2_2__back__10); // Cost_Parallel_Work_2_CostConstruction_2
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__22,out0_2_18__offsets__1,out_2_18__hWeights__1,out_2_18__vWeights__1,aggregatedDisparity__aggrega__39); // Cost_Parallel_Work_2_AggregateCost_2
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__2
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__2
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__139
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__139
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_4_18__disparity__2,grayL_4_18__grayL__2,grayR_4_18__grayR__1,cenL_4_18__cenL__2,cenR_4_18__cenR__2,disparityError__disparityErr__23,back_2_2__back__12); // Cost_Parallel_Work_2_CostConstruction_4
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__23,out0_4_18__offsets__1,out_4_18__hWeights__1,out_4_18__vWeights__1,aggregatedDisparity__aggrega__41); // Cost_Parallel_Work_2_AggregateCost_4
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__4
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__4
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__141
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_1_Broadca__141
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_6_18__disparity__2,grayL_6_18__grayL__2,grayR_6_18__grayR__1,cenL_6_18__cenL__2,cenR_6_18__cenR__2,disparityError__disparityErr__24,back_2_2__back__14); // Cost_Parallel_Work_2_CostConstruction_6
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__24,out0_6_18__offsets__2,out_6_18__hWeights__1,out_6_18__vWeights__1,aggregatedDisparity__aggrega__43); // Cost_Parallel_Work_2_AggregateCost_6
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__6
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__6
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__114
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__114
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_8_18__disparity__2,grayL_8_18__grayL__2,grayR_8_18__grayR__1,cenL_8_18__cenL__2,cenR_8_18__cenR__2,disparityError__disparityErr__25,back_2__back__22); // Cost_Parallel_Work_2_CostConstruction_8
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__25,out0_8_18__offsets__2,out_8_18__hWeights__1,out_8_18__vWeights__1,aggregatedDisparity__aggrega__45); // Cost_Parallel_Work_2_AggregateCost_8
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__8
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__8
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__116
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__116
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_10_18__disparity__2,grayL_10_18__grayL__2,grayR_10_18__grayR__1,cenL_10_18__cenL__2,cenR_10_18__cenR__2,disparityError__disparityErr__26,back_2__back__24); // Cost_Parallel_Work_2_CostConstruction_10
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__26,out0_10_18__offsets__1,out_10_18__hWeights__1,out_10_18__vWeights__1,aggregatedDisparity__aggrega__47); // Cost_Parallel_Work_2_AggregateCost_10
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__10
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__10
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__118
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__118
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_12_18__disparity__2,grayL_12_18__grayL__2,grayR_12_18__grayR__1,cenL_12_18__cenL__2,cenR_12_18__cenR__2,disparityError__disparityErr__27,back_2__back__26); // Cost_Parallel_Work_2_CostConstruction_12
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__27,out0_12_18__offsets__1,out_12_18__hWeights__1,out_12_18__vWeights__1,aggregatedDisparity__aggrega__49); // Cost_Parallel_Work_2_AggregateCost_12
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__12
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__12
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__120
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__120
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_14_18__disparity__2,grayL_14_18__grayL__2,grayR_14_18__grayR__1,cenL_14_18__cenL__2,cenR_14_18__cenR__2,disparityError__disparityErr__28,back_2__back__28); // Cost_Parallel_Work_2_CostConstruction_14
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__28,out0_14_18__offsets__1,out_14_18__hWeights__1,out_14_18__vWeights__1,aggregatedDisparity__aggrega__51); // Cost_Parallel_Work_2_AggregateCost_14
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__14
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__14
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__122
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__122
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_16_18__disparity__2,grayL_16_18__grayL__2,grayR_16_18__grayR__1,cenL_16_18__cenL__2,cenR_16_18__cenR__2,disparityError__disparityErr__29,back_2__back__30); // Cost_Parallel_Work_2_CostConstruction_16
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__29,out0_16_18__offsets__1,out_16_18__hWeights__1,out_16_18__vWeights__1,aggregatedDisparity__aggrega__53); // Cost_Parallel_Work_2_AggregateCost_16
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__16
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__16
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__124
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__124
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_18_18__disparity__2,grayL_18_18__grayL__2,grayR_18_18__grayR__1,cenL_18_18__cenL__2,cenR_18_18__cenR__2,disparityError__disparityErr__30,back_2__back__32); // Cost_Parallel_Work_2_CostConstruction_18
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__30,out0_18_18__offsets__1,out_18_18__hWeights__1,out_18_18__vWeights__1,aggregatedDisparity__aggrega__55); // Cost_Parallel_Work_2_AggregateCost_18
		sendStart(2, 0); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__18
		sendEnd(); // Core2 > Core0: Cost_Parallel_Work_2_Aggrega__18
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__49
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__49
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__50
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__50
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__51
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__51
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__52
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__52
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__53
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__53
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__54
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__54
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__55
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__55
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_dispari__18
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_dispari__18
		fifoPush(backBestCost__backBestCost__0, FIFO_Head_Cost_Parallel_Work__0, 484*sizeof(char), NULL, 0);
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__48
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__48
		// Join Cost_Parallel_Work_2_implode_out_Broadcast5_back_end_0_back
		{
			memcpy(back__back__1+7, back_2__back_7__0+0, 1*sizeof(uchar));
		}
		receiveStart(); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__94
		receiveEnd(0, 2); // Core0 > Core2: Cost_Parallel_Work_2_Broadca__94
		fifoPush(out1_1_1__out1_1__0, FIFO_Head_Cost_Parallel_Work__1, 120*sizeof(char), NULL, 0);
		fifoPush(back__back__1, FIFO_Head_Cost_Parallel_Work__2, 8*sizeof(char), NULL, 0);
		receiveStart(); // Core0 > Core2: explode_Split_2_output__Medi__1
		receiveEnd(0, 2); // Core0 > Core2: explode_Split_2_output__Medi__1
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_2__rawDisparity__1,filteredDisparity__in_8__2); // Median_Filter_28
		sendStart(2, 0); // Core2 > Core0: Median_Filter_28__implode_lu__0
		sendEnd(); // Core2 > Core0: Median_Filter_28__implode_lu__0
		receiveStart(); // Core0 > Core2: explode_Split_2_output__Medi__5
		receiveEnd(0, 2); // Core0 > Core2: explode_Split_2_output__Medi__5
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_6__rawDisparity__1,filteredDisparity__in_2__1); // Median_Filter_32
		sendStart(2, 1); // Core2 > Core1: Median_Filter_32__implode_lu__0
		sendEnd(); // Core2 > Core1: Median_Filter_32__implode_lu__0
		receiveStart(); // Core0 > Core2: explode_Split_2_output__Medi__9
		receiveEnd(0, 2); // Core0 > Core2: explode_Split_2_output__Medi__9
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_10__rawDisparity__1,filteredDisparity__in_6__1); // Median_Filter_36
		sendStart(2, 1); // Core2 > Core1: Median_Filter_36__implode_lu__0
		sendEnd(); // Core2 > Core1: Median_Filter_36__implode_lu__0
	}
}

//********** Core3 thread function *****************
void computationThread_Core3(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	displayRGBInit(0/*id*/,10/*height*/,12/*width*/); // Display_rgb0_0
	displayRGBInit(0/*id*/,10/*height*/,12/*width*/); // Display_rgb0_1
	displayRGBInit(0/*id*/,10/*height*/,12/*width*/); // Display_rgb0_2
	displayRGBInit(1/*id*/,10/*height*/,12/*width*/); // Display_RGB1_0
	displayRGBInit(1/*id*/,10/*height*/,12/*width*/); // Display_RGB1_1
	displayRGBInit(1/*id*/,10/*height*/,12/*width*/); // Display_RGB1_3
	displayRGBInit(1/*id*/,10/*height*/,12/*width*/); // Display_RGB1_2

	// Begin the execution loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
        printf("Chegou barrier\n");
		barrier_wait(&iter_barrier);
        printf("Passou barrier\n");
		disparityGen(0/*minDisparity*/,19/*maxDisparity*/,disparities__in__1); // Cost_Parallel_Work_1_DisparityGen_0
		offsetGen(5/*nbIterations*/,offsets__in__1); // Cost_Parallel_Work_1_OffsetGen_0
		disparityGen(0/*minDisparity*/,19/*maxDisparity*/,disparities__in__2); // Cost_Parallel_Work_2_DisparityGen_0
		offsetGen(5/*nbIterations*/,offsets__in__2); // Cost_Parallel_Work_2_OffsetGen_0
		receiveStart(); // Core0 > Core3: Read_PPM0_1__Broadcast0_1__0
		receiveEnd(0, 3); // Core0 > Core3: Read_PPM0_1__Broadcast0_1__0
		// Broadcast Broadcast0_1
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		receiveStart(); // Core0 > Core3: Read_PPM0_2__Broadcast0_2__0
		receiveEnd(0, 3); // Core0 > Core3: Read_PPM0_2__Broadcast0_2__0
		// Broadcast Broadcast0_2
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_1_Broadcast0_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			memcpy(out0_0_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_1_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_2_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_3_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_4_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_5_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_6_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_7_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_8_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_9_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_10_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_11_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_12_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_13_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_14_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_15_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_16_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_17_18__offsets__1+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_18_18__offsets__0+0, offsets__in__1+0, 5*sizeof(int));
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__105
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__105
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__106
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__106
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__107
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__107
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__108
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__108
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__109
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__109
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__110
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__110
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__111
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__111
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__112
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__112
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__113
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__113
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__114
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__114
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__115
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__115
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__116
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__116
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__117
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__117
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__118
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__118
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__119
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__119
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__120
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__120
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__121
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__121
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__122
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__122
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__123
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__123
		// Broadcast Cost_Parallel_Work_1_Broadcast4_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__57
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__57
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__58
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__58
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__59
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__59
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__60
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__60
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__61
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__61
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__62
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__62
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__63
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__63
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__64
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__64
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__65
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__65
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__66
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__66
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__67
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__67
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__68
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__68
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__69
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__69
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__70
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__70
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__71
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__71
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__72
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__72
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__73
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__73
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__74
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__74
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__75
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__75
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__76
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__76
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__77
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__77
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__78
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__78
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__79
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__79
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__80
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__80
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__81
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__81
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__82
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__82
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__83
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__83
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__84
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__84
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__56
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__56
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__85
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__85
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__86
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__86
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__87
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__87
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__88
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__88
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__89
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__89
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__90
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__90
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__91
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__91
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__92
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__92
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__93
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_1_Broadca__93
		// Broadcast Cost_Parallel_Work_2_Broadcast0_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			memcpy(out0_0_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_1_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_2_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_3_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_4_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_5_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_6_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_7_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_8_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_9_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_10_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_11_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_12_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_13_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_14_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_15_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_16_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_17_18__offsets__2+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			memcpy(out0_18_18__offsets__1+0, offsets__in__2+0, 5*sizeof(int));
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__95
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__95
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__96
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__96
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__97
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__97
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__98
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__98
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__99
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__99
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__100
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__100
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__101
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__101
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__102
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__102
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__103
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__103
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__104
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__104
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__105
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__105
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__106
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__106
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__107
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__107
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__108
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__108
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__109
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__109
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__110
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__110
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__111
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__111
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__112
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__112
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__113
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__113
		// Broadcast Cost_Parallel_Work_2_Broadcast4_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__57
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__57
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__58
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__58
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__59
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__59
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__60
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__60
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__61
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__61
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__62
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__62
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__63
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__63
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__64
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__64
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__65
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__65
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__66
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__66
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__67
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__67
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__68
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__68
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__69
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__69
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__70
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__70
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__71
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__71
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__72
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__72
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__73
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__73
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__74
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__74
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__75
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__75
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__76
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__76
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__77
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__77
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__78
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__78
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__79
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__79
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__80
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__80
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__81
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__81
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__82
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__82
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__83
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__83
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__84
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__84
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__56
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__56
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__85
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__85
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__86
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__86
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__87
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__87
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__88
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__88
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__89
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__89
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__90
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__90
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__91
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__91
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__92
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__92
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__93
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_2_Broadca__93
		receiveStart(); // Core0 > Core3: Read_PPM1_1__RGB2Gray_R_1__0
		receiveEnd(0, 3); // Core0 > Core3: Read_PPM1_1__RGB2Gray_R_1__0
		rgb2Gray(120/*size*/,rgb__rgb__0,gray__in__0); // RGB2Gray_R_1
		receiveStart(); // Core0 > Core3: Read_PPM1_2__RGB2Gray_R_2__0
		receiveEnd(0, 3); // Core0 > Core3: Read_PPM1_2__RGB2Gray_R_2__0
		rgb2Gray(120/*size*/,rgb__rgb__1,gray__in__1); // RGB2Gray_R_2
		// Broadcast BR_Cost_Parallel_Work_1__rgbL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		// Broadcast BR_Cost_Parallel_Work_2__rgbL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		receiveStart(); // Core0 > Core3: Broadcast0_0__Display_rgb0_0__0
		receiveEnd(0, 3); // Core0 > Core3: Broadcast0_0__Display_rgb0_0__0
		displayRGB(0/*id*/,10/*height*/,12/*width*/,out0_0__rgb__0); // Display_rgb0_0
		displayRGB(0/*id*/,10/*height*/,12/*width*/,out0_0__rgb__1); // Display_rgb0_1
		displayRGB(0/*id*/,10/*height*/,12/*width*/,out0_0__rgb__2); // Display_rgb0_2
		rgb2Gray(120/*size*/,out1_2__rgb__1,gray__in__3); // RGB2Gray_L_1
		rgb2Gray(120/*size*/,out1_2__rgb__2,gray__in__4); // RGB2Gray_L_2
		// Broadcast Cost_Parallel_Work_1_Broadcast1_0
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_1_Broadcast1_1
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_1_Broadcast1_2
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_1_Broadcast1_3
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_1_Broadcast1_4
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_2_Broadcast1_0
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_2_Broadcast1_1
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_2_Broadcast1_2
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_2_Broadcast1_3
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast Cost_Parallel_Work_2_Broadcast1_4
		{
			// memcpy #0
			// memcpy #0
		}
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_explode__2
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_explode__2
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_explode__4
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_explode__4
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__56
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__56
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__60
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__60
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__117
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__117
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__119
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__119
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__120
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__120
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__62
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__62
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__70
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__70
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__72
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__72
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__75
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__75
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__38
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__38
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__41
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__41
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_1_26__offset__0,out1_1__rgbL__1,weights__in_1__1); // Cost_Parallel_Work_0_ComputeHorWeights_1
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Compute__7
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Compute__7
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_0_22__offset__0,out0_0__rgbL__0,weights__in_0__4); // Cost_Parallel_Work_0_ComputeVertWeights_0
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__46
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__46
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_4_22__offset__0,out0_0__rgbL__4,weights__in_4__4); // Cost_Parallel_Work_0_ComputeVertWeights_4
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_0_26__offset__1,out1_1__rgbL__5,weights__in_0__1); // Cost_Parallel_Work_1_ComputeHorWeights_0
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_1_26__offset__1,out1_1__rgbL__6,weights__in_1__3); // Cost_Parallel_Work_1_ComputeHorWeights_1
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_2_26__offset__1,out1_1__rgbL__7,weights__in_2__1); // Cost_Parallel_Work_1_ComputeHorWeights_2
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_3_26__offset__1,out1_1__rgbL__8,weights__in_3__3); // Cost_Parallel_Work_1_ComputeHorWeights_3
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_4_26__offset__1,out1_1__rgbL__9,weights__in_4__1); // Cost_Parallel_Work_1_ComputeHorWeights_4
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_0_22__offset__1,out0_0__rgbL__5,weights__in_0__0); // Cost_Parallel_Work_1_ComputeVertWeights_0
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_1_22__offset__1,out0_0__rgbL__6,weights__in_1__2); // Cost_Parallel_Work_1_ComputeVertWeights_1
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_2_22__offset__1,out0_0__rgbL__7,weights__in_2__0); // Cost_Parallel_Work_1_ComputeVertWeights_2
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_3_22__offset__1,out0_0__rgbL__8,weights__in_3__2); // Cost_Parallel_Work_1_ComputeVertWeights_3
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_4_22__offset__1,out0_0__rgbL__9,weights__in_4__0); // Cost_Parallel_Work_1_ComputeVertWeights_4
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_0_26__offset__2,out1_1__rgbL__10,weights__in_0__3); // Cost_Parallel_Work_2_ComputeHorWeights_0
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_1_26__offset__2,out1_1__rgbL__11,weights__in_1__5); // Cost_Parallel_Work_2_ComputeHorWeights_1
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_2_26__offset__2,out1_1__rgbL__12,weights__in_2__3); // Cost_Parallel_Work_2_ComputeHorWeights_2
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_3_26__offset__2,out1_1__rgbL__13,weights__in_3__5); // Cost_Parallel_Work_2_ComputeHorWeights_3
		computeWeights(10/*height*/,12/*width*/,0/*horOrVert*/,out2_4_26__offset__2,out1_1__rgbL__14,weights__in_4__3); // Cost_Parallel_Work_2_ComputeHorWeights_4
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_0_22__offset__2,out0_0__rgbL__10,weights__in_0__2); // Cost_Parallel_Work_2_ComputeVertWeights_0
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_1_22__offset__2,out0_0__rgbL__11,weights__in_1__4); // Cost_Parallel_Work_2_ComputeVertWeights_1
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_2_22__offset__2,out0_0__rgbL__12,weights__in_2__2); // Cost_Parallel_Work_2_ComputeVertWeights_2
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_3_22__offset__2,out0_0__rgbL__13,weights__in_3__4); // Cost_Parallel_Work_2_ComputeVertWeights_3
		computeWeights(10/*height*/,12/*width*/,1/*horOrVert*/,out1_4_22__offset__2,out0_0__rgbL__14,weights__in_4__2); // Cost_Parallel_Work_2_ComputeVertWeights_4
		// Broadcast broadcast2_1
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast broadcast2_2
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast BR_Cost_Parallel_Work_1__grayR
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__1
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__1
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__2
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__2
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__3
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__3
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__4
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__4
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__5
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__5
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__6
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__6
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__7
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__7
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__8
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__8
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__9
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__9
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__0
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__0
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__10
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__10
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__11
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__11
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__12
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__12
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__13
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__13
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__14
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__14
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__15
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__15
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__16
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__16
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__17
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__17
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__18
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__18
		// Broadcast BR_Cost_Parallel_Work_2__grayR
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__1
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__1
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__2
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__2
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__3
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__3
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__4
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__4
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__5
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__5
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__6
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__6
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__7
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__7
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__8
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__8
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__9
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__9
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__0
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__0
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__10
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__10
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__11
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__11
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__12
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__12
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__13
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__13
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__14
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__14
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__15
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__15
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__16
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__16
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__17
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__17
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__18
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__18
		census(10/*height*/,12/*width*/,out0_0__gray__0,cen__cenR__1); // Census_R_1
		census(10/*height*/,12/*width*/,out0_0__gray__1,cen__cenR__2); // Census_R_2
		// Broadcast broadcast1_1
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast broadcast1_2
		{
			// memcpy #0
			// memcpy #0
		}
		// Broadcast BR_Cost_Parallel_Work_1__grayL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__20
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__20
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__21
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__21
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__22
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__22
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__23
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__23
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__24
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__24
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__25
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__25
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__26
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__26
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__27
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__27
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__28
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__28
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__19
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__19
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__29
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__29
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__30
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__30
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__31
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__31
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__32
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__32
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__33
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__33
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__34
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__34
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__35
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__35
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__36
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__gra__36
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__37
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__gra__37
		// Broadcast BR_Cost_Parallel_Work_2__grayL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__20
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__20
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__21
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__21
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__22
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__22
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__23
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__23
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__24
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__24
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__25
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__25
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__26
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__26
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__27
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__27
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__28
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__28
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__19
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__19
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__29
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__29
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__30
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__30
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__31
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__31
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__32
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__32
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__33
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__33
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__34
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__34
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__35
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__35
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__36
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__gra__36
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__37
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__gra__37
		census(10/*height*/,12/*width*/,out0_0__gray__3,cen__cenL__1); // Census_L_1
		census(10/*height*/,12/*width*/,out0_0__gray__4,cen__cenL__2); // Census_L_2
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Compute__6
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Compute__6
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Compute__1
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Compute__1
		receiveStart(); // Core1 > Core3: Cost_Parallel_Work_0_Compute__8
		receiveEnd(1, 3); // Core1 > Core3: Cost_Parallel_Work_0_Compute__8
		// Join Cost_Parallel_Work_0_implode_Cost_Parallel_Work_0_Broadcast2_0_in
		{
			memcpy(weights__in__4+360, weights__in_1__0+0, 360*sizeof(float));
			memcpy(weights__in__4+1080, weights__in_3__0+0, 360*sizeof(float));
		}
		// Join Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast2_0_in
		{
			memcpy(weights__in__0+360, weights__in_1__2+0, 360*sizeof(float));
			memcpy(weights__in__0+1080, weights__in_3__2+0, 360*sizeof(float));
		}
		// Join Cost_Parallel_Work_1_implode_Cost_Parallel_Work_1_Broadcast3_0_in
		{
			memcpy(weights__in__1+360, weights__in_1__3+0, 360*sizeof(float));
			memcpy(weights__in__1+1080, weights__in_3__3+0, 360*sizeof(float));
		}
		// Join Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast2_0_in
		{
			memcpy(weights__in__2+360, weights__in_1__4+0, 360*sizeof(float));
			memcpy(weights__in__2+1080, weights__in_3__4+0, 360*sizeof(float));
		}
		// Join Cost_Parallel_Work_2_implode_Cost_Parallel_Work_2_Broadcast3_0_in
		{
			memcpy(weights__in__3+360, weights__in_1__5+0, 360*sizeof(float));
			memcpy(weights__in__3+1080, weights__in_3__5+0, 360*sizeof(float));
		}
		// Broadcast Cost_Parallel_Work_0_Broadcast2_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Broadca__0
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_0_Broadca__0
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__1
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__1
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__2
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__2
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__4
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__4
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__5
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__5
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__7
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__7
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__9
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__9
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__10
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__10
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__11
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__11
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__12
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__12
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__13
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__13
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__14
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__14
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__15
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__15
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__16
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__16
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__17
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_Broadca__17
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__18
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_0_Broadca__18
		// Broadcast Cost_Parallel_Work_1_Broadcast2_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__0
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__0
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__1
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__1
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__2
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__2
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__3
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__3
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__4
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__4
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__5
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__5
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__6
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__6
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__7
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__7
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__8
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__8
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__9
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__9
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__10
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__10
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__11
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__11
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__12
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__12
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__13
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__13
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__14
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__14
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__15
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__15
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__16
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__16
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__17
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__17
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__18
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__18
		// Broadcast Cost_Parallel_Work_1_Broadcast3_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__19
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__19
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__20
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__20
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__21
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__21
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__22
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__22
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__23
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__23
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__24
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__24
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__25
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__25
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__26
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__26
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__27
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__27
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__28
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__28
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__29
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__29
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__30
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__30
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__31
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__31
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__32
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__32
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__33
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__33
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__34
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__34
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__35
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__35
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__36
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_1_Broadca__36
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__37
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_1_Broadca__37
		// Broadcast Cost_Parallel_Work_2_Broadcast2_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__0
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__0
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__1
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__1
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__2
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__2
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__3
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__3
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__4
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__4
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__5
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__5
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__6
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__6
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__7
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__7
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__8
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__8
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__9
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__9
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__10
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__10
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__11
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__11
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__12
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__12
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__13
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__13
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__14
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__14
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__15
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__15
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__16
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__16
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__17
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__17
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__18
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__18
		// Broadcast Cost_Parallel_Work_2_Broadcast3_0
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__19
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__19
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__20
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__20
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__21
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__21
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__22
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__22
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__23
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__23
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__24
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__24
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__25
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__25
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__26
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__26
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__27
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__27
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__28
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__28
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__29
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__29
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__30
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__30
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__31
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__31
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__32
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__32
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__33
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__33
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__34
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__34
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__35
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__35
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__36
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_2_Broadca__36
		sendStart(3, 2); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__37
		sendEnd(); // Core3 > Core2: Cost_Parallel_Work_2_Broadca__37
		// Broadcast BR_Cost_Parallel_Work_1__cenR
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__1
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__1
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__2
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__2
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__3
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__3
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__4
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__4
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__5
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__5
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__6
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__6
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__7
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__7
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__8
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__8
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__9
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__9
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__0
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__0
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__10
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__10
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__11
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__11
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__12
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__12
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__13
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__13
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__14
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__14
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__15
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__15
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__16
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__16
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__17
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__17
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__18
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__18
		// Broadcast BR_Cost_Parallel_Work_2__cenR
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__1
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__1
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__2
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__2
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__3
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__3
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__4
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__4
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__5
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__5
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__6
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__6
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__7
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__7
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__8
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__8
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__9
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__9
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__0
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__0
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__10
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__10
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__11
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__11
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__12
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__12
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__13
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__13
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__14
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__14
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__15
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__15
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__16
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__16
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__17
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__17
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__18
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__18
		// Broadcast BR_Cost_Parallel_Work_1__cenL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__20
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__20
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__21
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__21
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__22
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__22
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__23
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__23
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__24
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__24
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__25
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__25
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__26
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__26
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__27
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__27
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__28
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__28
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__19
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__19
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__29
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__29
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__30
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__30
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__31
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__31
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__32
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__32
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__33
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__33
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__34
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__34
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__35
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__35
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__36
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_1__cen__36
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__37
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_1__cen__37
		// Broadcast BR_Cost_Parallel_Work_2__cenL
		{
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
			// memcpy #0
		}
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__20
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__20
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__21
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__21
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__22
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__22
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__23
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__23
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__24
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__24
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__25
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__25
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__26
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__26
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__27
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__27
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__28
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__28
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__19
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__19
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__29
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__29
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__30
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__30
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__31
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__31
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__32
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__32
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__33
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__33
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__34
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__34
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__35
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__35
		sendStart(3, 1); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__36
		sendEnd(); // Core3 > Core1: BR_Cost_Parallel_Work_2__cen__36
		sendStart(3, 2); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__37
		sendEnd(); // Core3 > Core2: BR_Cost_Parallel_Work_2__cen__37
		receiveStart(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__23
		receiveEnd(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__23
		receiveStart(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__25
		receiveEnd(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__25
		receiveStart(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__28
		receiveEnd(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__28
		receiveStart(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__4
		receiveEnd(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__4
		receiveStart(); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__23
		receiveEnd(1, 3); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__23
		receiveStart(); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__4
		receiveEnd(0, 3); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__4
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_3_18__disparity__0,grayL_3_18__grayL__0,grayR_3_18__grayR__2,cenL_3_18__cenL__0,cenR_3_18__cenR__0,disparityError__disparityErr__4,back_3__back__0); // Cost_Parallel_Work_0_CostConstruction_3
		receiveStart(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__6
		receiveEnd(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__6
		receiveStart(); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__25
		receiveEnd(1, 3); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__25
		receiveStart(); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__6
		receiveEnd(0, 3); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__6
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_5_18__disparity__0,grayL_5_18__grayL__0,grayR_5_18__grayR__2,cenL_5_18__cenL__0,cenR_5_18__cenR__0,disparityError__disparityErr__2,back_5__back__0); // Cost_Parallel_Work_0_CostConstruction_5
		sendStart(3, 1); // Core3 > Core1: Cost_Parallel_Work_0_CostCon__2
		sendEnd(); // Core3 > Core1: Cost_Parallel_Work_0_CostCon__2
		receiveStart(); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__9
		receiveEnd(2, 3); // Core2 > Core3: BR_Cost_Parallel_Work_0__gra__9
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__22
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__22
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__4,out0_3_18__offsets__0,out_3_18__hWeights__2,out_3_18__vWeights__2,aggregatedDisparity__aggrega__4); // Cost_Parallel_Work_0_AggregateCost_3
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__4
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__4
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__25
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__25
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__27
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_Broadca__27
		receiveStart(); // Core2 > Core3: Cost_Parallel_Work_0_CostCon__0
		receiveEnd(2, 3); // Core2 > Core3: Cost_Parallel_Work_0_CostCon__0
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__0,out0_6_18__offsets__0,out_6_18__hWeights__2,out_6_18__vWeights__2,aggregatedDisparity__aggrega__6); // Cost_Parallel_Work_0_AggregateCost_6
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__6
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__6
		receiveStart(); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__28
		receiveEnd(1, 3); // Core1 > Core3: BR_Cost_Parallel_Work_0__cen__28
		receiveStart(); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__9
		receiveEnd(0, 3); // Core0 > Core3: BR_Cost_Parallel_Work_0__cen__9
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__126
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__126
		costConstruction(10/*height*/,12/*width*/,12/*truncValue*/,out0_8_18__disparity__0,grayL_8_18__grayL__0,grayR_8_18__grayR__2,cenL_8_18__cenL__0,cenR_8_18__cenR__0,disparityError__disparityErr__5,back_2__back__0); // Cost_Parallel_Work_0_CostConstruction_8
		aggregateCost(10/*height*/,12/*width*/,5/*nbIterations*/,disparityError__disparityErr__5,out0_8_18__offsets__0,out_8_18__hWeights__2,out_8_18__vWeights__2,aggregatedDisparity__aggrega__7); // Cost_Parallel_Work_0_AggregateCost_8
		sendStart(3, 0); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__7
		sendEnd(); // Core3 > Core0: Cost_Parallel_Work_0_Aggrega__7
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__104
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__104
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__105
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__105
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__106
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__106
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__107
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__107
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__108
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__108
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__109
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__109
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__110
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__110
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__111
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__111
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__112
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__112
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__113
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__113
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__114
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__114
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__48
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__48
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__49
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__49
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__50
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__50
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__51
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__51
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__52
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__52
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__53
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__53
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__54
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__54
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__55
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_0_Broadca__55
		// RoundBuffer RB_Cost_Parallel_Work_0__rawDisparity
		{
			// memcpy #0
		}
		split(15/*nbSlice*/,12/*width*/,10/*height*/,rawDisparity__input__0,output__rawDisparity__2); // Split_0
		// Fork explode_Split_0_output
		{
		}
		sendStart(3, 1); // Core3 > Core1: explode_Split_0_output__Medi__3
		sendEnd(); // Core3 > Core1: explode_Split_0_output__Medi__3
		sendStart(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__4
		sendEnd(); // Core3 > Core2: explode_Split_0_output__Medi__4
		sendStart(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__5
		sendEnd(); // Core3 > Core2: explode_Split_0_output__Medi__5
		sendStart(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__6
		sendEnd(); // Core3 > Core2: explode_Split_0_output__Medi__6
		sendStart(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__7
		sendEnd(); // Core3 > Core2: explode_Split_0_output__Medi__7
		sendStart(3, 2); // Core3 > Core2: explode_Split_0_output__Medi__8
		sendEnd(); // Core3 > Core2: explode_Split_0_output__Medi__8
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_0__rawDisparity__0,filteredDisparity__in_0__0); // Median_Filter_0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_1__rawDisparity__2,filteredDisparity__in_1__1); // Median_Filter_1
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_10__rawDisparity__2,filteredDisparity__in_0__3); // Median_Filter_10
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_11__rawDisparity__2,filteredDisparity__in_1__2); // Median_Filter_11
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_12__rawDisparity__2,filteredDisparity__in_2__3); // Median_Filter_12
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_2__rawDisparity__2,filteredDisparity__in_2__2); // Median_Filter_2
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_9__rawDisparity__2,filteredDisparity__in_9__1); // Median_Filter_9
		receiveStart(); // Core1 > Core3: Median_Filter_3__implode_lum__0
		receiveEnd(1, 3); // Core1 > Core3: Median_Filter_3__implode_lum__0
		receiveStart(); // Core2 > Core3: Median_Filter_4__implode_lum__0
		receiveEnd(2, 3); // Core2 > Core3: Median_Filter_4__implode_lum__0
		receiveStart(); // Core2 > Core3: Median_Filter_5__implode_lum__0
		receiveEnd(2, 3); // Core2 > Core3: Median_Filter_5__implode_lum__0
		receiveStart(); // Core2 > Core3: Median_Filter_6__implode_lum__0
		receiveEnd(2, 3); // Core2 > Core3: Median_Filter_6__implode_lum__0
		receiveStart(); // Core2 > Core3: Median_Filter_7__implode_lum__0
		receiveEnd(2, 3); // Core2 > Core3: Median_Filter_7__implode_lum__0
		receiveStart(); // Core2 > Core3: Median_Filter_8__implode_lum__0
		receiveEnd(2, 3); // Core2 > Core3: Median_Filter_8__implode_lum__0
		// Join implode_lum2RGB_0_in
		{
			memcpy(filteredDisparity__in__0+12, filteredDisparity__in_1__1+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+24, filteredDisparity__in_2__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+36, filteredDisparity__in_3__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+48, filteredDisparity__in_4__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+60, filteredDisparity__in_5__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+72, filteredDisparity__in_6__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+84, filteredDisparity__in_7__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+96, filteredDisparity__in_8__0+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__0+108, filteredDisparity__in_9__1+0, 12*sizeof(uchar));
		}
		sendStart(3, 2); // Core3 > Core2: implode_lum2RGB_0_in__lum2RG__0
		sendEnd(); // Core3 > Core2: implode_lum2RGB_0_in__lum2RG__0
		receiveStart(); // Core2 > Core3: lum2RGB_0__Display_RGB1_0__0
		receiveEnd(2, 3); // Core2 > Core3: lum2RGB_0__Display_RGB1_0__0
		displayLum(1/*id*/,out0_0__lum__0); // Display_RGB1_0
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__94
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__94
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__95
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__95
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__96
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__96
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__97
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__97
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__98
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__98
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__99
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__99
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__100
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__100
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__101
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__101
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__102
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__102
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__103
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__103
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__104
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__104
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__48
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__48
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__49
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__49
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__50
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__50
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__51
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__51
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__52
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__52
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__53
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__53
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__54
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__54
		receiveStart(); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__55
		receiveEnd(0, 3); // Core0 > Core3: Cost_Parallel_Work_1_Broadca__55
		// RoundBuffer RB_Cost_Parallel_Work_1__rawDisparity
		{
			// memcpy #0
		}
		split(15/*nbSlice*/,12/*width*/,10/*height*/,rawDisparity__input__1,output__rawDisparity__0); // Split_1
		// Fork explode_Split_1_output
		{
			memcpy(output_0__rawDisparity_1__1+0, output__rawDisparity__0+0, 24*sizeof(uchar));
			memcpy(output_13__rawDisparity_0__1+0, output__rawDisparity__0+456, 24*sizeof(uchar));
		}
		sendStart(3, 1); // Core3 > Core1: explode_Split_1_output__Medi__10
		sendEnd(); // Core3 > Core1: explode_Split_1_output__Medi__10
		sendStart(3, 0); // Core3 > Core0: explode_Split_1_output__impl__0
		sendEnd(); // Core3 > Core0: explode_Split_1_output__impl__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_1__rawDisparity__0,filteredDisparity__in_4__3); // Median_Filter_14
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_2__rawDisparity__0,filteredDisparity__in_5__2); // Median_Filter_15
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_3__rawDisparity__0,filteredDisparity__in_6__2); // Median_Filter_16
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_4__rawDisparity__0,filteredDisparity__in_7__3); // Median_Filter_17
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_5__rawDisparity__0,filteredDisparity__in_8__3); // Median_Filter_18
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_6__rawDisparity__0,filteredDisparity__in_9__2); // Median_Filter_19
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_7__rawDisparity__0,filteredDisparity__in_0__1); // Median_Filter_20
		sendStart(3, 0); // Core3 > Core0: Median_Filter_20__implode_lu__0
		sendEnd(); // Core3 > Core0: Median_Filter_20__implode_lu__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_8__rawDisparity__0,filteredDisparity__in_1__0); // Median_Filter_21
		sendStart(3, 0); // Core3 > Core0: Median_Filter_21__implode_lu__0
		sendEnd(); // Core3 > Core0: Median_Filter_21__implode_lu__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_9__rawDisparity__0,filteredDisparity__in_2__0); // Median_Filter_22
		sendStart(3, 0); // Core3 > Core0: Median_Filter_22__implode_lu__0
		sendEnd(); // Core3 > Core0: Median_Filter_22__implode_lu__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_10__rawDisparity__0,filteredDisparity__in_3__1); // Median_Filter_23
		sendStart(3, 0); // Core3 > Core0: Median_Filter_23__implode_lu__0
		sendEnd(); // Core3 > Core0: Median_Filter_23__implode_lu__0
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_12__rawDisparity__0,filteredDisparity__in_5__1); // Median_Filter_25
		sendStart(3, 0); // Core3 > Core0: Median_Filter_25__implode_lu__0
		sendEnd(); // Core3 > Core0: Median_Filter_25__implode_lu__0
		// Join implode_Median_Filter_13_rawDisparity
		{
			memcpy(output__rawDisparity__4+0, output_13__rawDisparity_0__0+0, 12*sizeof(uchar));
		}
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output__rawDisparity__4,filteredDisparity__in_3__3); // Median_Filter_13
		// Join implode_lum2RGB_1_in
		{
			memcpy(filteredDisparity__in__3+12, filteredDisparity__in_1__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+24, filteredDisparity__in_2__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+36, filteredDisparity__in_3__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+48, filteredDisparity__in_4__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+60, filteredDisparity__in_5__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+72, filteredDisparity__in_6__2+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+84, filteredDisparity__in_7__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+96, filteredDisparity__in_8__3+0, 12*sizeof(uchar));
			memcpy(filteredDisparity__in__3+108, filteredDisparity__in_9__2+0, 12*sizeof(uchar));
		}
		// Broadcast lum2RGB_1
		{
			// memcpy #0
			// memcpy #0
		}
		displayLum(1/*id*/,out0_0__lum__3); // Display_RGB1_1
		writePPM(10/*height*/,12/*width*/,out1_1__gray__3); // Write_PPM_1
		receiveStart(); // Core0 > Core3: explode_Split_2_output__Medi__2
		receiveEnd(0, 3); // Core0 > Core3: explode_Split_2_output__Medi__2
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_3__rawDisparity__1,filteredDisparity__in_9__0); // Median_Filter_29
		sendStart(3, 0); // Core3 > Core0: Median_Filter_29__implode_lu__0
		sendEnd(); // Core3 > Core0: Median_Filter_29__implode_lu__0
		receiveStart(); // Core0 > Core3: explode_Split_2_output__Medi__6
		receiveEnd(0, 3); // Core0 > Core3: explode_Split_2_output__Medi__6
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_7__rawDisparity__1,filteredDisparity__in_3__2); // Median_Filter_33
		sendStart(3, 1); // Core3 > Core1: Median_Filter_33__implode_lu__0
		sendEnd(); // Core3 > Core1: Median_Filter_33__implode_lu__0
		receiveStart(); // Core0 > Core3: explode_Split_2_output__Medi__10
		receiveEnd(0, 3); // Core0 > Core3: explode_Split_2_output__Medi__10
		medianFilter(3/*height*/,12/*width*/,1/*topDownBorderSize*/,output_11__rawDisparity__1,filteredDisparity__in_7__2); // Median_Filter_37
		sendStart(3, 1); // Core3 > Core1: Median_Filter_37__implode_lu__0
		sendEnd(); // Core3 > Core1: Median_Filter_37__implode_lu__0
		receiveStart(); // Core1 > Core3: lum2RGB_3__Display_RGB1_3__0
		receiveEnd(1, 3); // Core1 > Core3: lum2RGB_3__Display_RGB1_3__0
		displayLum(1/*id*/,out0_0__lum__2); // Display_RGB1_3
		receiveStart(); // Core0 > Core3: lum2RGB_2__Display_RGB1_2__0
		receiveEnd(0, 3); // Core0 > Core3: lum2RGB_2__Display_RGB1_2__0
		displayLum(1/*id*/,out0_0__lum__1); // Display_RGB1_2
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
