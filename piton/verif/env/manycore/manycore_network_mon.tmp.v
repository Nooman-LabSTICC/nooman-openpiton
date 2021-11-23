// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: cmp_l15_messages_mon.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
//
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
//
// The above named program is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
//
// ========== Copyright Header End ============================================
////////////////////////////////////////////////////////

`include "sys.h"
`include "iop.h"
`include "cross_module.tmp.h"


// /home/ruaro/openpiton/piton/verif/env/manycore/devices_ariane.xml
`define NUM_TILES 9


`ifndef USE_TEST_TOP // useless for older TOPs

module manycore_network_mon (
    input wire clk
    );
`ifndef DISABLE_ALL_MONITORS
`ifndef DISABLE_NETWORK_MONITOR
`ifndef XBAR_CONFIG
// check boundary communication
// There are two parts to the check
/* 1. check for valid signal from valid tiles to non-valid tiles
    - from leftmost tiles to left
    - topmost tiles to top
    - ... right
    - ... bottom
    The only exception is from tile 0 to off-chip
    Implementation:
        For every valid tile, check NESW. Also because the system will not to configured to fill all tiles,
            if the tile directly below or to the right is not configured then also check for error.
*/
/* 2. check for valid signal from non-valid tiles to valid tiles
    - for every non-valid tiles, if the valid signal to an adjacent valid tile is asserted, then error
*/

integer    fd;  
integer    counter = 0;
integer    target;
integer    chipID;

//Keeps the status of each packet entering in routers
integer tile0_noc0_inL_packet_state = 0;
integer tile0_noc0_inL_bdw_allocation = 0;
integer tile0_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc0_inL_header = 0;
integer tile0_noc0_inN_packet_state = 0;
integer tile0_noc0_inN_bdw_allocation = 0;
integer tile0_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc0_inN_header = 0;
integer tile0_noc0_inS_packet_state = 0;
integer tile0_noc0_inS_bdw_allocation = 0;
integer tile0_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc0_inS_header = 0;
integer tile0_noc0_inE_packet_state = 0;
integer tile0_noc0_inE_bdw_allocation = 0;
integer tile0_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc0_inE_header = 0;
integer tile0_noc0_inW_packet_state = 0;
integer tile0_noc0_inW_bdw_allocation = 0;
integer tile0_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc0_inW_header = 0;
integer tile0_noc1_inL_packet_state = 0;
integer tile0_noc1_inL_bdw_allocation = 0;
integer tile0_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc1_inL_header = 0;
integer tile0_noc1_inN_packet_state = 0;
integer tile0_noc1_inN_bdw_allocation = 0;
integer tile0_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc1_inN_header = 0;
integer tile0_noc1_inS_packet_state = 0;
integer tile0_noc1_inS_bdw_allocation = 0;
integer tile0_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc1_inS_header = 0;
integer tile0_noc1_inE_packet_state = 0;
integer tile0_noc1_inE_bdw_allocation = 0;
integer tile0_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc1_inE_header = 0;
integer tile0_noc1_inW_packet_state = 0;
integer tile0_noc1_inW_bdw_allocation = 0;
integer tile0_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc1_inW_header = 0;
integer tile0_noc2_inL_packet_state = 0;
integer tile0_noc2_inL_bdw_allocation = 0;
integer tile0_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc2_inL_header = 0;
integer tile0_noc2_inN_packet_state = 0;
integer tile0_noc2_inN_bdw_allocation = 0;
integer tile0_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc2_inN_header = 0;
integer tile0_noc2_inS_packet_state = 0;
integer tile0_noc2_inS_bdw_allocation = 0;
integer tile0_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc2_inS_header = 0;
integer tile0_noc2_inE_packet_state = 0;
integer tile0_noc2_inE_bdw_allocation = 0;
integer tile0_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc2_inE_header = 0;
integer tile0_noc2_inW_packet_state = 0;
integer tile0_noc2_inW_bdw_allocation = 0;
integer tile0_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile0_noc2_inW_header = 0;
integer tile1_noc0_inL_packet_state = 0;
integer tile1_noc0_inL_bdw_allocation = 0;
integer tile1_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc0_inL_header = 0;
integer tile1_noc0_inN_packet_state = 0;
integer tile1_noc0_inN_bdw_allocation = 0;
integer tile1_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc0_inN_header = 0;
integer tile1_noc0_inS_packet_state = 0;
integer tile1_noc0_inS_bdw_allocation = 0;
integer tile1_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc0_inS_header = 0;
integer tile1_noc0_inE_packet_state = 0;
integer tile1_noc0_inE_bdw_allocation = 0;
integer tile1_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc0_inE_header = 0;
integer tile1_noc0_inW_packet_state = 0;
integer tile1_noc0_inW_bdw_allocation = 0;
integer tile1_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc0_inW_header = 0;
integer tile1_noc1_inL_packet_state = 0;
integer tile1_noc1_inL_bdw_allocation = 0;
integer tile1_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc1_inL_header = 0;
integer tile1_noc1_inN_packet_state = 0;
integer tile1_noc1_inN_bdw_allocation = 0;
integer tile1_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc1_inN_header = 0;
integer tile1_noc1_inS_packet_state = 0;
integer tile1_noc1_inS_bdw_allocation = 0;
integer tile1_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc1_inS_header = 0;
integer tile1_noc1_inE_packet_state = 0;
integer tile1_noc1_inE_bdw_allocation = 0;
integer tile1_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc1_inE_header = 0;
integer tile1_noc1_inW_packet_state = 0;
integer tile1_noc1_inW_bdw_allocation = 0;
integer tile1_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc1_inW_header = 0;
integer tile1_noc2_inL_packet_state = 0;
integer tile1_noc2_inL_bdw_allocation = 0;
integer tile1_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc2_inL_header = 0;
integer tile1_noc2_inN_packet_state = 0;
integer tile1_noc2_inN_bdw_allocation = 0;
integer tile1_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc2_inN_header = 0;
integer tile1_noc2_inS_packet_state = 0;
integer tile1_noc2_inS_bdw_allocation = 0;
integer tile1_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc2_inS_header = 0;
integer tile1_noc2_inE_packet_state = 0;
integer tile1_noc2_inE_bdw_allocation = 0;
integer tile1_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc2_inE_header = 0;
integer tile1_noc2_inW_packet_state = 0;
integer tile1_noc2_inW_bdw_allocation = 0;
integer tile1_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile1_noc2_inW_header = 0;
integer tile2_noc0_inL_packet_state = 0;
integer tile2_noc0_inL_bdw_allocation = 0;
integer tile2_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc0_inL_header = 0;
integer tile2_noc0_inN_packet_state = 0;
integer tile2_noc0_inN_bdw_allocation = 0;
integer tile2_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc0_inN_header = 0;
integer tile2_noc0_inS_packet_state = 0;
integer tile2_noc0_inS_bdw_allocation = 0;
integer tile2_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc0_inS_header = 0;
integer tile2_noc0_inE_packet_state = 0;
integer tile2_noc0_inE_bdw_allocation = 0;
integer tile2_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc0_inE_header = 0;
integer tile2_noc0_inW_packet_state = 0;
integer tile2_noc0_inW_bdw_allocation = 0;
integer tile2_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc0_inW_header = 0;
integer tile2_noc1_inL_packet_state = 0;
integer tile2_noc1_inL_bdw_allocation = 0;
integer tile2_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc1_inL_header = 0;
integer tile2_noc1_inN_packet_state = 0;
integer tile2_noc1_inN_bdw_allocation = 0;
integer tile2_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc1_inN_header = 0;
integer tile2_noc1_inS_packet_state = 0;
integer tile2_noc1_inS_bdw_allocation = 0;
integer tile2_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc1_inS_header = 0;
integer tile2_noc1_inE_packet_state = 0;
integer tile2_noc1_inE_bdw_allocation = 0;
integer tile2_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc1_inE_header = 0;
integer tile2_noc1_inW_packet_state = 0;
integer tile2_noc1_inW_bdw_allocation = 0;
integer tile2_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc1_inW_header = 0;
integer tile2_noc2_inL_packet_state = 0;
integer tile2_noc2_inL_bdw_allocation = 0;
integer tile2_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc2_inL_header = 0;
integer tile2_noc2_inN_packet_state = 0;
integer tile2_noc2_inN_bdw_allocation = 0;
integer tile2_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc2_inN_header = 0;
integer tile2_noc2_inS_packet_state = 0;
integer tile2_noc2_inS_bdw_allocation = 0;
integer tile2_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc2_inS_header = 0;
integer tile2_noc2_inE_packet_state = 0;
integer tile2_noc2_inE_bdw_allocation = 0;
integer tile2_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc2_inE_header = 0;
integer tile2_noc2_inW_packet_state = 0;
integer tile2_noc2_inW_bdw_allocation = 0;
integer tile2_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile2_noc2_inW_header = 0;
integer tile3_noc0_inL_packet_state = 0;
integer tile3_noc0_inL_bdw_allocation = 0;
integer tile3_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc0_inL_header = 0;
integer tile3_noc0_inN_packet_state = 0;
integer tile3_noc0_inN_bdw_allocation = 0;
integer tile3_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc0_inN_header = 0;
integer tile3_noc0_inS_packet_state = 0;
integer tile3_noc0_inS_bdw_allocation = 0;
integer tile3_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc0_inS_header = 0;
integer tile3_noc0_inE_packet_state = 0;
integer tile3_noc0_inE_bdw_allocation = 0;
integer tile3_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc0_inE_header = 0;
integer tile3_noc0_inW_packet_state = 0;
integer tile3_noc0_inW_bdw_allocation = 0;
integer tile3_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc0_inW_header = 0;
integer tile3_noc1_inL_packet_state = 0;
integer tile3_noc1_inL_bdw_allocation = 0;
integer tile3_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc1_inL_header = 0;
integer tile3_noc1_inN_packet_state = 0;
integer tile3_noc1_inN_bdw_allocation = 0;
integer tile3_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc1_inN_header = 0;
integer tile3_noc1_inS_packet_state = 0;
integer tile3_noc1_inS_bdw_allocation = 0;
integer tile3_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc1_inS_header = 0;
integer tile3_noc1_inE_packet_state = 0;
integer tile3_noc1_inE_bdw_allocation = 0;
integer tile3_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc1_inE_header = 0;
integer tile3_noc1_inW_packet_state = 0;
integer tile3_noc1_inW_bdw_allocation = 0;
integer tile3_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc1_inW_header = 0;
integer tile3_noc2_inL_packet_state = 0;
integer tile3_noc2_inL_bdw_allocation = 0;
integer tile3_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc2_inL_header = 0;
integer tile3_noc2_inN_packet_state = 0;
integer tile3_noc2_inN_bdw_allocation = 0;
integer tile3_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc2_inN_header = 0;
integer tile3_noc2_inS_packet_state = 0;
integer tile3_noc2_inS_bdw_allocation = 0;
integer tile3_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc2_inS_header = 0;
integer tile3_noc2_inE_packet_state = 0;
integer tile3_noc2_inE_bdw_allocation = 0;
integer tile3_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc2_inE_header = 0;
integer tile3_noc2_inW_packet_state = 0;
integer tile3_noc2_inW_bdw_allocation = 0;
integer tile3_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile3_noc2_inW_header = 0;
integer tile4_noc0_inL_packet_state = 0;
integer tile4_noc0_inL_bdw_allocation = 0;
integer tile4_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc0_inL_header = 0;
integer tile4_noc0_inN_packet_state = 0;
integer tile4_noc0_inN_bdw_allocation = 0;
integer tile4_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc0_inN_header = 0;
integer tile4_noc0_inS_packet_state = 0;
integer tile4_noc0_inS_bdw_allocation = 0;
integer tile4_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc0_inS_header = 0;
integer tile4_noc0_inE_packet_state = 0;
integer tile4_noc0_inE_bdw_allocation = 0;
integer tile4_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc0_inE_header = 0;
integer tile4_noc0_inW_packet_state = 0;
integer tile4_noc0_inW_bdw_allocation = 0;
integer tile4_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc0_inW_header = 0;
integer tile4_noc1_inL_packet_state = 0;
integer tile4_noc1_inL_bdw_allocation = 0;
integer tile4_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc1_inL_header = 0;
integer tile4_noc1_inN_packet_state = 0;
integer tile4_noc1_inN_bdw_allocation = 0;
integer tile4_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc1_inN_header = 0;
integer tile4_noc1_inS_packet_state = 0;
integer tile4_noc1_inS_bdw_allocation = 0;
integer tile4_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc1_inS_header = 0;
integer tile4_noc1_inE_packet_state = 0;
integer tile4_noc1_inE_bdw_allocation = 0;
integer tile4_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc1_inE_header = 0;
integer tile4_noc1_inW_packet_state = 0;
integer tile4_noc1_inW_bdw_allocation = 0;
integer tile4_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc1_inW_header = 0;
integer tile4_noc2_inL_packet_state = 0;
integer tile4_noc2_inL_bdw_allocation = 0;
integer tile4_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc2_inL_header = 0;
integer tile4_noc2_inN_packet_state = 0;
integer tile4_noc2_inN_bdw_allocation = 0;
integer tile4_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc2_inN_header = 0;
integer tile4_noc2_inS_packet_state = 0;
integer tile4_noc2_inS_bdw_allocation = 0;
integer tile4_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc2_inS_header = 0;
integer tile4_noc2_inE_packet_state = 0;
integer tile4_noc2_inE_bdw_allocation = 0;
integer tile4_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc2_inE_header = 0;
integer tile4_noc2_inW_packet_state = 0;
integer tile4_noc2_inW_bdw_allocation = 0;
integer tile4_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile4_noc2_inW_header = 0;
integer tile5_noc0_inL_packet_state = 0;
integer tile5_noc0_inL_bdw_allocation = 0;
integer tile5_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc0_inL_header = 0;
integer tile5_noc0_inN_packet_state = 0;
integer tile5_noc0_inN_bdw_allocation = 0;
integer tile5_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc0_inN_header = 0;
integer tile5_noc0_inS_packet_state = 0;
integer tile5_noc0_inS_bdw_allocation = 0;
integer tile5_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc0_inS_header = 0;
integer tile5_noc0_inE_packet_state = 0;
integer tile5_noc0_inE_bdw_allocation = 0;
integer tile5_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc0_inE_header = 0;
integer tile5_noc0_inW_packet_state = 0;
integer tile5_noc0_inW_bdw_allocation = 0;
integer tile5_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc0_inW_header = 0;
integer tile5_noc1_inL_packet_state = 0;
integer tile5_noc1_inL_bdw_allocation = 0;
integer tile5_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc1_inL_header = 0;
integer tile5_noc1_inN_packet_state = 0;
integer tile5_noc1_inN_bdw_allocation = 0;
integer tile5_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc1_inN_header = 0;
integer tile5_noc1_inS_packet_state = 0;
integer tile5_noc1_inS_bdw_allocation = 0;
integer tile5_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc1_inS_header = 0;
integer tile5_noc1_inE_packet_state = 0;
integer tile5_noc1_inE_bdw_allocation = 0;
integer tile5_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc1_inE_header = 0;
integer tile5_noc1_inW_packet_state = 0;
integer tile5_noc1_inW_bdw_allocation = 0;
integer tile5_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc1_inW_header = 0;
integer tile5_noc2_inL_packet_state = 0;
integer tile5_noc2_inL_bdw_allocation = 0;
integer tile5_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc2_inL_header = 0;
integer tile5_noc2_inN_packet_state = 0;
integer tile5_noc2_inN_bdw_allocation = 0;
integer tile5_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc2_inN_header = 0;
integer tile5_noc2_inS_packet_state = 0;
integer tile5_noc2_inS_bdw_allocation = 0;
integer tile5_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc2_inS_header = 0;
integer tile5_noc2_inE_packet_state = 0;
integer tile5_noc2_inE_bdw_allocation = 0;
integer tile5_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc2_inE_header = 0;
integer tile5_noc2_inW_packet_state = 0;
integer tile5_noc2_inW_bdw_allocation = 0;
integer tile5_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile5_noc2_inW_header = 0;
integer tile6_noc0_inL_packet_state = 0;
integer tile6_noc0_inL_bdw_allocation = 0;
integer tile6_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc0_inL_header = 0;
integer tile6_noc0_inN_packet_state = 0;
integer tile6_noc0_inN_bdw_allocation = 0;
integer tile6_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc0_inN_header = 0;
integer tile6_noc0_inS_packet_state = 0;
integer tile6_noc0_inS_bdw_allocation = 0;
integer tile6_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc0_inS_header = 0;
integer tile6_noc0_inE_packet_state = 0;
integer tile6_noc0_inE_bdw_allocation = 0;
integer tile6_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc0_inE_header = 0;
integer tile6_noc0_inW_packet_state = 0;
integer tile6_noc0_inW_bdw_allocation = 0;
integer tile6_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc0_inW_header = 0;
integer tile6_noc1_inL_packet_state = 0;
integer tile6_noc1_inL_bdw_allocation = 0;
integer tile6_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc1_inL_header = 0;
integer tile6_noc1_inN_packet_state = 0;
integer tile6_noc1_inN_bdw_allocation = 0;
integer tile6_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc1_inN_header = 0;
integer tile6_noc1_inS_packet_state = 0;
integer tile6_noc1_inS_bdw_allocation = 0;
integer tile6_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc1_inS_header = 0;
integer tile6_noc1_inE_packet_state = 0;
integer tile6_noc1_inE_bdw_allocation = 0;
integer tile6_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc1_inE_header = 0;
integer tile6_noc1_inW_packet_state = 0;
integer tile6_noc1_inW_bdw_allocation = 0;
integer tile6_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc1_inW_header = 0;
integer tile6_noc2_inL_packet_state = 0;
integer tile6_noc2_inL_bdw_allocation = 0;
integer tile6_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc2_inL_header = 0;
integer tile6_noc2_inN_packet_state = 0;
integer tile6_noc2_inN_bdw_allocation = 0;
integer tile6_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc2_inN_header = 0;
integer tile6_noc2_inS_packet_state = 0;
integer tile6_noc2_inS_bdw_allocation = 0;
integer tile6_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc2_inS_header = 0;
integer tile6_noc2_inE_packet_state = 0;
integer tile6_noc2_inE_bdw_allocation = 0;
integer tile6_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc2_inE_header = 0;
integer tile6_noc2_inW_packet_state = 0;
integer tile6_noc2_inW_bdw_allocation = 0;
integer tile6_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile6_noc2_inW_header = 0;
integer tile7_noc0_inL_packet_state = 0;
integer tile7_noc0_inL_bdw_allocation = 0;
integer tile7_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc0_inL_header = 0;
integer tile7_noc0_inN_packet_state = 0;
integer tile7_noc0_inN_bdw_allocation = 0;
integer tile7_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc0_inN_header = 0;
integer tile7_noc0_inS_packet_state = 0;
integer tile7_noc0_inS_bdw_allocation = 0;
integer tile7_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc0_inS_header = 0;
integer tile7_noc0_inE_packet_state = 0;
integer tile7_noc0_inE_bdw_allocation = 0;
integer tile7_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc0_inE_header = 0;
integer tile7_noc0_inW_packet_state = 0;
integer tile7_noc0_inW_bdw_allocation = 0;
integer tile7_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc0_inW_header = 0;
integer tile7_noc1_inL_packet_state = 0;
integer tile7_noc1_inL_bdw_allocation = 0;
integer tile7_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc1_inL_header = 0;
integer tile7_noc1_inN_packet_state = 0;
integer tile7_noc1_inN_bdw_allocation = 0;
integer tile7_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc1_inN_header = 0;
integer tile7_noc1_inS_packet_state = 0;
integer tile7_noc1_inS_bdw_allocation = 0;
integer tile7_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc1_inS_header = 0;
integer tile7_noc1_inE_packet_state = 0;
integer tile7_noc1_inE_bdw_allocation = 0;
integer tile7_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc1_inE_header = 0;
integer tile7_noc1_inW_packet_state = 0;
integer tile7_noc1_inW_bdw_allocation = 0;
integer tile7_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc1_inW_header = 0;
integer tile7_noc2_inL_packet_state = 0;
integer tile7_noc2_inL_bdw_allocation = 0;
integer tile7_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc2_inL_header = 0;
integer tile7_noc2_inN_packet_state = 0;
integer tile7_noc2_inN_bdw_allocation = 0;
integer tile7_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc2_inN_header = 0;
integer tile7_noc2_inS_packet_state = 0;
integer tile7_noc2_inS_bdw_allocation = 0;
integer tile7_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc2_inS_header = 0;
integer tile7_noc2_inE_packet_state = 0;
integer tile7_noc2_inE_bdw_allocation = 0;
integer tile7_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc2_inE_header = 0;
integer tile7_noc2_inW_packet_state = 0;
integer tile7_noc2_inW_bdw_allocation = 0;
integer tile7_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile7_noc2_inW_header = 0;
integer tile8_noc0_inL_packet_state = 0;
integer tile8_noc0_inL_bdw_allocation = 0;
integer tile8_noc0_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc0_inL_header = 0;
integer tile8_noc0_inN_packet_state = 0;
integer tile8_noc0_inN_bdw_allocation = 0;
integer tile8_noc0_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc0_inN_header = 0;
integer tile8_noc0_inS_packet_state = 0;
integer tile8_noc0_inS_bdw_allocation = 0;
integer tile8_noc0_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc0_inS_header = 0;
integer tile8_noc0_inE_packet_state = 0;
integer tile8_noc0_inE_bdw_allocation = 0;
integer tile8_noc0_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc0_inE_header = 0;
integer tile8_noc0_inW_packet_state = 0;
integer tile8_noc0_inW_bdw_allocation = 0;
integer tile8_noc0_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc0_inW_header = 0;
integer tile8_noc1_inL_packet_state = 0;
integer tile8_noc1_inL_bdw_allocation = 0;
integer tile8_noc1_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc1_inL_header = 0;
integer tile8_noc1_inN_packet_state = 0;
integer tile8_noc1_inN_bdw_allocation = 0;
integer tile8_noc1_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc1_inN_header = 0;
integer tile8_noc1_inS_packet_state = 0;
integer tile8_noc1_inS_bdw_allocation = 0;
integer tile8_noc1_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc1_inS_header = 0;
integer tile8_noc1_inE_packet_state = 0;
integer tile8_noc1_inE_bdw_allocation = 0;
integer tile8_noc1_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc1_inE_header = 0;
integer tile8_noc1_inW_packet_state = 0;
integer tile8_noc1_inW_bdw_allocation = 0;
integer tile8_noc1_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc1_inW_header = 0;
integer tile8_noc2_inL_packet_state = 0;
integer tile8_noc2_inL_bdw_allocation = 0;
integer tile8_noc2_inL_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc2_inL_header = 0;
integer tile8_noc2_inN_packet_state = 0;
integer tile8_noc2_inN_bdw_allocation = 0;
integer tile8_noc2_inN_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc2_inN_header = 0;
integer tile8_noc2_inS_packet_state = 0;
integer tile8_noc2_inS_bdw_allocation = 0;
integer tile8_noc2_inS_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc2_inS_header = 0;
integer tile8_noc2_inE_packet_state = 0;
integer tile8_noc2_inE_bdw_allocation = 0;
integer tile8_noc2_inE_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc2_inE_header = 0;
integer tile8_noc2_inW_packet_state = 0;
integer tile8_noc2_inW_bdw_allocation = 0;
integer tile8_noc2_inW_payload_counter = 0;
reg [`NOC_DATA_WIDTH-1:0] tile8_noc2_inW_header = 0;

parameter HEADER = 0, PAYLOAD = 1;

initial begin
    fd = $fopen("debug/traffic_router.txt", "w");
    $fwrite(fd,"time \tcurr\tsrvc\tpayld\tbdw\tNoC\tInPort\ttarget_router\n"); 
    //$fwrite(fd,"time \tcurr\tsrvc\tpayld\tbdw\tNoC\tInPort\ttarget_router\tfullHeader\n"); 
    $fclose(fd);   
end

always @ (posedge clk)
begin
    counter <= counter + 1;
    if (`TILE0.buffer_router_valid_noc1)
    begin
         case (tile0_noc0_inL_packet_state)
         HEADER:
         begin
             tile0_noc0_inL_bdw_allocation = counter;
             tile0_noc0_inL_payload_counter = `TILE0.buffer_router_data_noc1[29:22];
             tile0_noc0_inL_header = `TILE0.buffer_router_data_noc1;
             tile0_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc0_inL_payload_counter = tile0_noc0_inL_payload_counter - 1;
             if (tile0_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile0_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc0_inL_header[49:42];
                     target = (target << 8) | tile0_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc0_inL_bdw_allocation, 0, tile0_noc0_inL_header[21:14], tile0_noc0_inL_header[29:22], (counter - tile0_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile0_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn0_validIn_N)
    begin
         case (tile0_noc0_inN_packet_state)
         HEADER:
         begin
             tile0_noc0_inN_bdw_allocation = counter;
             tile0_noc0_inN_payload_counter = `TILE0.dyn0_dataIn_N[29:22];
             tile0_noc0_inN_header = `TILE0.dyn0_dataIn_N;
             tile0_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc0_inN_payload_counter = tile0_noc0_inN_payload_counter - 1;
             if (tile0_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile0_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc0_inN_header[49:42];
                     target = (target << 8) | tile0_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc0_inN_bdw_allocation, 0, tile0_noc0_inN_header[21:14], tile0_noc0_inN_header[29:22], (counter - tile0_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile0_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn0_validIn_S)
    begin
         case (tile0_noc0_inS_packet_state)
         HEADER:
         begin
             tile0_noc0_inS_bdw_allocation = counter;
             tile0_noc0_inS_payload_counter = `TILE0.dyn0_dataIn_S[29:22];
             tile0_noc0_inS_header = `TILE0.dyn0_dataIn_S;
             tile0_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc0_inS_payload_counter = tile0_noc0_inS_payload_counter - 1;
             if (tile0_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile0_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc0_inS_header[49:42];
                     target = (target << 8) | tile0_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc0_inS_bdw_allocation, 0, tile0_noc0_inS_header[21:14], tile0_noc0_inS_header[29:22], (counter - tile0_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile0_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn0_validIn_E)
    begin
         case (tile0_noc0_inE_packet_state)
         HEADER:
         begin
             tile0_noc0_inE_bdw_allocation = counter;
             tile0_noc0_inE_payload_counter = `TILE0.dyn0_dataIn_E[29:22];
             tile0_noc0_inE_header = `TILE0.dyn0_dataIn_E;
             tile0_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc0_inE_payload_counter = tile0_noc0_inE_payload_counter - 1;
             if (tile0_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile0_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc0_inE_header[49:42];
                     target = (target << 8) | tile0_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc0_inE_bdw_allocation, 0, tile0_noc0_inE_header[21:14], tile0_noc0_inE_header[29:22], (counter - tile0_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile0_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn0_validIn_W)
    begin
         case (tile0_noc0_inW_packet_state)
         HEADER:
         begin
             tile0_noc0_inW_bdw_allocation = counter;
             tile0_noc0_inW_payload_counter = `TILE0.dyn0_dataIn_W[29:22];
             tile0_noc0_inW_header = `TILE0.dyn0_dataIn_W;
             tile0_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc0_inW_payload_counter = tile0_noc0_inW_payload_counter - 1;
             if (tile0_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile0_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc0_inW_header[49:42];
                     target = (target << 8) | tile0_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc0_inW_bdw_allocation, 0, tile0_noc0_inW_header[21:14], tile0_noc0_inW_header[29:22], (counter - tile0_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile0_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.buffer_router_valid_noc2)
    begin
         case (tile0_noc1_inL_packet_state)
         HEADER:
         begin
             tile0_noc1_inL_bdw_allocation = counter;
             tile0_noc1_inL_payload_counter = `TILE0.buffer_router_data_noc2[29:22];
             tile0_noc1_inL_header = `TILE0.buffer_router_data_noc2;
             tile0_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc1_inL_payload_counter = tile0_noc1_inL_payload_counter - 1;
             if (tile0_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile0_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc1_inL_header[49:42];
                     target = (target << 8) | tile0_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc1_inL_bdw_allocation, 0, tile0_noc1_inL_header[21:14], tile0_noc1_inL_header[29:22], (counter - tile0_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile0_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn1_validIn_N)
    begin
         case (tile0_noc1_inN_packet_state)
         HEADER:
         begin
             tile0_noc1_inN_bdw_allocation = counter;
             tile0_noc1_inN_payload_counter = `TILE0.dyn1_dataIn_N[29:22];
             tile0_noc1_inN_header = `TILE0.dyn1_dataIn_N;
             tile0_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc1_inN_payload_counter = tile0_noc1_inN_payload_counter - 1;
             if (tile0_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile0_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc1_inN_header[49:42];
                     target = (target << 8) | tile0_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc1_inN_bdw_allocation, 0, tile0_noc1_inN_header[21:14], tile0_noc1_inN_header[29:22], (counter - tile0_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile0_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn1_validIn_S)
    begin
         case (tile0_noc1_inS_packet_state)
         HEADER:
         begin
             tile0_noc1_inS_bdw_allocation = counter;
             tile0_noc1_inS_payload_counter = `TILE0.dyn1_dataIn_S[29:22];
             tile0_noc1_inS_header = `TILE0.dyn1_dataIn_S;
             tile0_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc1_inS_payload_counter = tile0_noc1_inS_payload_counter - 1;
             if (tile0_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile0_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc1_inS_header[49:42];
                     target = (target << 8) | tile0_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc1_inS_bdw_allocation, 0, tile0_noc1_inS_header[21:14], tile0_noc1_inS_header[29:22], (counter - tile0_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile0_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn1_validIn_E)
    begin
         case (tile0_noc1_inE_packet_state)
         HEADER:
         begin
             tile0_noc1_inE_bdw_allocation = counter;
             tile0_noc1_inE_payload_counter = `TILE0.dyn1_dataIn_E[29:22];
             tile0_noc1_inE_header = `TILE0.dyn1_dataIn_E;
             tile0_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc1_inE_payload_counter = tile0_noc1_inE_payload_counter - 1;
             if (tile0_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile0_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc1_inE_header[49:42];
                     target = (target << 8) | tile0_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc1_inE_bdw_allocation, 0, tile0_noc1_inE_header[21:14], tile0_noc1_inE_header[29:22], (counter - tile0_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile0_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn1_validIn_W)
    begin
         case (tile0_noc1_inW_packet_state)
         HEADER:
         begin
             tile0_noc1_inW_bdw_allocation = counter;
             tile0_noc1_inW_payload_counter = `TILE0.dyn1_dataIn_W[29:22];
             tile0_noc1_inW_header = `TILE0.dyn1_dataIn_W;
             tile0_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc1_inW_payload_counter = tile0_noc1_inW_payload_counter - 1;
             if (tile0_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile0_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc1_inW_header[49:42];
                     target = (target << 8) | tile0_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc1_inW_bdw_allocation, 0, tile0_noc1_inW_header[21:14], tile0_noc1_inW_header[29:22], (counter - tile0_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile0_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.buffer_router_valid_noc3)
    begin
         case (tile0_noc2_inL_packet_state)
         HEADER:
         begin
             tile0_noc2_inL_bdw_allocation = counter;
             tile0_noc2_inL_payload_counter = `TILE0.buffer_router_data_noc3[29:22];
             tile0_noc2_inL_header = `TILE0.buffer_router_data_noc3;
             tile0_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc2_inL_payload_counter = tile0_noc2_inL_payload_counter - 1;
             if (tile0_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile0_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc2_inL_header[49:42];
                     target = (target << 8) | tile0_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc2_inL_bdw_allocation, 0, tile0_noc2_inL_header[21:14], tile0_noc2_inL_header[29:22], (counter - tile0_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile0_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn2_validIn_N)
    begin
         case (tile0_noc2_inN_packet_state)
         HEADER:
         begin
             tile0_noc2_inN_bdw_allocation = counter;
             tile0_noc2_inN_payload_counter = `TILE0.dyn2_dataIn_N[29:22];
             tile0_noc2_inN_header = `TILE0.dyn2_dataIn_N;
             tile0_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc2_inN_payload_counter = tile0_noc2_inN_payload_counter - 1;
             if (tile0_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile0_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc2_inN_header[49:42];
                     target = (target << 8) | tile0_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc2_inN_bdw_allocation, 0, tile0_noc2_inN_header[21:14], tile0_noc2_inN_header[29:22], (counter - tile0_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile0_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn2_validIn_S)
    begin
         case (tile0_noc2_inS_packet_state)
         HEADER:
         begin
             tile0_noc2_inS_bdw_allocation = counter;
             tile0_noc2_inS_payload_counter = `TILE0.dyn2_dataIn_S[29:22];
             tile0_noc2_inS_header = `TILE0.dyn2_dataIn_S;
             tile0_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc2_inS_payload_counter = tile0_noc2_inS_payload_counter - 1;
             if (tile0_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile0_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc2_inS_header[49:42];
                     target = (target << 8) | tile0_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc2_inS_bdw_allocation, 0, tile0_noc2_inS_header[21:14], tile0_noc2_inS_header[29:22], (counter - tile0_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile0_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn2_validIn_E)
    begin
         case (tile0_noc2_inE_packet_state)
         HEADER:
         begin
             tile0_noc2_inE_bdw_allocation = counter;
             tile0_noc2_inE_payload_counter = `TILE0.dyn2_dataIn_E[29:22];
             tile0_noc2_inE_header = `TILE0.dyn2_dataIn_E;
             tile0_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc2_inE_payload_counter = tile0_noc2_inE_payload_counter - 1;
             if (tile0_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile0_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc2_inE_header[49:42];
                     target = (target << 8) | tile0_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc2_inE_bdw_allocation, 0, tile0_noc2_inE_header[21:14], tile0_noc2_inE_header[29:22], (counter - tile0_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile0_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE0.dyn2_validIn_W)
    begin
         case (tile0_noc2_inW_packet_state)
         HEADER:
         begin
             tile0_noc2_inW_bdw_allocation = counter;
             tile0_noc2_inW_payload_counter = `TILE0.dyn2_dataIn_W[29:22];
             tile0_noc2_inW_header = `TILE0.dyn2_dataIn_W;
             tile0_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile0_noc2_inW_payload_counter = tile0_noc2_inW_payload_counter - 1;
             if (tile0_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile0_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile0_noc2_inW_header[49:42];
                     target = (target << 8) | tile0_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile0_noc2_inW_bdw_allocation, 0, tile0_noc2_inW_header[21:14], tile0_noc2_inW_header[29:22], (counter - tile0_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile0_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.buffer_router_valid_noc1)
    begin
         case (tile1_noc0_inL_packet_state)
         HEADER:
         begin
             tile1_noc0_inL_bdw_allocation = counter;
             tile1_noc0_inL_payload_counter = `TILE1.buffer_router_data_noc1[29:22];
             tile1_noc0_inL_header = `TILE1.buffer_router_data_noc1;
             tile1_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc0_inL_payload_counter = tile1_noc0_inL_payload_counter - 1;
             if (tile1_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile1_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc0_inL_header[49:42];
                     target = (target << 8) | tile1_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc0_inL_bdw_allocation, 256, tile1_noc0_inL_header[21:14], tile1_noc0_inL_header[29:22], (counter - tile1_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile1_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn0_validIn_N)
    begin
         case (tile1_noc0_inN_packet_state)
         HEADER:
         begin
             tile1_noc0_inN_bdw_allocation = counter;
             tile1_noc0_inN_payload_counter = `TILE1.dyn0_dataIn_N[29:22];
             tile1_noc0_inN_header = `TILE1.dyn0_dataIn_N;
             tile1_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc0_inN_payload_counter = tile1_noc0_inN_payload_counter - 1;
             if (tile1_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile1_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc0_inN_header[49:42];
                     target = (target << 8) | tile1_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc0_inN_bdw_allocation, 256, tile1_noc0_inN_header[21:14], tile1_noc0_inN_header[29:22], (counter - tile1_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile1_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn0_validIn_S)
    begin
         case (tile1_noc0_inS_packet_state)
         HEADER:
         begin
             tile1_noc0_inS_bdw_allocation = counter;
             tile1_noc0_inS_payload_counter = `TILE1.dyn0_dataIn_S[29:22];
             tile1_noc0_inS_header = `TILE1.dyn0_dataIn_S;
             tile1_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc0_inS_payload_counter = tile1_noc0_inS_payload_counter - 1;
             if (tile1_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile1_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc0_inS_header[49:42];
                     target = (target << 8) | tile1_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc0_inS_bdw_allocation, 256, tile1_noc0_inS_header[21:14], tile1_noc0_inS_header[29:22], (counter - tile1_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile1_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn0_validIn_E)
    begin
         case (tile1_noc0_inE_packet_state)
         HEADER:
         begin
             tile1_noc0_inE_bdw_allocation = counter;
             tile1_noc0_inE_payload_counter = `TILE1.dyn0_dataIn_E[29:22];
             tile1_noc0_inE_header = `TILE1.dyn0_dataIn_E;
             tile1_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc0_inE_payload_counter = tile1_noc0_inE_payload_counter - 1;
             if (tile1_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile1_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc0_inE_header[49:42];
                     target = (target << 8) | tile1_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc0_inE_bdw_allocation, 256, tile1_noc0_inE_header[21:14], tile1_noc0_inE_header[29:22], (counter - tile1_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile1_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn0_validIn_W)
    begin
         case (tile1_noc0_inW_packet_state)
         HEADER:
         begin
             tile1_noc0_inW_bdw_allocation = counter;
             tile1_noc0_inW_payload_counter = `TILE1.dyn0_dataIn_W[29:22];
             tile1_noc0_inW_header = `TILE1.dyn0_dataIn_W;
             tile1_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc0_inW_payload_counter = tile1_noc0_inW_payload_counter - 1;
             if (tile1_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile1_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc0_inW_header[49:42];
                     target = (target << 8) | tile1_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc0_inW_bdw_allocation, 256, tile1_noc0_inW_header[21:14], tile1_noc0_inW_header[29:22], (counter - tile1_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile1_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.buffer_router_valid_noc2)
    begin
         case (tile1_noc1_inL_packet_state)
         HEADER:
         begin
             tile1_noc1_inL_bdw_allocation = counter;
             tile1_noc1_inL_payload_counter = `TILE1.buffer_router_data_noc2[29:22];
             tile1_noc1_inL_header = `TILE1.buffer_router_data_noc2;
             tile1_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc1_inL_payload_counter = tile1_noc1_inL_payload_counter - 1;
             if (tile1_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile1_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc1_inL_header[49:42];
                     target = (target << 8) | tile1_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc1_inL_bdw_allocation, 256, tile1_noc1_inL_header[21:14], tile1_noc1_inL_header[29:22], (counter - tile1_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile1_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn1_validIn_N)
    begin
         case (tile1_noc1_inN_packet_state)
         HEADER:
         begin
             tile1_noc1_inN_bdw_allocation = counter;
             tile1_noc1_inN_payload_counter = `TILE1.dyn1_dataIn_N[29:22];
             tile1_noc1_inN_header = `TILE1.dyn1_dataIn_N;
             tile1_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc1_inN_payload_counter = tile1_noc1_inN_payload_counter - 1;
             if (tile1_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile1_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc1_inN_header[49:42];
                     target = (target << 8) | tile1_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc1_inN_bdw_allocation, 256, tile1_noc1_inN_header[21:14], tile1_noc1_inN_header[29:22], (counter - tile1_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile1_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn1_validIn_S)
    begin
         case (tile1_noc1_inS_packet_state)
         HEADER:
         begin
             tile1_noc1_inS_bdw_allocation = counter;
             tile1_noc1_inS_payload_counter = `TILE1.dyn1_dataIn_S[29:22];
             tile1_noc1_inS_header = `TILE1.dyn1_dataIn_S;
             tile1_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc1_inS_payload_counter = tile1_noc1_inS_payload_counter - 1;
             if (tile1_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile1_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc1_inS_header[49:42];
                     target = (target << 8) | tile1_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc1_inS_bdw_allocation, 256, tile1_noc1_inS_header[21:14], tile1_noc1_inS_header[29:22], (counter - tile1_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile1_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn1_validIn_E)
    begin
         case (tile1_noc1_inE_packet_state)
         HEADER:
         begin
             tile1_noc1_inE_bdw_allocation = counter;
             tile1_noc1_inE_payload_counter = `TILE1.dyn1_dataIn_E[29:22];
             tile1_noc1_inE_header = `TILE1.dyn1_dataIn_E;
             tile1_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc1_inE_payload_counter = tile1_noc1_inE_payload_counter - 1;
             if (tile1_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile1_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc1_inE_header[49:42];
                     target = (target << 8) | tile1_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc1_inE_bdw_allocation, 256, tile1_noc1_inE_header[21:14], tile1_noc1_inE_header[29:22], (counter - tile1_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile1_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn1_validIn_W)
    begin
         case (tile1_noc1_inW_packet_state)
         HEADER:
         begin
             tile1_noc1_inW_bdw_allocation = counter;
             tile1_noc1_inW_payload_counter = `TILE1.dyn1_dataIn_W[29:22];
             tile1_noc1_inW_header = `TILE1.dyn1_dataIn_W;
             tile1_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc1_inW_payload_counter = tile1_noc1_inW_payload_counter - 1;
             if (tile1_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile1_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc1_inW_header[49:42];
                     target = (target << 8) | tile1_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc1_inW_bdw_allocation, 256, tile1_noc1_inW_header[21:14], tile1_noc1_inW_header[29:22], (counter - tile1_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile1_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.buffer_router_valid_noc3)
    begin
         case (tile1_noc2_inL_packet_state)
         HEADER:
         begin
             tile1_noc2_inL_bdw_allocation = counter;
             tile1_noc2_inL_payload_counter = `TILE1.buffer_router_data_noc3[29:22];
             tile1_noc2_inL_header = `TILE1.buffer_router_data_noc3;
             tile1_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc2_inL_payload_counter = tile1_noc2_inL_payload_counter - 1;
             if (tile1_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile1_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc2_inL_header[49:42];
                     target = (target << 8) | tile1_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc2_inL_bdw_allocation, 256, tile1_noc2_inL_header[21:14], tile1_noc2_inL_header[29:22], (counter - tile1_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile1_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn2_validIn_N)
    begin
         case (tile1_noc2_inN_packet_state)
         HEADER:
         begin
             tile1_noc2_inN_bdw_allocation = counter;
             tile1_noc2_inN_payload_counter = `TILE1.dyn2_dataIn_N[29:22];
             tile1_noc2_inN_header = `TILE1.dyn2_dataIn_N;
             tile1_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc2_inN_payload_counter = tile1_noc2_inN_payload_counter - 1;
             if (tile1_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile1_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc2_inN_header[49:42];
                     target = (target << 8) | tile1_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc2_inN_bdw_allocation, 256, tile1_noc2_inN_header[21:14], tile1_noc2_inN_header[29:22], (counter - tile1_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile1_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn2_validIn_S)
    begin
         case (tile1_noc2_inS_packet_state)
         HEADER:
         begin
             tile1_noc2_inS_bdw_allocation = counter;
             tile1_noc2_inS_payload_counter = `TILE1.dyn2_dataIn_S[29:22];
             tile1_noc2_inS_header = `TILE1.dyn2_dataIn_S;
             tile1_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc2_inS_payload_counter = tile1_noc2_inS_payload_counter - 1;
             if (tile1_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile1_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc2_inS_header[49:42];
                     target = (target << 8) | tile1_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc2_inS_bdw_allocation, 256, tile1_noc2_inS_header[21:14], tile1_noc2_inS_header[29:22], (counter - tile1_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile1_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn2_validIn_E)
    begin
         case (tile1_noc2_inE_packet_state)
         HEADER:
         begin
             tile1_noc2_inE_bdw_allocation = counter;
             tile1_noc2_inE_payload_counter = `TILE1.dyn2_dataIn_E[29:22];
             tile1_noc2_inE_header = `TILE1.dyn2_dataIn_E;
             tile1_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc2_inE_payload_counter = tile1_noc2_inE_payload_counter - 1;
             if (tile1_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile1_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc2_inE_header[49:42];
                     target = (target << 8) | tile1_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc2_inE_bdw_allocation, 256, tile1_noc2_inE_header[21:14], tile1_noc2_inE_header[29:22], (counter - tile1_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile1_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE1.dyn2_validIn_W)
    begin
         case (tile1_noc2_inW_packet_state)
         HEADER:
         begin
             tile1_noc2_inW_bdw_allocation = counter;
             tile1_noc2_inW_payload_counter = `TILE1.dyn2_dataIn_W[29:22];
             tile1_noc2_inW_header = `TILE1.dyn2_dataIn_W;
             tile1_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile1_noc2_inW_payload_counter = tile1_noc2_inW_payload_counter - 1;
             if (tile1_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile1_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile1_noc2_inW_header[49:42];
                     target = (target << 8) | tile1_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile1_noc2_inW_bdw_allocation, 256, tile1_noc2_inW_header[21:14], tile1_noc2_inW_header[29:22], (counter - tile1_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile1_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.buffer_router_valid_noc1)
    begin
         case (tile2_noc0_inL_packet_state)
         HEADER:
         begin
             tile2_noc0_inL_bdw_allocation = counter;
             tile2_noc0_inL_payload_counter = `TILE2.buffer_router_data_noc1[29:22];
             tile2_noc0_inL_header = `TILE2.buffer_router_data_noc1;
             tile2_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc0_inL_payload_counter = tile2_noc0_inL_payload_counter - 1;
             if (tile2_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile2_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc0_inL_header[49:42];
                     target = (target << 8) | tile2_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc0_inL_bdw_allocation, 512, tile2_noc0_inL_header[21:14], tile2_noc0_inL_header[29:22], (counter - tile2_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile2_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn0_validIn_N)
    begin
         case (tile2_noc0_inN_packet_state)
         HEADER:
         begin
             tile2_noc0_inN_bdw_allocation = counter;
             tile2_noc0_inN_payload_counter = `TILE2.dyn0_dataIn_N[29:22];
             tile2_noc0_inN_header = `TILE2.dyn0_dataIn_N;
             tile2_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc0_inN_payload_counter = tile2_noc0_inN_payload_counter - 1;
             if (tile2_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile2_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc0_inN_header[49:42];
                     target = (target << 8) | tile2_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc0_inN_bdw_allocation, 512, tile2_noc0_inN_header[21:14], tile2_noc0_inN_header[29:22], (counter - tile2_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile2_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn0_validIn_S)
    begin
         case (tile2_noc0_inS_packet_state)
         HEADER:
         begin
             tile2_noc0_inS_bdw_allocation = counter;
             tile2_noc0_inS_payload_counter = `TILE2.dyn0_dataIn_S[29:22];
             tile2_noc0_inS_header = `TILE2.dyn0_dataIn_S;
             tile2_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc0_inS_payload_counter = tile2_noc0_inS_payload_counter - 1;
             if (tile2_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile2_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc0_inS_header[49:42];
                     target = (target << 8) | tile2_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc0_inS_bdw_allocation, 512, tile2_noc0_inS_header[21:14], tile2_noc0_inS_header[29:22], (counter - tile2_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile2_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn0_validIn_E)
    begin
         case (tile2_noc0_inE_packet_state)
         HEADER:
         begin
             tile2_noc0_inE_bdw_allocation = counter;
             tile2_noc0_inE_payload_counter = `TILE2.dyn0_dataIn_E[29:22];
             tile2_noc0_inE_header = `TILE2.dyn0_dataIn_E;
             tile2_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc0_inE_payload_counter = tile2_noc0_inE_payload_counter - 1;
             if (tile2_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile2_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc0_inE_header[49:42];
                     target = (target << 8) | tile2_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc0_inE_bdw_allocation, 512, tile2_noc0_inE_header[21:14], tile2_noc0_inE_header[29:22], (counter - tile2_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile2_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn0_validIn_W)
    begin
         case (tile2_noc0_inW_packet_state)
         HEADER:
         begin
             tile2_noc0_inW_bdw_allocation = counter;
             tile2_noc0_inW_payload_counter = `TILE2.dyn0_dataIn_W[29:22];
             tile2_noc0_inW_header = `TILE2.dyn0_dataIn_W;
             tile2_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc0_inW_payload_counter = tile2_noc0_inW_payload_counter - 1;
             if (tile2_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile2_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc0_inW_header[49:42];
                     target = (target << 8) | tile2_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc0_inW_bdw_allocation, 512, tile2_noc0_inW_header[21:14], tile2_noc0_inW_header[29:22], (counter - tile2_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile2_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.buffer_router_valid_noc2)
    begin
         case (tile2_noc1_inL_packet_state)
         HEADER:
         begin
             tile2_noc1_inL_bdw_allocation = counter;
             tile2_noc1_inL_payload_counter = `TILE2.buffer_router_data_noc2[29:22];
             tile2_noc1_inL_header = `TILE2.buffer_router_data_noc2;
             tile2_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc1_inL_payload_counter = tile2_noc1_inL_payload_counter - 1;
             if (tile2_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile2_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc1_inL_header[49:42];
                     target = (target << 8) | tile2_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc1_inL_bdw_allocation, 512, tile2_noc1_inL_header[21:14], tile2_noc1_inL_header[29:22], (counter - tile2_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile2_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn1_validIn_N)
    begin
         case (tile2_noc1_inN_packet_state)
         HEADER:
         begin
             tile2_noc1_inN_bdw_allocation = counter;
             tile2_noc1_inN_payload_counter = `TILE2.dyn1_dataIn_N[29:22];
             tile2_noc1_inN_header = `TILE2.dyn1_dataIn_N;
             tile2_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc1_inN_payload_counter = tile2_noc1_inN_payload_counter - 1;
             if (tile2_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile2_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc1_inN_header[49:42];
                     target = (target << 8) | tile2_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc1_inN_bdw_allocation, 512, tile2_noc1_inN_header[21:14], tile2_noc1_inN_header[29:22], (counter - tile2_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile2_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn1_validIn_S)
    begin
         case (tile2_noc1_inS_packet_state)
         HEADER:
         begin
             tile2_noc1_inS_bdw_allocation = counter;
             tile2_noc1_inS_payload_counter = `TILE2.dyn1_dataIn_S[29:22];
             tile2_noc1_inS_header = `TILE2.dyn1_dataIn_S;
             tile2_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc1_inS_payload_counter = tile2_noc1_inS_payload_counter - 1;
             if (tile2_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile2_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc1_inS_header[49:42];
                     target = (target << 8) | tile2_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc1_inS_bdw_allocation, 512, tile2_noc1_inS_header[21:14], tile2_noc1_inS_header[29:22], (counter - tile2_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile2_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn1_validIn_E)
    begin
         case (tile2_noc1_inE_packet_state)
         HEADER:
         begin
             tile2_noc1_inE_bdw_allocation = counter;
             tile2_noc1_inE_payload_counter = `TILE2.dyn1_dataIn_E[29:22];
             tile2_noc1_inE_header = `TILE2.dyn1_dataIn_E;
             tile2_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc1_inE_payload_counter = tile2_noc1_inE_payload_counter - 1;
             if (tile2_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile2_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc1_inE_header[49:42];
                     target = (target << 8) | tile2_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc1_inE_bdw_allocation, 512, tile2_noc1_inE_header[21:14], tile2_noc1_inE_header[29:22], (counter - tile2_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile2_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn1_validIn_W)
    begin
         case (tile2_noc1_inW_packet_state)
         HEADER:
         begin
             tile2_noc1_inW_bdw_allocation = counter;
             tile2_noc1_inW_payload_counter = `TILE2.dyn1_dataIn_W[29:22];
             tile2_noc1_inW_header = `TILE2.dyn1_dataIn_W;
             tile2_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc1_inW_payload_counter = tile2_noc1_inW_payload_counter - 1;
             if (tile2_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile2_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc1_inW_header[49:42];
                     target = (target << 8) | tile2_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc1_inW_bdw_allocation, 512, tile2_noc1_inW_header[21:14], tile2_noc1_inW_header[29:22], (counter - tile2_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile2_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.buffer_router_valid_noc3)
    begin
         case (tile2_noc2_inL_packet_state)
         HEADER:
         begin
             tile2_noc2_inL_bdw_allocation = counter;
             tile2_noc2_inL_payload_counter = `TILE2.buffer_router_data_noc3[29:22];
             tile2_noc2_inL_header = `TILE2.buffer_router_data_noc3;
             tile2_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc2_inL_payload_counter = tile2_noc2_inL_payload_counter - 1;
             if (tile2_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile2_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc2_inL_header[49:42];
                     target = (target << 8) | tile2_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc2_inL_bdw_allocation, 512, tile2_noc2_inL_header[21:14], tile2_noc2_inL_header[29:22], (counter - tile2_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile2_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn2_validIn_N)
    begin
         case (tile2_noc2_inN_packet_state)
         HEADER:
         begin
             tile2_noc2_inN_bdw_allocation = counter;
             tile2_noc2_inN_payload_counter = `TILE2.dyn2_dataIn_N[29:22];
             tile2_noc2_inN_header = `TILE2.dyn2_dataIn_N;
             tile2_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc2_inN_payload_counter = tile2_noc2_inN_payload_counter - 1;
             if (tile2_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile2_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc2_inN_header[49:42];
                     target = (target << 8) | tile2_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc2_inN_bdw_allocation, 512, tile2_noc2_inN_header[21:14], tile2_noc2_inN_header[29:22], (counter - tile2_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile2_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn2_validIn_S)
    begin
         case (tile2_noc2_inS_packet_state)
         HEADER:
         begin
             tile2_noc2_inS_bdw_allocation = counter;
             tile2_noc2_inS_payload_counter = `TILE2.dyn2_dataIn_S[29:22];
             tile2_noc2_inS_header = `TILE2.dyn2_dataIn_S;
             tile2_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc2_inS_payload_counter = tile2_noc2_inS_payload_counter - 1;
             if (tile2_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile2_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc2_inS_header[49:42];
                     target = (target << 8) | tile2_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc2_inS_bdw_allocation, 512, tile2_noc2_inS_header[21:14], tile2_noc2_inS_header[29:22], (counter - tile2_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile2_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn2_validIn_E)
    begin
         case (tile2_noc2_inE_packet_state)
         HEADER:
         begin
             tile2_noc2_inE_bdw_allocation = counter;
             tile2_noc2_inE_payload_counter = `TILE2.dyn2_dataIn_E[29:22];
             tile2_noc2_inE_header = `TILE2.dyn2_dataIn_E;
             tile2_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc2_inE_payload_counter = tile2_noc2_inE_payload_counter - 1;
             if (tile2_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile2_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc2_inE_header[49:42];
                     target = (target << 8) | tile2_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc2_inE_bdw_allocation, 512, tile2_noc2_inE_header[21:14], tile2_noc2_inE_header[29:22], (counter - tile2_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile2_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE2.dyn2_validIn_W)
    begin
         case (tile2_noc2_inW_packet_state)
         HEADER:
         begin
             tile2_noc2_inW_bdw_allocation = counter;
             tile2_noc2_inW_payload_counter = `TILE2.dyn2_dataIn_W[29:22];
             tile2_noc2_inW_header = `TILE2.dyn2_dataIn_W;
             tile2_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile2_noc2_inW_payload_counter = tile2_noc2_inW_payload_counter - 1;
             if (tile2_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile2_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile2_noc2_inW_header[49:42];
                     target = (target << 8) | tile2_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile2_noc2_inW_bdw_allocation, 512, tile2_noc2_inW_header[21:14], tile2_noc2_inW_header[29:22], (counter - tile2_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile2_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.buffer_router_valid_noc1)
    begin
         case (tile3_noc0_inL_packet_state)
         HEADER:
         begin
             tile3_noc0_inL_bdw_allocation = counter;
             tile3_noc0_inL_payload_counter = `TILE3.buffer_router_data_noc1[29:22];
             tile3_noc0_inL_header = `TILE3.buffer_router_data_noc1;
             tile3_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc0_inL_payload_counter = tile3_noc0_inL_payload_counter - 1;
             if (tile3_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile3_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc0_inL_header[49:42];
                     target = (target << 8) | tile3_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc0_inL_bdw_allocation, 1, tile3_noc0_inL_header[21:14], tile3_noc0_inL_header[29:22], (counter - tile3_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile3_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn0_validIn_N)
    begin
         case (tile3_noc0_inN_packet_state)
         HEADER:
         begin
             tile3_noc0_inN_bdw_allocation = counter;
             tile3_noc0_inN_payload_counter = `TILE3.dyn0_dataIn_N[29:22];
             tile3_noc0_inN_header = `TILE3.dyn0_dataIn_N;
             tile3_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc0_inN_payload_counter = tile3_noc0_inN_payload_counter - 1;
             if (tile3_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile3_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc0_inN_header[49:42];
                     target = (target << 8) | tile3_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc0_inN_bdw_allocation, 1, tile3_noc0_inN_header[21:14], tile3_noc0_inN_header[29:22], (counter - tile3_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile3_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn0_validIn_S)
    begin
         case (tile3_noc0_inS_packet_state)
         HEADER:
         begin
             tile3_noc0_inS_bdw_allocation = counter;
             tile3_noc0_inS_payload_counter = `TILE3.dyn0_dataIn_S[29:22];
             tile3_noc0_inS_header = `TILE3.dyn0_dataIn_S;
             tile3_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc0_inS_payload_counter = tile3_noc0_inS_payload_counter - 1;
             if (tile3_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile3_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc0_inS_header[49:42];
                     target = (target << 8) | tile3_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc0_inS_bdw_allocation, 1, tile3_noc0_inS_header[21:14], tile3_noc0_inS_header[29:22], (counter - tile3_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile3_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn0_validIn_E)
    begin
         case (tile3_noc0_inE_packet_state)
         HEADER:
         begin
             tile3_noc0_inE_bdw_allocation = counter;
             tile3_noc0_inE_payload_counter = `TILE3.dyn0_dataIn_E[29:22];
             tile3_noc0_inE_header = `TILE3.dyn0_dataIn_E;
             tile3_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc0_inE_payload_counter = tile3_noc0_inE_payload_counter - 1;
             if (tile3_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile3_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc0_inE_header[49:42];
                     target = (target << 8) | tile3_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc0_inE_bdw_allocation, 1, tile3_noc0_inE_header[21:14], tile3_noc0_inE_header[29:22], (counter - tile3_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile3_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn0_validIn_W)
    begin
         case (tile3_noc0_inW_packet_state)
         HEADER:
         begin
             tile3_noc0_inW_bdw_allocation = counter;
             tile3_noc0_inW_payload_counter = `TILE3.dyn0_dataIn_W[29:22];
             tile3_noc0_inW_header = `TILE3.dyn0_dataIn_W;
             tile3_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc0_inW_payload_counter = tile3_noc0_inW_payload_counter - 1;
             if (tile3_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile3_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc0_inW_header[49:42];
                     target = (target << 8) | tile3_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc0_inW_bdw_allocation, 1, tile3_noc0_inW_header[21:14], tile3_noc0_inW_header[29:22], (counter - tile3_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile3_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.buffer_router_valid_noc2)
    begin
         case (tile3_noc1_inL_packet_state)
         HEADER:
         begin
             tile3_noc1_inL_bdw_allocation = counter;
             tile3_noc1_inL_payload_counter = `TILE3.buffer_router_data_noc2[29:22];
             tile3_noc1_inL_header = `TILE3.buffer_router_data_noc2;
             tile3_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc1_inL_payload_counter = tile3_noc1_inL_payload_counter - 1;
             if (tile3_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile3_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc1_inL_header[49:42];
                     target = (target << 8) | tile3_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc1_inL_bdw_allocation, 1, tile3_noc1_inL_header[21:14], tile3_noc1_inL_header[29:22], (counter - tile3_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile3_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn1_validIn_N)
    begin
         case (tile3_noc1_inN_packet_state)
         HEADER:
         begin
             tile3_noc1_inN_bdw_allocation = counter;
             tile3_noc1_inN_payload_counter = `TILE3.dyn1_dataIn_N[29:22];
             tile3_noc1_inN_header = `TILE3.dyn1_dataIn_N;
             tile3_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc1_inN_payload_counter = tile3_noc1_inN_payload_counter - 1;
             if (tile3_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile3_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc1_inN_header[49:42];
                     target = (target << 8) | tile3_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc1_inN_bdw_allocation, 1, tile3_noc1_inN_header[21:14], tile3_noc1_inN_header[29:22], (counter - tile3_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile3_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn1_validIn_S)
    begin
         case (tile3_noc1_inS_packet_state)
         HEADER:
         begin
             tile3_noc1_inS_bdw_allocation = counter;
             tile3_noc1_inS_payload_counter = `TILE3.dyn1_dataIn_S[29:22];
             tile3_noc1_inS_header = `TILE3.dyn1_dataIn_S;
             tile3_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc1_inS_payload_counter = tile3_noc1_inS_payload_counter - 1;
             if (tile3_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile3_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc1_inS_header[49:42];
                     target = (target << 8) | tile3_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc1_inS_bdw_allocation, 1, tile3_noc1_inS_header[21:14], tile3_noc1_inS_header[29:22], (counter - tile3_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile3_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn1_validIn_E)
    begin
         case (tile3_noc1_inE_packet_state)
         HEADER:
         begin
             tile3_noc1_inE_bdw_allocation = counter;
             tile3_noc1_inE_payload_counter = `TILE3.dyn1_dataIn_E[29:22];
             tile3_noc1_inE_header = `TILE3.dyn1_dataIn_E;
             tile3_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc1_inE_payload_counter = tile3_noc1_inE_payload_counter - 1;
             if (tile3_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile3_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc1_inE_header[49:42];
                     target = (target << 8) | tile3_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc1_inE_bdw_allocation, 1, tile3_noc1_inE_header[21:14], tile3_noc1_inE_header[29:22], (counter - tile3_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile3_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn1_validIn_W)
    begin
         case (tile3_noc1_inW_packet_state)
         HEADER:
         begin
             tile3_noc1_inW_bdw_allocation = counter;
             tile3_noc1_inW_payload_counter = `TILE3.dyn1_dataIn_W[29:22];
             tile3_noc1_inW_header = `TILE3.dyn1_dataIn_W;
             tile3_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc1_inW_payload_counter = tile3_noc1_inW_payload_counter - 1;
             if (tile3_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile3_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc1_inW_header[49:42];
                     target = (target << 8) | tile3_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc1_inW_bdw_allocation, 1, tile3_noc1_inW_header[21:14], tile3_noc1_inW_header[29:22], (counter - tile3_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile3_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.buffer_router_valid_noc3)
    begin
         case (tile3_noc2_inL_packet_state)
         HEADER:
         begin
             tile3_noc2_inL_bdw_allocation = counter;
             tile3_noc2_inL_payload_counter = `TILE3.buffer_router_data_noc3[29:22];
             tile3_noc2_inL_header = `TILE3.buffer_router_data_noc3;
             tile3_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc2_inL_payload_counter = tile3_noc2_inL_payload_counter - 1;
             if (tile3_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile3_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc2_inL_header[49:42];
                     target = (target << 8) | tile3_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc2_inL_bdw_allocation, 1, tile3_noc2_inL_header[21:14], tile3_noc2_inL_header[29:22], (counter - tile3_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile3_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn2_validIn_N)
    begin
         case (tile3_noc2_inN_packet_state)
         HEADER:
         begin
             tile3_noc2_inN_bdw_allocation = counter;
             tile3_noc2_inN_payload_counter = `TILE3.dyn2_dataIn_N[29:22];
             tile3_noc2_inN_header = `TILE3.dyn2_dataIn_N;
             tile3_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc2_inN_payload_counter = tile3_noc2_inN_payload_counter - 1;
             if (tile3_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile3_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc2_inN_header[49:42];
                     target = (target << 8) | tile3_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc2_inN_bdw_allocation, 1, tile3_noc2_inN_header[21:14], tile3_noc2_inN_header[29:22], (counter - tile3_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile3_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn2_validIn_S)
    begin
         case (tile3_noc2_inS_packet_state)
         HEADER:
         begin
             tile3_noc2_inS_bdw_allocation = counter;
             tile3_noc2_inS_payload_counter = `TILE3.dyn2_dataIn_S[29:22];
             tile3_noc2_inS_header = `TILE3.dyn2_dataIn_S;
             tile3_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc2_inS_payload_counter = tile3_noc2_inS_payload_counter - 1;
             if (tile3_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile3_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc2_inS_header[49:42];
                     target = (target << 8) | tile3_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc2_inS_bdw_allocation, 1, tile3_noc2_inS_header[21:14], tile3_noc2_inS_header[29:22], (counter - tile3_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile3_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn2_validIn_E)
    begin
         case (tile3_noc2_inE_packet_state)
         HEADER:
         begin
             tile3_noc2_inE_bdw_allocation = counter;
             tile3_noc2_inE_payload_counter = `TILE3.dyn2_dataIn_E[29:22];
             tile3_noc2_inE_header = `TILE3.dyn2_dataIn_E;
             tile3_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc2_inE_payload_counter = tile3_noc2_inE_payload_counter - 1;
             if (tile3_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile3_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc2_inE_header[49:42];
                     target = (target << 8) | tile3_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc2_inE_bdw_allocation, 1, tile3_noc2_inE_header[21:14], tile3_noc2_inE_header[29:22], (counter - tile3_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile3_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE3.dyn2_validIn_W)
    begin
         case (tile3_noc2_inW_packet_state)
         HEADER:
         begin
             tile3_noc2_inW_bdw_allocation = counter;
             tile3_noc2_inW_payload_counter = `TILE3.dyn2_dataIn_W[29:22];
             tile3_noc2_inW_header = `TILE3.dyn2_dataIn_W;
             tile3_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile3_noc2_inW_payload_counter = tile3_noc2_inW_payload_counter - 1;
             if (tile3_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile3_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile3_noc2_inW_header[49:42];
                     target = (target << 8) | tile3_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile3_noc2_inW_bdw_allocation, 1, tile3_noc2_inW_header[21:14], tile3_noc2_inW_header[29:22], (counter - tile3_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile3_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.buffer_router_valid_noc1)
    begin
         case (tile4_noc0_inL_packet_state)
         HEADER:
         begin
             tile4_noc0_inL_bdw_allocation = counter;
             tile4_noc0_inL_payload_counter = `TILE4.buffer_router_data_noc1[29:22];
             tile4_noc0_inL_header = `TILE4.buffer_router_data_noc1;
             tile4_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc0_inL_payload_counter = tile4_noc0_inL_payload_counter - 1;
             if (tile4_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile4_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc0_inL_header[49:42];
                     target = (target << 8) | tile4_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc0_inL_bdw_allocation, 257, tile4_noc0_inL_header[21:14], tile4_noc0_inL_header[29:22], (counter - tile4_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile4_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn0_validIn_N)
    begin
         case (tile4_noc0_inN_packet_state)
         HEADER:
         begin
             tile4_noc0_inN_bdw_allocation = counter;
             tile4_noc0_inN_payload_counter = `TILE4.dyn0_dataIn_N[29:22];
             tile4_noc0_inN_header = `TILE4.dyn0_dataIn_N;
             tile4_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc0_inN_payload_counter = tile4_noc0_inN_payload_counter - 1;
             if (tile4_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile4_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc0_inN_header[49:42];
                     target = (target << 8) | tile4_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc0_inN_bdw_allocation, 257, tile4_noc0_inN_header[21:14], tile4_noc0_inN_header[29:22], (counter - tile4_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile4_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn0_validIn_S)
    begin
         case (tile4_noc0_inS_packet_state)
         HEADER:
         begin
             tile4_noc0_inS_bdw_allocation = counter;
             tile4_noc0_inS_payload_counter = `TILE4.dyn0_dataIn_S[29:22];
             tile4_noc0_inS_header = `TILE4.dyn0_dataIn_S;
             tile4_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc0_inS_payload_counter = tile4_noc0_inS_payload_counter - 1;
             if (tile4_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile4_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc0_inS_header[49:42];
                     target = (target << 8) | tile4_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc0_inS_bdw_allocation, 257, tile4_noc0_inS_header[21:14], tile4_noc0_inS_header[29:22], (counter - tile4_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile4_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn0_validIn_E)
    begin
         case (tile4_noc0_inE_packet_state)
         HEADER:
         begin
             tile4_noc0_inE_bdw_allocation = counter;
             tile4_noc0_inE_payload_counter = `TILE4.dyn0_dataIn_E[29:22];
             tile4_noc0_inE_header = `TILE4.dyn0_dataIn_E;
             tile4_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc0_inE_payload_counter = tile4_noc0_inE_payload_counter - 1;
             if (tile4_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile4_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc0_inE_header[49:42];
                     target = (target << 8) | tile4_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc0_inE_bdw_allocation, 257, tile4_noc0_inE_header[21:14], tile4_noc0_inE_header[29:22], (counter - tile4_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile4_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn0_validIn_W)
    begin
         case (tile4_noc0_inW_packet_state)
         HEADER:
         begin
             tile4_noc0_inW_bdw_allocation = counter;
             tile4_noc0_inW_payload_counter = `TILE4.dyn0_dataIn_W[29:22];
             tile4_noc0_inW_header = `TILE4.dyn0_dataIn_W;
             tile4_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc0_inW_payload_counter = tile4_noc0_inW_payload_counter - 1;
             if (tile4_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile4_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc0_inW_header[49:42];
                     target = (target << 8) | tile4_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc0_inW_bdw_allocation, 257, tile4_noc0_inW_header[21:14], tile4_noc0_inW_header[29:22], (counter - tile4_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile4_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.buffer_router_valid_noc2)
    begin
         case (tile4_noc1_inL_packet_state)
         HEADER:
         begin
             tile4_noc1_inL_bdw_allocation = counter;
             tile4_noc1_inL_payload_counter = `TILE4.buffer_router_data_noc2[29:22];
             tile4_noc1_inL_header = `TILE4.buffer_router_data_noc2;
             tile4_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc1_inL_payload_counter = tile4_noc1_inL_payload_counter - 1;
             if (tile4_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile4_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc1_inL_header[49:42];
                     target = (target << 8) | tile4_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc1_inL_bdw_allocation, 257, tile4_noc1_inL_header[21:14], tile4_noc1_inL_header[29:22], (counter - tile4_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile4_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn1_validIn_N)
    begin
         case (tile4_noc1_inN_packet_state)
         HEADER:
         begin
             tile4_noc1_inN_bdw_allocation = counter;
             tile4_noc1_inN_payload_counter = `TILE4.dyn1_dataIn_N[29:22];
             tile4_noc1_inN_header = `TILE4.dyn1_dataIn_N;
             tile4_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc1_inN_payload_counter = tile4_noc1_inN_payload_counter - 1;
             if (tile4_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile4_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc1_inN_header[49:42];
                     target = (target << 8) | tile4_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc1_inN_bdw_allocation, 257, tile4_noc1_inN_header[21:14], tile4_noc1_inN_header[29:22], (counter - tile4_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile4_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn1_validIn_S)
    begin
         case (tile4_noc1_inS_packet_state)
         HEADER:
         begin
             tile4_noc1_inS_bdw_allocation = counter;
             tile4_noc1_inS_payload_counter = `TILE4.dyn1_dataIn_S[29:22];
             tile4_noc1_inS_header = `TILE4.dyn1_dataIn_S;
             tile4_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc1_inS_payload_counter = tile4_noc1_inS_payload_counter - 1;
             if (tile4_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile4_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc1_inS_header[49:42];
                     target = (target << 8) | tile4_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc1_inS_bdw_allocation, 257, tile4_noc1_inS_header[21:14], tile4_noc1_inS_header[29:22], (counter - tile4_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile4_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn1_validIn_E)
    begin
         case (tile4_noc1_inE_packet_state)
         HEADER:
         begin
             tile4_noc1_inE_bdw_allocation = counter;
             tile4_noc1_inE_payload_counter = `TILE4.dyn1_dataIn_E[29:22];
             tile4_noc1_inE_header = `TILE4.dyn1_dataIn_E;
             tile4_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc1_inE_payload_counter = tile4_noc1_inE_payload_counter - 1;
             if (tile4_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile4_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc1_inE_header[49:42];
                     target = (target << 8) | tile4_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc1_inE_bdw_allocation, 257, tile4_noc1_inE_header[21:14], tile4_noc1_inE_header[29:22], (counter - tile4_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile4_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn1_validIn_W)
    begin
         case (tile4_noc1_inW_packet_state)
         HEADER:
         begin
             tile4_noc1_inW_bdw_allocation = counter;
             tile4_noc1_inW_payload_counter = `TILE4.dyn1_dataIn_W[29:22];
             tile4_noc1_inW_header = `TILE4.dyn1_dataIn_W;
             tile4_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc1_inW_payload_counter = tile4_noc1_inW_payload_counter - 1;
             if (tile4_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile4_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc1_inW_header[49:42];
                     target = (target << 8) | tile4_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc1_inW_bdw_allocation, 257, tile4_noc1_inW_header[21:14], tile4_noc1_inW_header[29:22], (counter - tile4_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile4_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.buffer_router_valid_noc3)
    begin
         case (tile4_noc2_inL_packet_state)
         HEADER:
         begin
             tile4_noc2_inL_bdw_allocation = counter;
             tile4_noc2_inL_payload_counter = `TILE4.buffer_router_data_noc3[29:22];
             tile4_noc2_inL_header = `TILE4.buffer_router_data_noc3;
             tile4_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc2_inL_payload_counter = tile4_noc2_inL_payload_counter - 1;
             if (tile4_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile4_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc2_inL_header[49:42];
                     target = (target << 8) | tile4_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc2_inL_bdw_allocation, 257, tile4_noc2_inL_header[21:14], tile4_noc2_inL_header[29:22], (counter - tile4_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile4_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn2_validIn_N)
    begin
         case (tile4_noc2_inN_packet_state)
         HEADER:
         begin
             tile4_noc2_inN_bdw_allocation = counter;
             tile4_noc2_inN_payload_counter = `TILE4.dyn2_dataIn_N[29:22];
             tile4_noc2_inN_header = `TILE4.dyn2_dataIn_N;
             tile4_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc2_inN_payload_counter = tile4_noc2_inN_payload_counter - 1;
             if (tile4_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile4_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc2_inN_header[49:42];
                     target = (target << 8) | tile4_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc2_inN_bdw_allocation, 257, tile4_noc2_inN_header[21:14], tile4_noc2_inN_header[29:22], (counter - tile4_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile4_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn2_validIn_S)
    begin
         case (tile4_noc2_inS_packet_state)
         HEADER:
         begin
             tile4_noc2_inS_bdw_allocation = counter;
             tile4_noc2_inS_payload_counter = `TILE4.dyn2_dataIn_S[29:22];
             tile4_noc2_inS_header = `TILE4.dyn2_dataIn_S;
             tile4_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc2_inS_payload_counter = tile4_noc2_inS_payload_counter - 1;
             if (tile4_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile4_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc2_inS_header[49:42];
                     target = (target << 8) | tile4_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc2_inS_bdw_allocation, 257, tile4_noc2_inS_header[21:14], tile4_noc2_inS_header[29:22], (counter - tile4_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile4_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn2_validIn_E)
    begin
         case (tile4_noc2_inE_packet_state)
         HEADER:
         begin
             tile4_noc2_inE_bdw_allocation = counter;
             tile4_noc2_inE_payload_counter = `TILE4.dyn2_dataIn_E[29:22];
             tile4_noc2_inE_header = `TILE4.dyn2_dataIn_E;
             tile4_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc2_inE_payload_counter = tile4_noc2_inE_payload_counter - 1;
             if (tile4_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile4_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc2_inE_header[49:42];
                     target = (target << 8) | tile4_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc2_inE_bdw_allocation, 257, tile4_noc2_inE_header[21:14], tile4_noc2_inE_header[29:22], (counter - tile4_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile4_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE4.dyn2_validIn_W)
    begin
         case (tile4_noc2_inW_packet_state)
         HEADER:
         begin
             tile4_noc2_inW_bdw_allocation = counter;
             tile4_noc2_inW_payload_counter = `TILE4.dyn2_dataIn_W[29:22];
             tile4_noc2_inW_header = `TILE4.dyn2_dataIn_W;
             tile4_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile4_noc2_inW_payload_counter = tile4_noc2_inW_payload_counter - 1;
             if (tile4_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile4_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile4_noc2_inW_header[49:42];
                     target = (target << 8) | tile4_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile4_noc2_inW_bdw_allocation, 257, tile4_noc2_inW_header[21:14], tile4_noc2_inW_header[29:22], (counter - tile4_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile4_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.buffer_router_valid_noc1)
    begin
         case (tile5_noc0_inL_packet_state)
         HEADER:
         begin
             tile5_noc0_inL_bdw_allocation = counter;
             tile5_noc0_inL_payload_counter = `TILE5.buffer_router_data_noc1[29:22];
             tile5_noc0_inL_header = `TILE5.buffer_router_data_noc1;
             tile5_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc0_inL_payload_counter = tile5_noc0_inL_payload_counter - 1;
             if (tile5_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile5_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc0_inL_header[49:42];
                     target = (target << 8) | tile5_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc0_inL_bdw_allocation, 513, tile5_noc0_inL_header[21:14], tile5_noc0_inL_header[29:22], (counter - tile5_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile5_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn0_validIn_N)
    begin
         case (tile5_noc0_inN_packet_state)
         HEADER:
         begin
             tile5_noc0_inN_bdw_allocation = counter;
             tile5_noc0_inN_payload_counter = `TILE5.dyn0_dataIn_N[29:22];
             tile5_noc0_inN_header = `TILE5.dyn0_dataIn_N;
             tile5_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc0_inN_payload_counter = tile5_noc0_inN_payload_counter - 1;
             if (tile5_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile5_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc0_inN_header[49:42];
                     target = (target << 8) | tile5_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc0_inN_bdw_allocation, 513, tile5_noc0_inN_header[21:14], tile5_noc0_inN_header[29:22], (counter - tile5_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile5_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn0_validIn_S)
    begin
         case (tile5_noc0_inS_packet_state)
         HEADER:
         begin
             tile5_noc0_inS_bdw_allocation = counter;
             tile5_noc0_inS_payload_counter = `TILE5.dyn0_dataIn_S[29:22];
             tile5_noc0_inS_header = `TILE5.dyn0_dataIn_S;
             tile5_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc0_inS_payload_counter = tile5_noc0_inS_payload_counter - 1;
             if (tile5_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile5_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc0_inS_header[49:42];
                     target = (target << 8) | tile5_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc0_inS_bdw_allocation, 513, tile5_noc0_inS_header[21:14], tile5_noc0_inS_header[29:22], (counter - tile5_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile5_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn0_validIn_E)
    begin
         case (tile5_noc0_inE_packet_state)
         HEADER:
         begin
             tile5_noc0_inE_bdw_allocation = counter;
             tile5_noc0_inE_payload_counter = `TILE5.dyn0_dataIn_E[29:22];
             tile5_noc0_inE_header = `TILE5.dyn0_dataIn_E;
             tile5_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc0_inE_payload_counter = tile5_noc0_inE_payload_counter - 1;
             if (tile5_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile5_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc0_inE_header[49:42];
                     target = (target << 8) | tile5_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc0_inE_bdw_allocation, 513, tile5_noc0_inE_header[21:14], tile5_noc0_inE_header[29:22], (counter - tile5_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile5_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn0_validIn_W)
    begin
         case (tile5_noc0_inW_packet_state)
         HEADER:
         begin
             tile5_noc0_inW_bdw_allocation = counter;
             tile5_noc0_inW_payload_counter = `TILE5.dyn0_dataIn_W[29:22];
             tile5_noc0_inW_header = `TILE5.dyn0_dataIn_W;
             tile5_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc0_inW_payload_counter = tile5_noc0_inW_payload_counter - 1;
             if (tile5_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile5_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc0_inW_header[49:42];
                     target = (target << 8) | tile5_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc0_inW_bdw_allocation, 513, tile5_noc0_inW_header[21:14], tile5_noc0_inW_header[29:22], (counter - tile5_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile5_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.buffer_router_valid_noc2)
    begin
         case (tile5_noc1_inL_packet_state)
         HEADER:
         begin
             tile5_noc1_inL_bdw_allocation = counter;
             tile5_noc1_inL_payload_counter = `TILE5.buffer_router_data_noc2[29:22];
             tile5_noc1_inL_header = `TILE5.buffer_router_data_noc2;
             tile5_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc1_inL_payload_counter = tile5_noc1_inL_payload_counter - 1;
             if (tile5_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile5_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc1_inL_header[49:42];
                     target = (target << 8) | tile5_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc1_inL_bdw_allocation, 513, tile5_noc1_inL_header[21:14], tile5_noc1_inL_header[29:22], (counter - tile5_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile5_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn1_validIn_N)
    begin
         case (tile5_noc1_inN_packet_state)
         HEADER:
         begin
             tile5_noc1_inN_bdw_allocation = counter;
             tile5_noc1_inN_payload_counter = `TILE5.dyn1_dataIn_N[29:22];
             tile5_noc1_inN_header = `TILE5.dyn1_dataIn_N;
             tile5_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc1_inN_payload_counter = tile5_noc1_inN_payload_counter - 1;
             if (tile5_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile5_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc1_inN_header[49:42];
                     target = (target << 8) | tile5_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc1_inN_bdw_allocation, 513, tile5_noc1_inN_header[21:14], tile5_noc1_inN_header[29:22], (counter - tile5_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile5_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn1_validIn_S)
    begin
         case (tile5_noc1_inS_packet_state)
         HEADER:
         begin
             tile5_noc1_inS_bdw_allocation = counter;
             tile5_noc1_inS_payload_counter = `TILE5.dyn1_dataIn_S[29:22];
             tile5_noc1_inS_header = `TILE5.dyn1_dataIn_S;
             tile5_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc1_inS_payload_counter = tile5_noc1_inS_payload_counter - 1;
             if (tile5_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile5_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc1_inS_header[49:42];
                     target = (target << 8) | tile5_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc1_inS_bdw_allocation, 513, tile5_noc1_inS_header[21:14], tile5_noc1_inS_header[29:22], (counter - tile5_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile5_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn1_validIn_E)
    begin
         case (tile5_noc1_inE_packet_state)
         HEADER:
         begin
             tile5_noc1_inE_bdw_allocation = counter;
             tile5_noc1_inE_payload_counter = `TILE5.dyn1_dataIn_E[29:22];
             tile5_noc1_inE_header = `TILE5.dyn1_dataIn_E;
             tile5_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc1_inE_payload_counter = tile5_noc1_inE_payload_counter - 1;
             if (tile5_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile5_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc1_inE_header[49:42];
                     target = (target << 8) | tile5_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc1_inE_bdw_allocation, 513, tile5_noc1_inE_header[21:14], tile5_noc1_inE_header[29:22], (counter - tile5_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile5_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn1_validIn_W)
    begin
         case (tile5_noc1_inW_packet_state)
         HEADER:
         begin
             tile5_noc1_inW_bdw_allocation = counter;
             tile5_noc1_inW_payload_counter = `TILE5.dyn1_dataIn_W[29:22];
             tile5_noc1_inW_header = `TILE5.dyn1_dataIn_W;
             tile5_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc1_inW_payload_counter = tile5_noc1_inW_payload_counter - 1;
             if (tile5_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile5_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc1_inW_header[49:42];
                     target = (target << 8) | tile5_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc1_inW_bdw_allocation, 513, tile5_noc1_inW_header[21:14], tile5_noc1_inW_header[29:22], (counter - tile5_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile5_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.buffer_router_valid_noc3)
    begin
         case (tile5_noc2_inL_packet_state)
         HEADER:
         begin
             tile5_noc2_inL_bdw_allocation = counter;
             tile5_noc2_inL_payload_counter = `TILE5.buffer_router_data_noc3[29:22];
             tile5_noc2_inL_header = `TILE5.buffer_router_data_noc3;
             tile5_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc2_inL_payload_counter = tile5_noc2_inL_payload_counter - 1;
             if (tile5_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile5_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc2_inL_header[49:42];
                     target = (target << 8) | tile5_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc2_inL_bdw_allocation, 513, tile5_noc2_inL_header[21:14], tile5_noc2_inL_header[29:22], (counter - tile5_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile5_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn2_validIn_N)
    begin
         case (tile5_noc2_inN_packet_state)
         HEADER:
         begin
             tile5_noc2_inN_bdw_allocation = counter;
             tile5_noc2_inN_payload_counter = `TILE5.dyn2_dataIn_N[29:22];
             tile5_noc2_inN_header = `TILE5.dyn2_dataIn_N;
             tile5_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc2_inN_payload_counter = tile5_noc2_inN_payload_counter - 1;
             if (tile5_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile5_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc2_inN_header[49:42];
                     target = (target << 8) | tile5_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc2_inN_bdw_allocation, 513, tile5_noc2_inN_header[21:14], tile5_noc2_inN_header[29:22], (counter - tile5_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile5_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn2_validIn_S)
    begin
         case (tile5_noc2_inS_packet_state)
         HEADER:
         begin
             tile5_noc2_inS_bdw_allocation = counter;
             tile5_noc2_inS_payload_counter = `TILE5.dyn2_dataIn_S[29:22];
             tile5_noc2_inS_header = `TILE5.dyn2_dataIn_S;
             tile5_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc2_inS_payload_counter = tile5_noc2_inS_payload_counter - 1;
             if (tile5_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile5_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc2_inS_header[49:42];
                     target = (target << 8) | tile5_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc2_inS_bdw_allocation, 513, tile5_noc2_inS_header[21:14], tile5_noc2_inS_header[29:22], (counter - tile5_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile5_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn2_validIn_E)
    begin
         case (tile5_noc2_inE_packet_state)
         HEADER:
         begin
             tile5_noc2_inE_bdw_allocation = counter;
             tile5_noc2_inE_payload_counter = `TILE5.dyn2_dataIn_E[29:22];
             tile5_noc2_inE_header = `TILE5.dyn2_dataIn_E;
             tile5_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc2_inE_payload_counter = tile5_noc2_inE_payload_counter - 1;
             if (tile5_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile5_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc2_inE_header[49:42];
                     target = (target << 8) | tile5_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc2_inE_bdw_allocation, 513, tile5_noc2_inE_header[21:14], tile5_noc2_inE_header[29:22], (counter - tile5_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile5_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE5.dyn2_validIn_W)
    begin
         case (tile5_noc2_inW_packet_state)
         HEADER:
         begin
             tile5_noc2_inW_bdw_allocation = counter;
             tile5_noc2_inW_payload_counter = `TILE5.dyn2_dataIn_W[29:22];
             tile5_noc2_inW_header = `TILE5.dyn2_dataIn_W;
             tile5_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile5_noc2_inW_payload_counter = tile5_noc2_inW_payload_counter - 1;
             if (tile5_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile5_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile5_noc2_inW_header[49:42];
                     target = (target << 8) | tile5_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile5_noc2_inW_bdw_allocation, 513, tile5_noc2_inW_header[21:14], tile5_noc2_inW_header[29:22], (counter - tile5_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile5_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.buffer_router_valid_noc1)
    begin
         case (tile6_noc0_inL_packet_state)
         HEADER:
         begin
             tile6_noc0_inL_bdw_allocation = counter;
             tile6_noc0_inL_payload_counter = `TILE6.buffer_router_data_noc1[29:22];
             tile6_noc0_inL_header = `TILE6.buffer_router_data_noc1;
             tile6_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc0_inL_payload_counter = tile6_noc0_inL_payload_counter - 1;
             if (tile6_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile6_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc0_inL_header[49:42];
                     target = (target << 8) | tile6_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc0_inL_bdw_allocation, 2, tile6_noc0_inL_header[21:14], tile6_noc0_inL_header[29:22], (counter - tile6_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile6_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn0_validIn_N)
    begin
         case (tile6_noc0_inN_packet_state)
         HEADER:
         begin
             tile6_noc0_inN_bdw_allocation = counter;
             tile6_noc0_inN_payload_counter = `TILE6.dyn0_dataIn_N[29:22];
             tile6_noc0_inN_header = `TILE6.dyn0_dataIn_N;
             tile6_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc0_inN_payload_counter = tile6_noc0_inN_payload_counter - 1;
             if (tile6_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile6_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc0_inN_header[49:42];
                     target = (target << 8) | tile6_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc0_inN_bdw_allocation, 2, tile6_noc0_inN_header[21:14], tile6_noc0_inN_header[29:22], (counter - tile6_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile6_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn0_validIn_S)
    begin
         case (tile6_noc0_inS_packet_state)
         HEADER:
         begin
             tile6_noc0_inS_bdw_allocation = counter;
             tile6_noc0_inS_payload_counter = `TILE6.dyn0_dataIn_S[29:22];
             tile6_noc0_inS_header = `TILE6.dyn0_dataIn_S;
             tile6_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc0_inS_payload_counter = tile6_noc0_inS_payload_counter - 1;
             if (tile6_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile6_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc0_inS_header[49:42];
                     target = (target << 8) | tile6_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc0_inS_bdw_allocation, 2, tile6_noc0_inS_header[21:14], tile6_noc0_inS_header[29:22], (counter - tile6_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile6_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn0_validIn_E)
    begin
         case (tile6_noc0_inE_packet_state)
         HEADER:
         begin
             tile6_noc0_inE_bdw_allocation = counter;
             tile6_noc0_inE_payload_counter = `TILE6.dyn0_dataIn_E[29:22];
             tile6_noc0_inE_header = `TILE6.dyn0_dataIn_E;
             tile6_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc0_inE_payload_counter = tile6_noc0_inE_payload_counter - 1;
             if (tile6_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile6_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc0_inE_header[49:42];
                     target = (target << 8) | tile6_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc0_inE_bdw_allocation, 2, tile6_noc0_inE_header[21:14], tile6_noc0_inE_header[29:22], (counter - tile6_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile6_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn0_validIn_W)
    begin
         case (tile6_noc0_inW_packet_state)
         HEADER:
         begin
             tile6_noc0_inW_bdw_allocation = counter;
             tile6_noc0_inW_payload_counter = `TILE6.dyn0_dataIn_W[29:22];
             tile6_noc0_inW_header = `TILE6.dyn0_dataIn_W;
             tile6_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc0_inW_payload_counter = tile6_noc0_inW_payload_counter - 1;
             if (tile6_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile6_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc0_inW_header[49:42];
                     target = (target << 8) | tile6_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc0_inW_bdw_allocation, 2, tile6_noc0_inW_header[21:14], tile6_noc0_inW_header[29:22], (counter - tile6_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile6_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.buffer_router_valid_noc2)
    begin
         case (tile6_noc1_inL_packet_state)
         HEADER:
         begin
             tile6_noc1_inL_bdw_allocation = counter;
             tile6_noc1_inL_payload_counter = `TILE6.buffer_router_data_noc2[29:22];
             tile6_noc1_inL_header = `TILE6.buffer_router_data_noc2;
             tile6_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc1_inL_payload_counter = tile6_noc1_inL_payload_counter - 1;
             if (tile6_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile6_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc1_inL_header[49:42];
                     target = (target << 8) | tile6_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc1_inL_bdw_allocation, 2, tile6_noc1_inL_header[21:14], tile6_noc1_inL_header[29:22], (counter - tile6_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile6_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn1_validIn_N)
    begin
         case (tile6_noc1_inN_packet_state)
         HEADER:
         begin
             tile6_noc1_inN_bdw_allocation = counter;
             tile6_noc1_inN_payload_counter = `TILE6.dyn1_dataIn_N[29:22];
             tile6_noc1_inN_header = `TILE6.dyn1_dataIn_N;
             tile6_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc1_inN_payload_counter = tile6_noc1_inN_payload_counter - 1;
             if (tile6_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile6_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc1_inN_header[49:42];
                     target = (target << 8) | tile6_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc1_inN_bdw_allocation, 2, tile6_noc1_inN_header[21:14], tile6_noc1_inN_header[29:22], (counter - tile6_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile6_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn1_validIn_S)
    begin
         case (tile6_noc1_inS_packet_state)
         HEADER:
         begin
             tile6_noc1_inS_bdw_allocation = counter;
             tile6_noc1_inS_payload_counter = `TILE6.dyn1_dataIn_S[29:22];
             tile6_noc1_inS_header = `TILE6.dyn1_dataIn_S;
             tile6_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc1_inS_payload_counter = tile6_noc1_inS_payload_counter - 1;
             if (tile6_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile6_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc1_inS_header[49:42];
                     target = (target << 8) | tile6_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc1_inS_bdw_allocation, 2, tile6_noc1_inS_header[21:14], tile6_noc1_inS_header[29:22], (counter - tile6_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile6_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn1_validIn_E)
    begin
         case (tile6_noc1_inE_packet_state)
         HEADER:
         begin
             tile6_noc1_inE_bdw_allocation = counter;
             tile6_noc1_inE_payload_counter = `TILE6.dyn1_dataIn_E[29:22];
             tile6_noc1_inE_header = `TILE6.dyn1_dataIn_E;
             tile6_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc1_inE_payload_counter = tile6_noc1_inE_payload_counter - 1;
             if (tile6_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile6_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc1_inE_header[49:42];
                     target = (target << 8) | tile6_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc1_inE_bdw_allocation, 2, tile6_noc1_inE_header[21:14], tile6_noc1_inE_header[29:22], (counter - tile6_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile6_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn1_validIn_W)
    begin
         case (tile6_noc1_inW_packet_state)
         HEADER:
         begin
             tile6_noc1_inW_bdw_allocation = counter;
             tile6_noc1_inW_payload_counter = `TILE6.dyn1_dataIn_W[29:22];
             tile6_noc1_inW_header = `TILE6.dyn1_dataIn_W;
             tile6_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc1_inW_payload_counter = tile6_noc1_inW_payload_counter - 1;
             if (tile6_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile6_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc1_inW_header[49:42];
                     target = (target << 8) | tile6_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc1_inW_bdw_allocation, 2, tile6_noc1_inW_header[21:14], tile6_noc1_inW_header[29:22], (counter - tile6_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile6_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.buffer_router_valid_noc3)
    begin
         case (tile6_noc2_inL_packet_state)
         HEADER:
         begin
             tile6_noc2_inL_bdw_allocation = counter;
             tile6_noc2_inL_payload_counter = `TILE6.buffer_router_data_noc3[29:22];
             tile6_noc2_inL_header = `TILE6.buffer_router_data_noc3;
             tile6_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc2_inL_payload_counter = tile6_noc2_inL_payload_counter - 1;
             if (tile6_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile6_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc2_inL_header[49:42];
                     target = (target << 8) | tile6_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc2_inL_bdw_allocation, 2, tile6_noc2_inL_header[21:14], tile6_noc2_inL_header[29:22], (counter - tile6_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile6_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn2_validIn_N)
    begin
         case (tile6_noc2_inN_packet_state)
         HEADER:
         begin
             tile6_noc2_inN_bdw_allocation = counter;
             tile6_noc2_inN_payload_counter = `TILE6.dyn2_dataIn_N[29:22];
             tile6_noc2_inN_header = `TILE6.dyn2_dataIn_N;
             tile6_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc2_inN_payload_counter = tile6_noc2_inN_payload_counter - 1;
             if (tile6_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile6_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc2_inN_header[49:42];
                     target = (target << 8) | tile6_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc2_inN_bdw_allocation, 2, tile6_noc2_inN_header[21:14], tile6_noc2_inN_header[29:22], (counter - tile6_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile6_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn2_validIn_S)
    begin
         case (tile6_noc2_inS_packet_state)
         HEADER:
         begin
             tile6_noc2_inS_bdw_allocation = counter;
             tile6_noc2_inS_payload_counter = `TILE6.dyn2_dataIn_S[29:22];
             tile6_noc2_inS_header = `TILE6.dyn2_dataIn_S;
             tile6_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc2_inS_payload_counter = tile6_noc2_inS_payload_counter - 1;
             if (tile6_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile6_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc2_inS_header[49:42];
                     target = (target << 8) | tile6_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc2_inS_bdw_allocation, 2, tile6_noc2_inS_header[21:14], tile6_noc2_inS_header[29:22], (counter - tile6_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile6_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn2_validIn_E)
    begin
         case (tile6_noc2_inE_packet_state)
         HEADER:
         begin
             tile6_noc2_inE_bdw_allocation = counter;
             tile6_noc2_inE_payload_counter = `TILE6.dyn2_dataIn_E[29:22];
             tile6_noc2_inE_header = `TILE6.dyn2_dataIn_E;
             tile6_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc2_inE_payload_counter = tile6_noc2_inE_payload_counter - 1;
             if (tile6_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile6_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc2_inE_header[49:42];
                     target = (target << 8) | tile6_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc2_inE_bdw_allocation, 2, tile6_noc2_inE_header[21:14], tile6_noc2_inE_header[29:22], (counter - tile6_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile6_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE6.dyn2_validIn_W)
    begin
         case (tile6_noc2_inW_packet_state)
         HEADER:
         begin
             tile6_noc2_inW_bdw_allocation = counter;
             tile6_noc2_inW_payload_counter = `TILE6.dyn2_dataIn_W[29:22];
             tile6_noc2_inW_header = `TILE6.dyn2_dataIn_W;
             tile6_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile6_noc2_inW_payload_counter = tile6_noc2_inW_payload_counter - 1;
             if (tile6_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile6_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile6_noc2_inW_header[49:42];
                     target = (target << 8) | tile6_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile6_noc2_inW_bdw_allocation, 2, tile6_noc2_inW_header[21:14], tile6_noc2_inW_header[29:22], (counter - tile6_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile6_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.buffer_router_valid_noc1)
    begin
         case (tile7_noc0_inL_packet_state)
         HEADER:
         begin
             tile7_noc0_inL_bdw_allocation = counter;
             tile7_noc0_inL_payload_counter = `TILE7.buffer_router_data_noc1[29:22];
             tile7_noc0_inL_header = `TILE7.buffer_router_data_noc1;
             tile7_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc0_inL_payload_counter = tile7_noc0_inL_payload_counter - 1;
             if (tile7_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile7_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc0_inL_header[49:42];
                     target = (target << 8) | tile7_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc0_inL_bdw_allocation, 258, tile7_noc0_inL_header[21:14], tile7_noc0_inL_header[29:22], (counter - tile7_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile7_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn0_validIn_N)
    begin
         case (tile7_noc0_inN_packet_state)
         HEADER:
         begin
             tile7_noc0_inN_bdw_allocation = counter;
             tile7_noc0_inN_payload_counter = `TILE7.dyn0_dataIn_N[29:22];
             tile7_noc0_inN_header = `TILE7.dyn0_dataIn_N;
             tile7_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc0_inN_payload_counter = tile7_noc0_inN_payload_counter - 1;
             if (tile7_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile7_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc0_inN_header[49:42];
                     target = (target << 8) | tile7_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc0_inN_bdw_allocation, 258, tile7_noc0_inN_header[21:14], tile7_noc0_inN_header[29:22], (counter - tile7_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile7_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn0_validIn_S)
    begin
         case (tile7_noc0_inS_packet_state)
         HEADER:
         begin
             tile7_noc0_inS_bdw_allocation = counter;
             tile7_noc0_inS_payload_counter = `TILE7.dyn0_dataIn_S[29:22];
             tile7_noc0_inS_header = `TILE7.dyn0_dataIn_S;
             tile7_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc0_inS_payload_counter = tile7_noc0_inS_payload_counter - 1;
             if (tile7_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile7_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc0_inS_header[49:42];
                     target = (target << 8) | tile7_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc0_inS_bdw_allocation, 258, tile7_noc0_inS_header[21:14], tile7_noc0_inS_header[29:22], (counter - tile7_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile7_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn0_validIn_E)
    begin
         case (tile7_noc0_inE_packet_state)
         HEADER:
         begin
             tile7_noc0_inE_bdw_allocation = counter;
             tile7_noc0_inE_payload_counter = `TILE7.dyn0_dataIn_E[29:22];
             tile7_noc0_inE_header = `TILE7.dyn0_dataIn_E;
             tile7_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc0_inE_payload_counter = tile7_noc0_inE_payload_counter - 1;
             if (tile7_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile7_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc0_inE_header[49:42];
                     target = (target << 8) | tile7_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc0_inE_bdw_allocation, 258, tile7_noc0_inE_header[21:14], tile7_noc0_inE_header[29:22], (counter - tile7_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile7_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn0_validIn_W)
    begin
         case (tile7_noc0_inW_packet_state)
         HEADER:
         begin
             tile7_noc0_inW_bdw_allocation = counter;
             tile7_noc0_inW_payload_counter = `TILE7.dyn0_dataIn_W[29:22];
             tile7_noc0_inW_header = `TILE7.dyn0_dataIn_W;
             tile7_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc0_inW_payload_counter = tile7_noc0_inW_payload_counter - 1;
             if (tile7_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile7_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc0_inW_header[49:42];
                     target = (target << 8) | tile7_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc0_inW_bdw_allocation, 258, tile7_noc0_inW_header[21:14], tile7_noc0_inW_header[29:22], (counter - tile7_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile7_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.buffer_router_valid_noc2)
    begin
         case (tile7_noc1_inL_packet_state)
         HEADER:
         begin
             tile7_noc1_inL_bdw_allocation = counter;
             tile7_noc1_inL_payload_counter = `TILE7.buffer_router_data_noc2[29:22];
             tile7_noc1_inL_header = `TILE7.buffer_router_data_noc2;
             tile7_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc1_inL_payload_counter = tile7_noc1_inL_payload_counter - 1;
             if (tile7_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile7_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc1_inL_header[49:42];
                     target = (target << 8) | tile7_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc1_inL_bdw_allocation, 258, tile7_noc1_inL_header[21:14], tile7_noc1_inL_header[29:22], (counter - tile7_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile7_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn1_validIn_N)
    begin
         case (tile7_noc1_inN_packet_state)
         HEADER:
         begin
             tile7_noc1_inN_bdw_allocation = counter;
             tile7_noc1_inN_payload_counter = `TILE7.dyn1_dataIn_N[29:22];
             tile7_noc1_inN_header = `TILE7.dyn1_dataIn_N;
             tile7_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc1_inN_payload_counter = tile7_noc1_inN_payload_counter - 1;
             if (tile7_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile7_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc1_inN_header[49:42];
                     target = (target << 8) | tile7_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc1_inN_bdw_allocation, 258, tile7_noc1_inN_header[21:14], tile7_noc1_inN_header[29:22], (counter - tile7_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile7_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn1_validIn_S)
    begin
         case (tile7_noc1_inS_packet_state)
         HEADER:
         begin
             tile7_noc1_inS_bdw_allocation = counter;
             tile7_noc1_inS_payload_counter = `TILE7.dyn1_dataIn_S[29:22];
             tile7_noc1_inS_header = `TILE7.dyn1_dataIn_S;
             tile7_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc1_inS_payload_counter = tile7_noc1_inS_payload_counter - 1;
             if (tile7_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile7_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc1_inS_header[49:42];
                     target = (target << 8) | tile7_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc1_inS_bdw_allocation, 258, tile7_noc1_inS_header[21:14], tile7_noc1_inS_header[29:22], (counter - tile7_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile7_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn1_validIn_E)
    begin
         case (tile7_noc1_inE_packet_state)
         HEADER:
         begin
             tile7_noc1_inE_bdw_allocation = counter;
             tile7_noc1_inE_payload_counter = `TILE7.dyn1_dataIn_E[29:22];
             tile7_noc1_inE_header = `TILE7.dyn1_dataIn_E;
             tile7_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc1_inE_payload_counter = tile7_noc1_inE_payload_counter - 1;
             if (tile7_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile7_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc1_inE_header[49:42];
                     target = (target << 8) | tile7_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc1_inE_bdw_allocation, 258, tile7_noc1_inE_header[21:14], tile7_noc1_inE_header[29:22], (counter - tile7_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile7_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn1_validIn_W)
    begin
         case (tile7_noc1_inW_packet_state)
         HEADER:
         begin
             tile7_noc1_inW_bdw_allocation = counter;
             tile7_noc1_inW_payload_counter = `TILE7.dyn1_dataIn_W[29:22];
             tile7_noc1_inW_header = `TILE7.dyn1_dataIn_W;
             tile7_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc1_inW_payload_counter = tile7_noc1_inW_payload_counter - 1;
             if (tile7_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile7_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc1_inW_header[49:42];
                     target = (target << 8) | tile7_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc1_inW_bdw_allocation, 258, tile7_noc1_inW_header[21:14], tile7_noc1_inW_header[29:22], (counter - tile7_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile7_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.buffer_router_valid_noc3)
    begin
         case (tile7_noc2_inL_packet_state)
         HEADER:
         begin
             tile7_noc2_inL_bdw_allocation = counter;
             tile7_noc2_inL_payload_counter = `TILE7.buffer_router_data_noc3[29:22];
             tile7_noc2_inL_header = `TILE7.buffer_router_data_noc3;
             tile7_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc2_inL_payload_counter = tile7_noc2_inL_payload_counter - 1;
             if (tile7_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile7_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc2_inL_header[49:42];
                     target = (target << 8) | tile7_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc2_inL_bdw_allocation, 258, tile7_noc2_inL_header[21:14], tile7_noc2_inL_header[29:22], (counter - tile7_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile7_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn2_validIn_N)
    begin
         case (tile7_noc2_inN_packet_state)
         HEADER:
         begin
             tile7_noc2_inN_bdw_allocation = counter;
             tile7_noc2_inN_payload_counter = `TILE7.dyn2_dataIn_N[29:22];
             tile7_noc2_inN_header = `TILE7.dyn2_dataIn_N;
             tile7_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc2_inN_payload_counter = tile7_noc2_inN_payload_counter - 1;
             if (tile7_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile7_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc2_inN_header[49:42];
                     target = (target << 8) | tile7_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc2_inN_bdw_allocation, 258, tile7_noc2_inN_header[21:14], tile7_noc2_inN_header[29:22], (counter - tile7_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile7_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn2_validIn_S)
    begin
         case (tile7_noc2_inS_packet_state)
         HEADER:
         begin
             tile7_noc2_inS_bdw_allocation = counter;
             tile7_noc2_inS_payload_counter = `TILE7.dyn2_dataIn_S[29:22];
             tile7_noc2_inS_header = `TILE7.dyn2_dataIn_S;
             tile7_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc2_inS_payload_counter = tile7_noc2_inS_payload_counter - 1;
             if (tile7_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile7_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc2_inS_header[49:42];
                     target = (target << 8) | tile7_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc2_inS_bdw_allocation, 258, tile7_noc2_inS_header[21:14], tile7_noc2_inS_header[29:22], (counter - tile7_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile7_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn2_validIn_E)
    begin
         case (tile7_noc2_inE_packet_state)
         HEADER:
         begin
             tile7_noc2_inE_bdw_allocation = counter;
             tile7_noc2_inE_payload_counter = `TILE7.dyn2_dataIn_E[29:22];
             tile7_noc2_inE_header = `TILE7.dyn2_dataIn_E;
             tile7_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc2_inE_payload_counter = tile7_noc2_inE_payload_counter - 1;
             if (tile7_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile7_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc2_inE_header[49:42];
                     target = (target << 8) | tile7_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc2_inE_bdw_allocation, 258, tile7_noc2_inE_header[21:14], tile7_noc2_inE_header[29:22], (counter - tile7_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile7_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE7.dyn2_validIn_W)
    begin
         case (tile7_noc2_inW_packet_state)
         HEADER:
         begin
             tile7_noc2_inW_bdw_allocation = counter;
             tile7_noc2_inW_payload_counter = `TILE7.dyn2_dataIn_W[29:22];
             tile7_noc2_inW_header = `TILE7.dyn2_dataIn_W;
             tile7_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile7_noc2_inW_payload_counter = tile7_noc2_inW_payload_counter - 1;
             if (tile7_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile7_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile7_noc2_inW_header[49:42];
                     target = (target << 8) | tile7_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile7_noc2_inW_bdw_allocation, 258, tile7_noc2_inW_header[21:14], tile7_noc2_inW_header[29:22], (counter - tile7_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile7_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.buffer_router_valid_noc1)
    begin
         case (tile8_noc0_inL_packet_state)
         HEADER:
         begin
             tile8_noc0_inL_bdw_allocation = counter;
             tile8_noc0_inL_payload_counter = `TILE8.buffer_router_data_noc1[29:22];
             tile8_noc0_inL_header = `TILE8.buffer_router_data_noc1;
             tile8_noc0_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc0_inL_payload_counter = tile8_noc0_inL_payload_counter - 1;
             if (tile8_noc0_inL_payload_counter == 0)
             begin
                 chipID = tile8_noc0_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc0_inL_header[49:42];
                     target = (target << 8) | tile8_noc0_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc0_inL_bdw_allocation, 514, tile8_noc0_inL_header[21:14], tile8_noc0_inL_header[29:22], (counter - tile8_noc0_inL_bdw_allocation), 1, "L", target);
                 $fclose(fd);
                 tile8_noc0_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn0_validIn_N)
    begin
         case (tile8_noc0_inN_packet_state)
         HEADER:
         begin
             tile8_noc0_inN_bdw_allocation = counter;
             tile8_noc0_inN_payload_counter = `TILE8.dyn0_dataIn_N[29:22];
             tile8_noc0_inN_header = `TILE8.dyn0_dataIn_N;
             tile8_noc0_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc0_inN_payload_counter = tile8_noc0_inN_payload_counter - 1;
             if (tile8_noc0_inN_payload_counter == 0)
             begin
                 chipID = tile8_noc0_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc0_inN_header[49:42];
                     target = (target << 8) | tile8_noc0_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc0_inN_bdw_allocation, 514, tile8_noc0_inN_header[21:14], tile8_noc0_inN_header[29:22], (counter - tile8_noc0_inN_bdw_allocation), 1, "N", target);
                 $fclose(fd);
                 tile8_noc0_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn0_validIn_S)
    begin
         case (tile8_noc0_inS_packet_state)
         HEADER:
         begin
             tile8_noc0_inS_bdw_allocation = counter;
             tile8_noc0_inS_payload_counter = `TILE8.dyn0_dataIn_S[29:22];
             tile8_noc0_inS_header = `TILE8.dyn0_dataIn_S;
             tile8_noc0_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc0_inS_payload_counter = tile8_noc0_inS_payload_counter - 1;
             if (tile8_noc0_inS_payload_counter == 0)
             begin
                 chipID = tile8_noc0_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc0_inS_header[49:42];
                     target = (target << 8) | tile8_noc0_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc0_inS_bdw_allocation, 514, tile8_noc0_inS_header[21:14], tile8_noc0_inS_header[29:22], (counter - tile8_noc0_inS_bdw_allocation), 1, "S", target);
                 $fclose(fd);
                 tile8_noc0_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn0_validIn_E)
    begin
         case (tile8_noc0_inE_packet_state)
         HEADER:
         begin
             tile8_noc0_inE_bdw_allocation = counter;
             tile8_noc0_inE_payload_counter = `TILE8.dyn0_dataIn_E[29:22];
             tile8_noc0_inE_header = `TILE8.dyn0_dataIn_E;
             tile8_noc0_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc0_inE_payload_counter = tile8_noc0_inE_payload_counter - 1;
             if (tile8_noc0_inE_payload_counter == 0)
             begin
                 chipID = tile8_noc0_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc0_inE_header[49:42];
                     target = (target << 8) | tile8_noc0_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc0_inE_bdw_allocation, 514, tile8_noc0_inE_header[21:14], tile8_noc0_inE_header[29:22], (counter - tile8_noc0_inE_bdw_allocation), 1, "E", target);
                 $fclose(fd);
                 tile8_noc0_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn0_validIn_W)
    begin
         case (tile8_noc0_inW_packet_state)
         HEADER:
         begin
             tile8_noc0_inW_bdw_allocation = counter;
             tile8_noc0_inW_payload_counter = `TILE8.dyn0_dataIn_W[29:22];
             tile8_noc0_inW_header = `TILE8.dyn0_dataIn_W;
             tile8_noc0_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc0_inW_payload_counter = tile8_noc0_inW_payload_counter - 1;
             if (tile8_noc0_inW_payload_counter == 0)
             begin
                 chipID = tile8_noc0_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc0_inW_header[49:42];
                     target = (target << 8) | tile8_noc0_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc0_inW_bdw_allocation, 514, tile8_noc0_inW_header[21:14], tile8_noc0_inW_header[29:22], (counter - tile8_noc0_inW_bdw_allocation), 1, "W", target);
                 $fclose(fd);
                 tile8_noc0_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.buffer_router_valid_noc2)
    begin
         case (tile8_noc1_inL_packet_state)
         HEADER:
         begin
             tile8_noc1_inL_bdw_allocation = counter;
             tile8_noc1_inL_payload_counter = `TILE8.buffer_router_data_noc2[29:22];
             tile8_noc1_inL_header = `TILE8.buffer_router_data_noc2;
             tile8_noc1_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc1_inL_payload_counter = tile8_noc1_inL_payload_counter - 1;
             if (tile8_noc1_inL_payload_counter == 0)
             begin
                 chipID = tile8_noc1_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc1_inL_header[49:42];
                     target = (target << 8) | tile8_noc1_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc1_inL_bdw_allocation, 514, tile8_noc1_inL_header[21:14], tile8_noc1_inL_header[29:22], (counter - tile8_noc1_inL_bdw_allocation), 2, "L", target);
                 $fclose(fd);
                 tile8_noc1_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn1_validIn_N)
    begin
         case (tile8_noc1_inN_packet_state)
         HEADER:
         begin
             tile8_noc1_inN_bdw_allocation = counter;
             tile8_noc1_inN_payload_counter = `TILE8.dyn1_dataIn_N[29:22];
             tile8_noc1_inN_header = `TILE8.dyn1_dataIn_N;
             tile8_noc1_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc1_inN_payload_counter = tile8_noc1_inN_payload_counter - 1;
             if (tile8_noc1_inN_payload_counter == 0)
             begin
                 chipID = tile8_noc1_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc1_inN_header[49:42];
                     target = (target << 8) | tile8_noc1_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc1_inN_bdw_allocation, 514, tile8_noc1_inN_header[21:14], tile8_noc1_inN_header[29:22], (counter - tile8_noc1_inN_bdw_allocation), 2, "N", target);
                 $fclose(fd);
                 tile8_noc1_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn1_validIn_S)
    begin
         case (tile8_noc1_inS_packet_state)
         HEADER:
         begin
             tile8_noc1_inS_bdw_allocation = counter;
             tile8_noc1_inS_payload_counter = `TILE8.dyn1_dataIn_S[29:22];
             tile8_noc1_inS_header = `TILE8.dyn1_dataIn_S;
             tile8_noc1_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc1_inS_payload_counter = tile8_noc1_inS_payload_counter - 1;
             if (tile8_noc1_inS_payload_counter == 0)
             begin
                 chipID = tile8_noc1_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc1_inS_header[49:42];
                     target = (target << 8) | tile8_noc1_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc1_inS_bdw_allocation, 514, tile8_noc1_inS_header[21:14], tile8_noc1_inS_header[29:22], (counter - tile8_noc1_inS_bdw_allocation), 2, "S", target);
                 $fclose(fd);
                 tile8_noc1_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn1_validIn_E)
    begin
         case (tile8_noc1_inE_packet_state)
         HEADER:
         begin
             tile8_noc1_inE_bdw_allocation = counter;
             tile8_noc1_inE_payload_counter = `TILE8.dyn1_dataIn_E[29:22];
             tile8_noc1_inE_header = `TILE8.dyn1_dataIn_E;
             tile8_noc1_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc1_inE_payload_counter = tile8_noc1_inE_payload_counter - 1;
             if (tile8_noc1_inE_payload_counter == 0)
             begin
                 chipID = tile8_noc1_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc1_inE_header[49:42];
                     target = (target << 8) | tile8_noc1_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc1_inE_bdw_allocation, 514, tile8_noc1_inE_header[21:14], tile8_noc1_inE_header[29:22], (counter - tile8_noc1_inE_bdw_allocation), 2, "E", target);
                 $fclose(fd);
                 tile8_noc1_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn1_validIn_W)
    begin
         case (tile8_noc1_inW_packet_state)
         HEADER:
         begin
             tile8_noc1_inW_bdw_allocation = counter;
             tile8_noc1_inW_payload_counter = `TILE8.dyn1_dataIn_W[29:22];
             tile8_noc1_inW_header = `TILE8.dyn1_dataIn_W;
             tile8_noc1_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc1_inW_payload_counter = tile8_noc1_inW_payload_counter - 1;
             if (tile8_noc1_inW_payload_counter == 0)
             begin
                 chipID = tile8_noc1_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc1_inW_header[49:42];
                     target = (target << 8) | tile8_noc1_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc1_inW_bdw_allocation, 514, tile8_noc1_inW_header[21:14], tile8_noc1_inW_header[29:22], (counter - tile8_noc1_inW_bdw_allocation), 2, "W", target);
                 $fclose(fd);
                 tile8_noc1_inW_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.buffer_router_valid_noc3)
    begin
         case (tile8_noc2_inL_packet_state)
         HEADER:
         begin
             tile8_noc2_inL_bdw_allocation = counter;
             tile8_noc2_inL_payload_counter = `TILE8.buffer_router_data_noc3[29:22];
             tile8_noc2_inL_header = `TILE8.buffer_router_data_noc3;
             tile8_noc2_inL_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc2_inL_payload_counter = tile8_noc2_inL_payload_counter - 1;
             if (tile8_noc2_inL_payload_counter == 0)
             begin
                 chipID = tile8_noc2_inL_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc2_inL_header[49:42];
                     target = (target << 8) | tile8_noc2_inL_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc2_inL_bdw_allocation, 514, tile8_noc2_inL_header[21:14], tile8_noc2_inL_header[29:22], (counter - tile8_noc2_inL_bdw_allocation), 3, "L", target);
                 $fclose(fd);
                 tile8_noc2_inL_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn2_validIn_N)
    begin
         case (tile8_noc2_inN_packet_state)
         HEADER:
         begin
             tile8_noc2_inN_bdw_allocation = counter;
             tile8_noc2_inN_payload_counter = `TILE8.dyn2_dataIn_N[29:22];
             tile8_noc2_inN_header = `TILE8.dyn2_dataIn_N;
             tile8_noc2_inN_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc2_inN_payload_counter = tile8_noc2_inN_payload_counter - 1;
             if (tile8_noc2_inN_payload_counter == 0)
             begin
                 chipID = tile8_noc2_inN_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc2_inN_header[49:42];
                     target = (target << 8) | tile8_noc2_inN_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc2_inN_bdw_allocation, 514, tile8_noc2_inN_header[21:14], tile8_noc2_inN_header[29:22], (counter - tile8_noc2_inN_bdw_allocation), 3, "N", target);
                 $fclose(fd);
                 tile8_noc2_inN_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn2_validIn_S)
    begin
         case (tile8_noc2_inS_packet_state)
         HEADER:
         begin
             tile8_noc2_inS_bdw_allocation = counter;
             tile8_noc2_inS_payload_counter = `TILE8.dyn2_dataIn_S[29:22];
             tile8_noc2_inS_header = `TILE8.dyn2_dataIn_S;
             tile8_noc2_inS_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc2_inS_payload_counter = tile8_noc2_inS_payload_counter - 1;
             if (tile8_noc2_inS_payload_counter == 0)
             begin
                 chipID = tile8_noc2_inS_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc2_inS_header[49:42];
                     target = (target << 8) | tile8_noc2_inS_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc2_inS_bdw_allocation, 514, tile8_noc2_inS_header[21:14], tile8_noc2_inS_header[29:22], (counter - tile8_noc2_inS_bdw_allocation), 3, "S", target);
                 $fclose(fd);
                 tile8_noc2_inS_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn2_validIn_E)
    begin
         case (tile8_noc2_inE_packet_state)
         HEADER:
         begin
             tile8_noc2_inE_bdw_allocation = counter;
             tile8_noc2_inE_payload_counter = `TILE8.dyn2_dataIn_E[29:22];
             tile8_noc2_inE_header = `TILE8.dyn2_dataIn_E;
             tile8_noc2_inE_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc2_inE_payload_counter = tile8_noc2_inE_payload_counter - 1;
             if (tile8_noc2_inE_payload_counter == 0)
             begin
                 chipID = tile8_noc2_inE_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc2_inE_header[49:42];
                     target = (target << 8) | tile8_noc2_inE_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc2_inE_bdw_allocation, 514, tile8_noc2_inE_header[21:14], tile8_noc2_inE_header[29:22], (counter - tile8_noc2_inE_bdw_allocation), 3, "E", target);
                 $fclose(fd);
                 tile8_noc2_inE_packet_state = HEADER;
             end
         end
         endcase
    end
    if (`TILE8.dyn2_validIn_W)
    begin
         case (tile8_noc2_inW_packet_state)
         HEADER:
         begin
             tile8_noc2_inW_bdw_allocation = counter;
             tile8_noc2_inW_payload_counter = `TILE8.dyn2_dataIn_W[29:22];
             tile8_noc2_inW_header = `TILE8.dyn2_dataIn_W;
             tile8_noc2_inW_packet_state = PAYLOAD;
         end
         PAYLOAD:
         begin
              tile8_noc2_inW_payload_counter = tile8_noc2_inW_payload_counter - 1;
             if (tile8_noc2_inW_payload_counter == 0)
             begin
                 chipID = tile8_noc2_inW_header[63:50];
                 if (chipID != 0)
                 begin
                     target = chipID;
                 end else begin 
                     target = tile8_noc2_inW_header[49:42];
                     target = (target << 8) | tile8_noc2_inW_header[41:34];
                 end
                 fd = $fopen("debug/traffic_router.txt", "a");
                 $fwrite(fd,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%s\t%0d\n",  tile8_noc2_inW_bdw_allocation, 514, tile8_noc2_inW_header[21:14], tile8_noc2_inW_header[29:22], (counter - tile8_noc2_inW_bdw_allocation), 3, "W", target);
                 $fclose(fd);
                 tile8_noc2_inW_packet_state = HEADER;
             end
         end
         endcase
    end

end

always @ (negedge clk)
begin
    if($test$plusargs("enable_router_mon"))
    begin
`ifdef RTL_SPARC0
    if (`CHIP.tile_0_0_out_N_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out N data: 0x%x ", $time,`CHIP.tile_0_0_out_N_noc1_data);
    end
    if (`CHIP.tile_0_0_out_S_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out S data: 0x%x ", $time,`CHIP.tile_0_0_out_S_noc1_data);
    end
    if (`CHIP.tile_0_0_out_E_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out E data: 0x%x ", $time,`CHIP.tile_0_0_out_E_noc1_data);
    end
    if (`CHIP.tile_0_0_out_W_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out W data: 0x%x ", $time,`CHIP.tile_0_0_out_W_noc1_data);
    end
    if (`CHIP.tile_0_0_out_N_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out N data: 0x%x ", $time,`CHIP.tile_0_0_out_N_noc2_data);
    end
    if (`CHIP.tile_0_0_out_S_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out S data: 0x%x ", $time,`CHIP.tile_0_0_out_S_noc2_data);
    end
    if (`CHIP.tile_0_0_out_E_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out E data: 0x%x ", $time,`CHIP.tile_0_0_out_E_noc2_data);
    end
    if (`CHIP.tile_0_0_out_W_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out W data: 0x%x ", $time,`CHIP.tile_0_0_out_W_noc2_data);
    end
    if (`CHIP.tile_0_0_out_N_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out N data: 0x%x ", $time,`CHIP.tile_0_0_out_N_noc3_data);
    end
    if (`CHIP.tile_0_0_out_S_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out S data: 0x%x ", $time,`CHIP.tile_0_0_out_S_noc3_data);
    end
    if (`CHIP.tile_0_0_out_E_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out E data: 0x%x ", $time,`CHIP.tile_0_0_out_E_noc3_data);
    end
    if (`CHIP.tile_0_0_out_W_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out W data: 0x%x ", $time,`CHIP.tile_0_0_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC1
    if (`CHIP.tile_0_1_out_N_noc1_valid)
    begin
        $display("%d: TILE1 noc1 router out N data: 0x%x ", $time,`CHIP.tile_0_1_out_N_noc1_data);
    end
    if (`CHIP.tile_0_1_out_S_noc1_valid)
    begin
        $display("%d: TILE1 noc1 router out S data: 0x%x ", $time,`CHIP.tile_0_1_out_S_noc1_data);
    end
    if (`CHIP.tile_0_1_out_E_noc1_valid)
    begin
        $display("%d: TILE1 noc1 router out E data: 0x%x ", $time,`CHIP.tile_0_1_out_E_noc1_data);
    end
    if (`CHIP.tile_0_1_out_W_noc1_valid)
    begin
        $display("%d: TILE1 noc1 router out W data: 0x%x ", $time,`CHIP.tile_0_1_out_W_noc1_data);
    end
    if (`CHIP.tile_0_1_out_N_noc2_valid)
    begin
        $display("%d: TILE1 noc2 router out N data: 0x%x ", $time,`CHIP.tile_0_1_out_N_noc2_data);
    end
    if (`CHIP.tile_0_1_out_S_noc2_valid)
    begin
        $display("%d: TILE1 noc2 router out S data: 0x%x ", $time,`CHIP.tile_0_1_out_S_noc2_data);
    end
    if (`CHIP.tile_0_1_out_E_noc2_valid)
    begin
        $display("%d: TILE1 noc2 router out E data: 0x%x ", $time,`CHIP.tile_0_1_out_E_noc2_data);
    end
    if (`CHIP.tile_0_1_out_W_noc2_valid)
    begin
        $display("%d: TILE1 noc2 router out W data: 0x%x ", $time,`CHIP.tile_0_1_out_W_noc2_data);
    end
    if (`CHIP.tile_0_1_out_N_noc3_valid)
    begin
        $display("%d: TILE1 noc3 router out N data: 0x%x ", $time,`CHIP.tile_0_1_out_N_noc3_data);
    end
    if (`CHIP.tile_0_1_out_S_noc3_valid)
    begin
        $display("%d: TILE1 noc3 router out S data: 0x%x ", $time,`CHIP.tile_0_1_out_S_noc3_data);
    end
    if (`CHIP.tile_0_1_out_E_noc3_valid)
    begin
        $display("%d: TILE1 noc3 router out E data: 0x%x ", $time,`CHIP.tile_0_1_out_E_noc3_data);
    end
    if (`CHIP.tile_0_1_out_W_noc3_valid)
    begin
        $display("%d: TILE1 noc3 router out W data: 0x%x ", $time,`CHIP.tile_0_1_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC2
    if (`CHIP.tile_0_2_out_N_noc1_valid)
    begin
        $display("%d: TILE2 noc1 router out N data: 0x%x ", $time,`CHIP.tile_0_2_out_N_noc1_data);
    end
    if (`CHIP.tile_0_2_out_S_noc1_valid)
    begin
        $display("%d: TILE2 noc1 router out S data: 0x%x ", $time,`CHIP.tile_0_2_out_S_noc1_data);
    end
    if (`CHIP.tile_0_2_out_E_noc1_valid)
    begin
        $display("%d: TILE2 noc1 router out E data: 0x%x ", $time,`CHIP.tile_0_2_out_E_noc1_data);
    end
    if (`CHIP.tile_0_2_out_W_noc1_valid)
    begin
        $display("%d: TILE2 noc1 router out W data: 0x%x ", $time,`CHIP.tile_0_2_out_W_noc1_data);
    end
    if (`CHIP.tile_0_2_out_N_noc2_valid)
    begin
        $display("%d: TILE2 noc2 router out N data: 0x%x ", $time,`CHIP.tile_0_2_out_N_noc2_data);
    end
    if (`CHIP.tile_0_2_out_S_noc2_valid)
    begin
        $display("%d: TILE2 noc2 router out S data: 0x%x ", $time,`CHIP.tile_0_2_out_S_noc2_data);
    end
    if (`CHIP.tile_0_2_out_E_noc2_valid)
    begin
        $display("%d: TILE2 noc2 router out E data: 0x%x ", $time,`CHIP.tile_0_2_out_E_noc2_data);
    end
    if (`CHIP.tile_0_2_out_W_noc2_valid)
    begin
        $display("%d: TILE2 noc2 router out W data: 0x%x ", $time,`CHIP.tile_0_2_out_W_noc2_data);
    end
    if (`CHIP.tile_0_2_out_N_noc3_valid)
    begin
        $display("%d: TILE2 noc3 router out N data: 0x%x ", $time,`CHIP.tile_0_2_out_N_noc3_data);
    end
    if (`CHIP.tile_0_2_out_S_noc3_valid)
    begin
        $display("%d: TILE2 noc3 router out S data: 0x%x ", $time,`CHIP.tile_0_2_out_S_noc3_data);
    end
    if (`CHIP.tile_0_2_out_E_noc3_valid)
    begin
        $display("%d: TILE2 noc3 router out E data: 0x%x ", $time,`CHIP.tile_0_2_out_E_noc3_data);
    end
    if (`CHIP.tile_0_2_out_W_noc3_valid)
    begin
        $display("%d: TILE2 noc3 router out W data: 0x%x ", $time,`CHIP.tile_0_2_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC3
    if (`CHIP.tile_1_0_out_N_noc1_valid)
    begin
        $display("%d: TILE3 noc1 router out N data: 0x%x ", $time,`CHIP.tile_1_0_out_N_noc1_data);
    end
    if (`CHIP.tile_1_0_out_S_noc1_valid)
    begin
        $display("%d: TILE3 noc1 router out S data: 0x%x ", $time,`CHIP.tile_1_0_out_S_noc1_data);
    end
    if (`CHIP.tile_1_0_out_E_noc1_valid)
    begin
        $display("%d: TILE3 noc1 router out E data: 0x%x ", $time,`CHIP.tile_1_0_out_E_noc1_data);
    end
    if (`CHIP.tile_1_0_out_W_noc1_valid)
    begin
        $display("%d: TILE3 noc1 router out W data: 0x%x ", $time,`CHIP.tile_1_0_out_W_noc1_data);
    end
    if (`CHIP.tile_1_0_out_N_noc2_valid)
    begin
        $display("%d: TILE3 noc2 router out N data: 0x%x ", $time,`CHIP.tile_1_0_out_N_noc2_data);
    end
    if (`CHIP.tile_1_0_out_S_noc2_valid)
    begin
        $display("%d: TILE3 noc2 router out S data: 0x%x ", $time,`CHIP.tile_1_0_out_S_noc2_data);
    end
    if (`CHIP.tile_1_0_out_E_noc2_valid)
    begin
        $display("%d: TILE3 noc2 router out E data: 0x%x ", $time,`CHIP.tile_1_0_out_E_noc2_data);
    end
    if (`CHIP.tile_1_0_out_W_noc2_valid)
    begin
        $display("%d: TILE3 noc2 router out W data: 0x%x ", $time,`CHIP.tile_1_0_out_W_noc2_data);
    end
    if (`CHIP.tile_1_0_out_N_noc3_valid)
    begin
        $display("%d: TILE3 noc3 router out N data: 0x%x ", $time,`CHIP.tile_1_0_out_N_noc3_data);
    end
    if (`CHIP.tile_1_0_out_S_noc3_valid)
    begin
        $display("%d: TILE3 noc3 router out S data: 0x%x ", $time,`CHIP.tile_1_0_out_S_noc3_data);
    end
    if (`CHIP.tile_1_0_out_E_noc3_valid)
    begin
        $display("%d: TILE3 noc3 router out E data: 0x%x ", $time,`CHIP.tile_1_0_out_E_noc3_data);
    end
    if (`CHIP.tile_1_0_out_W_noc3_valid)
    begin
        $display("%d: TILE3 noc3 router out W data: 0x%x ", $time,`CHIP.tile_1_0_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC4
    if (`CHIP.tile_1_1_out_N_noc1_valid)
    begin
        $display("%d: TILE4 noc1 router out N data: 0x%x ", $time,`CHIP.tile_1_1_out_N_noc1_data);
    end
    if (`CHIP.tile_1_1_out_S_noc1_valid)
    begin
        $display("%d: TILE4 noc1 router out S data: 0x%x ", $time,`CHIP.tile_1_1_out_S_noc1_data);
    end
    if (`CHIP.tile_1_1_out_E_noc1_valid)
    begin
        $display("%d: TILE4 noc1 router out E data: 0x%x ", $time,`CHIP.tile_1_1_out_E_noc1_data);
    end
    if (`CHIP.tile_1_1_out_W_noc1_valid)
    begin
        $display("%d: TILE4 noc1 router out W data: 0x%x ", $time,`CHIP.tile_1_1_out_W_noc1_data);
    end
    if (`CHIP.tile_1_1_out_N_noc2_valid)
    begin
        $display("%d: TILE4 noc2 router out N data: 0x%x ", $time,`CHIP.tile_1_1_out_N_noc2_data);
    end
    if (`CHIP.tile_1_1_out_S_noc2_valid)
    begin
        $display("%d: TILE4 noc2 router out S data: 0x%x ", $time,`CHIP.tile_1_1_out_S_noc2_data);
    end
    if (`CHIP.tile_1_1_out_E_noc2_valid)
    begin
        $display("%d: TILE4 noc2 router out E data: 0x%x ", $time,`CHIP.tile_1_1_out_E_noc2_data);
    end
    if (`CHIP.tile_1_1_out_W_noc2_valid)
    begin
        $display("%d: TILE4 noc2 router out W data: 0x%x ", $time,`CHIP.tile_1_1_out_W_noc2_data);
    end
    if (`CHIP.tile_1_1_out_N_noc3_valid)
    begin
        $display("%d: TILE4 noc3 router out N data: 0x%x ", $time,`CHIP.tile_1_1_out_N_noc3_data);
    end
    if (`CHIP.tile_1_1_out_S_noc3_valid)
    begin
        $display("%d: TILE4 noc3 router out S data: 0x%x ", $time,`CHIP.tile_1_1_out_S_noc3_data);
    end
    if (`CHIP.tile_1_1_out_E_noc3_valid)
    begin
        $display("%d: TILE4 noc3 router out E data: 0x%x ", $time,`CHIP.tile_1_1_out_E_noc3_data);
    end
    if (`CHIP.tile_1_1_out_W_noc3_valid)
    begin
        $display("%d: TILE4 noc3 router out W data: 0x%x ", $time,`CHIP.tile_1_1_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC5
    if (`CHIP.tile_1_2_out_N_noc1_valid)
    begin
        $display("%d: TILE5 noc1 router out N data: 0x%x ", $time,`CHIP.tile_1_2_out_N_noc1_data);
    end
    if (`CHIP.tile_1_2_out_S_noc1_valid)
    begin
        $display("%d: TILE5 noc1 router out S data: 0x%x ", $time,`CHIP.tile_1_2_out_S_noc1_data);
    end
    if (`CHIP.tile_1_2_out_E_noc1_valid)
    begin
        $display("%d: TILE5 noc1 router out E data: 0x%x ", $time,`CHIP.tile_1_2_out_E_noc1_data);
    end
    if (`CHIP.tile_1_2_out_W_noc1_valid)
    begin
        $display("%d: TILE5 noc1 router out W data: 0x%x ", $time,`CHIP.tile_1_2_out_W_noc1_data);
    end
    if (`CHIP.tile_1_2_out_N_noc2_valid)
    begin
        $display("%d: TILE5 noc2 router out N data: 0x%x ", $time,`CHIP.tile_1_2_out_N_noc2_data);
    end
    if (`CHIP.tile_1_2_out_S_noc2_valid)
    begin
        $display("%d: TILE5 noc2 router out S data: 0x%x ", $time,`CHIP.tile_1_2_out_S_noc2_data);
    end
    if (`CHIP.tile_1_2_out_E_noc2_valid)
    begin
        $display("%d: TILE5 noc2 router out E data: 0x%x ", $time,`CHIP.tile_1_2_out_E_noc2_data);
    end
    if (`CHIP.tile_1_2_out_W_noc2_valid)
    begin
        $display("%d: TILE5 noc2 router out W data: 0x%x ", $time,`CHIP.tile_1_2_out_W_noc2_data);
    end
    if (`CHIP.tile_1_2_out_N_noc3_valid)
    begin
        $display("%d: TILE5 noc3 router out N data: 0x%x ", $time,`CHIP.tile_1_2_out_N_noc3_data);
    end
    if (`CHIP.tile_1_2_out_S_noc3_valid)
    begin
        $display("%d: TILE5 noc3 router out S data: 0x%x ", $time,`CHIP.tile_1_2_out_S_noc3_data);
    end
    if (`CHIP.tile_1_2_out_E_noc3_valid)
    begin
        $display("%d: TILE5 noc3 router out E data: 0x%x ", $time,`CHIP.tile_1_2_out_E_noc3_data);
    end
    if (`CHIP.tile_1_2_out_W_noc3_valid)
    begin
        $display("%d: TILE5 noc3 router out W data: 0x%x ", $time,`CHIP.tile_1_2_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC6
    if (`CHIP.tile_2_0_out_N_noc1_valid)
    begin
        $display("%d: TILE6 noc1 router out N data: 0x%x ", $time,`CHIP.tile_2_0_out_N_noc1_data);
    end
    if (`CHIP.tile_2_0_out_S_noc1_valid)
    begin
        $display("%d: TILE6 noc1 router out S data: 0x%x ", $time,`CHIP.tile_2_0_out_S_noc1_data);
    end
    if (`CHIP.tile_2_0_out_E_noc1_valid)
    begin
        $display("%d: TILE6 noc1 router out E data: 0x%x ", $time,`CHIP.tile_2_0_out_E_noc1_data);
    end
    if (`CHIP.tile_2_0_out_W_noc1_valid)
    begin
        $display("%d: TILE6 noc1 router out W data: 0x%x ", $time,`CHIP.tile_2_0_out_W_noc1_data);
    end
    if (`CHIP.tile_2_0_out_N_noc2_valid)
    begin
        $display("%d: TILE6 noc2 router out N data: 0x%x ", $time,`CHIP.tile_2_0_out_N_noc2_data);
    end
    if (`CHIP.tile_2_0_out_S_noc2_valid)
    begin
        $display("%d: TILE6 noc2 router out S data: 0x%x ", $time,`CHIP.tile_2_0_out_S_noc2_data);
    end
    if (`CHIP.tile_2_0_out_E_noc2_valid)
    begin
        $display("%d: TILE6 noc2 router out E data: 0x%x ", $time,`CHIP.tile_2_0_out_E_noc2_data);
    end
    if (`CHIP.tile_2_0_out_W_noc2_valid)
    begin
        $display("%d: TILE6 noc2 router out W data: 0x%x ", $time,`CHIP.tile_2_0_out_W_noc2_data);
    end
    if (`CHIP.tile_2_0_out_N_noc3_valid)
    begin
        $display("%d: TILE6 noc3 router out N data: 0x%x ", $time,`CHIP.tile_2_0_out_N_noc3_data);
    end
    if (`CHIP.tile_2_0_out_S_noc3_valid)
    begin
        $display("%d: TILE6 noc3 router out S data: 0x%x ", $time,`CHIP.tile_2_0_out_S_noc3_data);
    end
    if (`CHIP.tile_2_0_out_E_noc3_valid)
    begin
        $display("%d: TILE6 noc3 router out E data: 0x%x ", $time,`CHIP.tile_2_0_out_E_noc3_data);
    end
    if (`CHIP.tile_2_0_out_W_noc3_valid)
    begin
        $display("%d: TILE6 noc3 router out W data: 0x%x ", $time,`CHIP.tile_2_0_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC7
    if (`CHIP.tile_2_1_out_N_noc1_valid)
    begin
        $display("%d: TILE7 noc1 router out N data: 0x%x ", $time,`CHIP.tile_2_1_out_N_noc1_data);
    end
    if (`CHIP.tile_2_1_out_S_noc1_valid)
    begin
        $display("%d: TILE7 noc1 router out S data: 0x%x ", $time,`CHIP.tile_2_1_out_S_noc1_data);
    end
    if (`CHIP.tile_2_1_out_E_noc1_valid)
    begin
        $display("%d: TILE7 noc1 router out E data: 0x%x ", $time,`CHIP.tile_2_1_out_E_noc1_data);
    end
    if (`CHIP.tile_2_1_out_W_noc1_valid)
    begin
        $display("%d: TILE7 noc1 router out W data: 0x%x ", $time,`CHIP.tile_2_1_out_W_noc1_data);
    end
    if (`CHIP.tile_2_1_out_N_noc2_valid)
    begin
        $display("%d: TILE7 noc2 router out N data: 0x%x ", $time,`CHIP.tile_2_1_out_N_noc2_data);
    end
    if (`CHIP.tile_2_1_out_S_noc2_valid)
    begin
        $display("%d: TILE7 noc2 router out S data: 0x%x ", $time,`CHIP.tile_2_1_out_S_noc2_data);
    end
    if (`CHIP.tile_2_1_out_E_noc2_valid)
    begin
        $display("%d: TILE7 noc2 router out E data: 0x%x ", $time,`CHIP.tile_2_1_out_E_noc2_data);
    end
    if (`CHIP.tile_2_1_out_W_noc2_valid)
    begin
        $display("%d: TILE7 noc2 router out W data: 0x%x ", $time,`CHIP.tile_2_1_out_W_noc2_data);
    end
    if (`CHIP.tile_2_1_out_N_noc3_valid)
    begin
        $display("%d: TILE7 noc3 router out N data: 0x%x ", $time,`CHIP.tile_2_1_out_N_noc3_data);
    end
    if (`CHIP.tile_2_1_out_S_noc3_valid)
    begin
        $display("%d: TILE7 noc3 router out S data: 0x%x ", $time,`CHIP.tile_2_1_out_S_noc3_data);
    end
    if (`CHIP.tile_2_1_out_E_noc3_valid)
    begin
        $display("%d: TILE7 noc3 router out E data: 0x%x ", $time,`CHIP.tile_2_1_out_E_noc3_data);
    end
    if (`CHIP.tile_2_1_out_W_noc3_valid)
    begin
        $display("%d: TILE7 noc3 router out W data: 0x%x ", $time,`CHIP.tile_2_1_out_W_noc3_data);
    end
`endif
`ifdef RTL_SPARC8
    if (`CHIP.tile_2_2_out_N_noc1_valid)
    begin
        $display("%d: TILE8 noc1 router out N data: 0x%x ", $time,`CHIP.tile_2_2_out_N_noc1_data);
    end
    if (`CHIP.tile_2_2_out_S_noc1_valid)
    begin
        $display("%d: TILE8 noc1 router out S data: 0x%x ", $time,`CHIP.tile_2_2_out_S_noc1_data);
    end
    if (`CHIP.tile_2_2_out_E_noc1_valid)
    begin
        $display("%d: TILE8 noc1 router out E data: 0x%x ", $time,`CHIP.tile_2_2_out_E_noc1_data);
    end
    if (`CHIP.tile_2_2_out_W_noc1_valid)
    begin
        $display("%d: TILE8 noc1 router out W data: 0x%x ", $time,`CHIP.tile_2_2_out_W_noc1_data);
    end
    if (`CHIP.tile_2_2_out_N_noc2_valid)
    begin
        $display("%d: TILE8 noc2 router out N data: 0x%x ", $time,`CHIP.tile_2_2_out_N_noc2_data);
    end
    if (`CHIP.tile_2_2_out_S_noc2_valid)
    begin
        $display("%d: TILE8 noc2 router out S data: 0x%x ", $time,`CHIP.tile_2_2_out_S_noc2_data);
    end
    if (`CHIP.tile_2_2_out_E_noc2_valid)
    begin
        $display("%d: TILE8 noc2 router out E data: 0x%x ", $time,`CHIP.tile_2_2_out_E_noc2_data);
    end
    if (`CHIP.tile_2_2_out_W_noc2_valid)
    begin
        $display("%d: TILE8 noc2 router out W data: 0x%x ", $time,`CHIP.tile_2_2_out_W_noc2_data);
    end
    if (`CHIP.tile_2_2_out_N_noc3_valid)
    begin
        $display("%d: TILE8 noc3 router out N data: 0x%x ", $time,`CHIP.tile_2_2_out_N_noc3_data);
    end
    if (`CHIP.tile_2_2_out_S_noc3_valid)
    begin
        $display("%d: TILE8 noc3 router out S data: 0x%x ", $time,`CHIP.tile_2_2_out_S_noc3_data);
    end
    if (`CHIP.tile_2_2_out_E_noc3_valid)
    begin
        $display("%d: TILE8 noc3 router out E data: 0x%x ", $time,`CHIP.tile_2_2_out_E_noc3_data);
    end
    if (`CHIP.tile_2_2_out_W_noc3_valid)
    begin
        $display("%d: TILE8 noc3 router out W data: 0x%x ", $time,`CHIP.tile_2_2_out_W_noc3_data);
    end
`endif

    end
end

localparam ERROR_NOC1 = 2'd1;
localparam ERROR_NOC2 = 2'd2;
localparam ERROR_NOC3 = 2'd3;


reg [31:0] error_dir;
reg [31:0] error_noc;
reg [31:0] error_x;
reg [31:0] error_y;
reg boundary_err;
always @ (negedge clk)
begin
    boundary_err = 0;
    `ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_0_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 0;
error_y = 0;
end
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 0;
error_y = 0;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 0;
end
`endif
boundary_err = boundary_err | `CHIP.tile_0_0_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 0;
error_y = 0;
end
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 0;
error_y = 0;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 0;
end
`endif
boundary_err = boundary_err | `CHIP.tile_0_0_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 0;
error_y = 0;
end
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 0;
error_y = 0;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 0;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC0
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 0;
error_y = 0;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 0;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 0;
error_y = 0;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 0;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 0;
error_y = 0;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 0;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_1_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_0_1_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`endif
`ifndef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_1_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`endif
`ifndef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_1_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`endif
boundary_err = boundary_err | `CHIP.tile_0_1_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_0_1_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`endif
`ifndef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_1_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`endif
`ifndef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_1_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`endif
boundary_err = boundary_err | `CHIP.tile_0_1_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_0_1_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`endif
`ifndef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_1_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`endif
`ifndef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_1_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC1
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_0_1_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_1_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_1_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_0_1_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_1_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_1_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_0_1_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_1_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`endif
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_1_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 1;
error_y = 0;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_0_2_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 2;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_2_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 2;
error_y = 0;
end
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_0_2_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 2;
error_y = 0;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_2_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 2;
error_y = 0;
end
`endif
boundary_err = boundary_err | `CHIP.tile_0_2_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 2;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_2_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 2;
error_y = 0;
end
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_0_2_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 2;
error_y = 0;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_2_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 2;
error_y = 0;
end
`endif
boundary_err = boundary_err | `CHIP.tile_0_2_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 2;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_2_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 2;
error_y = 0;
end
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_0_2_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 2;
error_y = 0;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_2_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 2;
error_y = 0;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC2
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_0_2_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 2;
error_y = 0;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_2_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 2;
error_y = 0;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_0_2_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 2;
error_y = 0;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_2_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 2;
error_y = 0;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_0_2_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 2;
error_y = 0;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_0_2_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 2;
error_y = 0;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_0_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`ifndef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_1_0_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`endif
`ifndef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_1_0_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`endif
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`endif
boundary_err = boundary_err | `CHIP.tile_1_0_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`ifndef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_1_0_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`endif
`ifndef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_1_0_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`endif
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`endif
boundary_err = boundary_err | `CHIP.tile_1_0_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`ifndef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_1_0_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`endif
`ifndef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_1_0_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`endif
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC3
`ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_1_0_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_1_0_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_1_0_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_1_0_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_1_0_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_1_0_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 1;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC4
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_1_1_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_1_1_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_1_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_1_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_1_1_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_1_1_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_1_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_1_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_1_1_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_1_1_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_1_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_1_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC4
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_1_1_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_1_1_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_1_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_1_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_1_1_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_1_1_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_1_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_1_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC1
boundary_err = boundary_err | `CHIP.tile_1_1_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_1_1_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_1_1_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_1_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 1;
error_y = 1;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_1_2_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`ifndef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_1_2_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`endif
`ifndef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_1_2_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`endif
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_2_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`endif
boundary_err = boundary_err | `CHIP.tile_1_2_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`ifndef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_1_2_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`endif
`ifndef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_1_2_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`endif
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_2_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`endif
boundary_err = boundary_err | `CHIP.tile_1_2_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`ifndef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_1_2_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`endif
`ifndef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_1_2_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`endif
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_2_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC5
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_1_2_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_1_2_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_2_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_1_2_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_1_2_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_2_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC2
boundary_err = boundary_err | `CHIP.tile_1_2_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_1_2_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_1_2_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 2;
error_y = 1;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_0_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 0;
error_y = 2;
end
boundary_err = boundary_err | `CHIP.tile_2_0_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 0;
error_y = 2;
end
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_2_0_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 0;
error_y = 2;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 2;
end
`endif
boundary_err = boundary_err | `CHIP.tile_2_0_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 0;
error_y = 2;
end
boundary_err = boundary_err | `CHIP.tile_2_0_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 0;
error_y = 2;
end
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_2_0_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 0;
error_y = 2;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 2;
end
`endif
boundary_err = boundary_err | `CHIP.tile_2_0_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 0;
error_y = 2;
end
boundary_err = boundary_err | `CHIP.tile_2_0_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 0;
error_y = 2;
end
`ifndef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_2_0_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 0;
error_y = 2;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 2;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC6
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_2_0_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 0;
error_y = 2;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 2;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_2_0_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 0;
error_y = 2;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 2;
end
`endif
`ifdef RTL_SPARC3
boundary_err = boundary_err | `CHIP.tile_2_0_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 0;
error_y = 2;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 2;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_1_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_2_1_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`endif
`ifndef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_1_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`endif
`ifndef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_1_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`endif
boundary_err = boundary_err | `CHIP.tile_2_1_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_2_1_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`endif
`ifndef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_1_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`endif
`ifndef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_1_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`endif
boundary_err = boundary_err | `CHIP.tile_2_1_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`ifndef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_2_1_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`endif
`ifndef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_1_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`endif
`ifndef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_1_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC7
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_2_1_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_1_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_1_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_2_1_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_1_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_1_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC4
boundary_err = boundary_err | `CHIP.tile_2_1_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC6
boundary_err = boundary_err | `CHIP.tile_2_1_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_1_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 1;
error_y = 2;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif
`ifdef RTL_SPARC8
boundary_err = boundary_err | `CHIP.tile_2_2_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 2;
error_y = 2;
end
boundary_err = boundary_err | `CHIP.tile_2_2_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 2;
error_y = 2;
end
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_2_2_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 2;
error_y = 2;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_2_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 2;
error_y = 2;
end
`endif
boundary_err = boundary_err | `CHIP.tile_2_2_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 2;
error_y = 2;
end
boundary_err = boundary_err | `CHIP.tile_2_2_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 2;
error_y = 2;
end
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_2_2_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 2;
error_y = 2;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_2_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 2;
error_y = 2;
end
`endif
boundary_err = boundary_err | `CHIP.tile_2_2_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 2;
error_y = 2;
end
boundary_err = boundary_err | `CHIP.tile_2_2_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 2;
error_y = 2;
end
`ifndef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_2_2_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 2;
error_y = 2;
end
`endif
`ifndef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_2_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 2;
error_y = 2;
end
`endif
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC8
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_2_2_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 2;
error_y = 2;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_2_out_W_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 1;
error_x = 2;
error_y = 2;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_2_2_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 2;
error_y = 2;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_2_out_W_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 2;
error_x = 2;
error_y = 2;
end
`endif
`ifdef RTL_SPARC5
boundary_err = boundary_err | `CHIP.tile_2_2_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 2;
error_y = 2;
end
`endif
`ifdef RTL_SPARC7
boundary_err = boundary_err | `CHIP.tile_2_2_out_W_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "W";
error_noc = 3;
error_x = 2;
error_y = 2;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif


    // if (boundary_err == 1)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "network_mon: packet going out of bound");
    //     repeat(5)@(posedge clk);
    //     `MONITOR_PATH.fail("network_mon: network_mon: packet going out of bound");
    // end
end
`endif
`endif
`endif // DISABLE_ALL_MONITORS
endmodule

`endif
