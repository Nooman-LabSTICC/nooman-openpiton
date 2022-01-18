
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Dataflow application converted to run in OpenPiton
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"
#include "stabilization_4cores_include.h"
#include "preesm_communication.h"
#include "preesm_fifo.h"

//Barrier descriptor
m_barrier iter_barrier;


//Core Global Definitions
//********** Core0 global definitions *****************
char Shared[8124]; //  size:= 8124*char
char Core0[2600]; //  size:= 2600*char
char *const Stabilization_init_in_render__0 = (char*) (Shared+0);  // Stabilization_init_in_renderFrame_yPrev > Stabilization_0_renderFrame_0 size:= 2600*char
char *const Stabilization_0_renderFrame___0 = (char*) (Shared+2600);  // Stabilization_0_renderFrame_0 > Stabilization_0_BrY_0 size:= 2600*char
char *const Stabilization_0_BrY_0__Dupli__0 = (char*) (Shared+2600);  // Stabilization_0_BrY_0 > DuplicateY_0 size:= 2600*char
char *const DuplicateY_0__DisplayYUV_0__0 = (char*) (Shared+2600);  // DuplicateY_0 > DisplayYUV_0 size:= 2600*char
char *const DuplicateY_0__WriteYUV_0__0 = (char*) (Shared+2600);  // DuplicateY_0 > WriteYUV_0 size:= 2600*char
char *const Stabilization_init_in_render__1 = (char*) (Shared+5200);  // Stabilization_init_in_renderFrame_uPrev > Stabilization_0_renderFrame_0 size:= 650*char
char *const Stabilization_init_in_render__2 = (char*) (Shared+5850);  // Stabilization_init_in_renderFrame_vPrev > Stabilization_0_renderFrame_0 size:= 650*char
char *const Stabilization_0_renderFrame___1 = (char*) (Shared+6500);  // Stabilization_0_renderFrame_0 > Stabilization_0_BrU_0 size:= 650*char
char *const Stabilization_0_BrU_0__Dupli__0 = (char*) (Shared+6500);  // Stabilization_0_BrU_0 > DuplicateU_0 size:= 650*char
char *const DuplicateU_0__DisplayYUV_0__0 = (char*) (Shared+6500);  // DuplicateU_0 > DisplayYUV_0 size:= 650*char
char *const DuplicateU_0__WriteYUV_0__0 = (char*) (Shared+6500);  // DuplicateU_0 > WriteYUV_0 size:= 650*char
char *const Stabilization_0_renderFrame___2 = (char*) (Shared+7150);  // Stabilization_0_renderFrame_0 > Stabilization_0_BrV_0 size:= 650*char
char *const Stabilization_0_BrV_0__Dupli__0 = (char*) (Shared+7150);  // Stabilization_0_BrV_0 > DuplicateV_0 size:= 650*char
char *const DuplicateV_0__DisplayYUV_0__0 = (char*) (Shared+7150);  // DuplicateV_0 > DisplayYUV_0 size:= 650*char
char *const DuplicateV_0__WriteYUV_0__0 = (char*) (Shared+7150);  // DuplicateV_0 > WriteYUV_0 size:= 650*char
char *const Stabilization_0_BrU_0__Stabi__0 = (char*) (Shared+5200);  // Stabilization_0_BrU_0 > Stabilization_end_out_BrU_out_1 size:= 650*char
char *const Stabilization_0_BrV_0__Stabi__0 = (char*) (Shared+5850);  // Stabilization_0_BrV_0 > Stabilization_end_out_BrV_out_1 size:= 650*char
char *const Stabilization_0_ComputeBlock__0 = (char*) (Shared+2600);  // Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0 > Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord size:= 240*char
char *const Stabilization_0_ComputeBlock__1 = (char*) (Shared+2600);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0 size:= 8*char
char *const Stabilization_0_ComputeBlock__2 = (char*) (Shared+2608);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1 size:= 8*char
char *const Stabilization_0_ComputeBlock__3 = (char*) (Shared+2616);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2 size:= 8*char
char *const Stabilization_0_ComputeBlock__4 = (char*) (Shared+2624);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3 size:= 8*char
char *const Stabilization_0_ComputeBlock__5 = (char*) (Shared+2632);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4 size:= 8*char
char *const Stabilization_0_ComputeBlock__6 = (char*) (Shared+2640);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5 size:= 8*char
char *const Stabilization_0_ComputeBlock__7 = (char*) (Shared+2648);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6 size:= 8*char
char *const Stabilization_0_ComputeBlock__8 = (char*) (Shared+2656);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7 size:= 8*char
char *const Stabilization_0_ComputeBlock__9 = (char*) (Shared+2664);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8 size:= 8*char
char *const Stabilization_0_ComputeBlock__10 = (char*) (Shared+2672);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9 size:= 8*char
char *const Stabilization_0_ComputeBlock__11 = (char*) (Shared+2680);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10 size:= 8*char
char *const Stabilization_0_ComputeBlock__12 = (char*) (Shared+2688);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11 size:= 8*char
char *const Stabilization_0_ComputeBlock__13 = (char*) (Shared+2696);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12 size:= 8*char
char *const Stabilization_0_ComputeBlock__14 = (char*) (Shared+2704);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13 size:= 8*char
char *const Stabilization_0_ComputeBlock__15 = (char*) (Shared+2712);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14 size:= 8*char
char *const Stabilization_0_ComputeBlock__16 = (char*) (Shared+2720);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15 size:= 8*char
char *const Stabilization_0_ComputeBlock__17 = (char*) (Shared+2728);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16 size:= 8*char
char *const Stabilization_0_ComputeBlock__18 = (char*) (Shared+2736);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17 size:= 8*char
char *const Stabilization_0_ComputeBlock__19 = (char*) (Shared+2744);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18 size:= 8*char
char *const Stabilization_0_ComputeBlock__20 = (char*) (Shared+2752);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19 size:= 8*char
char *const Stabilization_0_ComputeBlock__21 = (char*) (Shared+2760);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20 size:= 8*char
char *const Stabilization_0_ComputeBlock__22 = (char*) (Shared+2768);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21 size:= 8*char
char *const Stabilization_0_ComputeBlock__23 = (char*) (Shared+2776);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22 size:= 8*char
char *const Stabilization_0_ComputeBlock__24 = (char*) (Shared+2784);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23 size:= 8*char
char *const Stabilization_0_ComputeBlock__25 = (char*) (Shared+2792);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24 size:= 8*char
char *const Stabilization_0_ComputeBlock__26 = (char*) (Shared+2800);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25 size:= 8*char
char *const Stabilization_0_ComputeBlock__27 = (char*) (Shared+2808);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26 size:= 8*char
char *const Stabilization_0_ComputeBlock__28 = (char*) (Shared+2816);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27 size:= 8*char
char *const Stabilization_0_ComputeBlock__29 = (char*) (Shared+2824);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28 size:= 8*char
char *const Stabilization_0_ComputeBlock__30 = (char*) (Shared+2832);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29 size:= 8*char
char *const Stabilization_0_implode_Stab__0 = (char*) (Shared+2840);  // Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors > Stabilization_0_FindDominatingMotion_0 size:= 240*char
char *const Stabilization_0_ComputeBlock__31 = (char*) (Shared+2840);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__32 = (char*) (Shared+2848);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__33 = (char*) (Shared+2856);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__34 = (char*) (Shared+2864);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__35 = (char*) (Shared+2872);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__36 = (char*) (Shared+2880);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__37 = (char*) (Shared+2888);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__38 = (char*) (Shared+2896);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__39 = (char*) (Shared+2904);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__40 = (char*) (Shared+2912);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__41 = (char*) (Shared+2920);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__42 = (char*) (Shared+2928);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__43 = (char*) (Shared+2936);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__44 = (char*) (Shared+2944);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__45 = (char*) (Shared+2952);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__46 = (char*) (Shared+2960);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__47 = (char*) (Shared+2968);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__48 = (char*) (Shared+2976);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__49 = (char*) (Shared+2984);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__50 = (char*) (Shared+2992);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__51 = (char*) (Shared+3000);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__52 = (char*) (Shared+3008);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__53 = (char*) (Shared+3016);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__54 = (char*) (Shared+3024);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__55 = (char*) (Shared+3032);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__56 = (char*) (Shared+3040);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__57 = (char*) (Shared+3048);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__58 = (char*) (Shared+3056);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__59 = (char*) (Shared+3064);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const Stabilization_0_ComputeBlock__60 = (char*) (Shared+3072);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29 > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors size:= 8*char
char *const ReadYUV_0__Stabilization_0_D__0 = (char*) (Shared+7800);  // ReadYUV_0 > Stabilization_0_DuplicateFrame_0 size:= 120*char
char *const Stabilization_0_DuplicateFra__0 = (char*) (Shared+7800);  // Stabilization_0_DuplicateFrame_0 > Stabilization_0_renderFrame_0 size:= 120*char
char *const Stabilization_0_ComputeBlock__61 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9 size:= 120*char
char *const Stabilization_init_in_Comput__0 = (char*) (Shared+3080);  // Stabilization_init_in_ComputeBlockMotionVectorss_previousFrame > Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 size:= 120*char
char *const Stabilization_0_ComputeBlock__62 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0 size:= 120*char
char *const Stabilization_0_ComputeBlock__63 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1 size:= 120*char
char *const Stabilization_0_ComputeBlock__64 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2 size:= 120*char
char *const Stabilization_0_ComputeBlock__65 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3 size:= 120*char
char *const Stabilization_0_ComputeBlock__66 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4 size:= 120*char
char *const Stabilization_0_ComputeBlock__67 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5 size:= 120*char
char *const Stabilization_0_ComputeBlock__68 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6 size:= 120*char
char *const Stabilization_0_ComputeBlock__69 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7 size:= 120*char
char *const Stabilization_0_ComputeBlock__70 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8 size:= 120*char
char *const Stabilization_0_ComputeBlock__71 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10 size:= 120*char
char *const Stabilization_0_ComputeBlock__72 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11 size:= 120*char
char *const Stabilization_0_ComputeBlock__73 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12 size:= 120*char
char *const Stabilization_0_ComputeBlock__74 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13 size:= 120*char
char *const Stabilization_0_ComputeBlock__75 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14 size:= 120*char
char *const Stabilization_0_ComputeBlock__76 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15 size:= 120*char
char *const Stabilization_0_ComputeBlock__77 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16 size:= 120*char
char *const Stabilization_0_ComputeBlock__78 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17 size:= 120*char
char *const Stabilization_0_ComputeBlock__79 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18 size:= 120*char
char *const Stabilization_0_ComputeBlock__80 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19 size:= 120*char
char *const Stabilization_0_ComputeBlock__81 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20 size:= 120*char
char *const Stabilization_0_ComputeBlock__82 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21 size:= 120*char
char *const Stabilization_0_ComputeBlock__83 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22 size:= 120*char
char *const Stabilization_0_ComputeBlock__84 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23 size:= 120*char
char *const Stabilization_0_ComputeBlock__85 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24 size:= 120*char
char *const Stabilization_0_ComputeBlock__86 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25 size:= 120*char
char *const Stabilization_0_ComputeBlock__87 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26 size:= 120*char
char *const Stabilization_0_ComputeBlock__88 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27 size:= 120*char
char *const Stabilization_0_ComputeBlock__89 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28 size:= 120*char
char *const Stabilization_0_ComputeBlock__90 = (char*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29 size:= 120*char
char *const Stabilization_0_DuplicateFra__1 = (char*) (Shared+3200);  // Stabilization_0_DuplicateFrame_0 > Stabilization_end_out_DuplicateFrame_out_1 size:= 120*char
char *const Stabilization_0_ComputeBlock__91 = (char*) (Shared+3320);  // Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0 > Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData size:= 120*char
char *const Stabilization_0_ComputeBlock__92 = (char*) (Shared+3320);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0 size:= 4*char
char *const Stabilization_0_ComputeBlock__93 = (char*) (Shared+3324);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1 size:= 4*char
char *const Stabilization_0_ComputeBlock__94 = (char*) (Shared+3328);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2 size:= 4*char
char *const Stabilization_0_ComputeBlock__95 = (char*) (Shared+3332);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3 size:= 4*char
char *const Stabilization_0_ComputeBlock__96 = (char*) (Shared+3336);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4 size:= 4*char
char *const Stabilization_0_ComputeBlock__97 = (char*) (Shared+3340);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5 size:= 4*char
char *const Stabilization_0_ComputeBlock__98 = (char*) (Shared+3344);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6 size:= 4*char
char *const Stabilization_0_ComputeBlock__99 = (char*) (Shared+3348);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7 size:= 4*char
char *const Stabilization_0_ComputeBlock__100 = (char*) (Shared+3352);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8 size:= 4*char
char *const Stabilization_0_ComputeBlock__101 = (char*) (Shared+3356);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9 size:= 4*char
char *const Stabilization_0_ComputeBlock__102 = (char*) (Shared+3360);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10 size:= 4*char
char *const Stabilization_0_ComputeBlock__103 = (char*) (Shared+3364);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11 size:= 4*char
char *const Stabilization_0_ComputeBlock__104 = (char*) (Shared+3368);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12 size:= 4*char
char *const Stabilization_0_ComputeBlock__105 = (char*) (Shared+3372);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13 size:= 4*char
char *const Stabilization_0_ComputeBlock__106 = (char*) (Shared+3376);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14 size:= 4*char
char *const Stabilization_0_ComputeBlock__107 = (char*) (Shared+3380);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15 size:= 4*char
char *const Stabilization_0_ComputeBlock__108 = (char*) (Shared+3384);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16 size:= 4*char
char *const Stabilization_0_ComputeBlock__109 = (char*) (Shared+3388);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17 size:= 4*char
char *const Stabilization_0_ComputeBlock__110 = (char*) (Shared+3392);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18 size:= 4*char
char *const Stabilization_0_ComputeBlock__111 = (char*) (Shared+3396);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19 size:= 4*char
char *const Stabilization_0_ComputeBlock__112 = (char*) (Shared+3400);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20 size:= 4*char
char *const Stabilization_0_ComputeBlock__113 = (char*) (Shared+3404);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21 size:= 4*char
char *const Stabilization_0_ComputeBlock__114 = (char*) (Shared+3408);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22 size:= 4*char
char *const Stabilization_0_ComputeBlock__115 = (char*) (Shared+3412);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23 size:= 4*char
char *const Stabilization_0_ComputeBlock__116 = (char*) (Shared+3416);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24 size:= 4*char
char *const Stabilization_0_ComputeBlock__117 = (char*) (Shared+3420);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25 size:= 4*char
char *const Stabilization_0_ComputeBlock__118 = (char*) (Shared+3424);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26 size:= 4*char
char *const Stabilization_0_ComputeBlock__119 = (char*) (Shared+3428);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27 size:= 4*char
char *const Stabilization_0_ComputeBlock__120 = (char*) (Shared+3432);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28 size:= 4*char
char *const Stabilization_0_ComputeBlock__121 = (char*) (Shared+3436);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29 size:= 4*char
char *const ReadYUV_0__Stabilization_0_r__0 = (char*) (Shared+8040);  // ReadYUV_0 > Stabilization_0_renderFrame_0 size:= 60*char
char *const Stabilization_init_in_Accumu__0 = (char*) (Shared+3440);  // Stabilization_init_in_AccumulateMotion_accumulatedMotionIn > Stabilization_0_AccumulateMotion_0 size:= 8*char
char *const Stabilization_init_in_Accumu__1 = (char*) (Shared+3448);  // Stabilization_init_in_AccumulateMotion_filteredMotionIn > Stabilization_0_AccumulateMotion_0 size:= 8*char
char *const Stabilization_0_AccumulateMo__0 = (char*) (Shared+8100);  // Stabilization_0_AccumulateMotion_0 > Stabilization_0_DuplicateAccumulatedMotion_0 size:= 8*char
char *const Stabilization_0_DuplicateAcc__0 = (char*) (Shared+8100);  // Stabilization_0_DuplicateAccumulatedMotion_0 > Stabilization_0_renderFrame_0 size:= 8*char
char *const Stabilization_0_brFilteredMo__0 = (char*) (Shared+8108);  // Stabilization_0_brFilteredMotion_0 > Stabilization_end_out_brFilteredMotion_out_1 size:= 8*char
char *const Stabilization_0_DuplicateAcc__1 = (char*) (Shared+8116);  // Stabilization_0_DuplicateAccumulatedMotion_0 > Stabilization_end_out_DuplicateAccumulatedMotion_out_1 size:= 8*char
char *const FIFO_Head_Stabilization_end___0 = (char*) (Shared+0);  // FIFO_Head_Stabilization_end_out_BrY_out_1 > Stabilization_init_in_renderFrame_yPrev size:= 2600*char
char *const FIFO_Head_Stabilization_end___1 = (char*) (Shared+5200);  // FIFO_Head_Stabilization_end_out_BrU_out_1 > Stabilization_init_in_renderFrame_uPrev size:= 650*char
char *const FIFO_Head_Stabilization_end___2 = (char*) (Shared+5850);  // FIFO_Head_Stabilization_end_out_BrV_out_1 > Stabilization_init_in_renderFrame_vPrev size:= 650*char
char *const FIFO_Head_Stabilization_end___3 = (char*) (Shared+7920);  // FIFO_Head_Stabilization_end_out_DuplicateFrame_out_1 > Stabilization_init_in_ComputeBlockMotionVectorss_previousFrame size:= 120*char
char *const FIFO_Head_Stabilization_end___4 = (char*) (Shared+8116);  // FIFO_Head_Stabilization_end_out_DuplicateAccumulatedMotion_out_1 > Stabilization_init_in_AccumulateMotion_accumulatedMotionIn size:= 8*char
char *const FIFO_Head_Stabilization_end___5 = (char*) (Shared+8108);  // FIFO_Head_Stabilization_end_out_brFilteredMotion_out_1 > Stabilization_init_in_AccumulateMotion_filteredMotionIn size:= 8*char
char *const Stabilization_0_BrY_0__Stabi__0 = (char*) (Core0+0);  // Stabilization_0_BrY_0 > Stabilization_end_out_BrY_out_1 size:= 2600*char
uchar *const yPrev__yPrev__0 = (uchar*) (Shared+0);  // Stabilization_init_in_renderFrame_yPrev_yPrev > Stabilization_0_renderFrame_0_yPrev size:= 2600*uchar
uchar *const yOut__in__0 = (uchar*) (Shared+2600);  // Stabilization_0_renderFrame_0_yOut > Stabilization_0_BrY_0_in size:= 2600*uchar
uchar *const out_0_0__in__0 = (uchar*) (Shared+2600);  // Stabilization_0_BrY_0_out_0_0 > DuplicateY_0_in size:= 2600*uchar
uchar *const out_0_0__y__0 = (uchar*) (Shared+2600);  // DuplicateY_0_out_0_0 > DisplayYUV_0_y size:= 2600*uchar
uchar *const out_1_1__y__0 = (uchar*) (Shared+2600);  // DuplicateY_0_out_1_1 > WriteYUV_0_y size:= 2600*uchar
uchar *const uPrev__uPrev__0 = (uchar*) (Shared+5200);  // Stabilization_init_in_renderFrame_uPrev_uPrev > Stabilization_0_renderFrame_0_uPrev size:= 650*uchar
uchar *const vPrev__vPrev__0 = (uchar*) (Shared+5850);  // Stabilization_init_in_renderFrame_vPrev_vPrev > Stabilization_0_renderFrame_0_vPrev size:= 650*uchar
uchar *const uOut__in__0 = (uchar*) (Shared+6500);  // Stabilization_0_renderFrame_0_uOut > Stabilization_0_BrU_0_in size:= 650*uchar
uchar *const out_0_0__in__1 = (uchar*) (Shared+6500);  // Stabilization_0_BrU_0_out_0_0 > DuplicateU_0_in size:= 650*uchar
uchar *const out_0_0__u__0 = (uchar*) (Shared+6500);  // DuplicateU_0_out_0_0 > DisplayYUV_0_u size:= 650*uchar
uchar *const out_1_1__u__0 = (uchar*) (Shared+6500);  // DuplicateU_0_out_1_1 > WriteYUV_0_u size:= 650*uchar
uchar *const vOut__in__0 = (uchar*) (Shared+7150);  // Stabilization_0_renderFrame_0_vOut > Stabilization_0_BrV_0_in size:= 650*uchar
uchar *const out_0_0__in__2 = (uchar*) (Shared+7150);  // Stabilization_0_BrV_0_out_0_0 > DuplicateV_0_in size:= 650*uchar
uchar *const out_0_0__v__0 = (uchar*) (Shared+7150);  // DuplicateV_0_out_0_0 > DisplayYUV_0_v size:= 650*uchar
uchar *const out_1_1__v__0 = (uchar*) (Shared+7150);  // DuplicateV_0_out_1_1 > WriteYUV_0_v size:= 650*uchar
uchar *const out_1_1_1__out_1_1__0 = (uchar*) (Shared+5200);  // Stabilization_0_BrU_0_out_1_1_1 > Stabilization_end_out_BrU_out_1_out_1_1 size:= 650*uchar
uchar *const out_1_1_1__out_1_1__1 = (uchar*) (Shared+5850);  // Stabilization_0_BrV_0_out_1_1_1 > Stabilization_end_out_BrV_out_1_out_1_1 size:= 650*uchar
coord *const blocksCoord__blockCoord__0 = (coord*) (Shared+2600);  // Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord > Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blockCoord size:= 30*coord
coord *const blocksCoord_0__blockCoord__0 = (coord*) (Shared+2600);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0_blockCoord size:= 1*coord
coord *const blocksCoord_1__blockCoord__0 = (coord*) (Shared+2608);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_1 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1_blockCoord size:= 1*coord
coord *const blocksCoord_2__blockCoord__0 = (coord*) (Shared+2616);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_2 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2_blockCoord size:= 1*coord
coord *const blocksCoord_3__blockCoord__0 = (coord*) (Shared+2624);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_3 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3_blockCoord size:= 1*coord
coord *const blocksCoord_4__blockCoord__0 = (coord*) (Shared+2632);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_4 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4_blockCoord size:= 1*coord
coord *const blocksCoord_5__blockCoord__0 = (coord*) (Shared+2640);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_5 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5_blockCoord size:= 1*coord
coord *const blocksCoord_6__blockCoord__0 = (coord*) (Shared+2648);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_6 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6_blockCoord size:= 1*coord
coord *const blocksCoord_7__blockCoord__0 = (coord*) (Shared+2656);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_7 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7_blockCoord size:= 1*coord
coord *const blocksCoord_8__blockCoord__0 = (coord*) (Shared+2664);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_8 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8_blockCoord size:= 1*coord
coord *const blocksCoord_9__blockCoord__0 = (coord*) (Shared+2672);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_9 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9_blockCoord size:= 1*coord
coord *const blocksCoord_10__blockCoord__0 = (coord*) (Shared+2680);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_10 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10_blockCoord size:= 1*coord
coord *const blocksCoord_11__blockCoord__0 = (coord*) (Shared+2688);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_11 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11_blockCoord size:= 1*coord
coord *const blocksCoord_12__blockCoord__0 = (coord*) (Shared+2696);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_12 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12_blockCoord size:= 1*coord
coord *const blocksCoord_13__blockCoord__0 = (coord*) (Shared+2704);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_13 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13_blockCoord size:= 1*coord
coord *const blocksCoord_14__blockCoord__0 = (coord*) (Shared+2712);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_14 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14_blockCoord size:= 1*coord
coord *const blocksCoord_15__blockCoord__0 = (coord*) (Shared+2720);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_15 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15_blockCoord size:= 1*coord
coord *const blocksCoord_16__blockCoord__0 = (coord*) (Shared+2728);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_16 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16_blockCoord size:= 1*coord
coord *const blocksCoord_17__blockCoord__0 = (coord*) (Shared+2736);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_17 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17_blockCoord size:= 1*coord
coord *const blocksCoord_18__blockCoord__0 = (coord*) (Shared+2744);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_18 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18_blockCoord size:= 1*coord
coord *const blocksCoord_19__blockCoord__0 = (coord*) (Shared+2752);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_19 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19_blockCoord size:= 1*coord
coord *const blocksCoord_20__blockCoord__0 = (coord*) (Shared+2760);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_20 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20_blockCoord size:= 1*coord
coord *const blocksCoord_21__blockCoord__0 = (coord*) (Shared+2768);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_21 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21_blockCoord size:= 1*coord
coord *const blocksCoord_22__blockCoord__0 = (coord*) (Shared+2776);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_22 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22_blockCoord size:= 1*coord
coord *const blocksCoord_23__blockCoord__0 = (coord*) (Shared+2784);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_23 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23_blockCoord size:= 1*coord
coord *const blocksCoord_24__blockCoord__0 = (coord*) (Shared+2792);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_24 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24_blockCoord size:= 1*coord
coord *const blocksCoord_25__blockCoord__0 = (coord*) (Shared+2800);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_25 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25_blockCoord size:= 1*coord
coord *const blocksCoord_26__blockCoord__0 = (coord*) (Shared+2808);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_26 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26_blockCoord size:= 1*coord
coord *const blocksCoord_27__blockCoord__0 = (coord*) (Shared+2816);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_27 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27_blockCoord size:= 1*coord
coord *const blocksCoord_28__blockCoord__0 = (coord*) (Shared+2824);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_28 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28_blockCoord size:= 1*coord
coord *const blocksCoord_29__blockCoord__0 = (coord*) (Shared+2832);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord_blocksCoord_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29_blockCoord size:= 1*coord
coord *const vector__vectors__0 = (coord*) (Shared+2840);  // Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vector > Stabilization_0_FindDominatingMotion_0_vectors size:= 30*coord
coord *const vector__vectors_0__0 = (coord*) (Shared+2840);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_0 size:= 1*coord
coord *const vector__vectors_1__0 = (coord*) (Shared+2848);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_1 size:= 1*coord
coord *const vector__vectors_2__0 = (coord*) (Shared+2856);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_2 size:= 1*coord
coord *const vector__vectors_3__0 = (coord*) (Shared+2864);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_3 size:= 1*coord
coord *const vector__vectors_4__0 = (coord*) (Shared+2872);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_4 size:= 1*coord
coord *const vector__vectors_5__0 = (coord*) (Shared+2880);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_5 size:= 1*coord
coord *const vector__vectors_6__0 = (coord*) (Shared+2888);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_6 size:= 1*coord
coord *const vector__vectors_7__0 = (coord*) (Shared+2896);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_7 size:= 1*coord
coord *const vector__vectors_8__0 = (coord*) (Shared+2904);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_8 size:= 1*coord
coord *const vector__vectors_9__0 = (coord*) (Shared+2912);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_9 size:= 1*coord
coord *const vector__vectors_10__0 = (coord*) (Shared+2920);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_10 size:= 1*coord
coord *const vector__vectors_11__0 = (coord*) (Shared+2928);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_11 size:= 1*coord
coord *const vector__vectors_12__0 = (coord*) (Shared+2936);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_12 size:= 1*coord
coord *const vector__vectors_13__0 = (coord*) (Shared+2944);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_13 size:= 1*coord
coord *const vector__vectors_14__0 = (coord*) (Shared+2952);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_14 size:= 1*coord
coord *const vector__vectors_15__0 = (coord*) (Shared+2960);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_15 size:= 1*coord
coord *const vector__vectors_16__0 = (coord*) (Shared+2968);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_16 size:= 1*coord
coord *const vector__vectors_17__0 = (coord*) (Shared+2976);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_17 size:= 1*coord
coord *const vector__vectors_18__0 = (coord*) (Shared+2984);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_18 size:= 1*coord
coord *const vector__vectors_19__0 = (coord*) (Shared+2992);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_19 size:= 1*coord
coord *const vector__vectors_20__0 = (coord*) (Shared+3000);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_20 size:= 1*coord
coord *const vector__vectors_21__0 = (coord*) (Shared+3008);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_21 size:= 1*coord
coord *const vector__vectors_22__0 = (coord*) (Shared+3016);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_22 size:= 1*coord
coord *const vector__vectors_23__0 = (coord*) (Shared+3024);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_23 size:= 1*coord
coord *const vector__vectors_24__0 = (coord*) (Shared+3032);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_24 size:= 1*coord
coord *const vector__vectors_25__0 = (coord*) (Shared+3040);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_25 size:= 1*coord
coord *const vector__vectors_26__0 = (coord*) (Shared+3048);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_26 size:= 1*coord
coord *const vector__vectors_27__0 = (coord*) (Shared+3056);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_27 size:= 1*coord
coord *const vector__vectors_28__0 = (coord*) (Shared+3064);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_28 size:= 1*coord
coord *const vector__vectors_29__0 = (coord*) (Shared+3072);  // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29_vector > Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors_vectors_29 size:= 1*coord
uchar *const y__in__0 = (uchar*) (Shared+7800);  // ReadYUV_0_y > Stabilization_0_DuplicateFrame_0_in size:= 120*uchar
uchar *const out_2_2__yIn__0 = (uchar*) (Shared+7800);  // Stabilization_0_DuplicateFrame_0_out_2_2 > Stabilization_0_renderFrame_0_yIn size:= 120*uchar
uchar *const out_9_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_9_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9_previousFrame size:= 120*uchar
uchar *const in__in__0 = (uchar*) (Shared+3080);  // Stabilization_init_in_ComputeBlockMotionVectorss_previousFrame_in > Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_in size:= 120*uchar
uchar *const out_0_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_0_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0_previousFrame size:= 120*uchar
uchar *const out_1_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_1_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1_previousFrame size:= 120*uchar
uchar *const out_2_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_2_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2_previousFrame size:= 120*uchar
uchar *const out_3_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_3_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3_previousFrame size:= 120*uchar
uchar *const out_4_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_4_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4_previousFrame size:= 120*uchar
uchar *const out_5_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_5_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5_previousFrame size:= 120*uchar
uchar *const out_6_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_6_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6_previousFrame size:= 120*uchar
uchar *const out_7_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_7_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7_previousFrame size:= 120*uchar
uchar *const out_8_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_8_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8_previousFrame size:= 120*uchar
uchar *const out_10_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_10_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10_previousFrame size:= 120*uchar
uchar *const out_11_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_11_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11_previousFrame size:= 120*uchar
uchar *const out_12_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_12_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12_previousFrame size:= 120*uchar
uchar *const out_13_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_13_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13_previousFrame size:= 120*uchar
uchar *const out_14_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_14_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14_previousFrame size:= 120*uchar
uchar *const out_15_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_15_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15_previousFrame size:= 120*uchar
uchar *const out_16_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_16_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16_previousFrame size:= 120*uchar
uchar *const out_17_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_17_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17_previousFrame size:= 120*uchar
uchar *const out_18_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_18_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18_previousFrame size:= 120*uchar
uchar *const out_19_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_19_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19_previousFrame size:= 120*uchar
uchar *const out_20_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_20_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20_previousFrame size:= 120*uchar
uchar *const out_21_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_21_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21_previousFrame size:= 120*uchar
uchar *const out_22_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_22_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22_previousFrame size:= 120*uchar
uchar *const out_23_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_23_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23_previousFrame size:= 120*uchar
uchar *const out_24_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_24_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24_previousFrame size:= 120*uchar
uchar *const out_25_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_25_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25_previousFrame size:= 120*uchar
uchar *const out_26_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_26_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26_previousFrame size:= 120*uchar
uchar *const out_27_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_27_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27_previousFrame size:= 120*uchar
uchar *const out_28_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_28_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28_previousFrame size:= 120*uchar
uchar *const out_29_29__previousFrame__0 = (uchar*) (Shared+3080);  // Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0_out_29_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29_previousFrame size:= 120*uchar
uchar *const out_1_1_1__out_1_1__2 = (uchar*) (Shared+3200);  // Stabilization_0_DuplicateFrame_0_out_1_1_1 > Stabilization_end_out_DuplicateFrame_out_1_out_1_1 size:= 120*uchar
uchar *const blocksData__blockData__0 = (uchar*) (Shared+3320);  // Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData > Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blockData size:= 120*uchar
uchar *const blocksData_0__blockData__0 = (uchar*) (Shared+3320);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_0 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0_blockData size:= 4*uchar
uchar *const blocksData_1__blockData__0 = (uchar*) (Shared+3324);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_1 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1_blockData size:= 4*uchar
uchar *const blocksData_2__blockData__0 = (uchar*) (Shared+3328);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_2 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2_blockData size:= 4*uchar
uchar *const blocksData_3__blockData__0 = (uchar*) (Shared+3332);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_3 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3_blockData size:= 4*uchar
uchar *const blocksData_4__blockData__0 = (uchar*) (Shared+3336);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_4 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4_blockData size:= 4*uchar
uchar *const blocksData_5__blockData__0 = (uchar*) (Shared+3340);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_5 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5_blockData size:= 4*uchar
uchar *const blocksData_6__blockData__0 = (uchar*) (Shared+3344);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_6 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6_blockData size:= 4*uchar
uchar *const blocksData_7__blockData__0 = (uchar*) (Shared+3348);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_7 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7_blockData size:= 4*uchar
uchar *const blocksData_8__blockData__0 = (uchar*) (Shared+3352);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_8 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8_blockData size:= 4*uchar
uchar *const blocksData_9__blockData__0 = (uchar*) (Shared+3356);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_9 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9_blockData size:= 4*uchar
uchar *const blocksData_10__blockData__0 = (uchar*) (Shared+3360);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_10 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10_blockData size:= 4*uchar
uchar *const blocksData_11__blockData__0 = (uchar*) (Shared+3364);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_11 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11_blockData size:= 4*uchar
uchar *const blocksData_12__blockData__0 = (uchar*) (Shared+3368);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_12 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12_blockData size:= 4*uchar
uchar *const blocksData_13__blockData__0 = (uchar*) (Shared+3372);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_13 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13_blockData size:= 4*uchar
uchar *const blocksData_14__blockData__0 = (uchar*) (Shared+3376);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_14 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14_blockData size:= 4*uchar
uchar *const blocksData_15__blockData__0 = (uchar*) (Shared+3380);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_15 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15_blockData size:= 4*uchar
uchar *const blocksData_16__blockData__0 = (uchar*) (Shared+3384);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_16 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16_blockData size:= 4*uchar
uchar *const blocksData_17__blockData__0 = (uchar*) (Shared+3388);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_17 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17_blockData size:= 4*uchar
uchar *const blocksData_18__blockData__0 = (uchar*) (Shared+3392);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_18 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18_blockData size:= 4*uchar
uchar *const blocksData_19__blockData__0 = (uchar*) (Shared+3396);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_19 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19_blockData size:= 4*uchar
uchar *const blocksData_20__blockData__0 = (uchar*) (Shared+3400);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_20 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20_blockData size:= 4*uchar
uchar *const blocksData_21__blockData__0 = (uchar*) (Shared+3404);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_21 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21_blockData size:= 4*uchar
uchar *const blocksData_22__blockData__0 = (uchar*) (Shared+3408);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_22 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22_blockData size:= 4*uchar
uchar *const blocksData_23__blockData__0 = (uchar*) (Shared+3412);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_23 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23_blockData size:= 4*uchar
uchar *const blocksData_24__blockData__0 = (uchar*) (Shared+3416);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_24 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24_blockData size:= 4*uchar
uchar *const blocksData_25__blockData__0 = (uchar*) (Shared+3420);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_25 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25_blockData size:= 4*uchar
uchar *const blocksData_26__blockData__0 = (uchar*) (Shared+3424);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_26 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26_blockData size:= 4*uchar
uchar *const blocksData_27__blockData__0 = (uchar*) (Shared+3428);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_27 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27_blockData size:= 4*uchar
uchar *const blocksData_28__blockData__0 = (uchar*) (Shared+3432);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_28 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28_blockData size:= 4*uchar
uchar *const blocksData_29__blockData__0 = (uchar*) (Shared+3436);  // Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData_blocksData_29 > Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29_blockData size:= 4*uchar
uchar *const u__uIn__0 = (uchar*) (Shared+8040);  // ReadYUV_0_u > Stabilization_0_renderFrame_0_uIn size:= 30*uchar
uchar *const v__vIn__0 = (uchar*) (Shared+8070);  // ReadYUV_0_v > Stabilization_0_renderFrame_0_vIn size:= 30*uchar
coordf *const accumulatedMotionIn__accumul__0 = (coordf*) (Shared+3440);  // Stabilization_init_in_AccumulateMotion_accumulatedMotionIn_accumulatedMotionIn > Stabilization_0_AccumulateMotion_0_accumulatedMotionIn size:= 1*coordf
coordf *const filteredMotionIn__filteredMo__0 = (coordf*) (Shared+3448);  // Stabilization_init_in_AccumulateMotion_filteredMotionIn_filteredMotionIn > Stabilization_0_AccumulateMotion_0_filteredMotionIn size:= 1*coordf
coordf *const accumulatedMotionOut__in__0 = (coordf*) (Shared+8100);  // Stabilization_0_AccumulateMotion_0_accumulatedMotionOut > Stabilization_0_DuplicateAccumulatedMotion_0_in size:= 1*coordf
coordf *const out_0_0__delta__0 = (coordf*) (Shared+8100);  // Stabilization_0_DuplicateAccumulatedMotion_0_out_0_0 > Stabilization_0_renderFrame_0_delta size:= 1*coordf
coordf *const out_1_1_1__out_1_1__3 = (coordf*) (Shared+8108);  // Stabilization_0_brFilteredMotion_0_out_1_1_1 > Stabilization_end_out_brFilteredMotion_out_1_out_1_1 size:= 1*coordf
coordf *const out_1_1_1__out_1_1__4 = (coordf*) (Shared+8116);  // Stabilization_0_DuplicateAccumulatedMotion_0_out_1_1_1 > Stabilization_end_out_DuplicateAccumulatedMotion_out_1_out_1_1 size:= 1*coordf
uchar *const out_1_1_1__out_1_1__5 = (uchar*) (Core0+0);  // Stabilization_0_BrY_0_out_1_1_1 > Stabilization_end_out_BrY_out_1_out_1_1 size:= 2600*uchar

//********** Core1 global definitions *****************
char Core1[120]; //  size:= 120*char
char *const Stabilization_0_DuplicateFra__2 = (char*) (Core1+0);  // Stabilization_0_DuplicateFrame_0 > Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0 size:= 120*char
char *const Stabilization_0_FindDominati__0 = (char*) (Core1+0);  // Stabilization_0_FindDominatingMotion_0 > Stabilization_0_AccumulateMotion_0 size:= 8*char
char *const Stabilization_0_AccumulateMo__1 = (char*) (Core1+8);  // Stabilization_0_AccumulateMotion_0 > Stabilization_0_brFilteredMotion_0 size:= 8*char
char *const Stabilization_0_brFilteredMo__1 = (char*) (Core1+8);  // Stabilization_0_brFilteredMotion_0 > Stabilization_0_renderFrame_0 size:= 8*char
uchar *const out_0_0__frame__0 = (uchar*) (Core1+0);  // Stabilization_0_DuplicateFrame_0_out_0_0 > Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_frame size:= 120*uchar
coordf *const dominatingVector__motionVect__0 = (coordf*) (Core1+0);  // Stabilization_0_FindDominatingMotion_0_dominatingVector > Stabilization_0_AccumulateMotion_0_motionVector size:= 1*coordf
coordf *const filteredMotionOut__in__0 = (coordf*) (Core1+8);  // Stabilization_0_AccumulateMotion_0_filteredMotionOut > Stabilization_0_brFilteredMotion_0_in size:= 1*coordf
coordf *const out_0_0__deltaPrev__0 = (coordf*) (Core1+8);  // Stabilization_0_brFilteredMotion_0_out_0_0 > Stabilization_0_renderFrame_0_deltaPrev size:= 1*coordf

//********** Core2 global definitions *****************

//********** Core3 global definitions *****************




//Core functions
//********** Core0 thread function *****************
void computationThread_Core0(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	initReadYUV(12/*width*/,10/*height*/); // ReadYUV_0
	yuvDisplayInit(0/*id*/,52/*width*/,50/*height*/); // DisplayYUV_0

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		printf("Enter loop\n");
		barrier_wait(&iter_barrier);
		printf("Passed barrier\n");
		readYUV(12/*width*/,10/*height*/,y__in__0,u__uIn__0,v__vIn__0); // ReadYUV_0
		printf("readYUV\n");
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: ReadYUV_0__Stabilization_0_D__0
		sendEnd(); // Core0 > Core1: ReadYUV_0__Stabilization_0_D__0
		// SyncComGroup = 0
		sendStart(0, 1); // Core0 > Core1: ReadYUV_0__Stabilization_0_r__0
		sendEnd(); // Core0 > Core1: ReadYUV_0__Stabilization_0_r__0
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__0
		// SyncComGroup = 1
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__0
		// Fork Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksCoord
		{
		}
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__1
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__1
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__2
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__2
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__4
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__4
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__5
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__5
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__6
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__6
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__8
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__8
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__9
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__9
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__10
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__10
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__12
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__12
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__13
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__13
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__14
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__14
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__16
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__16
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__17
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__17
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__18
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__18
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__20
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__20
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__21
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__21
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__22
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__22
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__24
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__24
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__25
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__25
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__26
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__26
		// SyncComGroup = 2
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__28
		sendEnd(); // Core0 > Core3: Stabilization_0_ComputeBlock__28
		// SyncComGroup = 2
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__29
		sendEnd(); // Core0 > Core1: Stabilization_0_ComputeBlock__29
		// SyncComGroup = 2
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__30
		sendEnd(); // Core0 > Core2: Stabilization_0_ComputeBlock__30
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__64
		// SyncComGroup = 3
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__64
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__68
		// SyncComGroup = 3
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__68
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__71
		// SyncComGroup = 3
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__71
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__94
		// SyncComGroup = 3
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__94
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__98
		// SyncComGroup = 3
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__98
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__102
		// SyncComGroup = 3
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__102
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_10__blockCoord__0,blocksData_10__blockData__0,out_10_29__previousFrame__0,vector__vectors_10__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_10
		printf("computeBlockMotionVector 1\n");
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__75
		// SyncComGroup = 4
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__75
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__106
		// SyncComGroup = 4
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__106
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_14__blockCoord__0,blocksData_14__blockData__0,out_14_29__previousFrame__0,vector__vectors_14__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_14
		printf("computeBlockMotionVector 2\n");
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__79
		// SyncComGroup = 5
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__79
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__110
		// SyncComGroup = 5
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__110
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_18__blockCoord__0,blocksData_18__blockData__0,out_18_29__previousFrame__0,vector__vectors_18__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_18
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_2__blockCoord__0,blocksData_2__blockData__0,out_2_29__previousFrame__0,vector__vectors_2__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_2
		printf("computeBlockMotionVector 3\n");
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__83
		// SyncComGroup = 6
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__83
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__114
		// SyncComGroup = 6
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__114
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_22__blockCoord__0,blocksData_22__blockData__0,out_22_29__previousFrame__0,vector__vectors_22__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_22
		printf("computeBlockMotionVector 4\n");
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__87
		// SyncComGroup = 7
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__87
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__118
		// SyncComGroup = 7
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__118
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_26__blockCoord__0,blocksData_26__blockData__0,out_26_29__previousFrame__0,vector__vectors_26__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_26
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_6__blockCoord__0,blocksData_6__blockData__0,out_6_29__previousFrame__0,vector__vectors_6__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_6
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__31
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__31
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__32
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__32
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__42
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__42
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__43
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__43
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__44
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__44
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__46
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__46
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__47
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__47
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__48
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__48
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__50
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__50
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__51
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__51
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__52
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__52
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__54
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__54
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__55
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__55
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__56
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__56
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__58
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__58
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__59
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__59
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__60
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__60
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__34
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__34
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__35
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__35
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__36
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__36
		receiveStart(); // Core3 > Core0: Stabilization_0_ComputeBlock__38
		// SyncComGroup = 8
		receiveEnd(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__38
		receiveStart(); // Core1 > Core0: Stabilization_0_ComputeBlock__39
		// SyncComGroup = 8
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__39
		receiveStart(); // Core2 > Core0: Stabilization_0_ComputeBlock__40
		// SyncComGroup = 8
		receiveEnd(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__40
		// Join Stabilization_0_implode_Stabilization_0_FindDominatingMotion_0_vectors
		{
			printf("computeBlockMotionVector 5\n");
		}
		// SyncComGroup = 9
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_implode_Stab__0
		sendEnd(); // Core0 > Core1: Stabilization_0_implode_Stab__0
		receiveStart(); // Core1 > Core0: Stabilization_0_AccumulateMo__0
		// SyncComGroup = 10
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_AccumulateMo__0
		// Broadcast Stabilization_0_DuplicateAccumulatedMotion_0
		{
			// memcpy #0
			// memcpy #0
			memcpy(out_1_1_1__out_1_1__4+0, accumulatedMotionOut__in__0+0, 1*sizeof(coordf));
		}
		// SyncComGroup = 11
		sendStart(0, 1); // Core0 > Core1: Stabilization_0_DuplicateAcc__0
		sendEnd(); // Core0 > Core1: Stabilization_0_DuplicateAcc__0
		// SyncComGroup = 11
		sendStart(0, 2); // Core0 > Core2: Stabilization_0_DuplicateAcc__1
		sendEnd(); // Core0 > Core2: Stabilization_0_DuplicateAcc__1
		receiveStart(); // Core1 > Core0: Stabilization_0_renderFrame___0
		// SyncComGroup = 12
		receiveEnd(1, 0); // Core1 > Core0: Stabilization_0_renderFrame___0
		// Broadcast Stabilization_0_BrY_0
		{
			// memcpy #0
			memcpy(out_1_1_1__out_1_1__5+0, yOut__in__0+0, 2600*sizeof(uchar));
			// memcpy #0
		}
		// SyncComGroup = 13
		sendStart(0, 3); // Core0 > Core3: Stabilization_0_BrY_0__Dupli__0
		sendEnd(); // Core0 > Core3: Stabilization_0_BrY_0__Dupli__0
		fifoPush(out_1_1_1__out_1_1__5, FIFO_Head_Stabilization_end___0, 2600*sizeof(char), NULL, 0);
		receiveStart(); // Core1 > Core0: DuplicateU_0__DisplayYUV_0__0
		// SyncComGroup = 14
		receiveEnd(1, 0); // Core1 > Core0: DuplicateU_0__DisplayYUV_0__0
		receiveStart(); // Core2 > Core0: DuplicateV_0__DisplayYUV_0__0
		// SyncComGroup = 14
		receiveEnd(2, 0); // Core2 > Core0: DuplicateV_0__DisplayYUV_0__0
		receiveStart(); // Core3 > Core0: DuplicateY_0__DisplayYUV_0__0
		// SyncComGroup = 14
		receiveEnd(3, 0); // Core3 > Core0: DuplicateY_0__DisplayYUV_0__0
		printf("yuvDisplay\n");
		yuvDisplay(0/*id*/,out_0_0__y__0,out_0_0__u__0,out_0_0__v__0); // DisplayYUV_0
	}
}

//********** Core1 thread function *****************
void computationThread_Core1(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	initYUVWrite(); // WriteYUV_0

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		receiveStart(); // Core0 > Core1: ReadYUV_0__Stabilization_0_D__0
		// SyncComGroup = 0
		receiveEnd(0, 1); // Core0 > Core1: ReadYUV_0__Stabilization_0_D__0
		// Broadcast Stabilization_0_DuplicateFrame_0
		{
			// memcpy #0
			memcpy(out_0_0__frame__0+0, y__in__0+0, 120*sizeof(uchar));
			// memcpy #0
			// memcpy #0
			memcpy(out_1_1_1__out_1_1__2+0, y__in__0+0, 120*sizeof(uchar));
		}
		// SyncComGroup = 1
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_DuplicateFra__1
		sendEnd(); // Core1 > Core2: Stabilization_0_DuplicateFra__1
		divideBlocks(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,out_0_0__frame__0,blocksCoord__blockCoord__0,blocksData__blockData__0); // Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0
		// SyncComGroup = 2
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__0
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__0
		// Fork Stabilization_0_ComputeBlockMotionVectorss_0_explode_Stabilization_0_ComputeBlockMotionVectorss_0_DivideBlocks_0_blocksData
		{
		}
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__93
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__93
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__94
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__94
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__95
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__95
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__97
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__97
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__98
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__98
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__99
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__99
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__101
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__101
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__102
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__102
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__103
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__103
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__105
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__105
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__106
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__106
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__107
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__107
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__109
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__109
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__110
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__110
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__111
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__111
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__113
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__113
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__114
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__114
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__115
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__115
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__117
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__117
		// SyncComGroup = 3
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__118
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__118
		// SyncComGroup = 3
		sendStart(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__119
		sendEnd(); // Core1 > Core3: Stabilization_0_ComputeBlock__119
		// SyncComGroup = 3
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__121
		sendEnd(); // Core1 > Core2: Stabilization_0_ComputeBlock__121
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__62
		// SyncComGroup = 4
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__62
		receiveStart(); // Core0 > Core1: ReadYUV_0__Stabilization_0_r__0
		// SyncComGroup = 4
		receiveEnd(0, 1); // Core0 > Core1: ReadYUV_0__Stabilization_0_r__0
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__1
		// SyncComGroup = 4
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__1
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_0__blockCoord__0,blocksData_0__blockData__0,out_0_29__previousFrame__0,vector__vectors_0__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_0
		// SyncComGroup = 5
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__31
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__31
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__66
		// SyncComGroup = 6
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__66
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__70
		// SyncComGroup = 6
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__70
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__73
		// SyncComGroup = 6
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__73
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__5
		// SyncComGroup = 6
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__5
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__9
		// SyncComGroup = 6
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__9
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__13
		// SyncComGroup = 6
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__13
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_12__blockCoord__0,blocksData_12__blockData__0,out_12_29__previousFrame__0,vector__vectors_12__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_12
		// SyncComGroup = 7
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__43
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__43
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__77
		// SyncComGroup = 8
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__77
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__17
		// SyncComGroup = 8
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__17
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_16__blockCoord__0,blocksData_16__blockData__0,out_16_29__previousFrame__0,vector__vectors_16__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_16
		// SyncComGroup = 9
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__47
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__47
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__81
		// SyncComGroup = 10
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__81
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__21
		// SyncComGroup = 10
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__21
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_20__blockCoord__0,blocksData_20__blockData__0,out_20_29__previousFrame__0,vector__vectors_20__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_20
		// SyncComGroup = 11
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__51
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__51
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__85
		// SyncComGroup = 12
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__85
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__25
		// SyncComGroup = 12
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__25
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_24__blockCoord__0,blocksData_24__blockData__0,out_24_29__previousFrame__0,vector__vectors_24__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_24
		// SyncComGroup = 13
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__55
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__55
		receiveStart(); // Core2 > Core1: Stabilization_0_ComputeBlock__89
		// SyncComGroup = 14
		receiveEnd(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__89
		receiveStart(); // Core0 > Core1: Stabilization_0_ComputeBlock__29
		// SyncComGroup = 14
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_ComputeBlock__29
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_28__blockCoord__0,blocksData_28__blockData__0,out_28_29__previousFrame__0,vector__vectors_28__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_28
		// SyncComGroup = 15
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__59
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__59
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_4__blockCoord__0,blocksData_4__blockData__0,out_4_29__previousFrame__0,vector__vectors_4__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_4
		// SyncComGroup = 16
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__35
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__35
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_8__blockCoord__0,blocksData_8__blockData__0,out_8_29__previousFrame__0,vector__vectors_8__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_8
		// SyncComGroup = 17
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_ComputeBlock__39
		sendEnd(); // Core1 > Core0: Stabilization_0_ComputeBlock__39
		receiveStart(); // Core0 > Core1: Stabilization_0_implode_Stab__0
		// SyncComGroup = 18
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_implode_Stab__0
		findDominatingMotionVector(30/*nbVectors*/,vector__vectors__0,dominatingVector__motionVect__0); // Stabilization_0_FindDominatingMotion_0
		receiveStart(); // Core3 > Core1: Stabilization_init_in_Accumu__0
		// SyncComGroup = 19
		receiveEnd(3, 1); // Core3 > Core1: Stabilization_init_in_Accumu__0
		receiveStart(); // Core3 > Core1: Stabilization_init_in_Accumu__1
		// SyncComGroup = 19
		receiveEnd(3, 1); // Core3 > Core1: Stabilization_init_in_Accumu__1
		accumulateMotion(dominatingVector__motionVect__0,accumulatedMotionIn__accumul__0,filteredMotionIn__filteredMo__0,filteredMotionOut__in__0,accumulatedMotionOut__in__0); // Stabilization_0_AccumulateMotion_0
		// SyncComGroup = 20
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_AccumulateMo__0
		sendEnd(); // Core1 > Core0: Stabilization_0_AccumulateMo__0
		// Broadcast Stabilization_0_brFilteredMotion_0
		{
			// memcpy #0
			// memcpy #0
			memcpy(out_1_1_1__out_1_1__3+0, filteredMotionOut__in__0+0, 1*sizeof(coordf));
		}
		// SyncComGroup = 21
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_brFilteredMo__0
		sendEnd(); // Core1 > Core2: Stabilization_0_brFilteredMo__0
		receiveStart(); // Core3 > Core1: Stabilization_init_in_render__1
		// SyncComGroup = 22
		receiveEnd(3, 1); // Core3 > Core1: Stabilization_init_in_render__1
		receiveStart(); // Core3 > Core1: Stabilization_init_in_render__2
		// SyncComGroup = 22
		receiveEnd(3, 1); // Core3 > Core1: Stabilization_init_in_render__2
		receiveStart(); // Core3 > Core1: Stabilization_init_in_render__0
		// SyncComGroup = 22
		receiveEnd(3, 1); // Core3 > Core1: Stabilization_init_in_render__0
		receiveStart(); // Core0 > Core1: Stabilization_0_DuplicateAcc__0
		// SyncComGroup = 22
		receiveEnd(0, 1); // Core0 > Core1: Stabilization_0_DuplicateAcc__0
		renderFrame(12/*frameWidth*/,10/*frameHeight*/,52/*dispWidth*/,50/*dispHeight*/,out_0_0__delta__0,out_0_0__deltaPrev__0,out_2_2__yIn__0,u__uIn__0,v__vIn__0,yPrev__yPrev__0,uPrev__uPrev__0,vPrev__vPrev__0,yOut__in__0,uOut__in__0,vOut__in__0); // Stabilization_0_renderFrame_0
		// SyncComGroup = 23
		sendStart(1, 0); // Core1 > Core0: Stabilization_0_renderFrame___0
		sendEnd(); // Core1 > Core0: Stabilization_0_renderFrame___0
		// SyncComGroup = 23
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_renderFrame___2
		sendEnd(); // Core1 > Core2: Stabilization_0_renderFrame___2
		// Broadcast Stabilization_0_BrU_0
		{
			// memcpy #0
			memcpy(out_1_1_1__out_1_1__0+0, uOut__in__0+0, 650*sizeof(uchar));
			// memcpy #0
		}
		// SyncComGroup = 24
		sendStart(1, 2); // Core1 > Core2: Stabilization_0_BrU_0__Stabi__0
		sendEnd(); // Core1 > Core2: Stabilization_0_BrU_0__Stabi__0
		// Broadcast DuplicateU_0
		{
			// memcpy #0
			// memcpy #0
		}
		// SyncComGroup = 25
		sendStart(1, 0); // Core1 > Core0: DuplicateU_0__DisplayYUV_0__0
		sendEnd(); // Core1 > Core0: DuplicateU_0__DisplayYUV_0__0
		receiveStart(); // Core2 > Core1: DuplicateV_0__WriteYUV_0__0
		// SyncComGroup = 26
		receiveEnd(2, 1); // Core2 > Core1: DuplicateV_0__WriteYUV_0__0
		receiveStart(); // Core3 > Core1: DuplicateY_0__WriteYUV_0__0
		// SyncComGroup = 26
		receiveEnd(3, 1); // Core3 > Core1: DuplicateY_0__WriteYUV_0__0
		yuvWrite(52/*width*/,50/*height*/,out_1_1__y__0,out_1_1__u__0,out_1_1__v__0); // WriteYUV_0
	}
}

//********** Core2 thread function *****************
void computationThread_Core2(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	fifoInit(FIFO_Head_Stabilization_end___3, 120*sizeof(char), NULL, 0);

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		fifoPop(in__in__0, FIFO_Head_Stabilization_end___3, 120*sizeof(char), NULL, 0);
		// Broadcast Stabilization_0_ComputeBlockMotionVectorss_0_DuplicatePreviousFrame_0
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
		}
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__62
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__62
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__64
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__64
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__65
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__65
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__66
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__66
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__68
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__68
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__69
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__69
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__70
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__70
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__71
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__71
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__72
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__72
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__73
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__73
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__75
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__75
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__76
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__76
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__77
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__77
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__79
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__79
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__80
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__80
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__81
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__81
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__83
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__83
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__84
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__84
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__85
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__85
		// SyncComGroup = 0
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__87
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__87
		// SyncComGroup = 0
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__88
		sendEnd(); // Core2 > Core3: Stabilization_0_ComputeBlock__88
		// SyncComGroup = 0
		sendStart(2, 1); // Core2 > Core1: Stabilization_0_ComputeBlock__89
		sendEnd(); // Core2 > Core1: Stabilization_0_ComputeBlock__89
		receiveStart(); // Core1 > Core2: Stabilization_0_DuplicateFra__1
		// SyncComGroup = 1
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_DuplicateFra__1
		fifoPush(out_1_1_1__out_1_1__2, FIFO_Head_Stabilization_end___3, 120*sizeof(char), NULL, 0);
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__2
		// SyncComGroup = 2
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__2
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__93
		// SyncComGroup = 2
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__93
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_1__blockCoord__0,blocksData_1__blockData__0,out_1_29__previousFrame__0,vector__vectors_1__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_1
		// SyncComGroup = 3
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__32
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__32
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__6
		// SyncComGroup = 4
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__6
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__10
		// SyncComGroup = 4
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__10
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__14
		// SyncComGroup = 4
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__14
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__97
		// SyncComGroup = 4
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__97
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__101
		// SyncComGroup = 4
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__101
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__105
		// SyncComGroup = 4
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__105
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_13__blockCoord__0,blocksData_13__blockData__0,out_13_29__previousFrame__0,vector__vectors_13__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_13
		// SyncComGroup = 5
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__44
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__44
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__18
		// SyncComGroup = 6
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__18
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__109
		// SyncComGroup = 6
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__109
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_17__blockCoord__0,blocksData_17__blockData__0,out_17_29__previousFrame__0,vector__vectors_17__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_17
		// SyncComGroup = 7
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__48
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__48
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__22
		// SyncComGroup = 8
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__22
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__113
		// SyncComGroup = 8
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__113
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_21__blockCoord__0,blocksData_21__blockData__0,out_21_29__previousFrame__0,vector__vectors_21__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_21
		// SyncComGroup = 9
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__52
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__52
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__26
		// SyncComGroup = 10
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__26
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__117
		// SyncComGroup = 10
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__117
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_25__blockCoord__0,blocksData_25__blockData__0,out_25_29__previousFrame__0,vector__vectors_25__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_25
		// SyncComGroup = 11
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__56
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__56
		receiveStart(); // Core0 > Core2: Stabilization_0_ComputeBlock__30
		// SyncComGroup = 12
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_ComputeBlock__30
		receiveStart(); // Core1 > Core2: Stabilization_0_ComputeBlock__121
		// SyncComGroup = 12
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_ComputeBlock__121
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_29__blockCoord__0,blocksData_29__blockData__0,out_29_29__previousFrame__0,vector__vectors_29__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_29
		// SyncComGroup = 13
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__60
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__60
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_5__blockCoord__0,blocksData_5__blockData__0,out_5_29__previousFrame__0,vector__vectors_5__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_5
		// SyncComGroup = 14
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__36
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__36
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_9__blockCoord__0,blocksData_9__blockData__0,out_9_29__previousFrame__0,vector__vectors_9__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_9
		// SyncComGroup = 15
		sendStart(2, 0); // Core2 > Core0: Stabilization_0_ComputeBlock__40
		sendEnd(); // Core2 > Core0: Stabilization_0_ComputeBlock__40
		receiveStart(); // Core0 > Core2: Stabilization_0_DuplicateAcc__1
		// SyncComGroup = 16
		receiveEnd(0, 2); // Core0 > Core2: Stabilization_0_DuplicateAcc__1
		fifoPush(out_1_1_1__out_1_1__4, FIFO_Head_Stabilization_end___4, 8*sizeof(char), NULL, 0);
		receiveStart(); // Core1 > Core2: Stabilization_0_brFilteredMo__0
		// SyncComGroup = 17
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_brFilteredMo__0
		fifoPush(out_1_1_1__out_1_1__3, FIFO_Head_Stabilization_end___5, 8*sizeof(char), NULL, 0);
		receiveStart(); // Core1 > Core2: Stabilization_0_renderFrame___2
		// SyncComGroup = 18
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_renderFrame___2
		// Broadcast Stabilization_0_BrV_0
		{
			// memcpy #0
			memcpy(out_1_1_1__out_1_1__1+0, vOut__in__0+0, 650*sizeof(uchar));
			// memcpy #0
		}
		// SyncComGroup = 19
		sendStart(2, 3); // Core2 > Core3: Stabilization_0_BrV_0__Stabi__0
		sendEnd(); // Core2 > Core3: Stabilization_0_BrV_0__Stabi__0
		// Broadcast DuplicateV_0
		{
			// memcpy #0
			// memcpy #0
		}
		// SyncComGroup = 20
		sendStart(2, 0); // Core2 > Core0: DuplicateV_0__DisplayYUV_0__0
		sendEnd(); // Core2 > Core0: DuplicateV_0__DisplayYUV_0__0
		// SyncComGroup = 20
		sendStart(2, 1); // Core2 > Core1: DuplicateV_0__WriteYUV_0__0
		sendEnd(); // Core2 > Core1: DuplicateV_0__WriteYUV_0__0
		receiveStart(); // Core1 > Core2: Stabilization_0_BrU_0__Stabi__0
		// SyncComGroup = 21
		receiveEnd(1, 2); // Core1 > Core2: Stabilization_0_BrU_0__Stabi__0
		fifoPush(out_1_1_1__out_1_1__0, FIFO_Head_Stabilization_end___1, 650*sizeof(char), NULL, 0);
	}
}

//********** Core3 thread function *****************
void computationThread_Core3(void *arg){
	if (arg != NULL) {
		printf("Warning: expecting NULL arguments\n");
	}
	// Initialisation(s)
	fifoInit(FIFO_Head_Stabilization_end___4, 8*sizeof(char), NULL, 0);
	fifoInit(FIFO_Head_Stabilization_end___5, 8*sizeof(char), NULL, 0);
	fifoInit(FIFO_Head_Stabilization_end___1, 650*sizeof(char), NULL, 0);
	fifoInit(FIFO_Head_Stabilization_end___2, 650*sizeof(char), NULL, 0);
	fifoInit(FIFO_Head_Stabilization_end___0, 2600*sizeof(char), NULL, 0);

	// Begin the execution loop
#ifdef LOOP_SIZE // Case of a finite loop
	int index;
	for(index=0;index<LOOP_SIZE;index++){
#else // Default case of an infinite loop
	while(1){
#endif
		barrier_wait(&iter_barrier);
		fifoPop(accumulatedMotionIn__accumul__0, FIFO_Head_Stabilization_end___4, 8*sizeof(char), NULL, 0);
		// SyncComGroup = 0
		sendStart(3, 1); // Core3 > Core1: Stabilization_init_in_Accumu__0
		sendEnd(); // Core3 > Core1: Stabilization_init_in_Accumu__0
		fifoPop(filteredMotionIn__filteredMo__0, FIFO_Head_Stabilization_end___5, 8*sizeof(char), NULL, 0);
		// SyncComGroup = 1
		sendStart(3, 1); // Core3 > Core1: Stabilization_init_in_Accumu__1
		sendEnd(); // Core3 > Core1: Stabilization_init_in_Accumu__1
		fifoPop(uPrev__uPrev__0, FIFO_Head_Stabilization_end___1, 650*sizeof(char), NULL, 0);
		// SyncComGroup = 2
		sendStart(3, 1); // Core3 > Core1: Stabilization_init_in_render__1
		sendEnd(); // Core3 > Core1: Stabilization_init_in_render__1
		fifoPop(vPrev__vPrev__0, FIFO_Head_Stabilization_end___2, 650*sizeof(char), NULL, 0);
		// SyncComGroup = 3
		sendStart(3, 1); // Core3 > Core1: Stabilization_init_in_render__2
		sendEnd(); // Core3 > Core1: Stabilization_init_in_render__2
		fifoPop(yPrev__yPrev__0, FIFO_Head_Stabilization_end___0, 2600*sizeof(char), NULL, 0);
		// SyncComGroup = 4
		sendStart(3, 1); // Core3 > Core1: Stabilization_init_in_render__0
		sendEnd(); // Core3 > Core1: Stabilization_init_in_render__0
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__65
		// SyncComGroup = 5
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__65
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__69
		// SyncComGroup = 5
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__69
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__72
		// SyncComGroup = 5
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__72
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__4
		// SyncComGroup = 5
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__4
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__8
		// SyncComGroup = 5
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__8
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__12
		// SyncComGroup = 5
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__12
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__95
		// SyncComGroup = 5
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__95
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__99
		// SyncComGroup = 5
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__99
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__103
		// SyncComGroup = 5
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__103
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_11__blockCoord__0,blocksData_11__blockData__0,out_11_29__previousFrame__0,vector__vectors_11__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_11
		// SyncComGroup = 6
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__42
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__42
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__76
		// SyncComGroup = 7
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__76
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__16
		// SyncComGroup = 7
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__16
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__107
		// SyncComGroup = 7
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__107
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_15__blockCoord__0,blocksData_15__blockData__0,out_15_29__previousFrame__0,vector__vectors_15__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_15
		// SyncComGroup = 8
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__46
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__46
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__80
		// SyncComGroup = 9
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__80
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__20
		// SyncComGroup = 9
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__20
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__111
		// SyncComGroup = 9
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__111
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_19__blockCoord__0,blocksData_19__blockData__0,out_19_29__previousFrame__0,vector__vectors_19__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_19
		// SyncComGroup = 10
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__50
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__50
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__84
		// SyncComGroup = 11
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__84
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__24
		// SyncComGroup = 11
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__24
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__115
		// SyncComGroup = 11
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__115
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_23__blockCoord__0,blocksData_23__blockData__0,out_23_29__previousFrame__0,vector__vectors_23__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_23
		// SyncComGroup = 12
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__54
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__54
		receiveStart(); // Core2 > Core3: Stabilization_0_ComputeBlock__88
		// SyncComGroup = 13
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_ComputeBlock__88
		receiveStart(); // Core0 > Core3: Stabilization_0_ComputeBlock__28
		// SyncComGroup = 13
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_ComputeBlock__28
		receiveStart(); // Core1 > Core3: Stabilization_0_ComputeBlock__119
		// SyncComGroup = 13
		receiveEnd(1, 3); // Core1 > Core3: Stabilization_0_ComputeBlock__119
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_27__blockCoord__0,blocksData_27__blockData__0,out_27_29__previousFrame__0,vector__vectors_27__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_27
		// SyncComGroup = 14
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__58
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__58
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_3__blockCoord__0,blocksData_3__blockData__0,out_3_29__previousFrame__0,vector__vectors_3__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_3
		// SyncComGroup = 15
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__34
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__34
		computeBlockMotionVector(12/*width*/,10/*height*/,2/*blockWidth*/,2/*blockHeight*/,2/*maxDeltaX*/,3/*maxDeltaY*/,blocksCoord_7__blockCoord__0,blocksData_7__blockData__0,out_7_29__previousFrame__0,vector__vectors_7__0); // Stabilization_0_ComputeBlockMotionVectorss_0_ComputeBlockMotionVector_7
		// SyncComGroup = 16
		sendStart(3, 0); // Core3 > Core0: Stabilization_0_ComputeBlock__38
		sendEnd(); // Core3 > Core0: Stabilization_0_ComputeBlock__38
		receiveStart(); // Core0 > Core3: Stabilization_0_BrY_0__Dupli__0
		// SyncComGroup = 17
		receiveEnd(0, 3); // Core0 > Core3: Stabilization_0_BrY_0__Dupli__0
		// Broadcast DuplicateY_0
		{
			// memcpy #0
			// memcpy #0
		}
		// SyncComGroup = 18
		sendStart(3, 0); // Core3 > Core0: DuplicateY_0__DisplayYUV_0__0
		sendEnd(); // Core3 > Core0: DuplicateY_0__DisplayYUV_0__0
		// SyncComGroup = 18
		sendStart(3, 1); // Core3 > Core1: DuplicateY_0__WriteYUV_0__0
		sendEnd(); // Core3 > Core1: DuplicateY_0__WriteYUV_0__0
		receiveStart(); // Core2 > Core3: Stabilization_0_BrV_0__Stabi__0
		// SyncComGroup = 19
		receiveEnd(2, 3); // Core2 > Core3: Stabilization_0_BrV_0__Stabi__0
		fifoPush(out_1_1_1__out_1_1__1, FIFO_Head_Stabilization_end___2, 650*sizeof(char), NULL, 0);
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
