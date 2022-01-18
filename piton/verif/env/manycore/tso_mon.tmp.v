// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: tso_mon.v
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
////////////////////////////////////////////////////////;
// tso_mon.v
//
// Description: This is a rather eclectic monitor
// to do tso coverage gathering. It also has some checkers
// and other useful stuff. It pokes into L2 the sparc core pipeline
// as well as the LSU.
//
////////////////////////////////////////////////////////

`ifndef VERILATOR

`define FPOP1_RQ 5'b01010
`define FPOP2_RQ 5'b01011
`define STB_DRAIN_TO 8000

`ifdef GATE_SIM
`else
`include "cross_module.tmp.h"
`include "sys.h"
`include "iop.h"
`endif

// /home/ruaro/nooman-openpiton/piton/verif/env/manycore/devices_ariane.xml


//--------------------------------------------------------------------------------------
// module definition:
//  Note that most of the stuff is cross-module referencing,
// so the interface is minimal
//--------------------------------------------------------------------------------------
module tso_mon ( clk, rst_l);

  input clk;		// the cpu clock
  input rst_l;		// reset (active low).

`ifdef GATE_SIM
`else

  reg tso_mon_msg; 		// decides should we print all tso_mon messages
  reg disable_lock_check;	// disable one of my checkes
  reg kill_on_cross_mod_code;
  reg force_dfq;
  integer stb_drain_to_max;	// what the Store buffer timeout will be.
  reg enable_ifu_lsu_inv_clear;

  initial
  begin
    if( $test$plusargs("force_dfq") )
      force_dfq = 1'b1;
    else
      force_dfq= 1'b0;

    if( $test$plusargs("enable_ifu_lsu_inv_clear") )
	enable_ifu_lsu_inv_clear = 1;
    else
	enable_ifu_lsu_inv_clear = 0;


    if( $test$plusargs("tso_mon_msg") )
      tso_mon_msg = 1'b1;
    else
      tso_mon_msg= 1'b0;

    if( $test$plusargs("disable_lock_check") )
      disable_lock_check = 1'b1;
    else
      disable_lock_check = 1'b0;


    if (! $value$plusargs("stb_drain_to_max=%d", stb_drain_to_max)) begin
      stb_drain_to_max = `STB_DRAIN_TO ;
    end

    $display("%0d tso_mon: stb_drain_to_max = %d", $time, stb_drain_to_max);

    if( $test$plusargs("kill_on_cross_mod_code") )
      kill_on_cross_mod_code = 1'b1;
    else
      kill_on_cross_mod_code = 1'b0;


  end

wire tso_mon_vcc = 1'b1;

//--------------------------------------------------------------------------------------
// related to bug 6372 - need to monitor some DFQ signals
//--------------------------------------------------------------------------------------

`ifdef RTL_SPARC0
`ifndef RTL_SPU
wire       spc0_dfq_byp_ff_en      = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
wire       spc0_dfq_wr_en          = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dfq_wr_en;
`else
wire       spc0_dfq_byp_ff_en      = `SPARC_CORE0.sparc0.lsu.qctl2.dfq_byp_ff_en;
wire       spc0_dfq_wr_en          = `SPARC_CORE0.sparc0.lsu.qctl2.dfq_wr_en;
`endif
reg        spc0_dfq_byp_ff_en_d1;
reg        spc0_dfq_wr_en_d1;
`endif


`ifdef RTL_SPARC1
`ifndef RTL_SPU
wire       spc1_dfq_byp_ff_en      = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
wire       spc1_dfq_wr_en          = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dfq_wr_en;
`else
wire       spc1_dfq_byp_ff_en      = `SPARC_CORE1.sparc0.lsu.qctl2.dfq_byp_ff_en;
wire       spc1_dfq_wr_en          = `SPARC_CORE1.sparc0.lsu.qctl2.dfq_wr_en;
`endif
reg        spc1_dfq_byp_ff_en_d1;
reg        spc1_dfq_wr_en_d1;
`endif


`ifdef RTL_SPARC2
`ifndef RTL_SPU
wire       spc2_dfq_byp_ff_en      = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
wire       spc2_dfq_wr_en          = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dfq_wr_en;
`else
wire       spc2_dfq_byp_ff_en      = `SPARC_CORE2.sparc0.lsu.qctl2.dfq_byp_ff_en;
wire       spc2_dfq_wr_en          = `SPARC_CORE2.sparc0.lsu.qctl2.dfq_wr_en;
`endif
reg        spc2_dfq_byp_ff_en_d1;
reg        spc2_dfq_wr_en_d1;
`endif


`ifdef RTL_SPARC3
`ifndef RTL_SPU
wire       spc3_dfq_byp_ff_en      = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
wire       spc3_dfq_wr_en          = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dfq_wr_en;
`else
wire       spc3_dfq_byp_ff_en      = `SPARC_CORE3.sparc0.lsu.qctl2.dfq_byp_ff_en;
wire       spc3_dfq_wr_en          = `SPARC_CORE3.sparc0.lsu.qctl2.dfq_wr_en;
`endif
reg        spc3_dfq_byp_ff_en_d1;
reg        spc3_dfq_wr_en_d1;
`endif




//--------------------------------------------------------------------------------------
// spc to pcx packets
//--------------------------------------------------------------------------------------


`ifdef RTL_SPARC0
   wire  [4:0] 		  spc0_pcx_req_pq 	= `SPARC_CORE0.spc0_pcx_req_pq[4:0];
   wire        		  spc0_pcx_atom_pq	= `SPARC_CORE0.spc0_pcx_atom_pq;
   wire  [`PCX_WIDTH-1:0] spc0_pcx_data_pa 	= `SPARC_CORE0.spc0_pcx_data_pa[`PCX_WIDTH-1:0];

   reg 			  pcx0_vld_d1;	// valid pcx packet
   reg 			  pcx0_atom_pq_d1;	// atomic bit delayed by 1
   reg 			  pcx0_atom_pq_d2;	// delayed by 2
   reg 			  pcx0_req_pq_d1;	// OR of request bits delayed by 1
   reg [5:0]		  pcx0_type_d1;	// packet type delayed by 1
`endif


`ifdef RTL_SPARC1
   wire  [4:0] 		  spc1_pcx_req_pq 	= `SPARC_CORE1.spc0_pcx_req_pq[4:0];
   wire        		  spc1_pcx_atom_pq	= `SPARC_CORE1.spc0_pcx_atom_pq;
   wire  [`PCX_WIDTH-1:0] spc1_pcx_data_pa 	= `SPARC_CORE1.spc0_pcx_data_pa[`PCX_WIDTH-1:0];

   reg 			  pcx1_vld_d1;	// valid pcx packet
   reg 			  pcx1_atom_pq_d1;	// atomic bit delayed by 1
   reg 			  pcx1_atom_pq_d2;	// delayed by 2
   reg 			  pcx1_req_pq_d1;	// OR of request bits delayed by 1
   reg [5:0]		  pcx1_type_d1;	// packet type delayed by 1
`endif


`ifdef RTL_SPARC2
   wire  [4:0] 		  spc2_pcx_req_pq 	= `SPARC_CORE2.spc0_pcx_req_pq[4:0];
   wire        		  spc2_pcx_atom_pq	= `SPARC_CORE2.spc0_pcx_atom_pq;
   wire  [`PCX_WIDTH-1:0] spc2_pcx_data_pa 	= `SPARC_CORE2.spc0_pcx_data_pa[`PCX_WIDTH-1:0];

   reg 			  pcx2_vld_d1;	// valid pcx packet
   reg 			  pcx2_atom_pq_d1;	// atomic bit delayed by 1
   reg 			  pcx2_atom_pq_d2;	// delayed by 2
   reg 			  pcx2_req_pq_d1;	// OR of request bits delayed by 1
   reg [5:0]		  pcx2_type_d1;	// packet type delayed by 1
`endif


`ifdef RTL_SPARC3
   wire  [4:0] 		  spc3_pcx_req_pq 	= `SPARC_CORE3.spc0_pcx_req_pq[4:0];
   wire        		  spc3_pcx_atom_pq	= `SPARC_CORE3.spc0_pcx_atom_pq;
   wire  [`PCX_WIDTH-1:0] spc3_pcx_data_pa 	= `SPARC_CORE3.spc0_pcx_data_pa[`PCX_WIDTH-1:0];

   reg 			  pcx3_vld_d1;	// valid pcx packet
   reg 			  pcx3_atom_pq_d1;	// atomic bit delayed by 1
   reg 			  pcx3_atom_pq_d2;	// delayed by 2
   reg 			  pcx3_req_pq_d1;	// OR of request bits delayed by 1
   reg [5:0]		  pcx3_type_d1;	// packet type delayed by 1
`endif




//--------------------------------------------------------------------------------------
// cpx to spc (sparc) packets
//--------------------------------------------------------------------------------------


`ifdef RTL_SPARC0
   wire                  cpx_spc0_data_vld 	= `SPARC_CORE0.cpx_spc0_data_cx2[`CPX_WIDTH-1];
   wire [`CPX_WIDTH-1:0] cpx_spc0_data_cx2	= `SPARC_CORE0.cpx_spc0_data_cx2[`CPX_WIDTH-1:0];

   reg [`CPX_WIDTH-1:0] cpx_spc0_data_cx2_d1;	// packet delayed by 1
   reg [`CPX_WIDTH-1:0] cpx_spc0_data_cx2_d2;	// packet delayed by 2
   reg [127:0]		spc0_pcx_type_str;		// packet type in string format for debug.

   reg [127:0]		cpx_spc0_type_str;		// in string format for debug

   wire [3:0]  		cpx_spc0_type     	= cpx_spc0_data_vld ? cpx_spc0_data_cx2[`CPX_RQ_HI:`CPX_RQ_LO] :4'h0;
   wire        		cpx_spc0_wyvld    	= cpx_spc0_data_cx2[`CPX_WYVLD] & cpx_spc0_data_vld;

   wire cpx_spc0_st_ack = (cpx_spc0_type == `ST_ACK) | (cpx_spc0_type == `STRST_ACK);
   wire cpx_spc0_evict  = (cpx_spc0_type == `EVICT_REQ);

   reg cpx_spc0_ifill_wyvld;
   reg cpx_spc0_dfill_wyvld;

  wire cpx_spc0_st_ack_dc_inval_1c_tmp = (cpx_spc0_data_cx2[122:121] == 2'b00) ?  cpx_spc0_data_cx2[0]  :
                                          (cpx_spc0_data_cx2[122:121] == 2'b01)   ?  cpx_spc0_data_cx2[32] :
                                          (cpx_spc0_data_cx2[122:121] == 2'b10)   ?  cpx_spc0_data_cx2[56] :
                                          					        cpx_spc0_data_cx2[88];

  wire [2:0] cpx_spc0_st_ack_dc_inval_1c = {2'b00, cpx_spc0_st_ack & cpx_spc0_st_ack_dc_inval_1c_tmp};

  wire cpx_spc0_st_ack_ic_inval_1c_tmp = cpx_spc0_data_cx2[122] ?  cpx_spc0_data_cx2[57] : cpx_spc0_data_cx2[1];
  wire [2:0] cpx_spc0_st_ack_ic_inval_1c = {2'b00, (cpx_spc0_st_ack & cpx_spc0_st_ack_ic_inval_1c_tmp)};
  wire [5:0] cpx_spc0_st_ack_icdc_inval_1c = {6{cpx_spc0_st_ack}} &
					        {cpx_spc0_st_ack_ic_inval_1c, cpx_spc0_st_ack_dc_inval_1c};

  wire [2:0] cpx_spc0_evict_dc_inval_1c   = cpx_spc0_data_cx2[0]  + cpx_spc0_data_cx2[32] +
                                       cpx_spc0_data_cx2[56] + cpx_spc0_data_cx2[88];
  wire [1:0] cpx_spc0_evict_ic_inval_1c   = cpx_spc0_data_cx2[1]  + cpx_spc0_data_cx2[57];


  reg cpx_spc0_evict_d1;
  always @(posedge clk)
    cpx_spc0_evict_d1 <= cpx_spc0_evict;

  wire cpx_spc0_b2b_evict = cpx_spc0_evict_d1 & cpx_spc0_evict;

  wire [5:0] cpx_spc0_evict_icdc_inval_1c;
  assign cpx_spc0_evict_icdc_inval_1c[4:0]={5{cpx_spc0_evict}} &
                                              {cpx_spc0_evict_ic_inval_1c,cpx_spc0_evict_dc_inval_1c};

  assign cpx_spc0_evict_icdc_inval_1c[5] = cpx_spc0_b2b_evict;

  wire [5:0] cpx_spc0_st_ack_dc_inval_8c_tmp = (cpx_spc0_data_cx2[122:121] == 2'b00) ? (
									     cpx_spc0_data_cx2[0] + cpx_spc0_data_cx2[4]   +
									     cpx_spc0_data_cx2[8] + cpx_spc0_data_cx2[12]  +
									     cpx_spc0_data_cx2[16] + cpx_spc0_data_cx2[20] +
									     cpx_spc0_data_cx2[24] + cpx_spc0_data_cx2[28]
                                                                           ) :
                                  (cpx_spc0_data_cx2[122:121] == 2'b01) ? (
									     cpx_spc0_data_cx2[32] + cpx_spc0_data_cx2[35] +
									     cpx_spc0_data_cx2[38] + cpx_spc0_data_cx2[41] +
									     cpx_spc0_data_cx2[44] + cpx_spc0_data_cx2[47] +
									     cpx_spc0_data_cx2[50] + cpx_spc0_data_cx2[53]
                                                                           ) :
                                  (cpx_spc0_data_cx2[122:121] == 2'b10) ? (
									     cpx_spc0_data_cx2[56] + cpx_spc0_data_cx2[60] +
									     cpx_spc0_data_cx2[64] + cpx_spc0_data_cx2[68] +
									     cpx_spc0_data_cx2[72] + cpx_spc0_data_cx2[76] +
									     cpx_spc0_data_cx2[80] + cpx_spc0_data_cx2[84]
                                                                           ) :
									   ( cpx_spc0_data_cx2[88] + cpx_spc0_data_cx2[91] +
									     cpx_spc0_data_cx2[94] + cpx_spc0_data_cx2[97] +
									     cpx_spc0_data_cx2[100]+ cpx_spc0_data_cx2[103]+
									     cpx_spc0_data_cx2[106]+ cpx_spc0_data_cx2[109]
                                                                           ) ;

  wire [5:0] cpx_spc0_st_ack_dc_inval_8c = {6{cpx_spc0_st_ack}} & cpx_spc0_st_ack_dc_inval_8c_tmp;

  wire [5:0] cpx_spc0_st_ack_ic_inval_8c_tmp = ~cpx_spc0_data_cx2[122] ? (
                                                                             cpx_spc0_data_cx2[1] + cpx_spc0_data_cx2[5]   +
                                                                             cpx_spc0_data_cx2[9] + cpx_spc0_data_cx2[13]  +
                                                                             cpx_spc0_data_cx2[17] + cpx_spc0_data_cx2[21] +
                                                                             cpx_spc0_data_cx2[25] + cpx_spc0_data_cx2[29]
                                                                           ) :
                                                                           ( cpx_spc0_data_cx2[57] + cpx_spc0_data_cx2[61] +
                                                                             cpx_spc0_data_cx2[65] + cpx_spc0_data_cx2[69] +
                                                                             cpx_spc0_data_cx2[73] + cpx_spc0_data_cx2[77] +
                                                                             cpx_spc0_data_cx2[81] + cpx_spc0_data_cx2[85]
                                                                           ) ;

  wire [5:0] cpx_spc0_st_ack_ic_inval_8c = {4{cpx_spc0_st_ack}} & cpx_spc0_st_ack_ic_inval_8c_tmp;

  wire [5:0] cpx_spc0_evict_dc_inval_8c_tmp =
									     cpx_spc0_data_cx2[0] + cpx_spc0_data_cx2[4] +
									     cpx_spc0_data_cx2[8] + cpx_spc0_data_cx2[12] +
									     cpx_spc0_data_cx2[16] + cpx_spc0_data_cx2[20] +
									     cpx_spc0_data_cx2[24] + cpx_spc0_data_cx2[28] +
									     cpx_spc0_data_cx2[32] + cpx_spc0_data_cx2[35] +
									     cpx_spc0_data_cx2[38] + cpx_spc0_data_cx2[41] +
									     cpx_spc0_data_cx2[44] + cpx_spc0_data_cx2[47] +
									     cpx_spc0_data_cx2[50] + cpx_spc0_data_cx2[53] +
									     cpx_spc0_data_cx2[56] + cpx_spc0_data_cx2[60] +
									     cpx_spc0_data_cx2[64] + cpx_spc0_data_cx2[68] +
									     cpx_spc0_data_cx2[72] + cpx_spc0_data_cx2[76] +
									     cpx_spc0_data_cx2[80] + cpx_spc0_data_cx2[84] +
									     cpx_spc0_data_cx2[88] + cpx_spc0_data_cx2[91] +
									     cpx_spc0_data_cx2[94] + cpx_spc0_data_cx2[97] +
									     cpx_spc0_data_cx2[100]+ cpx_spc0_data_cx2[103]+
									     cpx_spc0_data_cx2[106]+ cpx_spc0_data_cx2[109];

  wire [5:0] cpx_spc0_evict_dc_inval_8c = {6{cpx_spc0_evict}} & cpx_spc0_evict_dc_inval_8c_tmp;

  wire [5:0] cpx_spc0_evict_ic_inval_8c_tmp =
                                                                             cpx_spc0_data_cx2[1] + cpx_spc0_data_cx2[5] +
                                                                             cpx_spc0_data_cx2[9] + cpx_spc0_data_cx2[13] +
                                                                             cpx_spc0_data_cx2[17] + cpx_spc0_data_cx2[21] +
                                                                             cpx_spc0_data_cx2[25] + cpx_spc0_data_cx2[29] +
                                                                             cpx_spc0_data_cx2[57] + cpx_spc0_data_cx2[61] +
                                                                             cpx_spc0_data_cx2[65] + cpx_spc0_data_cx2[69] +
                                                                             cpx_spc0_data_cx2[73] + cpx_spc0_data_cx2[77] +
                                                                             cpx_spc0_data_cx2[81] + cpx_spc0_data_cx2[85];

  wire [5:0] cpx_spc0_evict_ic_inval_8c = {6{cpx_spc0_evict}} & cpx_spc0_evict_ic_inval_8c_tmp;

  reg [3:0] 	blk_st_cnt0;			// counts the number of block  stores without an acknowledge in between
  reg [3:0] 	ini_st_cnt0;			// counts the number of init   stores without an acknowledge in between
  reg  		st_blkst_mixture0;		// a flag set upon detection of block store and normal store mixture.
  reg  		st_inist_mixture0;		// a flag set upon detection of init  store and normal store mixture.
  reg 		atomic_ret0;			// atomic  cpx to spc package
  reg 		non_b2b_atomic_ret0;		// atomic  cpx to spc package did not return in back to back cycles
`endif


`ifdef RTL_SPARC1
   wire                  cpx_spc1_data_vld 	= `SPARC_CORE1.cpx_spc0_data_cx2[`CPX_WIDTH-1];
   wire [`CPX_WIDTH-1:0] cpx_spc1_data_cx2	= `SPARC_CORE1.cpx_spc0_data_cx2[`CPX_WIDTH-1:0];

   reg [`CPX_WIDTH-1:0] cpx_spc1_data_cx2_d1;	// packet delayed by 1
   reg [`CPX_WIDTH-1:0] cpx_spc1_data_cx2_d2;	// packet delayed by 2
   reg [127:0]		spc1_pcx_type_str;		// packet type in string format for debug.

   reg [127:0]		cpx_spc1_type_str;		// in string format for debug

   wire [3:0]  		cpx_spc1_type     	= cpx_spc1_data_vld ? cpx_spc1_data_cx2[`CPX_RQ_HI:`CPX_RQ_LO] :4'h0;
   wire        		cpx_spc1_wyvld    	= cpx_spc1_data_cx2[`CPX_WYVLD] & cpx_spc1_data_vld;

   wire cpx_spc1_st_ack = (cpx_spc1_type == `ST_ACK) | (cpx_spc1_type == `STRST_ACK);
   wire cpx_spc1_evict  = (cpx_spc1_type == `EVICT_REQ);

   reg cpx_spc1_ifill_wyvld;
   reg cpx_spc1_dfill_wyvld;

  wire cpx_spc1_st_ack_dc_inval_1c_tmp = (cpx_spc1_data_cx2[122:121] == 2'b00) ?  cpx_spc1_data_cx2[0]  :
                                          (cpx_spc1_data_cx2[122:121] == 2'b01)   ?  cpx_spc1_data_cx2[32] :
                                          (cpx_spc1_data_cx2[122:121] == 2'b10)   ?  cpx_spc1_data_cx2[56] :
                                          					        cpx_spc1_data_cx2[88];

  wire [2:0] cpx_spc1_st_ack_dc_inval_1c = {2'b00, cpx_spc1_st_ack & cpx_spc1_st_ack_dc_inval_1c_tmp};

  wire cpx_spc1_st_ack_ic_inval_1c_tmp = cpx_spc1_data_cx2[122] ?  cpx_spc1_data_cx2[57] : cpx_spc1_data_cx2[1];
  wire [2:0] cpx_spc1_st_ack_ic_inval_1c = {2'b00, (cpx_spc1_st_ack & cpx_spc1_st_ack_ic_inval_1c_tmp)};
  wire [5:0] cpx_spc1_st_ack_icdc_inval_1c = {6{cpx_spc1_st_ack}} &
					        {cpx_spc1_st_ack_ic_inval_1c, cpx_spc1_st_ack_dc_inval_1c};

  wire [2:0] cpx_spc1_evict_dc_inval_1c   = cpx_spc1_data_cx2[0]  + cpx_spc1_data_cx2[32] +
                                       cpx_spc1_data_cx2[56] + cpx_spc1_data_cx2[88];
  wire [1:0] cpx_spc1_evict_ic_inval_1c   = cpx_spc1_data_cx2[1]  + cpx_spc1_data_cx2[57];


  reg cpx_spc1_evict_d1;
  always @(posedge clk)
    cpx_spc1_evict_d1 <= cpx_spc1_evict;

  wire cpx_spc1_b2b_evict = cpx_spc1_evict_d1 & cpx_spc1_evict;

  wire [5:0] cpx_spc1_evict_icdc_inval_1c;
  assign cpx_spc1_evict_icdc_inval_1c[4:0]={5{cpx_spc1_evict}} &
                                              {cpx_spc1_evict_ic_inval_1c,cpx_spc1_evict_dc_inval_1c};

  assign cpx_spc1_evict_icdc_inval_1c[5] = cpx_spc1_b2b_evict;

  wire [5:0] cpx_spc1_st_ack_dc_inval_8c_tmp = (cpx_spc1_data_cx2[122:121] == 2'b00) ? (
									     cpx_spc1_data_cx2[0] + cpx_spc1_data_cx2[4]   +
									     cpx_spc1_data_cx2[8] + cpx_spc1_data_cx2[12]  +
									     cpx_spc1_data_cx2[16] + cpx_spc1_data_cx2[20] +
									     cpx_spc1_data_cx2[24] + cpx_spc1_data_cx2[28]
                                                                           ) :
                                  (cpx_spc1_data_cx2[122:121] == 2'b01) ? (
									     cpx_spc1_data_cx2[32] + cpx_spc1_data_cx2[35] +
									     cpx_spc1_data_cx2[38] + cpx_spc1_data_cx2[41] +
									     cpx_spc1_data_cx2[44] + cpx_spc1_data_cx2[47] +
									     cpx_spc1_data_cx2[50] + cpx_spc1_data_cx2[53]
                                                                           ) :
                                  (cpx_spc1_data_cx2[122:121] == 2'b10) ? (
									     cpx_spc1_data_cx2[56] + cpx_spc1_data_cx2[60] +
									     cpx_spc1_data_cx2[64] + cpx_spc1_data_cx2[68] +
									     cpx_spc1_data_cx2[72] + cpx_spc1_data_cx2[76] +
									     cpx_spc1_data_cx2[80] + cpx_spc1_data_cx2[84]
                                                                           ) :
									   ( cpx_spc1_data_cx2[88] + cpx_spc1_data_cx2[91] +
									     cpx_spc1_data_cx2[94] + cpx_spc1_data_cx2[97] +
									     cpx_spc1_data_cx2[100]+ cpx_spc1_data_cx2[103]+
									     cpx_spc1_data_cx2[106]+ cpx_spc1_data_cx2[109]
                                                                           ) ;

  wire [5:0] cpx_spc1_st_ack_dc_inval_8c = {6{cpx_spc1_st_ack}} & cpx_spc1_st_ack_dc_inval_8c_tmp;

  wire [5:0] cpx_spc1_st_ack_ic_inval_8c_tmp = ~cpx_spc1_data_cx2[122] ? (
                                                                             cpx_spc1_data_cx2[1] + cpx_spc1_data_cx2[5]   +
                                                                             cpx_spc1_data_cx2[9] + cpx_spc1_data_cx2[13]  +
                                                                             cpx_spc1_data_cx2[17] + cpx_spc1_data_cx2[21] +
                                                                             cpx_spc1_data_cx2[25] + cpx_spc1_data_cx2[29]
                                                                           ) :
                                                                           ( cpx_spc1_data_cx2[57] + cpx_spc1_data_cx2[61] +
                                                                             cpx_spc1_data_cx2[65] + cpx_spc1_data_cx2[69] +
                                                                             cpx_spc1_data_cx2[73] + cpx_spc1_data_cx2[77] +
                                                                             cpx_spc1_data_cx2[81] + cpx_spc1_data_cx2[85]
                                                                           ) ;

  wire [5:0] cpx_spc1_st_ack_ic_inval_8c = {4{cpx_spc1_st_ack}} & cpx_spc1_st_ack_ic_inval_8c_tmp;

  wire [5:0] cpx_spc1_evict_dc_inval_8c_tmp =
									     cpx_spc1_data_cx2[0] + cpx_spc1_data_cx2[4] +
									     cpx_spc1_data_cx2[8] + cpx_spc1_data_cx2[12] +
									     cpx_spc1_data_cx2[16] + cpx_spc1_data_cx2[20] +
									     cpx_spc1_data_cx2[24] + cpx_spc1_data_cx2[28] +
									     cpx_spc1_data_cx2[32] + cpx_spc1_data_cx2[35] +
									     cpx_spc1_data_cx2[38] + cpx_spc1_data_cx2[41] +
									     cpx_spc1_data_cx2[44] + cpx_spc1_data_cx2[47] +
									     cpx_spc1_data_cx2[50] + cpx_spc1_data_cx2[53] +
									     cpx_spc1_data_cx2[56] + cpx_spc1_data_cx2[60] +
									     cpx_spc1_data_cx2[64] + cpx_spc1_data_cx2[68] +
									     cpx_spc1_data_cx2[72] + cpx_spc1_data_cx2[76] +
									     cpx_spc1_data_cx2[80] + cpx_spc1_data_cx2[84] +
									     cpx_spc1_data_cx2[88] + cpx_spc1_data_cx2[91] +
									     cpx_spc1_data_cx2[94] + cpx_spc1_data_cx2[97] +
									     cpx_spc1_data_cx2[100]+ cpx_spc1_data_cx2[103]+
									     cpx_spc1_data_cx2[106]+ cpx_spc1_data_cx2[109];

  wire [5:0] cpx_spc1_evict_dc_inval_8c = {6{cpx_spc1_evict}} & cpx_spc1_evict_dc_inval_8c_tmp;

  wire [5:0] cpx_spc1_evict_ic_inval_8c_tmp =
                                                                             cpx_spc1_data_cx2[1] + cpx_spc1_data_cx2[5] +
                                                                             cpx_spc1_data_cx2[9] + cpx_spc1_data_cx2[13] +
                                                                             cpx_spc1_data_cx2[17] + cpx_spc1_data_cx2[21] +
                                                                             cpx_spc1_data_cx2[25] + cpx_spc1_data_cx2[29] +
                                                                             cpx_spc1_data_cx2[57] + cpx_spc1_data_cx2[61] +
                                                                             cpx_spc1_data_cx2[65] + cpx_spc1_data_cx2[69] +
                                                                             cpx_spc1_data_cx2[73] + cpx_spc1_data_cx2[77] +
                                                                             cpx_spc1_data_cx2[81] + cpx_spc1_data_cx2[85];

  wire [5:0] cpx_spc1_evict_ic_inval_8c = {6{cpx_spc1_evict}} & cpx_spc1_evict_ic_inval_8c_tmp;

  reg [3:0] 	blk_st_cnt1;			// counts the number of block  stores without an acknowledge in between
  reg [3:0] 	ini_st_cnt1;			// counts the number of init   stores without an acknowledge in between
  reg  		st_blkst_mixture1;		// a flag set upon detection of block store and normal store mixture.
  reg  		st_inist_mixture1;		// a flag set upon detection of init  store and normal store mixture.
  reg 		atomic_ret1;			// atomic  cpx to spc package
  reg 		non_b2b_atomic_ret1;		// atomic  cpx to spc package did not return in back to back cycles
`endif


`ifdef RTL_SPARC2
   wire                  cpx_spc2_data_vld 	= `SPARC_CORE2.cpx_spc0_data_cx2[`CPX_WIDTH-1];
   wire [`CPX_WIDTH-1:0] cpx_spc2_data_cx2	= `SPARC_CORE2.cpx_spc0_data_cx2[`CPX_WIDTH-1:0];

   reg [`CPX_WIDTH-1:0] cpx_spc2_data_cx2_d1;	// packet delayed by 1
   reg [`CPX_WIDTH-1:0] cpx_spc2_data_cx2_d2;	// packet delayed by 2
   reg [127:0]		spc2_pcx_type_str;		// packet type in string format for debug.

   reg [127:0]		cpx_spc2_type_str;		// in string format for debug

   wire [3:0]  		cpx_spc2_type     	= cpx_spc2_data_vld ? cpx_spc2_data_cx2[`CPX_RQ_HI:`CPX_RQ_LO] :4'h0;
   wire        		cpx_spc2_wyvld    	= cpx_spc2_data_cx2[`CPX_WYVLD] & cpx_spc2_data_vld;

   wire cpx_spc2_st_ack = (cpx_spc2_type == `ST_ACK) | (cpx_spc2_type == `STRST_ACK);
   wire cpx_spc2_evict  = (cpx_spc2_type == `EVICT_REQ);

   reg cpx_spc2_ifill_wyvld;
   reg cpx_spc2_dfill_wyvld;

  wire cpx_spc2_st_ack_dc_inval_1c_tmp = (cpx_spc2_data_cx2[122:121] == 2'b00) ?  cpx_spc2_data_cx2[0]  :
                                          (cpx_spc2_data_cx2[122:121] == 2'b01)   ?  cpx_spc2_data_cx2[32] :
                                          (cpx_spc2_data_cx2[122:121] == 2'b10)   ?  cpx_spc2_data_cx2[56] :
                                          					        cpx_spc2_data_cx2[88];

  wire [2:0] cpx_spc2_st_ack_dc_inval_1c = {2'b00, cpx_spc2_st_ack & cpx_spc2_st_ack_dc_inval_1c_tmp};

  wire cpx_spc2_st_ack_ic_inval_1c_tmp = cpx_spc2_data_cx2[122] ?  cpx_spc2_data_cx2[57] : cpx_spc2_data_cx2[1];
  wire [2:0] cpx_spc2_st_ack_ic_inval_1c = {2'b00, (cpx_spc2_st_ack & cpx_spc2_st_ack_ic_inval_1c_tmp)};
  wire [5:0] cpx_spc2_st_ack_icdc_inval_1c = {6{cpx_spc2_st_ack}} &
					        {cpx_spc2_st_ack_ic_inval_1c, cpx_spc2_st_ack_dc_inval_1c};

  wire [2:0] cpx_spc2_evict_dc_inval_1c   = cpx_spc2_data_cx2[0]  + cpx_spc2_data_cx2[32] +
                                       cpx_spc2_data_cx2[56] + cpx_spc2_data_cx2[88];
  wire [1:0] cpx_spc2_evict_ic_inval_1c   = cpx_spc2_data_cx2[1]  + cpx_spc2_data_cx2[57];


  reg cpx_spc2_evict_d1;
  always @(posedge clk)
    cpx_spc2_evict_d1 <= cpx_spc2_evict;

  wire cpx_spc2_b2b_evict = cpx_spc2_evict_d1 & cpx_spc2_evict;

  wire [5:0] cpx_spc2_evict_icdc_inval_1c;
  assign cpx_spc2_evict_icdc_inval_1c[4:0]={5{cpx_spc2_evict}} &
                                              {cpx_spc2_evict_ic_inval_1c,cpx_spc2_evict_dc_inval_1c};

  assign cpx_spc2_evict_icdc_inval_1c[5] = cpx_spc2_b2b_evict;

  wire [5:0] cpx_spc2_st_ack_dc_inval_8c_tmp = (cpx_spc2_data_cx2[122:121] == 2'b00) ? (
									     cpx_spc2_data_cx2[0] + cpx_spc2_data_cx2[4]   +
									     cpx_spc2_data_cx2[8] + cpx_spc2_data_cx2[12]  +
									     cpx_spc2_data_cx2[16] + cpx_spc2_data_cx2[20] +
									     cpx_spc2_data_cx2[24] + cpx_spc2_data_cx2[28]
                                                                           ) :
                                  (cpx_spc2_data_cx2[122:121] == 2'b01) ? (
									     cpx_spc2_data_cx2[32] + cpx_spc2_data_cx2[35] +
									     cpx_spc2_data_cx2[38] + cpx_spc2_data_cx2[41] +
									     cpx_spc2_data_cx2[44] + cpx_spc2_data_cx2[47] +
									     cpx_spc2_data_cx2[50] + cpx_spc2_data_cx2[53]
                                                                           ) :
                                  (cpx_spc2_data_cx2[122:121] == 2'b10) ? (
									     cpx_spc2_data_cx2[56] + cpx_spc2_data_cx2[60] +
									     cpx_spc2_data_cx2[64] + cpx_spc2_data_cx2[68] +
									     cpx_spc2_data_cx2[72] + cpx_spc2_data_cx2[76] +
									     cpx_spc2_data_cx2[80] + cpx_spc2_data_cx2[84]
                                                                           ) :
									   ( cpx_spc2_data_cx2[88] + cpx_spc2_data_cx2[91] +
									     cpx_spc2_data_cx2[94] + cpx_spc2_data_cx2[97] +
									     cpx_spc2_data_cx2[100]+ cpx_spc2_data_cx2[103]+
									     cpx_spc2_data_cx2[106]+ cpx_spc2_data_cx2[109]
                                                                           ) ;

  wire [5:0] cpx_spc2_st_ack_dc_inval_8c = {6{cpx_spc2_st_ack}} & cpx_spc2_st_ack_dc_inval_8c_tmp;

  wire [5:0] cpx_spc2_st_ack_ic_inval_8c_tmp = ~cpx_spc2_data_cx2[122] ? (
                                                                             cpx_spc2_data_cx2[1] + cpx_spc2_data_cx2[5]   +
                                                                             cpx_spc2_data_cx2[9] + cpx_spc2_data_cx2[13]  +
                                                                             cpx_spc2_data_cx2[17] + cpx_spc2_data_cx2[21] +
                                                                             cpx_spc2_data_cx2[25] + cpx_spc2_data_cx2[29]
                                                                           ) :
                                                                           ( cpx_spc2_data_cx2[57] + cpx_spc2_data_cx2[61] +
                                                                             cpx_spc2_data_cx2[65] + cpx_spc2_data_cx2[69] +
                                                                             cpx_spc2_data_cx2[73] + cpx_spc2_data_cx2[77] +
                                                                             cpx_spc2_data_cx2[81] + cpx_spc2_data_cx2[85]
                                                                           ) ;

  wire [5:0] cpx_spc2_st_ack_ic_inval_8c = {4{cpx_spc2_st_ack}} & cpx_spc2_st_ack_ic_inval_8c_tmp;

  wire [5:0] cpx_spc2_evict_dc_inval_8c_tmp =
									     cpx_spc2_data_cx2[0] + cpx_spc2_data_cx2[4] +
									     cpx_spc2_data_cx2[8] + cpx_spc2_data_cx2[12] +
									     cpx_spc2_data_cx2[16] + cpx_spc2_data_cx2[20] +
									     cpx_spc2_data_cx2[24] + cpx_spc2_data_cx2[28] +
									     cpx_spc2_data_cx2[32] + cpx_spc2_data_cx2[35] +
									     cpx_spc2_data_cx2[38] + cpx_spc2_data_cx2[41] +
									     cpx_spc2_data_cx2[44] + cpx_spc2_data_cx2[47] +
									     cpx_spc2_data_cx2[50] + cpx_spc2_data_cx2[53] +
									     cpx_spc2_data_cx2[56] + cpx_spc2_data_cx2[60] +
									     cpx_spc2_data_cx2[64] + cpx_spc2_data_cx2[68] +
									     cpx_spc2_data_cx2[72] + cpx_spc2_data_cx2[76] +
									     cpx_spc2_data_cx2[80] + cpx_spc2_data_cx2[84] +
									     cpx_spc2_data_cx2[88] + cpx_spc2_data_cx2[91] +
									     cpx_spc2_data_cx2[94] + cpx_spc2_data_cx2[97] +
									     cpx_spc2_data_cx2[100]+ cpx_spc2_data_cx2[103]+
									     cpx_spc2_data_cx2[106]+ cpx_spc2_data_cx2[109];

  wire [5:0] cpx_spc2_evict_dc_inval_8c = {6{cpx_spc2_evict}} & cpx_spc2_evict_dc_inval_8c_tmp;

  wire [5:0] cpx_spc2_evict_ic_inval_8c_tmp =
                                                                             cpx_spc2_data_cx2[1] + cpx_spc2_data_cx2[5] +
                                                                             cpx_spc2_data_cx2[9] + cpx_spc2_data_cx2[13] +
                                                                             cpx_spc2_data_cx2[17] + cpx_spc2_data_cx2[21] +
                                                                             cpx_spc2_data_cx2[25] + cpx_spc2_data_cx2[29] +
                                                                             cpx_spc2_data_cx2[57] + cpx_spc2_data_cx2[61] +
                                                                             cpx_spc2_data_cx2[65] + cpx_spc2_data_cx2[69] +
                                                                             cpx_spc2_data_cx2[73] + cpx_spc2_data_cx2[77] +
                                                                             cpx_spc2_data_cx2[81] + cpx_spc2_data_cx2[85];

  wire [5:0] cpx_spc2_evict_ic_inval_8c = {6{cpx_spc2_evict}} & cpx_spc2_evict_ic_inval_8c_tmp;

  reg [3:0] 	blk_st_cnt2;			// counts the number of block  stores without an acknowledge in between
  reg [3:0] 	ini_st_cnt2;			// counts the number of init   stores without an acknowledge in between
  reg  		st_blkst_mixture2;		// a flag set upon detection of block store and normal store mixture.
  reg  		st_inist_mixture2;		// a flag set upon detection of init  store and normal store mixture.
  reg 		atomic_ret2;			// atomic  cpx to spc package
  reg 		non_b2b_atomic_ret2;		// atomic  cpx to spc package did not return in back to back cycles
`endif


`ifdef RTL_SPARC3
   wire                  cpx_spc3_data_vld 	= `SPARC_CORE3.cpx_spc0_data_cx2[`CPX_WIDTH-1];
   wire [`CPX_WIDTH-1:0] cpx_spc3_data_cx2	= `SPARC_CORE3.cpx_spc0_data_cx2[`CPX_WIDTH-1:0];

   reg [`CPX_WIDTH-1:0] cpx_spc3_data_cx2_d1;	// packet delayed by 1
   reg [`CPX_WIDTH-1:0] cpx_spc3_data_cx2_d2;	// packet delayed by 2
   reg [127:0]		spc3_pcx_type_str;		// packet type in string format for debug.

   reg [127:0]		cpx_spc3_type_str;		// in string format for debug

   wire [3:0]  		cpx_spc3_type     	= cpx_spc3_data_vld ? cpx_spc3_data_cx2[`CPX_RQ_HI:`CPX_RQ_LO] :4'h0;
   wire        		cpx_spc3_wyvld    	= cpx_spc3_data_cx2[`CPX_WYVLD] & cpx_spc3_data_vld;

   wire cpx_spc3_st_ack = (cpx_spc3_type == `ST_ACK) | (cpx_spc3_type == `STRST_ACK);
   wire cpx_spc3_evict  = (cpx_spc3_type == `EVICT_REQ);

   reg cpx_spc3_ifill_wyvld;
   reg cpx_spc3_dfill_wyvld;

  wire cpx_spc3_st_ack_dc_inval_1c_tmp = (cpx_spc3_data_cx2[122:121] == 2'b00) ?  cpx_spc3_data_cx2[0]  :
                                          (cpx_spc3_data_cx2[122:121] == 2'b01)   ?  cpx_spc3_data_cx2[32] :
                                          (cpx_spc3_data_cx2[122:121] == 2'b10)   ?  cpx_spc3_data_cx2[56] :
                                          					        cpx_spc3_data_cx2[88];

  wire [2:0] cpx_spc3_st_ack_dc_inval_1c = {2'b00, cpx_spc3_st_ack & cpx_spc3_st_ack_dc_inval_1c_tmp};

  wire cpx_spc3_st_ack_ic_inval_1c_tmp = cpx_spc3_data_cx2[122] ?  cpx_spc3_data_cx2[57] : cpx_spc3_data_cx2[1];
  wire [2:0] cpx_spc3_st_ack_ic_inval_1c = {2'b00, (cpx_spc3_st_ack & cpx_spc3_st_ack_ic_inval_1c_tmp)};
  wire [5:0] cpx_spc3_st_ack_icdc_inval_1c = {6{cpx_spc3_st_ack}} &
					        {cpx_spc3_st_ack_ic_inval_1c, cpx_spc3_st_ack_dc_inval_1c};

  wire [2:0] cpx_spc3_evict_dc_inval_1c   = cpx_spc3_data_cx2[0]  + cpx_spc3_data_cx2[32] +
                                       cpx_spc3_data_cx2[56] + cpx_spc3_data_cx2[88];
  wire [1:0] cpx_spc3_evict_ic_inval_1c   = cpx_spc3_data_cx2[1]  + cpx_spc3_data_cx2[57];


  reg cpx_spc3_evict_d1;
  always @(posedge clk)
    cpx_spc3_evict_d1 <= cpx_spc3_evict;

  wire cpx_spc3_b2b_evict = cpx_spc3_evict_d1 & cpx_spc3_evict;

  wire [5:0] cpx_spc3_evict_icdc_inval_1c;
  assign cpx_spc3_evict_icdc_inval_1c[4:0]={5{cpx_spc3_evict}} &
                                              {cpx_spc3_evict_ic_inval_1c,cpx_spc3_evict_dc_inval_1c};

  assign cpx_spc3_evict_icdc_inval_1c[5] = cpx_spc3_b2b_evict;

  wire [5:0] cpx_spc3_st_ack_dc_inval_8c_tmp = (cpx_spc3_data_cx2[122:121] == 2'b00) ? (
									     cpx_spc3_data_cx2[0] + cpx_spc3_data_cx2[4]   +
									     cpx_spc3_data_cx2[8] + cpx_spc3_data_cx2[12]  +
									     cpx_spc3_data_cx2[16] + cpx_spc3_data_cx2[20] +
									     cpx_spc3_data_cx2[24] + cpx_spc3_data_cx2[28]
                                                                           ) :
                                  (cpx_spc3_data_cx2[122:121] == 2'b01) ? (
									     cpx_spc3_data_cx2[32] + cpx_spc3_data_cx2[35] +
									     cpx_spc3_data_cx2[38] + cpx_spc3_data_cx2[41] +
									     cpx_spc3_data_cx2[44] + cpx_spc3_data_cx2[47] +
									     cpx_spc3_data_cx2[50] + cpx_spc3_data_cx2[53]
                                                                           ) :
                                  (cpx_spc3_data_cx2[122:121] == 2'b10) ? (
									     cpx_spc3_data_cx2[56] + cpx_spc3_data_cx2[60] +
									     cpx_spc3_data_cx2[64] + cpx_spc3_data_cx2[68] +
									     cpx_spc3_data_cx2[72] + cpx_spc3_data_cx2[76] +
									     cpx_spc3_data_cx2[80] + cpx_spc3_data_cx2[84]
                                                                           ) :
									   ( cpx_spc3_data_cx2[88] + cpx_spc3_data_cx2[91] +
									     cpx_spc3_data_cx2[94] + cpx_spc3_data_cx2[97] +
									     cpx_spc3_data_cx2[100]+ cpx_spc3_data_cx2[103]+
									     cpx_spc3_data_cx2[106]+ cpx_spc3_data_cx2[109]
                                                                           ) ;

  wire [5:0] cpx_spc3_st_ack_dc_inval_8c = {6{cpx_spc3_st_ack}} & cpx_spc3_st_ack_dc_inval_8c_tmp;

  wire [5:0] cpx_spc3_st_ack_ic_inval_8c_tmp = ~cpx_spc3_data_cx2[122] ? (
                                                                             cpx_spc3_data_cx2[1] + cpx_spc3_data_cx2[5]   +
                                                                             cpx_spc3_data_cx2[9] + cpx_spc3_data_cx2[13]  +
                                                                             cpx_spc3_data_cx2[17] + cpx_spc3_data_cx2[21] +
                                                                             cpx_spc3_data_cx2[25] + cpx_spc3_data_cx2[29]
                                                                           ) :
                                                                           ( cpx_spc3_data_cx2[57] + cpx_spc3_data_cx2[61] +
                                                                             cpx_spc3_data_cx2[65] + cpx_spc3_data_cx2[69] +
                                                                             cpx_spc3_data_cx2[73] + cpx_spc3_data_cx2[77] +
                                                                             cpx_spc3_data_cx2[81] + cpx_spc3_data_cx2[85]
                                                                           ) ;

  wire [5:0] cpx_spc3_st_ack_ic_inval_8c = {4{cpx_spc3_st_ack}} & cpx_spc3_st_ack_ic_inval_8c_tmp;

  wire [5:0] cpx_spc3_evict_dc_inval_8c_tmp =
									     cpx_spc3_data_cx2[0] + cpx_spc3_data_cx2[4] +
									     cpx_spc3_data_cx2[8] + cpx_spc3_data_cx2[12] +
									     cpx_spc3_data_cx2[16] + cpx_spc3_data_cx2[20] +
									     cpx_spc3_data_cx2[24] + cpx_spc3_data_cx2[28] +
									     cpx_spc3_data_cx2[32] + cpx_spc3_data_cx2[35] +
									     cpx_spc3_data_cx2[38] + cpx_spc3_data_cx2[41] +
									     cpx_spc3_data_cx2[44] + cpx_spc3_data_cx2[47] +
									     cpx_spc3_data_cx2[50] + cpx_spc3_data_cx2[53] +
									     cpx_spc3_data_cx2[56] + cpx_spc3_data_cx2[60] +
									     cpx_spc3_data_cx2[64] + cpx_spc3_data_cx2[68] +
									     cpx_spc3_data_cx2[72] + cpx_spc3_data_cx2[76] +
									     cpx_spc3_data_cx2[80] + cpx_spc3_data_cx2[84] +
									     cpx_spc3_data_cx2[88] + cpx_spc3_data_cx2[91] +
									     cpx_spc3_data_cx2[94] + cpx_spc3_data_cx2[97] +
									     cpx_spc3_data_cx2[100]+ cpx_spc3_data_cx2[103]+
									     cpx_spc3_data_cx2[106]+ cpx_spc3_data_cx2[109];

  wire [5:0] cpx_spc3_evict_dc_inval_8c = {6{cpx_spc3_evict}} & cpx_spc3_evict_dc_inval_8c_tmp;

  wire [5:0] cpx_spc3_evict_ic_inval_8c_tmp =
                                                                             cpx_spc3_data_cx2[1] + cpx_spc3_data_cx2[5] +
                                                                             cpx_spc3_data_cx2[9] + cpx_spc3_data_cx2[13] +
                                                                             cpx_spc3_data_cx2[17] + cpx_spc3_data_cx2[21] +
                                                                             cpx_spc3_data_cx2[25] + cpx_spc3_data_cx2[29] +
                                                                             cpx_spc3_data_cx2[57] + cpx_spc3_data_cx2[61] +
                                                                             cpx_spc3_data_cx2[65] + cpx_spc3_data_cx2[69] +
                                                                             cpx_spc3_data_cx2[73] + cpx_spc3_data_cx2[77] +
                                                                             cpx_spc3_data_cx2[81] + cpx_spc3_data_cx2[85];

  wire [5:0] cpx_spc3_evict_ic_inval_8c = {6{cpx_spc3_evict}} & cpx_spc3_evict_ic_inval_8c_tmp;

  reg [3:0] 	blk_st_cnt3;			// counts the number of block  stores without an acknowledge in between
  reg [3:0] 	ini_st_cnt3;			// counts the number of init   stores without an acknowledge in between
  reg  		st_blkst_mixture3;		// a flag set upon detection of block store and normal store mixture.
  reg  		st_inist_mixture3;		// a flag set upon detection of init  store and normal store mixture.
  reg 		atomic_ret3;			// atomic  cpx to spc package
  reg 		non_b2b_atomic_ret3;		// atomic  cpx to spc package did not return in back to back cycles
`endif




//----------------------------------------------------------------------------------------
// The real thing starts somewhere here
//----------------------------------------------------------------------------------------

// This check belongs to another monitor (PLL) but since the PLL monitor does not
// exist and I do want this chip to work I put it here.
//--------------------------------------------------------------------------------


always @(posedge clk)
begin


`ifdef RTL_SPARC0
  pcx0_vld_d1 	<= spc0_pcx_data_pa[123];
  pcx0_type_d1 	<= spc0_pcx_data_pa[122:118];
  pcx0_req_pq_d1 	<= |spc0_pcx_req_pq;
  pcx0_atom_pq_d1 	<= spc0_pcx_atom_pq;
  pcx0_atom_pq_d2 	<= pcx0_atom_pq_d1;


// Multiple block stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc0_type == `ST_ACK) | ~rst_l)
    blk_st_cnt0 <=  4'h0;
  else if(pcx0_req_pq_d1 & (spc0_pcx_data_pa[122:118] == `STORE_RQ) & spc0_pcx_data_pa[109] & spc0_pcx_data_pa[110])
    blk_st_cnt0 <= blk_st_cnt0 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(blk_st_cnt0 & (spc0_pcx_data_pa[122:118] == `STORE_RQ) & ~spc0_pcx_data_pa[109])
    st_blkst_mixture0 <= 1'b1;
  else if(blk_st_cnt0 == 4'h0)
    st_blkst_mixture0 <= 1'b0;

// Multiple init stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc0_type == `ST_ACK) | ~rst_l)
    ini_st_cnt0 <=  4'h0;
  else if(pcx0_req_pq_d1 & (spc0_pcx_data_pa[122:118] == `STORE_RQ) & spc0_pcx_data_pa[109] & ~spc0_pcx_data_pa[110])
    ini_st_cnt0 <= ini_st_cnt0 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(ini_st_cnt0 && (spc0_pcx_data_pa[122:118] == `STORE_RQ) & ~spc0_pcx_data_pa[109])
    st_inist_mixture0 <= 1'b1;
  else if(ini_st_cnt0 == 4'h0)
    st_inist_mixture0 <= 1'b0;

  if(~rst_l)
    cpx_spc0_ifill_wyvld <= 1'b0;
  else
    cpx_spc0_ifill_wyvld <= ((cpx_spc0_type == `IFILL_RET) & cpx_spc0_wyvld);

  if(~rst_l)
    cpx_spc0_dfill_wyvld <= 1'b0;
  else
    cpx_spc0_dfill_wyvld <= ((cpx_spc0_type == `LOAD_RET) & cpx_spc0_wyvld);
`endif


`ifdef RTL_SPARC1
  pcx1_vld_d1 	<= spc1_pcx_data_pa[123];
  pcx1_type_d1 	<= spc1_pcx_data_pa[122:118];
  pcx1_req_pq_d1 	<= |spc1_pcx_req_pq;
  pcx1_atom_pq_d1 	<= spc1_pcx_atom_pq;
  pcx1_atom_pq_d2 	<= pcx1_atom_pq_d1;


// Multiple block stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc1_type == `ST_ACK) | ~rst_l)
    blk_st_cnt1 <=  4'h0;
  else if(pcx1_req_pq_d1 & (spc1_pcx_data_pa[122:118] == `STORE_RQ) & spc1_pcx_data_pa[109] & spc1_pcx_data_pa[110])
    blk_st_cnt1 <= blk_st_cnt1 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(blk_st_cnt1 & (spc1_pcx_data_pa[122:118] == `STORE_RQ) & ~spc1_pcx_data_pa[109])
    st_blkst_mixture1 <= 1'b1;
  else if(blk_st_cnt1 == 4'h0)
    st_blkst_mixture1 <= 1'b0;

// Multiple init stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc1_type == `ST_ACK) | ~rst_l)
    ini_st_cnt1 <=  4'h0;
  else if(pcx1_req_pq_d1 & (spc1_pcx_data_pa[122:118] == `STORE_RQ) & spc1_pcx_data_pa[109] & ~spc1_pcx_data_pa[110])
    ini_st_cnt1 <= ini_st_cnt1 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(ini_st_cnt1 && (spc1_pcx_data_pa[122:118] == `STORE_RQ) & ~spc1_pcx_data_pa[109])
    st_inist_mixture1 <= 1'b1;
  else if(ini_st_cnt1 == 4'h0)
    st_inist_mixture1 <= 1'b0;

  if(~rst_l)
    cpx_spc1_ifill_wyvld <= 1'b0;
  else
    cpx_spc1_ifill_wyvld <= ((cpx_spc1_type == `IFILL_RET) & cpx_spc1_wyvld);

  if(~rst_l)
    cpx_spc1_dfill_wyvld <= 1'b0;
  else
    cpx_spc1_dfill_wyvld <= ((cpx_spc1_type == `LOAD_RET) & cpx_spc1_wyvld);
`endif


`ifdef RTL_SPARC2
  pcx2_vld_d1 	<= spc2_pcx_data_pa[123];
  pcx2_type_d1 	<= spc2_pcx_data_pa[122:118];
  pcx2_req_pq_d1 	<= |spc2_pcx_req_pq;
  pcx2_atom_pq_d1 	<= spc2_pcx_atom_pq;
  pcx2_atom_pq_d2 	<= pcx2_atom_pq_d1;


// Multiple block stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc2_type == `ST_ACK) | ~rst_l)
    blk_st_cnt2 <=  4'h0;
  else if(pcx2_req_pq_d1 & (spc2_pcx_data_pa[122:118] == `STORE_RQ) & spc2_pcx_data_pa[109] & spc2_pcx_data_pa[110])
    blk_st_cnt2 <= blk_st_cnt2 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(blk_st_cnt2 & (spc2_pcx_data_pa[122:118] == `STORE_RQ) & ~spc2_pcx_data_pa[109])
    st_blkst_mixture2 <= 1'b1;
  else if(blk_st_cnt2 == 4'h0)
    st_blkst_mixture2 <= 1'b0;

// Multiple init stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc2_type == `ST_ACK) | ~rst_l)
    ini_st_cnt2 <=  4'h0;
  else if(pcx2_req_pq_d1 & (spc2_pcx_data_pa[122:118] == `STORE_RQ) & spc2_pcx_data_pa[109] & ~spc2_pcx_data_pa[110])
    ini_st_cnt2 <= ini_st_cnt2 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(ini_st_cnt2 && (spc2_pcx_data_pa[122:118] == `STORE_RQ) & ~spc2_pcx_data_pa[109])
    st_inist_mixture2 <= 1'b1;
  else if(ini_st_cnt2 == 4'h0)
    st_inist_mixture2 <= 1'b0;

  if(~rst_l)
    cpx_spc2_ifill_wyvld <= 1'b0;
  else
    cpx_spc2_ifill_wyvld <= ((cpx_spc2_type == `IFILL_RET) & cpx_spc2_wyvld);

  if(~rst_l)
    cpx_spc2_dfill_wyvld <= 1'b0;
  else
    cpx_spc2_dfill_wyvld <= ((cpx_spc2_type == `LOAD_RET) & cpx_spc2_wyvld);
`endif


`ifdef RTL_SPARC3
  pcx3_vld_d1 	<= spc3_pcx_data_pa[123];
  pcx3_type_d1 	<= spc3_pcx_data_pa[122:118];
  pcx3_req_pq_d1 	<= |spc3_pcx_req_pq;
  pcx3_atom_pq_d1 	<= spc3_pcx_atom_pq;
  pcx3_atom_pq_d2 	<= pcx3_atom_pq_d1;


// Multiple block stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc3_type == `ST_ACK) | ~rst_l)
    blk_st_cnt3 <=  4'h0;
  else if(pcx3_req_pq_d1 & (spc3_pcx_data_pa[122:118] == `STORE_RQ) & spc3_pcx_data_pa[109] & spc3_pcx_data_pa[110])
    blk_st_cnt3 <= blk_st_cnt3 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(blk_st_cnt3 & (spc3_pcx_data_pa[122:118] == `STORE_RQ) & ~spc3_pcx_data_pa[109])
    st_blkst_mixture3 <= 1'b1;
  else if(blk_st_cnt3 == 4'h0)
    st_blkst_mixture3 <= 1'b0;

// Multiple init stores without an ACK in between
//---------------------------------------------------
  if((cpx_spc3_type == `ST_ACK) | ~rst_l)
    ini_st_cnt3 <=  4'h0;
  else if(pcx3_req_pq_d1 & (spc3_pcx_data_pa[122:118] == `STORE_RQ) & spc3_pcx_data_pa[109] & ~spc3_pcx_data_pa[110])
    ini_st_cnt3 <= ini_st_cnt3 + 1'b1;

// detect if a normal store came while this counter is not zero.
//--------------------------------------------------------------
  if(ini_st_cnt3 && (spc3_pcx_data_pa[122:118] == `STORE_RQ) & ~spc3_pcx_data_pa[109])
    st_inist_mixture3 <= 1'b1;
  else if(ini_st_cnt3 == 4'h0)
    st_inist_mixture3 <= 1'b0;

  if(~rst_l)
    cpx_spc3_ifill_wyvld <= 1'b0;
  else
    cpx_spc3_ifill_wyvld <= ((cpx_spc3_type == `IFILL_RET) & cpx_spc3_wyvld);

  if(~rst_l)
    cpx_spc3_dfill_wyvld <= 1'b0;
  else
    cpx_spc3_dfill_wyvld <= ((cpx_spc3_type == `LOAD_RET) & cpx_spc3_wyvld);
`endif




end

always @(negedge clk)
begin

`ifdef RTL_SPARC0
  if (rst_l & (^spc0_pcx_req_pq === 1'bx))
     finish_test("spc", "pcx_req_pq has X-s", 0);
  else if(rst_l & pcx0_req_pq_d1)
     get_pcx(	spc0_pcx_type_str, spc0_pcx_data_pa, pcx0_type_d1,
		pcx0_atom_pq_d1, pcx0_atom_pq_d2, 3'd0, pcx0_req_pq_d1);
`endif


`ifdef RTL_SPARC1
  if (rst_l & (^spc1_pcx_req_pq === 1'bx))
     finish_test("spc", "pcx_req_pq has X-s", 1);
  else if(rst_l & pcx1_req_pq_d1)
     get_pcx(	spc1_pcx_type_str, spc1_pcx_data_pa, pcx1_type_d1,
		pcx1_atom_pq_d1, pcx1_atom_pq_d2, 3'd0, pcx1_req_pq_d1);
`endif


`ifdef RTL_SPARC2
  if (rst_l & (^spc2_pcx_req_pq === 1'bx))
     finish_test("spc", "pcx_req_pq has X-s", 2);
  else if(rst_l & pcx2_req_pq_d1)
     get_pcx(	spc2_pcx_type_str, spc2_pcx_data_pa, pcx2_type_d1,
		pcx2_atom_pq_d1, pcx2_atom_pq_d2, 3'd0, pcx2_req_pq_d1);
`endif


`ifdef RTL_SPARC3
  if (rst_l & (^spc3_pcx_req_pq === 1'bx))
     finish_test("spc", "pcx_req_pq has X-s", 3);
  else if(rst_l & pcx3_req_pq_d1)
     get_pcx(	spc3_pcx_type_str, spc3_pcx_data_pa, pcx3_type_d1,
		pcx3_atom_pq_d1, pcx3_atom_pq_d2, 3'd0, pcx3_req_pq_d1);
`endif



end

//----------------------------------------------------------------------------------------
// This section deals with the cpx to spc packets
//----------------------------------------------------------------------------------------
always @(posedge clk)
begin


`ifdef RTL_SPARC0
       if(cpx_spc0_data_vld & (cpx_spc0_type == `LOAD_RET) & cpx_spc0_data_cx2[129])
       begin
           atomic_ret0 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: atomic_ret0 = 1");
       end
       else if(cpx_spc0_data_vld & (cpx_spc0_type == `ST_ACK) & cpx_spc0_data_cx2[129])
       begin
           atomic_ret0 <= 1'b0;
           if(tso_mon_msg) $display("tso_mon: atomic_ret0 = 0");
       end

       if(atomic_ret0 & cpx_spc0_data_vld & ~(cpx_spc0_type == `ST_ACK))
       begin
           non_b2b_atomic_ret0 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: non_b2b_atomic_ret0");
       end
       else
          non_b2b_atomic_ret0 <= 1'b0;
`endif


`ifdef RTL_SPARC1
       if(cpx_spc1_data_vld & (cpx_spc1_type == `LOAD_RET) & cpx_spc1_data_cx2[129])
       begin
           atomic_ret1 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: atomic_ret1 = 1");
       end
       else if(cpx_spc1_data_vld & (cpx_spc1_type == `ST_ACK) & cpx_spc1_data_cx2[129])
       begin
           atomic_ret1 <= 1'b0;
           if(tso_mon_msg) $display("tso_mon: atomic_ret1 = 0");
       end

       if(atomic_ret1 & cpx_spc1_data_vld & ~(cpx_spc1_type == `ST_ACK))
       begin
           non_b2b_atomic_ret1 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: non_b2b_atomic_ret0");
       end
       else
          non_b2b_atomic_ret1 <= 1'b0;
`endif


`ifdef RTL_SPARC2
       if(cpx_spc2_data_vld & (cpx_spc2_type == `LOAD_RET) & cpx_spc2_data_cx2[129])
       begin
           atomic_ret2 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: atomic_ret2 = 1");
       end
       else if(cpx_spc2_data_vld & (cpx_spc2_type == `ST_ACK) & cpx_spc2_data_cx2[129])
       begin
           atomic_ret2 <= 1'b0;
           if(tso_mon_msg) $display("tso_mon: atomic_ret2 = 0");
       end

       if(atomic_ret2 & cpx_spc2_data_vld & ~(cpx_spc2_type == `ST_ACK))
       begin
           non_b2b_atomic_ret2 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: non_b2b_atomic_ret0");
       end
       else
          non_b2b_atomic_ret2 <= 1'b0;
`endif


`ifdef RTL_SPARC3
       if(cpx_spc3_data_vld & (cpx_spc3_type == `LOAD_RET) & cpx_spc3_data_cx2[129])
       begin
           atomic_ret3 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: atomic_ret3 = 1");
       end
       else if(cpx_spc3_data_vld & (cpx_spc3_type == `ST_ACK) & cpx_spc3_data_cx2[129])
       begin
           atomic_ret3 <= 1'b0;
           if(tso_mon_msg) $display("tso_mon: atomic_ret3 = 0");
       end

       if(atomic_ret3 & cpx_spc3_data_vld & ~(cpx_spc3_type == `ST_ACK))
       begin
           non_b2b_atomic_ret3 <= 1'b1;
           if(tso_mon_msg) $display("tso_mon: non_b2b_atomic_ret0");
       end
       else
          non_b2b_atomic_ret3 <= 1'b0;
`endif



end

always @(negedge clk)
begin
  if(rst_l)
  begin

`ifdef RTL_SPARC0
  if(cpx_spc0_data_vld)
    get_cpx_spc(cpx_spc0_type_str, cpx_spc0_type);
  if(tso_mon_msg)
    $display("%0d:Info cpx-to-spc%d packet TYPE= %s data= %x", $time, 0, cpx_spc0_type_str, cpx_spc0_data_cx2[127:0]);
`endif


`ifdef RTL_SPARC1
  if(cpx_spc1_data_vld)
    get_cpx_spc(cpx_spc1_type_str, cpx_spc1_type);
  if(tso_mon_msg)
    $display("%0d:Info cpx-to-spc%d packet TYPE= %s data= %x", $time, 1, cpx_spc1_type_str, cpx_spc1_data_cx2[127:0]);
`endif


`ifdef RTL_SPARC2
  if(cpx_spc2_data_vld)
    get_cpx_spc(cpx_spc2_type_str, cpx_spc2_type);
  if(tso_mon_msg)
    $display("%0d:Info cpx-to-spc%d packet TYPE= %s data= %x", $time, 2, cpx_spc2_type_str, cpx_spc2_data_cx2[127:0]);
`endif


`ifdef RTL_SPARC3
  if(cpx_spc3_data_vld)
    get_cpx_spc(cpx_spc3_type_str, cpx_spc3_type);
  if(tso_mon_msg)
    $display("%0d:Info cpx-to-spc%d packet TYPE= %s data= %x", $time, 3, cpx_spc3_type_str, cpx_spc3_data_cx2[127:0]);
`endif



  end // of rst_l
end

//============================================================================================
// LSU stuff
//============================================================================================

//============================================================================================
// Back to back invalidates and loads ...cores...
//============================================================================================

`ifdef RTL_SPARC0
`ifndef RTL_SPU
wire   C0T0_stb_ne    = |`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C0T1_stb_ne    = |`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C0T2_stb_ne    = |`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C0T3_stb_ne    = |`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C0T0_stb_nced  = |(   `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0] &
                ~`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C0T1_stb_nced  = |(   `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0] &
                ~`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C0T2_stb_nced  = |(   `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0] &
                ~`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C0T3_stb_nced  = |(   `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0] &
                ~`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc0_lsu_ifill_pkt_vld   = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc0_dfq_rd_advance          = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dfq_rd_advance;
wire   spc0_dfq_int_type        = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dfq_int_type;

wire   spc0_ifu_lsu_inv_clear   = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.ifu_lsu_inv_clear;

wire        spc0_dva_svld_e         = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dva_svld_e;
wire        spc0_dva_rvld_e     = `SPARC_CORE0.sparc0.lsu.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc0_dva_rd_addr_e      = `SPARC_CORE0.sparc0.lsu.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [`L1D_ADDRESS_HI-6:0]  spc0_dva_snp_addr_e     = `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dva_snp_addr_e[`L1D_ADDRESS_HI-6:0];

wire [4:0]  spc0_stb_data_rd_ptr    = `SPARC_CORE0.sparc0.lsu.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc0_stb_data_wr_ptr    = `SPARC_CORE0.sparc0.lsu.lsu.stb_data_wr_ptr[4:0];
wire        spc0_stb_data_wptr_vld  = `SPARC_CORE0.sparc0.lsu.lsu.stb_data_wptr_vld;
wire        spc0_stb_data_rptr_vld  = `SPARC_CORE0.sparc0.lsu.lsu.stb_data_rptr_vld;
wire        spc0_stbrwctl_flush_pipe_w = `SPARC_CORE0.sparc0.lsu.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc0_lsu_st_pcx_rq_pick     = |`SPARC_CORE0.sparc0.lsu.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [`L1D_WAY_ARRAY_MASK]  spc0_lsu_rd_dtag_parity_g = `SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_rd_dtag_parity_g[`L1D_WAY_ARRAY_MASK];
wire [`L1D_WAY_ARRAY_MASK]  spc0_dva_vld_g       = `SPARC_CORE0.sparc0.lsu.lsu.dctl.dva_vld_g[`L1D_WAY_ARRAY_MASK];

wire [3:0]  spc0_lsu_dc_tag_pe_g_unmasked    = spc0_lsu_rd_dtag_parity_g[3:0] & spc0_dva_vld_g[3:0];
wire        spc0_lsu_dc_tag_pe_g_unmasked_or = |spc0_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C0T0_stb_full  = &`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C0T1_stb_full  = &`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C0T2_stb_full  = &`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C0T3_stb_full  = &`SPARC_CORE0.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C0T0_stb_vld  = `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C0T1_stb_vld  = `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C0T2_stb_vld  = `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C0T3_stb_vld  = `SPARC_CORE0.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];
`else
wire   C0T0_stb_ne    = |`SPARC_CORE0.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C0T1_stb_ne    = |`SPARC_CORE0.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C0T2_stb_ne    = |`SPARC_CORE0.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C0T3_stb_ne    = |`SPARC_CORE0.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C0T0_stb_nced  = |(	 `SPARC_CORE0.sparc0.lsu.stb_ctl0.stb_state_vld[7:0] &
				~`SPARC_CORE0.sparc0.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C0T1_stb_nced  = |(	 `SPARC_CORE0.sparc0.lsu.stb_ctl1.stb_state_vld[7:0] &
				~`SPARC_CORE0.sparc0.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C0T2_stb_nced  = |(	 `SPARC_CORE0.sparc0.lsu.stb_ctl2.stb_state_vld[7:0] &
				~`SPARC_CORE0.sparc0.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C0T3_stb_nced  = |(	 `SPARC_CORE0.sparc0.lsu.stb_ctl3.stb_state_vld[7:0] &
				~`SPARC_CORE0.sparc0.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc0_lsu_ifill_pkt_vld	= `SPARC_CORE0.sparc0.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc0_dfq_rd_advance  		= `SPARC_CORE0.sparc0.lsu.qctl2.dfq_rd_advance;
wire   spc0_dfq_int_type  		= `SPARC_CORE0.sparc0.lsu.qctl2.dfq_int_type;

wire   spc0_ifu_lsu_inv_clear	= `SPARC_CORE0.sparc0.lsu.qctl2.ifu_lsu_inv_clear;

wire 	    spc0_dva_svld_e 	 	= `SPARC_CORE0.sparc0.lsu.qctl2.dva_svld_e;
wire 	    spc0_dva_rvld_e	 	= `SPARC_CORE0.sparc0.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc0_dva_rd_addr_e  	= `SPARC_CORE0.sparc0.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [4:0]  spc0_dva_snp_addr_e 	= `SPARC_CORE0.sparc0.lsu.qctl2.dva_snp_addr_e[4:0];

wire [4:0]  spc0_stb_data_rd_ptr   	= `SPARC_CORE0.sparc0.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc0_stb_data_wr_ptr   	= `SPARC_CORE0.sparc0.lsu.stb_data_wr_ptr[4:0];
wire        spc0_stb_data_wptr_vld 	= `SPARC_CORE0.sparc0.lsu.stb_data_wptr_vld;
wire        spc0_stb_data_rptr_vld 	= `SPARC_CORE0.sparc0.lsu.stb_data_rptr_vld;
wire        spc0_stbrwctl_flush_pipe_w = `SPARC_CORE0.sparc0.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc0_lsu_st_pcx_rq_pick 	= |`SPARC_CORE0.sparc0.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [3:0]  spc0_lsu_rd_dtag_parity_g = `SPARC_CORE0.sparc0.lsu.dctl.lsu_rd_dtag_parity_g[3:0];
wire [3:0]  spc0_dva_vld_g		 = `SPARC_CORE0.sparc0.lsu.dctl.dva_vld_g[3:0];

wire [3:0]  spc0_lsu_dc_tag_pe_g_unmasked    = spc0_lsu_rd_dtag_parity_g[3:0] & spc0_dva_vld_g[3:0];
wire        spc0_lsu_dc_tag_pe_g_unmasked_or = |spc0_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C0T0_stb_full  = &`SPARC_CORE0.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C0T1_stb_full  = &`SPARC_CORE0.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C0T2_stb_full  = &`SPARC_CORE0.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C0T3_stb_full  = &`SPARC_CORE0.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C0T0_stb_vld  = `SPARC_CORE0.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C0T1_stb_vld  = `SPARC_CORE0.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C0T2_stb_vld  = `SPARC_CORE0.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C0T3_stb_vld  = `SPARC_CORE0.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];
`endif

wire   [4:0] C0T0_stb_vld_sum  =  C0T0_stb_vld[0] +  C0T0_stb_vld[1] +  C0T0_stb_vld[2] +  C0T0_stb_vld[3] +
                                     C0T0_stb_vld[4] +  C0T0_stb_vld[5] +  C0T0_stb_vld[6] +  C0T0_stb_vld[7] ;
wire   [4:0] C0T1_stb_vld_sum  =  C0T1_stb_vld[0] +  C0T1_stb_vld[1] +  C0T1_stb_vld[2] +  C0T1_stb_vld[3] +
                                     C0T1_stb_vld[4] +  C0T1_stb_vld[5] +  C0T1_stb_vld[6] +  C0T1_stb_vld[7] ;
wire   [4:0] C0T2_stb_vld_sum  =  C0T2_stb_vld[0] +  C0T2_stb_vld[1] +  C0T2_stb_vld[2] +  C0T2_stb_vld[3] +
                                     C0T2_stb_vld[4] +  C0T2_stb_vld[5] +  C0T2_stb_vld[6] +  C0T2_stb_vld[7] ;
wire   [4:0] C0T3_stb_vld_sum  =  C0T3_stb_vld[0] +  C0T3_stb_vld[1] +  C0T3_stb_vld[2] +  C0T3_stb_vld[3] +
                                     C0T3_stb_vld[4] +  C0T3_stb_vld[5] +  C0T3_stb_vld[6] +  C0T3_stb_vld[7] ;

reg [4:0] C0T0_stb_vld_sum_d1;
reg [4:0] C0T1_stb_vld_sum_d1;
reg [4:0] C0T2_stb_vld_sum_d1;
reg [4:0] C0T3_stb_vld_sum_d1;

`ifndef RTL_SPU
wire   C0T0_st_ack  = &`SPARC_CORE0.sparc0.lsu.lsu.cpx_st_ack_tid0;
wire   C0T1_st_ack  = &`SPARC_CORE0.sparc0.lsu.lsu.cpx_st_ack_tid1;
wire   C0T2_st_ack  = &`SPARC_CORE0.sparc0.lsu.lsu.cpx_st_ack_tid2;
wire   C0T3_st_ack  = &`SPARC_CORE0.sparc0.lsu.lsu.cpx_st_ack_tid3;

wire   C0T0_defr_trp_en = &`SPARC_CORE0.sparc0.lsu.lsu.excpctl.st_defr_trp_en0;
wire   C0T1_defr_trp_en = &`SPARC_CORE0.sparc0.lsu.lsu.excpctl.st_defr_trp_en1;
wire   C0T2_defr_trp_en = &`SPARC_CORE0.sparc0.lsu.lsu.excpctl.st_defr_trp_en2;
wire   C0T3_defr_trp_en = &`SPARC_CORE0.sparc0.lsu.lsu.excpctl.st_defr_trp_en3;
`else
wire   C0T0_st_ack  = &`SPARC_CORE0.sparc0.lsu.cpx_st_ack_tid0;
wire   C0T1_st_ack  = &`SPARC_CORE0.sparc0.lsu.cpx_st_ack_tid1;
wire   C0T2_st_ack  = &`SPARC_CORE0.sparc0.lsu.cpx_st_ack_tid2;
wire   C0T3_st_ack  = &`SPARC_CORE0.sparc0.lsu.cpx_st_ack_tid3;

wire   C0T0_defr_trp_en	= &`SPARC_CORE0.sparc0.lsu.excpctl.st_defr_trp_en0;
wire   C0T1_defr_trp_en	= &`SPARC_CORE0.sparc0.lsu.excpctl.st_defr_trp_en1;
wire   C0T2_defr_trp_en	= &`SPARC_CORE0.sparc0.lsu.excpctl.st_defr_trp_en2;
wire   C0T3_defr_trp_en	= &`SPARC_CORE0.sparc0.lsu.excpctl.st_defr_trp_en3;
`endif

reg C0T0_defr_trp_en_d1;
reg C0T1_defr_trp_en_d1;
reg C0T2_defr_trp_en_d1;
reg C0T3_defr_trp_en_d1;

integer C0T0_stb_drain_cnt;
integer C0T1_stb_drain_cnt;
integer C0T2_stb_drain_cnt;
integer C0T3_stb_drain_cnt;

// Hits in the store buffer
//-------------------------
`ifndef RTL_SPU
wire       spc0_inst_vld_w      = `SPARC_CORE0.sparc0.ifu.ifu.fcl.inst_vld_w;
wire [1:0] spc0_sas_thrid_w     = `SPARC_CORE0.sparc0.ifu.ifu.fcl.sas_thrid_w[1:0];
`else
wire       spc0_inst_vld_w		= `SPARC_CORE0.sparc0.ifu.fcl.inst_vld_w;
wire [1:0] spc0_sas_thrid_w		= `SPARC_CORE0.sparc0.ifu.fcl.sas_thrid_w[1:0];
`endif

wire C0_st_ack_w = (spc0_sas_thrid_w == 2'b00) & C0T0_st_ack |
                      (spc0_sas_thrid_w == 2'b01) & C0T1_st_ack |
                      (spc0_sas_thrid_w == 2'b10) & C0T2_st_ack |
                      (spc0_sas_thrid_w == 2'b11) & C0T3_st_ack;

`ifndef RTL_SPU
wire [7:0] spc0_stb_ld_full_raw = `SPARC_CORE0.sparc0.lsu.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc0_stb_ld_partial_raw  = `SPARC_CORE0.sparc0.lsu.lsu.stb_ld_partial_raw[7:0];
wire       spc0_stb_cam_mhit        = `SPARC_CORE0.sparc0.lsu.lsu.stb_cam_mhit;
wire       spc0_stb_cam_hit     = `SPARC_CORE0.sparc0.lsu.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc0_lsu_way_hit     = `SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc0_lsu_ifu_ldst_miss_w = `SPARC_CORE0.sparc0.lsu.lsu.lsu_ifu_ldst_miss_w;
wire       spc0_ld_inst_vld_g   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.ld_inst_vld_g;
wire       spc0_ldst_dbl_g      = `SPARC_CORE0.sparc0.lsu.lsu.dctl.ldst_dbl_g;
wire       spc0_quad_asi_g      = `SPARC_CORE0.sparc0.lsu.lsu.dctl.quad_asi_g;
wire [1:0] spc0_ldst_sz_g       = `SPARC_CORE0.sparc0.lsu.lsu.dctl.ldst_sz_g;
wire       spc0_lsu_alt_space_g = `SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_alt_space_g;

wire       spc0_mbar_inst0_g        = `SPARC_CORE0.sparc0.lsu.lsu.dctl.mbar_inst0_g;
wire       spc0_mbar_inst1_g        = `SPARC_CORE0.sparc0.lsu.lsu.dctl.mbar_inst1_g;
wire       spc0_mbar_inst2_g        = `SPARC_CORE0.sparc0.lsu.lsu.dctl.mbar_inst2_g;
wire       spc0_mbar_inst3_g        = `SPARC_CORE0.sparc0.lsu.lsu.dctl.mbar_inst3_g;

wire       spc0_flush_inst0_g   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.flush_inst0_g;
wire       spc0_flush_inst1_g   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.flush_inst1_g;
wire       spc0_flush_inst2_g   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.flush_inst2_g;
wire       spc0_flush_inst3_g   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.flush_inst3_g;

wire       spc0_intrpt_disp_asi0_g  = `SPARC_CORE0.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b00);
wire       spc0_intrpt_disp_asi1_g  = `SPARC_CORE0.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b01);
wire       spc0_intrpt_disp_asi2_g  = `SPARC_CORE0.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b10);
wire       spc0_intrpt_disp_asi3_g  = `SPARC_CORE0.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b11);

wire       spc0_st_inst_vld_g   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.st_inst_vld_g;
wire       spc0_non_altspace_ldst_g = `SPARC_CORE0.sparc0.lsu.lsu.dctl.non_altspace_ldst_g;

wire       spc0_dctl_flush_pipe_w   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc0_no_spc_rmo_st   = `SPARC_CORE0.sparc0.lsu.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc0_ldst_fp_e       = `SPARC_CORE0.sparc0.lsu.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc0_stb_rdptr       = `SPARC_CORE0.sparc0.lsu.lsu.stb_rwctl.stb_rdptr_l;

wire       spc0_ld_l2cache_req  = `SPARC_CORE0.sparc0.lsu.lsu.qctl1.ld3_l2cache_rq |
                      `SPARC_CORE0.sparc0.lsu.lsu.qctl1.ld2_l2cache_rq |
                              `SPARC_CORE0.sparc0.lsu.lsu.qctl1.ld1_l2cache_rq |
                      `SPARC_CORE0.sparc0.lsu.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc0_dcache_enable   = {`SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_ctl_reg0[1],
                                           `SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_ctl_reg1[1],
                       `SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_ctl_reg2[1],
                       `SPARC_CORE0.sparc0.lsu.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc0_icache_enable   = `SPARC_CORE0.sparc0.lsu.lsu.lsu_ifu_icache_en[3:0];

wire spc0_dc_direct_map         = `SPARC_CORE0.sparc0.lsu.lsu.dc_direct_map;
wire spc0_lsu_ifu_direct_map_l1 = `SPARC_CORE0.sparc0.lsu.lsu.lsu_ifu_direct_map_l1;
`else
wire [7:0] spc0_stb_ld_full_raw	= `SPARC_CORE0.sparc0.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc0_stb_ld_partial_raw	= `SPARC_CORE0.sparc0.lsu.stb_ld_partial_raw[7:0];
wire       spc0_stb_cam_mhit		= `SPARC_CORE0.sparc0.lsu.stb_cam_mhit;
wire       spc0_stb_cam_hit		= `SPARC_CORE0.sparc0.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc0_lsu_way_hit		= `SPARC_CORE0.sparc0.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc0_lsu_ifu_ldst_miss_w	= `SPARC_CORE0.sparc0.lsu.lsu_ifu_ldst_miss_w;
wire       spc0_ld_inst_vld_g	= `SPARC_CORE0.sparc0.lsu.dctl.ld_inst_vld_g;
wire       spc0_ldst_dbl_g		= `SPARC_CORE0.sparc0.lsu.dctl.ldst_dbl_g;
wire       spc0_quad_asi_g		= `SPARC_CORE0.sparc0.lsu.dctl.quad_asi_g;
wire [1:0] spc0_ldst_sz_g		= `SPARC_CORE0.sparc0.lsu.dctl.ldst_sz_g;
wire       spc0_lsu_alt_space_g	= `SPARC_CORE0.sparc0.lsu.dctl.lsu_alt_space_g;

wire       spc0_mbar_inst0_g		= `SPARC_CORE0.sparc0.lsu.dctl.mbar_inst0_g;
wire       spc0_mbar_inst1_g		= `SPARC_CORE0.sparc0.lsu.dctl.mbar_inst1_g;
wire       spc0_mbar_inst2_g		= `SPARC_CORE0.sparc0.lsu.dctl.mbar_inst2_g;
wire       spc0_mbar_inst3_g		= `SPARC_CORE0.sparc0.lsu.dctl.mbar_inst3_g;

wire       spc0_flush_inst0_g	= `SPARC_CORE0.sparc0.lsu.dctl.flush_inst0_g;
wire       spc0_flush_inst1_g	= `SPARC_CORE0.sparc0.lsu.dctl.flush_inst1_g;
wire       spc0_flush_inst2_g	= `SPARC_CORE0.sparc0.lsu.dctl.flush_inst2_g;
wire       spc0_flush_inst3_g	= `SPARC_CORE0.sparc0.lsu.dctl.flush_inst3_g;

wire       spc0_intrpt_disp_asi0_g	= `SPARC_CORE0.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b00);
wire       spc0_intrpt_disp_asi1_g	= `SPARC_CORE0.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b01);
wire       spc0_intrpt_disp_asi2_g	= `SPARC_CORE0.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b10);
wire       spc0_intrpt_disp_asi3_g	= `SPARC_CORE0.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc0_sas_thrid_w == 2'b11);

wire       spc0_st_inst_vld_g	= `SPARC_CORE0.sparc0.lsu.dctl.st_inst_vld_g;
wire       spc0_non_altspace_ldst_g	= `SPARC_CORE0.sparc0.lsu.dctl.non_altspace_ldst_g;

wire       spc0_dctl_flush_pipe_w	= `SPARC_CORE0.sparc0.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc0_no_spc_rmo_st	= `SPARC_CORE0.sparc0.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc0_ldst_fp_e		= `SPARC_CORE0.sparc0.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc0_stb_rdptr		= `SPARC_CORE0.sparc0.lsu.stb_rwctl.stb_rdptr_l;

wire 	   spc0_ld_l2cache_req 	= `SPARC_CORE0.sparc0.lsu.qctl1.ld3_l2cache_rq |
					  `SPARC_CORE0.sparc0.lsu.qctl1.ld2_l2cache_rq |
                 			  `SPARC_CORE0.sparc0.lsu.qctl1.ld1_l2cache_rq |
					  `SPARC_CORE0.sparc0.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc0_dcache_enable	= {`SPARC_CORE0.sparc0.lsu.dctl.lsu_ctl_reg0[1],
                                    	   `SPARC_CORE0.sparc0.lsu.dctl.lsu_ctl_reg1[1],
					   `SPARC_CORE0.sparc0.lsu.dctl.lsu_ctl_reg2[1],
					   `SPARC_CORE0.sparc0.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc0_icache_enable	= `SPARC_CORE0.sparc0.lsu.lsu_ifu_icache_en[3:0];

wire spc0_dc_direct_map 		= `SPARC_CORE0.sparc0.lsu.dc_direct_map;
wire spc0_lsu_ifu_direct_map_l1	= `SPARC_CORE0.sparc0.lsu.lsu_ifu_direct_map_l1;
`endif

always @(spc0_dcache_enable)
    $display("%0d tso_mon: spc0_dcache_enable changed to %x", $time, spc0_dcache_enable);

always @(spc0_icache_enable)
    $display("%0d tso_mon: spc0_icache_enable changed to %x", $time, spc0_icache_enable);

always @(spc0_dc_direct_map)
    $display("%0d tso_mon: spc0_dc_direct_map changed to %x", $time, spc0_dc_direct_map);

always @(spc0_lsu_ifu_direct_map_l1)
   $display("%0d tso_mon: spc0_lsu_ifu_direct_map_l1 changed to %x", $time, spc0_lsu_ifu_direct_map_l1);

reg 		spc0_dva_svld_e_d1;
reg 		spc0_dva_rvld_e_d1;
reg [`L1D_ADDRESS_HI:4] 	spc0_dva_rd_addr_e_d1;
reg [4:0]  	spc0_dva_snp_addr_e_d1;

reg   		spc0_lsu_snp_after_rd;
reg   		spc0_lsu_rd_after_snp;

reg 	   	spc0_ldst_fp_m, spc0_ldst_fp_g;

integer 	spc0_multiple_hits;

reg spc0_skid_d1, spc0_skid_d2, spc0_skid_d3;
initial begin
  spc0_skid_d1 = 0;
  spc0_skid_d2 = 0;
  spc0_skid_d3 = 0;
end

always @(posedge clk)
begin

  spc0_skid_d1 <= (~spc0_ifu_lsu_inv_clear & spc0_dfq_rd_advance & spc0_dfq_int_type);
  spc0_skid_d2 <= spc0_skid_d1 & ~spc0_ifu_lsu_inv_clear;
  spc0_skid_d3 <= spc0_skid_d2 & ~spc0_ifu_lsu_inv_clear;

// The full tracking of this condition is complicated since after the interrupt is advanced
// there may be more invalidations to the IFQ.
// All we care about is that the invalidations BEFORE the interrupt are finished.
// I provided a command line argument to disable this check.
  if(spc0_skid_d3 & enable_ifu_lsu_inv_clear)
     finish_test("spc", "tso_mon:   spc0_ifu_lsu_inv_clear should have been clear by now", 0);

  spc0_dva_svld_e_d1 	<= spc0_dva_svld_e;
  spc0_dva_rvld_e_d1 	<= spc0_dva_rvld_e;
  spc0_dva_rd_addr_e_d1 	<= spc0_dva_rd_addr_e;
  spc0_dva_snp_addr_e_d1 	<= spc0_dva_snp_addr_e;

  if(spc0_dva_svld_e_d1 & spc0_dva_rvld_e & (spc0_dva_rd_addr_e_d1[`L1D_ADDRESS_HI:6] == spc0_dva_snp_addr_e[4:0]))
    spc0_lsu_rd_after_snp <= 1'b1;
  else
    spc0_lsu_rd_after_snp <= 1'b0;

  if(spc0_dva_svld_e & spc0_dva_rvld_e_d1 & (spc0_dva_rd_addr_e[`L1D_ADDRESS_HI:6] == spc0_dva_snp_addr_e_d1[4:0]))
    spc0_lsu_snp_after_rd <= 1'b1;
  else
    spc0_lsu_snp_after_rd <= 1'b0;

  spc0_ldst_fp_m <= spc0_ldst_fp_e;
  spc0_ldst_fp_g <= spc0_ldst_fp_m;

  if(spc0_stb_data_rptr_vld & spc0_stb_data_wptr_vld & ~spc0_stbrwctl_flush_pipe_w &
     (spc0_stb_data_rd_ptr == spc0_stb_data_wr_ptr) & spc0_lsu_st_pcx_rq_pick)
  begin
    finish_test("spc", "tso_mon: LSU stb data write and read in the same cycle", 0);
  end

   spc0_multiple_hits = (spc0_lsu_way_hit[3] + spc0_lsu_way_hit[2] + spc0_lsu_way_hit[1] + spc0_lsu_way_hit[0]);
   if(!spc0_lsu_ifu_ldst_miss_w && (spc0_multiple_hits >1) && spc0_inst_vld_w && !spc0_dctl_flush_pipe_w && !spc0_lsu_dc_tag_pe_g_unmasked_or)
     finish_test("spc", "tso_mon: LSU multiple hits ", 0);
end

wire spc0_ld_dbl      = spc0_ld_inst_vld_g &  spc0_ldst_dbl_g &  ~spc0_quad_asi_g;
wire spc0_ld_quad     = spc0_ld_inst_vld_g &  spc0_ldst_dbl_g &  spc0_quad_asi_g;
wire spc0_ld_other    = spc0_ld_inst_vld_g & ~spc0_ldst_dbl_g;

wire spc0_ld_dbl_fp   = spc0_ld_dbl        &  spc0_ldst_fp_g;
wire spc0_ld_other_fp = spc0_ld_other      &  spc0_ldst_fp_g;

wire spc0_ld_dbl_int  = spc0_ld_dbl        & ~spc0_ldst_fp_g;
wire spc0_ld_quad_int = spc0_ld_quad       & ~spc0_ldst_fp_g;
wire spc0_ld_other_int= spc0_ld_other      & ~spc0_ldst_fp_g;

wire spc0_ld_bypassok_hit = |spc0_stb_ld_full_raw[7:0] & ~spc0_stb_cam_mhit;
wire spc0_ld_partial_hit  = |spc0_stb_ld_partial_raw[7:0] & ~spc0_stb_cam_mhit;
wire spc0_ld_multiple_hit =  spc0_stb_cam_mhit;

wire spc0_any_lsu_way_hit = |spc0_lsu_way_hit;

wire [7:0] spc0_stb_rdptr_decoded = 	(spc0_stb_rdptr ==3'b000) ? 8'b00000001 :
                               		(spc0_stb_rdptr ==3'b001) ? 8'b00000010 :
                               		(spc0_stb_rdptr ==3'b010) ? 8'b00000100 :
                              		(spc0_stb_rdptr ==3'b011) ? 8'b00001000 :
                              		(spc0_stb_rdptr ==3'b100) ? 8'b00010000 :
                              		(spc0_stb_rdptr ==3'b101) ? 8'b00100000 :
                             		(spc0_stb_rdptr ==3'b110) ? 8'b01000000 :
                              		(spc0_stb_rdptr ==3'b111) ? 8'b10000000 : 8'h00;


wire spc0_stb_top_hit = |(spc0_stb_rdptr_decoded & (spc0_stb_ld_full_raw | spc0_stb_ld_partial_raw));

//---------------------------------------------------------------------
// ld_type[4:0] hit_type[2:0], cache_hit, hit_top
// this is passed to the coverage monitor.
//---------------------------------------------------------------------
wire [10:0] spc0_stb_ld_hit_info =
	{spc0_ld_dbl_fp,        spc0_ld_other_fp,
	 spc0_ld_dbl_int, 	   spc0_ld_quad_int,    spc0_ld_other_int,
	 spc0_ld_bypassok_hit,  spc0_ld_partial_hit, spc0_ld_multiple_hit,
	 spc0_any_lsu_way_hit,
	 spc0_stb_top_hit, C0_st_ack_w};

reg spc0_mbar0_active;
reg spc0_mbar1_active;
reg spc0_mbar2_active;
reg spc0_mbar3_active;

reg spc0_flush0_active;
reg spc0_flush1_active;
reg spc0_flush2_active;
reg spc0_flush3_active;

reg spc0_intr0_active;
reg spc0_intr1_active;
reg spc0_intr2_active;
reg spc0_intr3_active;

always @(negedge clk)
begin
  if(~rst_l)
  begin
     spc0_mbar0_active <= 1'b0;
     spc0_mbar1_active <= 1'b0;
     spc0_mbar2_active <= 1'b0;
     spc0_mbar3_active <= 1'b0;

     spc0_flush0_active <= 1'b0;
     spc0_flush1_active <= 1'b0;
     spc0_flush2_active <= 1'b0;
     spc0_flush3_active <= 1'b0;

     spc0_intr0_active <= 1'b0;
     spc0_intr1_active <= 1'b0;
     spc0_intr2_active <= 1'b0;
     spc0_intr3_active <= 1'b0;

  end
  else
  begin
    if(spc0_mbar_inst0_g & ~spc0_dctl_flush_pipe_w & (C0T0_stb_ne|~spc0_no_spc_rmo_st[0]))
	spc0_mbar0_active <= 1'b1;
    else if(~C0T0_stb_ne & spc0_no_spc_rmo_st[0])
	spc0_mbar0_active <= 1'b0;
    if(spc0_mbar_inst1_g & ~ spc0_dctl_flush_pipe_w & (C0T1_stb_ne|~spc0_no_spc_rmo_st[1]))
	spc0_mbar1_active <= 1'b1;
    else if(~C0T1_stb_ne & spc0_no_spc_rmo_st[1])
	spc0_mbar1_active <= 1'b0;
    if(spc0_mbar_inst2_g & ~ spc0_dctl_flush_pipe_w & (C0T2_stb_ne|~spc0_no_spc_rmo_st[2]))
	spc0_mbar2_active <= 1'b1;
    else if(~C0T2_stb_ne & spc0_no_spc_rmo_st[2])
	spc0_mbar2_active <= 1'b0;
    if(spc0_mbar_inst3_g & ~ spc0_dctl_flush_pipe_w & (C0T3_stb_ne|~spc0_no_spc_rmo_st[3]))
	spc0_mbar3_active <= 1'b1;
    else if(~C0T3_stb_ne & spc0_no_spc_rmo_st[3])
	spc0_mbar3_active <= 1'b0;

    if(spc0_flush_inst0_g & ~spc0_dctl_flush_pipe_w & C0T0_stb_ne) 	spc0_flush0_active <= 1'b1;
    else if(~C0T0_stb_ne)			  				spc0_flush0_active <= 1'b0;
    if(spc0_flush_inst1_g & ~spc0_dctl_flush_pipe_w & C0T1_stb_ne) 	spc0_flush1_active <= 1'b1;
    else if(~C0T1_stb_ne)			  				spc0_flush1_active <= 1'b0;
    if(spc0_flush_inst2_g & ~spc0_dctl_flush_pipe_w & C0T2_stb_ne) 	spc0_flush2_active <= 1'b1;
    else if(~C0T2_stb_ne)			  				spc0_flush2_active <= 1'b0;
    if(spc0_flush_inst3_g & ~spc0_dctl_flush_pipe_w & C0T3_stb_ne) 	spc0_flush3_active <= 1'b1;
    else if(~C0T3_stb_ne)			  				spc0_flush3_active <= 1'b0;

    if(spc0_intrpt_disp_asi0_g & spc0_st_inst_vld_g & ~spc0_non_altspace_ldst_g & ~spc0_dctl_flush_pipe_w & C0T0_stb_ne)
	spc0_intr0_active <= 1'b1;
    else if(~C0T0_stb_ne)
	spc0_intr0_active <= 1'b0;
    if(spc0_intrpt_disp_asi1_g &  spc0_st_inst_vld_g & ~spc0_non_altspace_ldst_g & ~spc0_dctl_flush_pipe_w & C0T1_stb_ne)
	spc0_intr1_active <= 1'b1;
    else if(~C0T1_stb_ne)
	spc0_intr1_active <= 1'b0;
    if(spc0_intrpt_disp_asi2_g &  spc0_st_inst_vld_g & ~spc0_non_altspace_ldst_g & ~spc0_dctl_flush_pipe_w & C0T2_stb_ne)
	spc0_intr2_active <= 1'b1;
    else if(~C0T2_stb_ne)
	spc0_intr2_active <= 1'b0;
    if(spc0_intrpt_disp_asi3_g &  spc0_st_inst_vld_g & ~spc0_non_altspace_ldst_g & ~spc0_dctl_flush_pipe_w & C0T3_stb_ne)
	spc0_intr3_active <= 1'b1;
    else if(~C0T3_stb_ne)
	spc0_intr3_active <= 1'b0;
  end

  if(spc0_mbar0_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "membar violation thread 0", 0);
  if(spc0_mbar1_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "membar violation thread 1", 0);
  if(spc0_mbar2_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "membar violation thread 2", 0);
  if(spc0_mbar3_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "membar violation thread 3", 0);

  if(spc0_flush0_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "flush violation thread 0", 0);
  if(spc0_flush1_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "flush violation thread 1", 0);
  if(spc0_flush2_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "flush violation thread 2", 0);
  if(spc0_flush3_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "flush violation thread 3", 0);

  if(spc0_intr0_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "intr violation thread 0", 0);
  if(spc0_intr1_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "intr violation thread 1", 0);
  if(spc0_intr2_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "intr violation thread 2", 0);
  if(spc0_intr3_active & spc0_inst_vld_w & spc0_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "intr violation thread 3", 0);

   else							C0T0_stb_drain_cnt = C0T0_stb_drain_cnt + 1;
   if(C0T0_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 0 is not draining", 0);

   else							C0T1_stb_drain_cnt = C0T1_stb_drain_cnt + 1;
   if(C0T1_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 1 is not draining", 0);

   else							C0T2_stb_drain_cnt = C0T2_stb_drain_cnt + 1;
   if(C0T2_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 2 is not draining", 0);

   else							C0T3_stb_drain_cnt = C0T3_stb_drain_cnt + 1;
   if(C0T3_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 3 is not draining", 0);

  C0T0_stb_vld_sum_d1 <= C0T0_stb_vld_sum;
  C0T1_stb_vld_sum_d1 <= C0T1_stb_vld_sum;
  C0T2_stb_vld_sum_d1 <= C0T2_stb_vld_sum;
  C0T3_stb_vld_sum_d1 <= C0T3_stb_vld_sum;
  C0T0_defr_trp_en_d1 <= C0T0_defr_trp_en;
  C0T1_defr_trp_en_d1 <= C0T1_defr_trp_en;
  C0T2_defr_trp_en_d1 <= C0T2_defr_trp_en;
  C0T3_defr_trp_en_d1 <= C0T3_defr_trp_en;

  if(rst_l & C0T0_defr_trp_en_d1 & (C0T0_stb_vld_sum_d1 < C0T0_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T0", 0);
  if(rst_l & C0T1_defr_trp_en_d1 & (C0T1_stb_vld_sum_d1 < C0T1_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T1", 0);
  if(rst_l & C0T2_defr_trp_en_d1 & (C0T2_stb_vld_sum_d1 < C0T2_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T2", 0);
  if(rst_l & C0T3_defr_trp_en_d1 & (C0T3_stb_vld_sum_d1 < C0T3_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T3", 0);

end
`endif



`ifdef RTL_SPARC1
`ifndef RTL_SPU
wire   C1T0_stb_ne    = |`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C1T1_stb_ne    = |`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C1T2_stb_ne    = |`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C1T3_stb_ne    = |`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C1T0_stb_nced  = |(   `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0] &
                ~`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C1T1_stb_nced  = |(   `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0] &
                ~`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C1T2_stb_nced  = |(   `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0] &
                ~`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C1T3_stb_nced  = |(   `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0] &
                ~`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc1_lsu_ifill_pkt_vld   = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc1_dfq_rd_advance          = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dfq_rd_advance;
wire   spc1_dfq_int_type        = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dfq_int_type;

wire   spc1_ifu_lsu_inv_clear   = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.ifu_lsu_inv_clear;

wire        spc1_dva_svld_e         = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dva_svld_e;
wire        spc1_dva_rvld_e     = `SPARC_CORE1.sparc0.lsu.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc1_dva_rd_addr_e      = `SPARC_CORE1.sparc0.lsu.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [`L1D_ADDRESS_HI-6:0]  spc1_dva_snp_addr_e     = `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dva_snp_addr_e[`L1D_ADDRESS_HI-6:0];

wire [4:0]  spc1_stb_data_rd_ptr    = `SPARC_CORE1.sparc0.lsu.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc1_stb_data_wr_ptr    = `SPARC_CORE1.sparc0.lsu.lsu.stb_data_wr_ptr[4:0];
wire        spc1_stb_data_wptr_vld  = `SPARC_CORE1.sparc0.lsu.lsu.stb_data_wptr_vld;
wire        spc1_stb_data_rptr_vld  = `SPARC_CORE1.sparc0.lsu.lsu.stb_data_rptr_vld;
wire        spc1_stbrwctl_flush_pipe_w = `SPARC_CORE1.sparc0.lsu.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc1_lsu_st_pcx_rq_pick     = |`SPARC_CORE1.sparc0.lsu.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [`L1D_WAY_ARRAY_MASK]  spc1_lsu_rd_dtag_parity_g = `SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_rd_dtag_parity_g[`L1D_WAY_ARRAY_MASK];
wire [`L1D_WAY_ARRAY_MASK]  spc1_dva_vld_g       = `SPARC_CORE1.sparc0.lsu.lsu.dctl.dva_vld_g[`L1D_WAY_ARRAY_MASK];

wire [3:0]  spc1_lsu_dc_tag_pe_g_unmasked    = spc1_lsu_rd_dtag_parity_g[3:0] & spc1_dva_vld_g[3:0];
wire        spc1_lsu_dc_tag_pe_g_unmasked_or = |spc1_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C1T0_stb_full  = &`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C1T1_stb_full  = &`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C1T2_stb_full  = &`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C1T3_stb_full  = &`SPARC_CORE1.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C1T0_stb_vld  = `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C1T1_stb_vld  = `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C1T2_stb_vld  = `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C1T3_stb_vld  = `SPARC_CORE1.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];
`else
wire   C1T0_stb_ne    = |`SPARC_CORE1.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C1T1_stb_ne    = |`SPARC_CORE1.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C1T2_stb_ne    = |`SPARC_CORE1.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C1T3_stb_ne    = |`SPARC_CORE1.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C1T0_stb_nced  = |(	 `SPARC_CORE1.sparc0.lsu.stb_ctl0.stb_state_vld[7:0] &
				~`SPARC_CORE1.sparc0.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C1T1_stb_nced  = |(	 `SPARC_CORE1.sparc0.lsu.stb_ctl1.stb_state_vld[7:0] &
				~`SPARC_CORE1.sparc0.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C1T2_stb_nced  = |(	 `SPARC_CORE1.sparc0.lsu.stb_ctl2.stb_state_vld[7:0] &
				~`SPARC_CORE1.sparc0.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C1T3_stb_nced  = |(	 `SPARC_CORE1.sparc0.lsu.stb_ctl3.stb_state_vld[7:0] &
				~`SPARC_CORE1.sparc0.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc1_lsu_ifill_pkt_vld	= `SPARC_CORE1.sparc0.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc1_dfq_rd_advance  		= `SPARC_CORE1.sparc0.lsu.qctl2.dfq_rd_advance;
wire   spc1_dfq_int_type  		= `SPARC_CORE1.sparc0.lsu.qctl2.dfq_int_type;

wire   spc1_ifu_lsu_inv_clear	= `SPARC_CORE1.sparc0.lsu.qctl2.ifu_lsu_inv_clear;

wire 	    spc1_dva_svld_e 	 	= `SPARC_CORE1.sparc0.lsu.qctl2.dva_svld_e;
wire 	    spc1_dva_rvld_e	 	= `SPARC_CORE1.sparc0.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc1_dva_rd_addr_e  	= `SPARC_CORE1.sparc0.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [4:0]  spc1_dva_snp_addr_e 	= `SPARC_CORE1.sparc0.lsu.qctl2.dva_snp_addr_e[4:0];

wire [4:0]  spc1_stb_data_rd_ptr   	= `SPARC_CORE1.sparc0.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc1_stb_data_wr_ptr   	= `SPARC_CORE1.sparc0.lsu.stb_data_wr_ptr[4:0];
wire        spc1_stb_data_wptr_vld 	= `SPARC_CORE1.sparc0.lsu.stb_data_wptr_vld;
wire        spc1_stb_data_rptr_vld 	= `SPARC_CORE1.sparc0.lsu.stb_data_rptr_vld;
wire        spc1_stbrwctl_flush_pipe_w = `SPARC_CORE1.sparc0.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc1_lsu_st_pcx_rq_pick 	= |`SPARC_CORE1.sparc0.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [3:0]  spc1_lsu_rd_dtag_parity_g = `SPARC_CORE1.sparc0.lsu.dctl.lsu_rd_dtag_parity_g[3:0];
wire [3:0]  spc1_dva_vld_g		 = `SPARC_CORE1.sparc0.lsu.dctl.dva_vld_g[3:0];

wire [3:0]  spc1_lsu_dc_tag_pe_g_unmasked    = spc1_lsu_rd_dtag_parity_g[3:0] & spc1_dva_vld_g[3:0];
wire        spc1_lsu_dc_tag_pe_g_unmasked_or = |spc1_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C1T0_stb_full  = &`SPARC_CORE1.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C1T1_stb_full  = &`SPARC_CORE1.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C1T2_stb_full  = &`SPARC_CORE1.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C1T3_stb_full  = &`SPARC_CORE1.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C1T0_stb_vld  = `SPARC_CORE1.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C1T1_stb_vld  = `SPARC_CORE1.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C1T2_stb_vld  = `SPARC_CORE1.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C1T3_stb_vld  = `SPARC_CORE1.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];
`endif

wire   [4:0] C1T0_stb_vld_sum  =  C1T0_stb_vld[0] +  C1T0_stb_vld[1] +  C1T0_stb_vld[2] +  C1T0_stb_vld[3] +
                                     C1T0_stb_vld[4] +  C1T0_stb_vld[5] +  C1T0_stb_vld[6] +  C1T0_stb_vld[7] ;
wire   [4:0] C1T1_stb_vld_sum  =  C1T1_stb_vld[0] +  C1T1_stb_vld[1] +  C1T1_stb_vld[2] +  C1T1_stb_vld[3] +
                                     C1T1_stb_vld[4] +  C1T1_stb_vld[5] +  C1T1_stb_vld[6] +  C1T1_stb_vld[7] ;
wire   [4:0] C1T2_stb_vld_sum  =  C1T2_stb_vld[0] +  C1T2_stb_vld[1] +  C1T2_stb_vld[2] +  C1T2_stb_vld[3] +
                                     C1T2_stb_vld[4] +  C1T2_stb_vld[5] +  C1T2_stb_vld[6] +  C1T2_stb_vld[7] ;
wire   [4:0] C1T3_stb_vld_sum  =  C1T3_stb_vld[0] +  C1T3_stb_vld[1] +  C1T3_stb_vld[2] +  C1T3_stb_vld[3] +
                                     C1T3_stb_vld[4] +  C1T3_stb_vld[5] +  C1T3_stb_vld[6] +  C1T3_stb_vld[7] ;

reg [4:0] C1T0_stb_vld_sum_d1;
reg [4:0] C1T1_stb_vld_sum_d1;
reg [4:0] C1T2_stb_vld_sum_d1;
reg [4:0] C1T3_stb_vld_sum_d1;

`ifndef RTL_SPU
wire   C1T0_st_ack  = &`SPARC_CORE1.sparc0.lsu.lsu.cpx_st_ack_tid0;
wire   C1T1_st_ack  = &`SPARC_CORE1.sparc0.lsu.lsu.cpx_st_ack_tid1;
wire   C1T2_st_ack  = &`SPARC_CORE1.sparc0.lsu.lsu.cpx_st_ack_tid2;
wire   C1T3_st_ack  = &`SPARC_CORE1.sparc0.lsu.lsu.cpx_st_ack_tid3;

wire   C1T0_defr_trp_en = &`SPARC_CORE1.sparc0.lsu.lsu.excpctl.st_defr_trp_en0;
wire   C1T1_defr_trp_en = &`SPARC_CORE1.sparc0.lsu.lsu.excpctl.st_defr_trp_en1;
wire   C1T2_defr_trp_en = &`SPARC_CORE1.sparc0.lsu.lsu.excpctl.st_defr_trp_en2;
wire   C1T3_defr_trp_en = &`SPARC_CORE1.sparc0.lsu.lsu.excpctl.st_defr_trp_en3;
`else
wire   C1T0_st_ack  = &`SPARC_CORE1.sparc0.lsu.cpx_st_ack_tid0;
wire   C1T1_st_ack  = &`SPARC_CORE1.sparc0.lsu.cpx_st_ack_tid1;
wire   C1T2_st_ack  = &`SPARC_CORE1.sparc0.lsu.cpx_st_ack_tid2;
wire   C1T3_st_ack  = &`SPARC_CORE1.sparc0.lsu.cpx_st_ack_tid3;

wire   C1T0_defr_trp_en	= &`SPARC_CORE1.sparc0.lsu.excpctl.st_defr_trp_en0;
wire   C1T1_defr_trp_en	= &`SPARC_CORE1.sparc0.lsu.excpctl.st_defr_trp_en1;
wire   C1T2_defr_trp_en	= &`SPARC_CORE1.sparc0.lsu.excpctl.st_defr_trp_en2;
wire   C1T3_defr_trp_en	= &`SPARC_CORE1.sparc0.lsu.excpctl.st_defr_trp_en3;
`endif

reg C1T0_defr_trp_en_d1;
reg C1T1_defr_trp_en_d1;
reg C1T2_defr_trp_en_d1;
reg C1T3_defr_trp_en_d1;

integer C1T0_stb_drain_cnt;
integer C1T1_stb_drain_cnt;
integer C1T2_stb_drain_cnt;
integer C1T3_stb_drain_cnt;

// Hits in the store buffer
//-------------------------
`ifndef RTL_SPU
wire       spc1_inst_vld_w      = `SPARC_CORE1.sparc0.ifu.ifu.fcl.inst_vld_w;
wire [1:0] spc1_sas_thrid_w     = `SPARC_CORE1.sparc0.ifu.ifu.fcl.sas_thrid_w[1:0];
`else
wire       spc1_inst_vld_w		= `SPARC_CORE1.sparc0.ifu.fcl.inst_vld_w;
wire [1:0] spc1_sas_thrid_w		= `SPARC_CORE1.sparc0.ifu.fcl.sas_thrid_w[1:0];
`endif

wire C1_st_ack_w = (spc1_sas_thrid_w == 2'b00) & C1T0_st_ack |
                      (spc1_sas_thrid_w == 2'b01) & C1T1_st_ack |
                      (spc1_sas_thrid_w == 2'b10) & C1T2_st_ack |
                      (spc1_sas_thrid_w == 2'b11) & C1T3_st_ack;

`ifndef RTL_SPU
wire [7:0] spc1_stb_ld_full_raw = `SPARC_CORE1.sparc0.lsu.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc1_stb_ld_partial_raw  = `SPARC_CORE1.sparc0.lsu.lsu.stb_ld_partial_raw[7:0];
wire       spc1_stb_cam_mhit        = `SPARC_CORE1.sparc0.lsu.lsu.stb_cam_mhit;
wire       spc1_stb_cam_hit     = `SPARC_CORE1.sparc0.lsu.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc1_lsu_way_hit     = `SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc1_lsu_ifu_ldst_miss_w = `SPARC_CORE1.sparc0.lsu.lsu.lsu_ifu_ldst_miss_w;
wire       spc1_ld_inst_vld_g   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.ld_inst_vld_g;
wire       spc1_ldst_dbl_g      = `SPARC_CORE1.sparc0.lsu.lsu.dctl.ldst_dbl_g;
wire       spc1_quad_asi_g      = `SPARC_CORE1.sparc0.lsu.lsu.dctl.quad_asi_g;
wire [1:0] spc1_ldst_sz_g       = `SPARC_CORE1.sparc0.lsu.lsu.dctl.ldst_sz_g;
wire       spc1_lsu_alt_space_g = `SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_alt_space_g;

wire       spc1_mbar_inst0_g        = `SPARC_CORE1.sparc0.lsu.lsu.dctl.mbar_inst0_g;
wire       spc1_mbar_inst1_g        = `SPARC_CORE1.sparc0.lsu.lsu.dctl.mbar_inst1_g;
wire       spc1_mbar_inst2_g        = `SPARC_CORE1.sparc0.lsu.lsu.dctl.mbar_inst2_g;
wire       spc1_mbar_inst3_g        = `SPARC_CORE1.sparc0.lsu.lsu.dctl.mbar_inst3_g;

wire       spc1_flush_inst0_g   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.flush_inst0_g;
wire       spc1_flush_inst1_g   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.flush_inst1_g;
wire       spc1_flush_inst2_g   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.flush_inst2_g;
wire       spc1_flush_inst3_g   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.flush_inst3_g;

wire       spc1_intrpt_disp_asi0_g  = `SPARC_CORE1.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b00);
wire       spc1_intrpt_disp_asi1_g  = `SPARC_CORE1.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b01);
wire       spc1_intrpt_disp_asi2_g  = `SPARC_CORE1.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b10);
wire       spc1_intrpt_disp_asi3_g  = `SPARC_CORE1.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b11);

wire       spc1_st_inst_vld_g   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.st_inst_vld_g;
wire       spc1_non_altspace_ldst_g = `SPARC_CORE1.sparc0.lsu.lsu.dctl.non_altspace_ldst_g;

wire       spc1_dctl_flush_pipe_w   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc1_no_spc_rmo_st   = `SPARC_CORE1.sparc0.lsu.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc1_ldst_fp_e       = `SPARC_CORE1.sparc0.lsu.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc1_stb_rdptr       = `SPARC_CORE1.sparc0.lsu.lsu.stb_rwctl.stb_rdptr_l;

wire       spc1_ld_l2cache_req  = `SPARC_CORE1.sparc0.lsu.lsu.qctl1.ld3_l2cache_rq |
                      `SPARC_CORE1.sparc0.lsu.lsu.qctl1.ld2_l2cache_rq |
                              `SPARC_CORE1.sparc0.lsu.lsu.qctl1.ld1_l2cache_rq |
                      `SPARC_CORE1.sparc0.lsu.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc1_dcache_enable   = {`SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_ctl_reg0[1],
                                           `SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_ctl_reg1[1],
                       `SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_ctl_reg2[1],
                       `SPARC_CORE1.sparc0.lsu.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc1_icache_enable   = `SPARC_CORE1.sparc0.lsu.lsu.lsu_ifu_icache_en[3:0];

wire spc1_dc_direct_map         = `SPARC_CORE1.sparc0.lsu.lsu.dc_direct_map;
wire spc1_lsu_ifu_direct_map_l1 = `SPARC_CORE1.sparc0.lsu.lsu.lsu_ifu_direct_map_l1;
`else
wire [7:0] spc1_stb_ld_full_raw	= `SPARC_CORE1.sparc0.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc1_stb_ld_partial_raw	= `SPARC_CORE1.sparc0.lsu.stb_ld_partial_raw[7:0];
wire       spc1_stb_cam_mhit		= `SPARC_CORE1.sparc0.lsu.stb_cam_mhit;
wire       spc1_stb_cam_hit		= `SPARC_CORE1.sparc0.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc1_lsu_way_hit		= `SPARC_CORE1.sparc0.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc1_lsu_ifu_ldst_miss_w	= `SPARC_CORE1.sparc0.lsu.lsu_ifu_ldst_miss_w;
wire       spc1_ld_inst_vld_g	= `SPARC_CORE1.sparc0.lsu.dctl.ld_inst_vld_g;
wire       spc1_ldst_dbl_g		= `SPARC_CORE1.sparc0.lsu.dctl.ldst_dbl_g;
wire       spc1_quad_asi_g		= `SPARC_CORE1.sparc0.lsu.dctl.quad_asi_g;
wire [1:0] spc1_ldst_sz_g		= `SPARC_CORE1.sparc0.lsu.dctl.ldst_sz_g;
wire       spc1_lsu_alt_space_g	= `SPARC_CORE1.sparc0.lsu.dctl.lsu_alt_space_g;

wire       spc1_mbar_inst0_g		= `SPARC_CORE1.sparc0.lsu.dctl.mbar_inst0_g;
wire       spc1_mbar_inst1_g		= `SPARC_CORE1.sparc0.lsu.dctl.mbar_inst1_g;
wire       spc1_mbar_inst2_g		= `SPARC_CORE1.sparc0.lsu.dctl.mbar_inst2_g;
wire       spc1_mbar_inst3_g		= `SPARC_CORE1.sparc0.lsu.dctl.mbar_inst3_g;

wire       spc1_flush_inst0_g	= `SPARC_CORE1.sparc0.lsu.dctl.flush_inst0_g;
wire       spc1_flush_inst1_g	= `SPARC_CORE1.sparc0.lsu.dctl.flush_inst1_g;
wire       spc1_flush_inst2_g	= `SPARC_CORE1.sparc0.lsu.dctl.flush_inst2_g;
wire       spc1_flush_inst3_g	= `SPARC_CORE1.sparc0.lsu.dctl.flush_inst3_g;

wire       spc1_intrpt_disp_asi0_g	= `SPARC_CORE1.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b00);
wire       spc1_intrpt_disp_asi1_g	= `SPARC_CORE1.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b01);
wire       spc1_intrpt_disp_asi2_g	= `SPARC_CORE1.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b10);
wire       spc1_intrpt_disp_asi3_g	= `SPARC_CORE1.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc1_sas_thrid_w == 2'b11);

wire       spc1_st_inst_vld_g	= `SPARC_CORE1.sparc0.lsu.dctl.st_inst_vld_g;
wire       spc1_non_altspace_ldst_g	= `SPARC_CORE1.sparc0.lsu.dctl.non_altspace_ldst_g;

wire       spc1_dctl_flush_pipe_w	= `SPARC_CORE1.sparc0.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc1_no_spc_rmo_st	= `SPARC_CORE1.sparc0.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc1_ldst_fp_e		= `SPARC_CORE1.sparc0.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc1_stb_rdptr		= `SPARC_CORE1.sparc0.lsu.stb_rwctl.stb_rdptr_l;

wire 	   spc1_ld_l2cache_req 	= `SPARC_CORE1.sparc0.lsu.qctl1.ld3_l2cache_rq |
					  `SPARC_CORE1.sparc0.lsu.qctl1.ld2_l2cache_rq |
                 			  `SPARC_CORE1.sparc0.lsu.qctl1.ld1_l2cache_rq |
					  `SPARC_CORE1.sparc0.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc1_dcache_enable	= {`SPARC_CORE1.sparc0.lsu.dctl.lsu_ctl_reg0[1],
                                    	   `SPARC_CORE1.sparc0.lsu.dctl.lsu_ctl_reg1[1],
					   `SPARC_CORE1.sparc0.lsu.dctl.lsu_ctl_reg2[1],
					   `SPARC_CORE1.sparc0.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc1_icache_enable	= `SPARC_CORE1.sparc0.lsu.lsu_ifu_icache_en[3:0];

wire spc1_dc_direct_map 		= `SPARC_CORE1.sparc0.lsu.dc_direct_map;
wire spc1_lsu_ifu_direct_map_l1	= `SPARC_CORE1.sparc0.lsu.lsu_ifu_direct_map_l1;
`endif

always @(spc1_dcache_enable)
    $display("%0d tso_mon: spc1_dcache_enable changed to %x", $time, spc1_dcache_enable);

always @(spc1_icache_enable)
    $display("%0d tso_mon: spc1_icache_enable changed to %x", $time, spc1_icache_enable);

always @(spc1_dc_direct_map)
    $display("%0d tso_mon: spc1_dc_direct_map changed to %x", $time, spc1_dc_direct_map);

always @(spc1_lsu_ifu_direct_map_l1)
   $display("%0d tso_mon: spc1_lsu_ifu_direct_map_l1 changed to %x", $time, spc1_lsu_ifu_direct_map_l1);

reg 		spc1_dva_svld_e_d1;
reg 		spc1_dva_rvld_e_d1;
reg [`L1D_ADDRESS_HI:4] 	spc1_dva_rd_addr_e_d1;
reg [4:0]  	spc1_dva_snp_addr_e_d1;

reg   		spc1_lsu_snp_after_rd;
reg   		spc1_lsu_rd_after_snp;

reg 	   	spc1_ldst_fp_m, spc1_ldst_fp_g;

integer 	spc1_multiple_hits;

reg spc1_skid_d1, spc1_skid_d2, spc1_skid_d3;
initial begin
  spc1_skid_d1 = 0;
  spc1_skid_d2 = 0;
  spc1_skid_d3 = 0;
end

always @(posedge clk)
begin

  spc1_skid_d1 <= (~spc1_ifu_lsu_inv_clear & spc1_dfq_rd_advance & spc1_dfq_int_type);
  spc1_skid_d2 <= spc1_skid_d1 & ~spc1_ifu_lsu_inv_clear;
  spc1_skid_d3 <= spc1_skid_d2 & ~spc1_ifu_lsu_inv_clear;

// The full tracking of this condition is complicated since after the interrupt is advanced
// there may be more invalidations to the IFQ.
// All we care about is that the invalidations BEFORE the interrupt are finished.
// I provided a command line argument to disable this check.
  if(spc1_skid_d3 & enable_ifu_lsu_inv_clear)
     finish_test("spc", "tso_mon:   spc1_ifu_lsu_inv_clear should have been clear by now", 1);

  spc1_dva_svld_e_d1 	<= spc1_dva_svld_e;
  spc1_dva_rvld_e_d1 	<= spc1_dva_rvld_e;
  spc1_dva_rd_addr_e_d1 	<= spc1_dva_rd_addr_e;
  spc1_dva_snp_addr_e_d1 	<= spc1_dva_snp_addr_e;

  if(spc1_dva_svld_e_d1 & spc1_dva_rvld_e & (spc1_dva_rd_addr_e_d1[`L1D_ADDRESS_HI:6] == spc1_dva_snp_addr_e[4:0]))
    spc1_lsu_rd_after_snp <= 1'b1;
  else
    spc1_lsu_rd_after_snp <= 1'b0;

  if(spc1_dva_svld_e & spc1_dva_rvld_e_d1 & (spc1_dva_rd_addr_e[`L1D_ADDRESS_HI:6] == spc1_dva_snp_addr_e_d1[4:0]))
    spc1_lsu_snp_after_rd <= 1'b1;
  else
    spc1_lsu_snp_after_rd <= 1'b0;

  spc1_ldst_fp_m <= spc1_ldst_fp_e;
  spc1_ldst_fp_g <= spc1_ldst_fp_m;

  if(spc1_stb_data_rptr_vld & spc1_stb_data_wptr_vld & ~spc1_stbrwctl_flush_pipe_w &
     (spc1_stb_data_rd_ptr == spc1_stb_data_wr_ptr) & spc1_lsu_st_pcx_rq_pick)
  begin
    finish_test("spc", "tso_mon: LSU stb data write and read in the same cycle", 1);
  end

   spc1_multiple_hits = (spc1_lsu_way_hit[3] + spc1_lsu_way_hit[2] + spc1_lsu_way_hit[1] + spc1_lsu_way_hit[0]);
   if(!spc1_lsu_ifu_ldst_miss_w && (spc1_multiple_hits >1) && spc1_inst_vld_w && !spc1_dctl_flush_pipe_w && !spc1_lsu_dc_tag_pe_g_unmasked_or)
     finish_test("spc", "tso_mon: LSU multiple hits ", 1);
end

wire spc1_ld_dbl      = spc1_ld_inst_vld_g &  spc1_ldst_dbl_g &  ~spc1_quad_asi_g;
wire spc1_ld_quad     = spc1_ld_inst_vld_g &  spc1_ldst_dbl_g &  spc1_quad_asi_g;
wire spc1_ld_other    = spc1_ld_inst_vld_g & ~spc1_ldst_dbl_g;

wire spc1_ld_dbl_fp   = spc1_ld_dbl        &  spc1_ldst_fp_g;
wire spc1_ld_other_fp = spc1_ld_other      &  spc1_ldst_fp_g;

wire spc1_ld_dbl_int  = spc1_ld_dbl        & ~spc1_ldst_fp_g;
wire spc1_ld_quad_int = spc1_ld_quad       & ~spc1_ldst_fp_g;
wire spc1_ld_other_int= spc1_ld_other      & ~spc1_ldst_fp_g;

wire spc1_ld_bypassok_hit = |spc1_stb_ld_full_raw[7:0] & ~spc1_stb_cam_mhit;
wire spc1_ld_partial_hit  = |spc1_stb_ld_partial_raw[7:0] & ~spc1_stb_cam_mhit;
wire spc1_ld_multiple_hit =  spc1_stb_cam_mhit;

wire spc1_any_lsu_way_hit = |spc1_lsu_way_hit;

wire [7:0] spc1_stb_rdptr_decoded = 	(spc1_stb_rdptr ==3'b000) ? 8'b00000001 :
                               		(spc1_stb_rdptr ==3'b001) ? 8'b00000010 :
                               		(spc1_stb_rdptr ==3'b010) ? 8'b00000100 :
                              		(spc1_stb_rdptr ==3'b011) ? 8'b00001000 :
                              		(spc1_stb_rdptr ==3'b100) ? 8'b00010000 :
                              		(spc1_stb_rdptr ==3'b101) ? 8'b00100000 :
                             		(spc1_stb_rdptr ==3'b110) ? 8'b01000000 :
                              		(spc1_stb_rdptr ==3'b111) ? 8'b10000000 : 8'h00;


wire spc1_stb_top_hit = |(spc1_stb_rdptr_decoded & (spc1_stb_ld_full_raw | spc1_stb_ld_partial_raw));

//---------------------------------------------------------------------
// ld_type[4:0] hit_type[2:0], cache_hit, hit_top
// this is passed to the coverage monitor.
//---------------------------------------------------------------------
wire [10:0] spc1_stb_ld_hit_info =
	{spc1_ld_dbl_fp,        spc1_ld_other_fp,
	 spc1_ld_dbl_int, 	   spc1_ld_quad_int,    spc1_ld_other_int,
	 spc1_ld_bypassok_hit,  spc1_ld_partial_hit, spc1_ld_multiple_hit,
	 spc1_any_lsu_way_hit,
	 spc1_stb_top_hit, C1_st_ack_w};

reg spc1_mbar0_active;
reg spc1_mbar1_active;
reg spc1_mbar2_active;
reg spc1_mbar3_active;

reg spc1_flush0_active;
reg spc1_flush1_active;
reg spc1_flush2_active;
reg spc1_flush3_active;

reg spc1_intr0_active;
reg spc1_intr1_active;
reg spc1_intr2_active;
reg spc1_intr3_active;

always @(negedge clk)
begin
  if(~rst_l)
  begin
     spc1_mbar0_active <= 1'b0;
     spc1_mbar1_active <= 1'b0;
     spc1_mbar2_active <= 1'b0;
     spc1_mbar3_active <= 1'b0;

     spc1_flush0_active <= 1'b0;
     spc1_flush1_active <= 1'b0;
     spc1_flush2_active <= 1'b0;
     spc1_flush3_active <= 1'b0;

     spc1_intr0_active <= 1'b0;
     spc1_intr1_active <= 1'b0;
     spc1_intr2_active <= 1'b0;
     spc1_intr3_active <= 1'b0;

  end
  else
  begin
    if(spc1_mbar_inst0_g & ~spc1_dctl_flush_pipe_w & (C1T0_stb_ne|~spc1_no_spc_rmo_st[0]))
	spc1_mbar0_active <= 1'b1;
    else if(~C1T0_stb_ne & spc1_no_spc_rmo_st[0])
	spc1_mbar0_active <= 1'b0;
    if(spc1_mbar_inst1_g & ~ spc1_dctl_flush_pipe_w & (C1T1_stb_ne|~spc1_no_spc_rmo_st[1]))
	spc1_mbar1_active <= 1'b1;
    else if(~C1T1_stb_ne & spc1_no_spc_rmo_st[1])
	spc1_mbar1_active <= 1'b0;
    if(spc1_mbar_inst2_g & ~ spc1_dctl_flush_pipe_w & (C1T2_stb_ne|~spc1_no_spc_rmo_st[2]))
	spc1_mbar2_active <= 1'b1;
    else if(~C1T2_stb_ne & spc1_no_spc_rmo_st[2])
	spc1_mbar2_active <= 1'b0;
    if(spc1_mbar_inst3_g & ~ spc1_dctl_flush_pipe_w & (C1T3_stb_ne|~spc1_no_spc_rmo_st[3]))
	spc1_mbar3_active <= 1'b1;
    else if(~C1T3_stb_ne & spc1_no_spc_rmo_st[3])
	spc1_mbar3_active <= 1'b0;

    if(spc1_flush_inst0_g & ~spc1_dctl_flush_pipe_w & C1T0_stb_ne) 	spc1_flush0_active <= 1'b1;
    else if(~C1T0_stb_ne)			  				spc1_flush0_active <= 1'b0;
    if(spc1_flush_inst1_g & ~spc1_dctl_flush_pipe_w & C1T1_stb_ne) 	spc1_flush1_active <= 1'b1;
    else if(~C1T1_stb_ne)			  				spc1_flush1_active <= 1'b0;
    if(spc1_flush_inst2_g & ~spc1_dctl_flush_pipe_w & C1T2_stb_ne) 	spc1_flush2_active <= 1'b1;
    else if(~C1T2_stb_ne)			  				spc1_flush2_active <= 1'b0;
    if(spc1_flush_inst3_g & ~spc1_dctl_flush_pipe_w & C1T3_stb_ne) 	spc1_flush3_active <= 1'b1;
    else if(~C1T3_stb_ne)			  				spc1_flush3_active <= 1'b0;

    if(spc1_intrpt_disp_asi0_g & spc1_st_inst_vld_g & ~spc1_non_altspace_ldst_g & ~spc1_dctl_flush_pipe_w & C1T0_stb_ne)
	spc1_intr0_active <= 1'b1;
    else if(~C1T0_stb_ne)
	spc1_intr0_active <= 1'b0;
    if(spc1_intrpt_disp_asi1_g &  spc1_st_inst_vld_g & ~spc1_non_altspace_ldst_g & ~spc1_dctl_flush_pipe_w & C1T1_stb_ne)
	spc1_intr1_active <= 1'b1;
    else if(~C1T1_stb_ne)
	spc1_intr1_active <= 1'b0;
    if(spc1_intrpt_disp_asi2_g &  spc1_st_inst_vld_g & ~spc1_non_altspace_ldst_g & ~spc1_dctl_flush_pipe_w & C1T2_stb_ne)
	spc1_intr2_active <= 1'b1;
    else if(~C1T2_stb_ne)
	spc1_intr2_active <= 1'b0;
    if(spc1_intrpt_disp_asi3_g &  spc1_st_inst_vld_g & ~spc1_non_altspace_ldst_g & ~spc1_dctl_flush_pipe_w & C1T3_stb_ne)
	spc1_intr3_active <= 1'b1;
    else if(~C1T3_stb_ne)
	spc1_intr3_active <= 1'b0;
  end

  if(spc1_mbar0_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "membar violation thread 0", 1);
  if(spc1_mbar1_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "membar violation thread 1", 1);
  if(spc1_mbar2_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "membar violation thread 2", 1);
  if(spc1_mbar3_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "membar violation thread 3", 1);

  if(spc1_flush0_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "flush violation thread 0", 1);
  if(spc1_flush1_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "flush violation thread 1", 1);
  if(spc1_flush2_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "flush violation thread 2", 1);
  if(spc1_flush3_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "flush violation thread 3", 1);

  if(spc1_intr0_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "intr violation thread 0", 1);
  if(spc1_intr1_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "intr violation thread 1", 1);
  if(spc1_intr2_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "intr violation thread 2", 1);
  if(spc1_intr3_active & spc1_inst_vld_w & spc1_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "intr violation thread 3", 1);

   else							C1T0_stb_drain_cnt = C1T0_stb_drain_cnt + 1;
   if(C1T0_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 0 is not draining", 1);

   else							C1T1_stb_drain_cnt = C1T1_stb_drain_cnt + 1;
   if(C1T1_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 1 is not draining", 1);

   else							C1T2_stb_drain_cnt = C1T2_stb_drain_cnt + 1;
   if(C1T2_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 2 is not draining", 1);

   else							C1T3_stb_drain_cnt = C1T3_stb_drain_cnt + 1;
   if(C1T3_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 3 is not draining", 1);

  C1T0_stb_vld_sum_d1 <= C1T0_stb_vld_sum;
  C1T1_stb_vld_sum_d1 <= C1T1_stb_vld_sum;
  C1T2_stb_vld_sum_d1 <= C1T2_stb_vld_sum;
  C1T3_stb_vld_sum_d1 <= C1T3_stb_vld_sum;
  C1T0_defr_trp_en_d1 <= C1T0_defr_trp_en;
  C1T1_defr_trp_en_d1 <= C1T1_defr_trp_en;
  C1T2_defr_trp_en_d1 <= C1T2_defr_trp_en;
  C1T3_defr_trp_en_d1 <= C1T3_defr_trp_en;

  if(rst_l & C1T0_defr_trp_en_d1 & (C1T0_stb_vld_sum_d1 < C1T0_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T0", 1);
  if(rst_l & C1T1_defr_trp_en_d1 & (C1T1_stb_vld_sum_d1 < C1T1_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T1", 1);
  if(rst_l & C1T2_defr_trp_en_d1 & (C1T2_stb_vld_sum_d1 < C1T2_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T2", 1);
  if(rst_l & C1T3_defr_trp_en_d1 & (C1T3_stb_vld_sum_d1 < C1T3_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T3", 1);

end
`endif



`ifdef RTL_SPARC2
`ifndef RTL_SPU
wire   C2T0_stb_ne    = |`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C2T1_stb_ne    = |`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C2T2_stb_ne    = |`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C2T3_stb_ne    = |`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C2T0_stb_nced  = |(   `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0] &
                ~`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C2T1_stb_nced  = |(   `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0] &
                ~`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C2T2_stb_nced  = |(   `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0] &
                ~`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C2T3_stb_nced  = |(   `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0] &
                ~`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc2_lsu_ifill_pkt_vld   = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc2_dfq_rd_advance          = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dfq_rd_advance;
wire   spc2_dfq_int_type        = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dfq_int_type;

wire   spc2_ifu_lsu_inv_clear   = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.ifu_lsu_inv_clear;

wire        spc2_dva_svld_e         = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dva_svld_e;
wire        spc2_dva_rvld_e     = `SPARC_CORE2.sparc0.lsu.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc2_dva_rd_addr_e      = `SPARC_CORE2.sparc0.lsu.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [`L1D_ADDRESS_HI-6:0]  spc2_dva_snp_addr_e     = `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dva_snp_addr_e[`L1D_ADDRESS_HI-6:0];

wire [4:0]  spc2_stb_data_rd_ptr    = `SPARC_CORE2.sparc0.lsu.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc2_stb_data_wr_ptr    = `SPARC_CORE2.sparc0.lsu.lsu.stb_data_wr_ptr[4:0];
wire        spc2_stb_data_wptr_vld  = `SPARC_CORE2.sparc0.lsu.lsu.stb_data_wptr_vld;
wire        spc2_stb_data_rptr_vld  = `SPARC_CORE2.sparc0.lsu.lsu.stb_data_rptr_vld;
wire        spc2_stbrwctl_flush_pipe_w = `SPARC_CORE2.sparc0.lsu.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc2_lsu_st_pcx_rq_pick     = |`SPARC_CORE2.sparc0.lsu.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [`L1D_WAY_ARRAY_MASK]  spc2_lsu_rd_dtag_parity_g = `SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_rd_dtag_parity_g[`L1D_WAY_ARRAY_MASK];
wire [`L1D_WAY_ARRAY_MASK]  spc2_dva_vld_g       = `SPARC_CORE2.sparc0.lsu.lsu.dctl.dva_vld_g[`L1D_WAY_ARRAY_MASK];

wire [3:0]  spc2_lsu_dc_tag_pe_g_unmasked    = spc2_lsu_rd_dtag_parity_g[3:0] & spc2_dva_vld_g[3:0];
wire        spc2_lsu_dc_tag_pe_g_unmasked_or = |spc2_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C2T0_stb_full  = &`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C2T1_stb_full  = &`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C2T2_stb_full  = &`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C2T3_stb_full  = &`SPARC_CORE2.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C2T0_stb_vld  = `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C2T1_stb_vld  = `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C2T2_stb_vld  = `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C2T3_stb_vld  = `SPARC_CORE2.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];
`else
wire   C2T0_stb_ne    = |`SPARC_CORE2.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C2T1_stb_ne    = |`SPARC_CORE2.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C2T2_stb_ne    = |`SPARC_CORE2.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C2T3_stb_ne    = |`SPARC_CORE2.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C2T0_stb_nced  = |(	 `SPARC_CORE2.sparc0.lsu.stb_ctl0.stb_state_vld[7:0] &
				~`SPARC_CORE2.sparc0.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C2T1_stb_nced  = |(	 `SPARC_CORE2.sparc0.lsu.stb_ctl1.stb_state_vld[7:0] &
				~`SPARC_CORE2.sparc0.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C2T2_stb_nced  = |(	 `SPARC_CORE2.sparc0.lsu.stb_ctl2.stb_state_vld[7:0] &
				~`SPARC_CORE2.sparc0.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C2T3_stb_nced  = |(	 `SPARC_CORE2.sparc0.lsu.stb_ctl3.stb_state_vld[7:0] &
				~`SPARC_CORE2.sparc0.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc2_lsu_ifill_pkt_vld	= `SPARC_CORE2.sparc0.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc2_dfq_rd_advance  		= `SPARC_CORE2.sparc0.lsu.qctl2.dfq_rd_advance;
wire   spc2_dfq_int_type  		= `SPARC_CORE2.sparc0.lsu.qctl2.dfq_int_type;

wire   spc2_ifu_lsu_inv_clear	= `SPARC_CORE2.sparc0.lsu.qctl2.ifu_lsu_inv_clear;

wire 	    spc2_dva_svld_e 	 	= `SPARC_CORE2.sparc0.lsu.qctl2.dva_svld_e;
wire 	    spc2_dva_rvld_e	 	= `SPARC_CORE2.sparc0.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc2_dva_rd_addr_e  	= `SPARC_CORE2.sparc0.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [4:0]  spc2_dva_snp_addr_e 	= `SPARC_CORE2.sparc0.lsu.qctl2.dva_snp_addr_e[4:0];

wire [4:0]  spc2_stb_data_rd_ptr   	= `SPARC_CORE2.sparc0.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc2_stb_data_wr_ptr   	= `SPARC_CORE2.sparc0.lsu.stb_data_wr_ptr[4:0];
wire        spc2_stb_data_wptr_vld 	= `SPARC_CORE2.sparc0.lsu.stb_data_wptr_vld;
wire        spc2_stb_data_rptr_vld 	= `SPARC_CORE2.sparc0.lsu.stb_data_rptr_vld;
wire        spc2_stbrwctl_flush_pipe_w = `SPARC_CORE2.sparc0.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc2_lsu_st_pcx_rq_pick 	= |`SPARC_CORE2.sparc0.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [3:0]  spc2_lsu_rd_dtag_parity_g = `SPARC_CORE2.sparc0.lsu.dctl.lsu_rd_dtag_parity_g[3:0];
wire [3:0]  spc2_dva_vld_g		 = `SPARC_CORE2.sparc0.lsu.dctl.dva_vld_g[3:0];

wire [3:0]  spc2_lsu_dc_tag_pe_g_unmasked    = spc2_lsu_rd_dtag_parity_g[3:0] & spc2_dva_vld_g[3:0];
wire        spc2_lsu_dc_tag_pe_g_unmasked_or = |spc2_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C2T0_stb_full  = &`SPARC_CORE2.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C2T1_stb_full  = &`SPARC_CORE2.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C2T2_stb_full  = &`SPARC_CORE2.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C2T3_stb_full  = &`SPARC_CORE2.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C2T0_stb_vld  = `SPARC_CORE2.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C2T1_stb_vld  = `SPARC_CORE2.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C2T2_stb_vld  = `SPARC_CORE2.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C2T3_stb_vld  = `SPARC_CORE2.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];
`endif

wire   [4:0] C2T0_stb_vld_sum  =  C2T0_stb_vld[0] +  C2T0_stb_vld[1] +  C2T0_stb_vld[2] +  C2T0_stb_vld[3] +
                                     C2T0_stb_vld[4] +  C2T0_stb_vld[5] +  C2T0_stb_vld[6] +  C2T0_stb_vld[7] ;
wire   [4:0] C2T1_stb_vld_sum  =  C2T1_stb_vld[0] +  C2T1_stb_vld[1] +  C2T1_stb_vld[2] +  C2T1_stb_vld[3] +
                                     C2T1_stb_vld[4] +  C2T1_stb_vld[5] +  C2T1_stb_vld[6] +  C2T1_stb_vld[7] ;
wire   [4:0] C2T2_stb_vld_sum  =  C2T2_stb_vld[0] +  C2T2_stb_vld[1] +  C2T2_stb_vld[2] +  C2T2_stb_vld[3] +
                                     C2T2_stb_vld[4] +  C2T2_stb_vld[5] +  C2T2_stb_vld[6] +  C2T2_stb_vld[7] ;
wire   [4:0] C2T3_stb_vld_sum  =  C2T3_stb_vld[0] +  C2T3_stb_vld[1] +  C2T3_stb_vld[2] +  C2T3_stb_vld[3] +
                                     C2T3_stb_vld[4] +  C2T3_stb_vld[5] +  C2T3_stb_vld[6] +  C2T3_stb_vld[7] ;

reg [4:0] C2T0_stb_vld_sum_d1;
reg [4:0] C2T1_stb_vld_sum_d1;
reg [4:0] C2T2_stb_vld_sum_d1;
reg [4:0] C2T3_stb_vld_sum_d1;

`ifndef RTL_SPU
wire   C2T0_st_ack  = &`SPARC_CORE2.sparc0.lsu.lsu.cpx_st_ack_tid0;
wire   C2T1_st_ack  = &`SPARC_CORE2.sparc0.lsu.lsu.cpx_st_ack_tid1;
wire   C2T2_st_ack  = &`SPARC_CORE2.sparc0.lsu.lsu.cpx_st_ack_tid2;
wire   C2T3_st_ack  = &`SPARC_CORE2.sparc0.lsu.lsu.cpx_st_ack_tid3;

wire   C2T0_defr_trp_en = &`SPARC_CORE2.sparc0.lsu.lsu.excpctl.st_defr_trp_en0;
wire   C2T1_defr_trp_en = &`SPARC_CORE2.sparc0.lsu.lsu.excpctl.st_defr_trp_en1;
wire   C2T2_defr_trp_en = &`SPARC_CORE2.sparc0.lsu.lsu.excpctl.st_defr_trp_en2;
wire   C2T3_defr_trp_en = &`SPARC_CORE2.sparc0.lsu.lsu.excpctl.st_defr_trp_en3;
`else
wire   C2T0_st_ack  = &`SPARC_CORE2.sparc0.lsu.cpx_st_ack_tid0;
wire   C2T1_st_ack  = &`SPARC_CORE2.sparc0.lsu.cpx_st_ack_tid1;
wire   C2T2_st_ack  = &`SPARC_CORE2.sparc0.lsu.cpx_st_ack_tid2;
wire   C2T3_st_ack  = &`SPARC_CORE2.sparc0.lsu.cpx_st_ack_tid3;

wire   C2T0_defr_trp_en	= &`SPARC_CORE2.sparc0.lsu.excpctl.st_defr_trp_en0;
wire   C2T1_defr_trp_en	= &`SPARC_CORE2.sparc0.lsu.excpctl.st_defr_trp_en1;
wire   C2T2_defr_trp_en	= &`SPARC_CORE2.sparc0.lsu.excpctl.st_defr_trp_en2;
wire   C2T3_defr_trp_en	= &`SPARC_CORE2.sparc0.lsu.excpctl.st_defr_trp_en3;
`endif

reg C2T0_defr_trp_en_d1;
reg C2T1_defr_trp_en_d1;
reg C2T2_defr_trp_en_d1;
reg C2T3_defr_trp_en_d1;

integer C2T0_stb_drain_cnt;
integer C2T1_stb_drain_cnt;
integer C2T2_stb_drain_cnt;
integer C2T3_stb_drain_cnt;

// Hits in the store buffer
//-------------------------
`ifndef RTL_SPU
wire       spc2_inst_vld_w      = `SPARC_CORE2.sparc0.ifu.ifu.fcl.inst_vld_w;
wire [1:0] spc2_sas_thrid_w     = `SPARC_CORE2.sparc0.ifu.ifu.fcl.sas_thrid_w[1:0];
`else
wire       spc2_inst_vld_w		= `SPARC_CORE2.sparc0.ifu.fcl.inst_vld_w;
wire [1:0] spc2_sas_thrid_w		= `SPARC_CORE2.sparc0.ifu.fcl.sas_thrid_w[1:0];
`endif

wire C2_st_ack_w = (spc2_sas_thrid_w == 2'b00) & C2T0_st_ack |
                      (spc2_sas_thrid_w == 2'b01) & C2T1_st_ack |
                      (spc2_sas_thrid_w == 2'b10) & C2T2_st_ack |
                      (spc2_sas_thrid_w == 2'b11) & C2T3_st_ack;

`ifndef RTL_SPU
wire [7:0] spc2_stb_ld_full_raw = `SPARC_CORE2.sparc0.lsu.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc2_stb_ld_partial_raw  = `SPARC_CORE2.sparc0.lsu.lsu.stb_ld_partial_raw[7:0];
wire       spc2_stb_cam_mhit        = `SPARC_CORE2.sparc0.lsu.lsu.stb_cam_mhit;
wire       spc2_stb_cam_hit     = `SPARC_CORE2.sparc0.lsu.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc2_lsu_way_hit     = `SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc2_lsu_ifu_ldst_miss_w = `SPARC_CORE2.sparc0.lsu.lsu.lsu_ifu_ldst_miss_w;
wire       spc2_ld_inst_vld_g   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.ld_inst_vld_g;
wire       spc2_ldst_dbl_g      = `SPARC_CORE2.sparc0.lsu.lsu.dctl.ldst_dbl_g;
wire       spc2_quad_asi_g      = `SPARC_CORE2.sparc0.lsu.lsu.dctl.quad_asi_g;
wire [1:0] spc2_ldst_sz_g       = `SPARC_CORE2.sparc0.lsu.lsu.dctl.ldst_sz_g;
wire       spc2_lsu_alt_space_g = `SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_alt_space_g;

wire       spc2_mbar_inst0_g        = `SPARC_CORE2.sparc0.lsu.lsu.dctl.mbar_inst0_g;
wire       spc2_mbar_inst1_g        = `SPARC_CORE2.sparc0.lsu.lsu.dctl.mbar_inst1_g;
wire       spc2_mbar_inst2_g        = `SPARC_CORE2.sparc0.lsu.lsu.dctl.mbar_inst2_g;
wire       spc2_mbar_inst3_g        = `SPARC_CORE2.sparc0.lsu.lsu.dctl.mbar_inst3_g;

wire       spc2_flush_inst0_g   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.flush_inst0_g;
wire       spc2_flush_inst1_g   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.flush_inst1_g;
wire       spc2_flush_inst2_g   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.flush_inst2_g;
wire       spc2_flush_inst3_g   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.flush_inst3_g;

wire       spc2_intrpt_disp_asi0_g  = `SPARC_CORE2.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b00);
wire       spc2_intrpt_disp_asi1_g  = `SPARC_CORE2.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b01);
wire       spc2_intrpt_disp_asi2_g  = `SPARC_CORE2.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b10);
wire       spc2_intrpt_disp_asi3_g  = `SPARC_CORE2.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b11);

wire       spc2_st_inst_vld_g   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.st_inst_vld_g;
wire       spc2_non_altspace_ldst_g = `SPARC_CORE2.sparc0.lsu.lsu.dctl.non_altspace_ldst_g;

wire       spc2_dctl_flush_pipe_w   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc2_no_spc_rmo_st   = `SPARC_CORE2.sparc0.lsu.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc2_ldst_fp_e       = `SPARC_CORE2.sparc0.lsu.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc2_stb_rdptr       = `SPARC_CORE2.sparc0.lsu.lsu.stb_rwctl.stb_rdptr_l;

wire       spc2_ld_l2cache_req  = `SPARC_CORE2.sparc0.lsu.lsu.qctl1.ld3_l2cache_rq |
                      `SPARC_CORE2.sparc0.lsu.lsu.qctl1.ld2_l2cache_rq |
                              `SPARC_CORE2.sparc0.lsu.lsu.qctl1.ld1_l2cache_rq |
                      `SPARC_CORE2.sparc0.lsu.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc2_dcache_enable   = {`SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_ctl_reg0[1],
                                           `SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_ctl_reg1[1],
                       `SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_ctl_reg2[1],
                       `SPARC_CORE2.sparc0.lsu.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc2_icache_enable   = `SPARC_CORE2.sparc0.lsu.lsu.lsu_ifu_icache_en[3:0];

wire spc2_dc_direct_map         = `SPARC_CORE2.sparc0.lsu.lsu.dc_direct_map;
wire spc2_lsu_ifu_direct_map_l1 = `SPARC_CORE2.sparc0.lsu.lsu.lsu_ifu_direct_map_l1;
`else
wire [7:0] spc2_stb_ld_full_raw	= `SPARC_CORE2.sparc0.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc2_stb_ld_partial_raw	= `SPARC_CORE2.sparc0.lsu.stb_ld_partial_raw[7:0];
wire       spc2_stb_cam_mhit		= `SPARC_CORE2.sparc0.lsu.stb_cam_mhit;
wire       spc2_stb_cam_hit		= `SPARC_CORE2.sparc0.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc2_lsu_way_hit		= `SPARC_CORE2.sparc0.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc2_lsu_ifu_ldst_miss_w	= `SPARC_CORE2.sparc0.lsu.lsu_ifu_ldst_miss_w;
wire       spc2_ld_inst_vld_g	= `SPARC_CORE2.sparc0.lsu.dctl.ld_inst_vld_g;
wire       spc2_ldst_dbl_g		= `SPARC_CORE2.sparc0.lsu.dctl.ldst_dbl_g;
wire       spc2_quad_asi_g		= `SPARC_CORE2.sparc0.lsu.dctl.quad_asi_g;
wire [1:0] spc2_ldst_sz_g		= `SPARC_CORE2.sparc0.lsu.dctl.ldst_sz_g;
wire       spc2_lsu_alt_space_g	= `SPARC_CORE2.sparc0.lsu.dctl.lsu_alt_space_g;

wire       spc2_mbar_inst0_g		= `SPARC_CORE2.sparc0.lsu.dctl.mbar_inst0_g;
wire       spc2_mbar_inst1_g		= `SPARC_CORE2.sparc0.lsu.dctl.mbar_inst1_g;
wire       spc2_mbar_inst2_g		= `SPARC_CORE2.sparc0.lsu.dctl.mbar_inst2_g;
wire       spc2_mbar_inst3_g		= `SPARC_CORE2.sparc0.lsu.dctl.mbar_inst3_g;

wire       spc2_flush_inst0_g	= `SPARC_CORE2.sparc0.lsu.dctl.flush_inst0_g;
wire       spc2_flush_inst1_g	= `SPARC_CORE2.sparc0.lsu.dctl.flush_inst1_g;
wire       spc2_flush_inst2_g	= `SPARC_CORE2.sparc0.lsu.dctl.flush_inst2_g;
wire       spc2_flush_inst3_g	= `SPARC_CORE2.sparc0.lsu.dctl.flush_inst3_g;

wire       spc2_intrpt_disp_asi0_g	= `SPARC_CORE2.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b00);
wire       spc2_intrpt_disp_asi1_g	= `SPARC_CORE2.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b01);
wire       spc2_intrpt_disp_asi2_g	= `SPARC_CORE2.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b10);
wire       spc2_intrpt_disp_asi3_g	= `SPARC_CORE2.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc2_sas_thrid_w == 2'b11);

wire       spc2_st_inst_vld_g	= `SPARC_CORE2.sparc0.lsu.dctl.st_inst_vld_g;
wire       spc2_non_altspace_ldst_g	= `SPARC_CORE2.sparc0.lsu.dctl.non_altspace_ldst_g;

wire       spc2_dctl_flush_pipe_w	= `SPARC_CORE2.sparc0.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc2_no_spc_rmo_st	= `SPARC_CORE2.sparc0.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc2_ldst_fp_e		= `SPARC_CORE2.sparc0.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc2_stb_rdptr		= `SPARC_CORE2.sparc0.lsu.stb_rwctl.stb_rdptr_l;

wire 	   spc2_ld_l2cache_req 	= `SPARC_CORE2.sparc0.lsu.qctl1.ld3_l2cache_rq |
					  `SPARC_CORE2.sparc0.lsu.qctl1.ld2_l2cache_rq |
                 			  `SPARC_CORE2.sparc0.lsu.qctl1.ld1_l2cache_rq |
					  `SPARC_CORE2.sparc0.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc2_dcache_enable	= {`SPARC_CORE2.sparc0.lsu.dctl.lsu_ctl_reg0[1],
                                    	   `SPARC_CORE2.sparc0.lsu.dctl.lsu_ctl_reg1[1],
					   `SPARC_CORE2.sparc0.lsu.dctl.lsu_ctl_reg2[1],
					   `SPARC_CORE2.sparc0.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc2_icache_enable	= `SPARC_CORE2.sparc0.lsu.lsu_ifu_icache_en[3:0];

wire spc2_dc_direct_map 		= `SPARC_CORE2.sparc0.lsu.dc_direct_map;
wire spc2_lsu_ifu_direct_map_l1	= `SPARC_CORE2.sparc0.lsu.lsu_ifu_direct_map_l1;
`endif

always @(spc2_dcache_enable)
    $display("%0d tso_mon: spc2_dcache_enable changed to %x", $time, spc2_dcache_enable);

always @(spc2_icache_enable)
    $display("%0d tso_mon: spc2_icache_enable changed to %x", $time, spc2_icache_enable);

always @(spc2_dc_direct_map)
    $display("%0d tso_mon: spc2_dc_direct_map changed to %x", $time, spc2_dc_direct_map);

always @(spc2_lsu_ifu_direct_map_l1)
   $display("%0d tso_mon: spc2_lsu_ifu_direct_map_l1 changed to %x", $time, spc2_lsu_ifu_direct_map_l1);

reg 		spc2_dva_svld_e_d1;
reg 		spc2_dva_rvld_e_d1;
reg [`L1D_ADDRESS_HI:4] 	spc2_dva_rd_addr_e_d1;
reg [4:0]  	spc2_dva_snp_addr_e_d1;

reg   		spc2_lsu_snp_after_rd;
reg   		spc2_lsu_rd_after_snp;

reg 	   	spc2_ldst_fp_m, spc2_ldst_fp_g;

integer 	spc2_multiple_hits;

reg spc2_skid_d1, spc2_skid_d2, spc2_skid_d3;
initial begin
  spc2_skid_d1 = 0;
  spc2_skid_d2 = 0;
  spc2_skid_d3 = 0;
end

always @(posedge clk)
begin

  spc2_skid_d1 <= (~spc2_ifu_lsu_inv_clear & spc2_dfq_rd_advance & spc2_dfq_int_type);
  spc2_skid_d2 <= spc2_skid_d1 & ~spc2_ifu_lsu_inv_clear;
  spc2_skid_d3 <= spc2_skid_d2 & ~spc2_ifu_lsu_inv_clear;

// The full tracking of this condition is complicated since after the interrupt is advanced
// there may be more invalidations to the IFQ.
// All we care about is that the invalidations BEFORE the interrupt are finished.
// I provided a command line argument to disable this check.
  if(spc2_skid_d3 & enable_ifu_lsu_inv_clear)
     finish_test("spc", "tso_mon:   spc2_ifu_lsu_inv_clear should have been clear by now", 2);

  spc2_dva_svld_e_d1 	<= spc2_dva_svld_e;
  spc2_dva_rvld_e_d1 	<= spc2_dva_rvld_e;
  spc2_dva_rd_addr_e_d1 	<= spc2_dva_rd_addr_e;
  spc2_dva_snp_addr_e_d1 	<= spc2_dva_snp_addr_e;

  if(spc2_dva_svld_e_d1 & spc2_dva_rvld_e & (spc2_dva_rd_addr_e_d1[`L1D_ADDRESS_HI:6] == spc2_dva_snp_addr_e[4:0]))
    spc2_lsu_rd_after_snp <= 1'b1;
  else
    spc2_lsu_rd_after_snp <= 1'b0;

  if(spc2_dva_svld_e & spc2_dva_rvld_e_d1 & (spc2_dva_rd_addr_e[`L1D_ADDRESS_HI:6] == spc2_dva_snp_addr_e_d1[4:0]))
    spc2_lsu_snp_after_rd <= 1'b1;
  else
    spc2_lsu_snp_after_rd <= 1'b0;

  spc2_ldst_fp_m <= spc2_ldst_fp_e;
  spc2_ldst_fp_g <= spc2_ldst_fp_m;

  if(spc2_stb_data_rptr_vld & spc2_stb_data_wptr_vld & ~spc2_stbrwctl_flush_pipe_w &
     (spc2_stb_data_rd_ptr == spc2_stb_data_wr_ptr) & spc2_lsu_st_pcx_rq_pick)
  begin
    finish_test("spc", "tso_mon: LSU stb data write and read in the same cycle", 2);
  end

   spc2_multiple_hits = (spc2_lsu_way_hit[3] + spc2_lsu_way_hit[2] + spc2_lsu_way_hit[1] + spc2_lsu_way_hit[0]);
   if(!spc2_lsu_ifu_ldst_miss_w && (spc2_multiple_hits >1) && spc2_inst_vld_w && !spc2_dctl_flush_pipe_w && !spc2_lsu_dc_tag_pe_g_unmasked_or)
     finish_test("spc", "tso_mon: LSU multiple hits ", 2);
end

wire spc2_ld_dbl      = spc2_ld_inst_vld_g &  spc2_ldst_dbl_g &  ~spc2_quad_asi_g;
wire spc2_ld_quad     = spc2_ld_inst_vld_g &  spc2_ldst_dbl_g &  spc2_quad_asi_g;
wire spc2_ld_other    = spc2_ld_inst_vld_g & ~spc2_ldst_dbl_g;

wire spc2_ld_dbl_fp   = spc2_ld_dbl        &  spc2_ldst_fp_g;
wire spc2_ld_other_fp = spc2_ld_other      &  spc2_ldst_fp_g;

wire spc2_ld_dbl_int  = spc2_ld_dbl        & ~spc2_ldst_fp_g;
wire spc2_ld_quad_int = spc2_ld_quad       & ~spc2_ldst_fp_g;
wire spc2_ld_other_int= spc2_ld_other      & ~spc2_ldst_fp_g;

wire spc2_ld_bypassok_hit = |spc2_stb_ld_full_raw[7:0] & ~spc2_stb_cam_mhit;
wire spc2_ld_partial_hit  = |spc2_stb_ld_partial_raw[7:0] & ~spc2_stb_cam_mhit;
wire spc2_ld_multiple_hit =  spc2_stb_cam_mhit;

wire spc2_any_lsu_way_hit = |spc2_lsu_way_hit;

wire [7:0] spc2_stb_rdptr_decoded = 	(spc2_stb_rdptr ==3'b000) ? 8'b00000001 :
                               		(spc2_stb_rdptr ==3'b001) ? 8'b00000010 :
                               		(spc2_stb_rdptr ==3'b010) ? 8'b00000100 :
                              		(spc2_stb_rdptr ==3'b011) ? 8'b00001000 :
                              		(spc2_stb_rdptr ==3'b100) ? 8'b00010000 :
                              		(spc2_stb_rdptr ==3'b101) ? 8'b00100000 :
                             		(spc2_stb_rdptr ==3'b110) ? 8'b01000000 :
                              		(spc2_stb_rdptr ==3'b111) ? 8'b10000000 : 8'h00;


wire spc2_stb_top_hit = |(spc2_stb_rdptr_decoded & (spc2_stb_ld_full_raw | spc2_stb_ld_partial_raw));

//---------------------------------------------------------------------
// ld_type[4:0] hit_type[2:0], cache_hit, hit_top
// this is passed to the coverage monitor.
//---------------------------------------------------------------------
wire [10:0] spc2_stb_ld_hit_info =
	{spc2_ld_dbl_fp,        spc2_ld_other_fp,
	 spc2_ld_dbl_int, 	   spc2_ld_quad_int,    spc2_ld_other_int,
	 spc2_ld_bypassok_hit,  spc2_ld_partial_hit, spc2_ld_multiple_hit,
	 spc2_any_lsu_way_hit,
	 spc2_stb_top_hit, C2_st_ack_w};

reg spc2_mbar0_active;
reg spc2_mbar1_active;
reg spc2_mbar2_active;
reg spc2_mbar3_active;

reg spc2_flush0_active;
reg spc2_flush1_active;
reg spc2_flush2_active;
reg spc2_flush3_active;

reg spc2_intr0_active;
reg spc2_intr1_active;
reg spc2_intr2_active;
reg spc2_intr3_active;

always @(negedge clk)
begin
  if(~rst_l)
  begin
     spc2_mbar0_active <= 1'b0;
     spc2_mbar1_active <= 1'b0;
     spc2_mbar2_active <= 1'b0;
     spc2_mbar3_active <= 1'b0;

     spc2_flush0_active <= 1'b0;
     spc2_flush1_active <= 1'b0;
     spc2_flush2_active <= 1'b0;
     spc2_flush3_active <= 1'b0;

     spc2_intr0_active <= 1'b0;
     spc2_intr1_active <= 1'b0;
     spc2_intr2_active <= 1'b0;
     spc2_intr3_active <= 1'b0;

  end
  else
  begin
    if(spc2_mbar_inst0_g & ~spc2_dctl_flush_pipe_w & (C2T0_stb_ne|~spc2_no_spc_rmo_st[0]))
	spc2_mbar0_active <= 1'b1;
    else if(~C2T0_stb_ne & spc2_no_spc_rmo_st[0])
	spc2_mbar0_active <= 1'b0;
    if(spc2_mbar_inst1_g & ~ spc2_dctl_flush_pipe_w & (C2T1_stb_ne|~spc2_no_spc_rmo_st[1]))
	spc2_mbar1_active <= 1'b1;
    else if(~C2T1_stb_ne & spc2_no_spc_rmo_st[1])
	spc2_mbar1_active <= 1'b0;
    if(spc2_mbar_inst2_g & ~ spc2_dctl_flush_pipe_w & (C2T2_stb_ne|~spc2_no_spc_rmo_st[2]))
	spc2_mbar2_active <= 1'b1;
    else if(~C2T2_stb_ne & spc2_no_spc_rmo_st[2])
	spc2_mbar2_active <= 1'b0;
    if(spc2_mbar_inst3_g & ~ spc2_dctl_flush_pipe_w & (C2T3_stb_ne|~spc2_no_spc_rmo_st[3]))
	spc2_mbar3_active <= 1'b1;
    else if(~C2T3_stb_ne & spc2_no_spc_rmo_st[3])
	spc2_mbar3_active <= 1'b0;

    if(spc2_flush_inst0_g & ~spc2_dctl_flush_pipe_w & C2T0_stb_ne) 	spc2_flush0_active <= 1'b1;
    else if(~C2T0_stb_ne)			  				spc2_flush0_active <= 1'b0;
    if(spc2_flush_inst1_g & ~spc2_dctl_flush_pipe_w & C2T1_stb_ne) 	spc2_flush1_active <= 1'b1;
    else if(~C2T1_stb_ne)			  				spc2_flush1_active <= 1'b0;
    if(spc2_flush_inst2_g & ~spc2_dctl_flush_pipe_w & C2T2_stb_ne) 	spc2_flush2_active <= 1'b1;
    else if(~C2T2_stb_ne)			  				spc2_flush2_active <= 1'b0;
    if(spc2_flush_inst3_g & ~spc2_dctl_flush_pipe_w & C2T3_stb_ne) 	spc2_flush3_active <= 1'b1;
    else if(~C2T3_stb_ne)			  				spc2_flush3_active <= 1'b0;

    if(spc2_intrpt_disp_asi0_g & spc2_st_inst_vld_g & ~spc2_non_altspace_ldst_g & ~spc2_dctl_flush_pipe_w & C2T0_stb_ne)
	spc2_intr0_active <= 1'b1;
    else if(~C2T0_stb_ne)
	spc2_intr0_active <= 1'b0;
    if(spc2_intrpt_disp_asi1_g &  spc2_st_inst_vld_g & ~spc2_non_altspace_ldst_g & ~spc2_dctl_flush_pipe_w & C2T1_stb_ne)
	spc2_intr1_active <= 1'b1;
    else if(~C2T1_stb_ne)
	spc2_intr1_active <= 1'b0;
    if(spc2_intrpt_disp_asi2_g &  spc2_st_inst_vld_g & ~spc2_non_altspace_ldst_g & ~spc2_dctl_flush_pipe_w & C2T2_stb_ne)
	spc2_intr2_active <= 1'b1;
    else if(~C2T2_stb_ne)
	spc2_intr2_active <= 1'b0;
    if(spc2_intrpt_disp_asi3_g &  spc2_st_inst_vld_g & ~spc2_non_altspace_ldst_g & ~spc2_dctl_flush_pipe_w & C2T3_stb_ne)
	spc2_intr3_active <= 1'b1;
    else if(~C2T3_stb_ne)
	spc2_intr3_active <= 1'b0;
  end

  if(spc2_mbar0_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "membar violation thread 0", 2);
  if(spc2_mbar1_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "membar violation thread 1", 2);
  if(spc2_mbar2_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "membar violation thread 2", 2);
  if(spc2_mbar3_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "membar violation thread 3", 2);

  if(spc2_flush0_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "flush violation thread 0", 2);
  if(spc2_flush1_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "flush violation thread 1", 2);
  if(spc2_flush2_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "flush violation thread 2", 2);
  if(spc2_flush3_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "flush violation thread 3", 2);

  if(spc2_intr0_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "intr violation thread 0", 2);
  if(spc2_intr1_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "intr violation thread 1", 2);
  if(spc2_intr2_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "intr violation thread 2", 2);
  if(spc2_intr3_active & spc2_inst_vld_w & spc2_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "intr violation thread 3", 2);

   else							C2T0_stb_drain_cnt = C2T0_stb_drain_cnt + 1;
   if(C2T0_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 0 is not draining", 2);

   else							C2T1_stb_drain_cnt = C2T1_stb_drain_cnt + 1;
   if(C2T1_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 1 is not draining", 2);

   else							C2T2_stb_drain_cnt = C2T2_stb_drain_cnt + 1;
   if(C2T2_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 2 is not draining", 2);

   else							C2T3_stb_drain_cnt = C2T3_stb_drain_cnt + 1;
   if(C2T3_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 3 is not draining", 2);

  C2T0_stb_vld_sum_d1 <= C2T0_stb_vld_sum;
  C2T1_stb_vld_sum_d1 <= C2T1_stb_vld_sum;
  C2T2_stb_vld_sum_d1 <= C2T2_stb_vld_sum;
  C2T3_stb_vld_sum_d1 <= C2T3_stb_vld_sum;
  C2T0_defr_trp_en_d1 <= C2T0_defr_trp_en;
  C2T1_defr_trp_en_d1 <= C2T1_defr_trp_en;
  C2T2_defr_trp_en_d1 <= C2T2_defr_trp_en;
  C2T3_defr_trp_en_d1 <= C2T3_defr_trp_en;

  if(rst_l & C2T0_defr_trp_en_d1 & (C2T0_stb_vld_sum_d1 < C2T0_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T0", 2);
  if(rst_l & C2T1_defr_trp_en_d1 & (C2T1_stb_vld_sum_d1 < C2T1_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T1", 2);
  if(rst_l & C2T2_defr_trp_en_d1 & (C2T2_stb_vld_sum_d1 < C2T2_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T2", 2);
  if(rst_l & C2T3_defr_trp_en_d1 & (C2T3_stb_vld_sum_d1 < C2T3_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T3", 2);

end
`endif



`ifdef RTL_SPARC3
`ifndef RTL_SPU
wire   C3T0_stb_ne    = |`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C3T1_stb_ne    = |`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C3T2_stb_ne    = |`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C3T3_stb_ne    = |`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C3T0_stb_nced  = |(   `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0] &
                ~`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C3T1_stb_nced  = |(   `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0] &
                ~`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C3T2_stb_nced  = |(   `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0] &
                ~`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C3T3_stb_nced  = |(   `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0] &
                ~`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc3_lsu_ifill_pkt_vld   = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc3_dfq_rd_advance          = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dfq_rd_advance;
wire   spc3_dfq_int_type        = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dfq_int_type;

wire   spc3_ifu_lsu_inv_clear   = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.ifu_lsu_inv_clear;

wire        spc3_dva_svld_e         = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dva_svld_e;
wire        spc3_dva_rvld_e     = `SPARC_CORE3.sparc0.lsu.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc3_dva_rd_addr_e      = `SPARC_CORE3.sparc0.lsu.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [`L1D_ADDRESS_HI-6:0]  spc3_dva_snp_addr_e     = `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dva_snp_addr_e[`L1D_ADDRESS_HI-6:0];

wire [4:0]  spc3_stb_data_rd_ptr    = `SPARC_CORE3.sparc0.lsu.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc3_stb_data_wr_ptr    = `SPARC_CORE3.sparc0.lsu.lsu.stb_data_wr_ptr[4:0];
wire        spc3_stb_data_wptr_vld  = `SPARC_CORE3.sparc0.lsu.lsu.stb_data_wptr_vld;
wire        spc3_stb_data_rptr_vld  = `SPARC_CORE3.sparc0.lsu.lsu.stb_data_rptr_vld;
wire        spc3_stbrwctl_flush_pipe_w = `SPARC_CORE3.sparc0.lsu.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc3_lsu_st_pcx_rq_pick     = |`SPARC_CORE3.sparc0.lsu.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [`L1D_WAY_ARRAY_MASK]  spc3_lsu_rd_dtag_parity_g = `SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_rd_dtag_parity_g[`L1D_WAY_ARRAY_MASK];
wire [`L1D_WAY_ARRAY_MASK]  spc3_dva_vld_g       = `SPARC_CORE3.sparc0.lsu.lsu.dctl.dva_vld_g[`L1D_WAY_ARRAY_MASK];

wire [3:0]  spc3_lsu_dc_tag_pe_g_unmasked    = spc3_lsu_rd_dtag_parity_g[3:0] & spc3_dva_vld_g[3:0];
wire        spc3_lsu_dc_tag_pe_g_unmasked_or = |spc3_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C3T0_stb_full  = &`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C3T1_stb_full  = &`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C3T2_stb_full  = &`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C3T3_stb_full  = &`SPARC_CORE3.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C3T0_stb_vld  = `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C3T1_stb_vld  = `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C3T2_stb_vld  = `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C3T3_stb_vld  = `SPARC_CORE3.sparc0.lsu.lsu.stb_ctl3.stb_state_vld[7:0];
`else
wire   C3T0_stb_ne    = |`SPARC_CORE3.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C3T1_stb_ne    = |`SPARC_CORE3.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C3T2_stb_ne    = |`SPARC_CORE3.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C3T3_stb_ne    = |`SPARC_CORE3.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   C3T0_stb_nced  = |(	 `SPARC_CORE3.sparc0.lsu.stb_ctl0.stb_state_vld[7:0] &
				~`SPARC_CORE3.sparc0.lsu.stb_ctl0.stb_state_ced[7:0]);
wire   C3T1_stb_nced  = |(	 `SPARC_CORE3.sparc0.lsu.stb_ctl1.stb_state_vld[7:0] &
				~`SPARC_CORE3.sparc0.lsu.stb_ctl1.stb_state_ced[7:0]);
wire   C3T2_stb_nced  = |(	 `SPARC_CORE3.sparc0.lsu.stb_ctl2.stb_state_vld[7:0] &
				~`SPARC_CORE3.sparc0.lsu.stb_ctl2.stb_state_ced[7:0]);
wire   C3T3_stb_nced  = |(	 `SPARC_CORE3.sparc0.lsu.stb_ctl3.stb_state_vld[7:0] &
				~`SPARC_CORE3.sparc0.lsu.stb_ctl3.stb_state_ced[7:0]);

wire   spc3_lsu_ifill_pkt_vld	= `SPARC_CORE3.sparc0.lsu.qctl2.lsu_ifill_pkt_vld;
wire   spc3_dfq_rd_advance  		= `SPARC_CORE3.sparc0.lsu.qctl2.dfq_rd_advance;
wire   spc3_dfq_int_type  		= `SPARC_CORE3.sparc0.lsu.qctl2.dfq_int_type;

wire   spc3_ifu_lsu_inv_clear	= `SPARC_CORE3.sparc0.lsu.qctl2.ifu_lsu_inv_clear;

wire 	    spc3_dva_svld_e 	 	= `SPARC_CORE3.sparc0.lsu.qctl2.dva_svld_e;
wire 	    spc3_dva_rvld_e	 	= `SPARC_CORE3.sparc0.lsu.dva.rd_en;
wire [`L1D_ADDRESS_HI:4] spc3_dva_rd_addr_e  	= `SPARC_CORE3.sparc0.lsu.dva.rd_adr1[`L1D_ADDRESS_HI-4:0];
wire [4:0]  spc3_dva_snp_addr_e 	= `SPARC_CORE3.sparc0.lsu.qctl2.dva_snp_addr_e[4:0];

wire [4:0]  spc3_stb_data_rd_ptr   	= `SPARC_CORE3.sparc0.lsu.stb_data_rd_ptr[4:0];
wire [4:0]  spc3_stb_data_wr_ptr   	= `SPARC_CORE3.sparc0.lsu.stb_data_wr_ptr[4:0];
wire        spc3_stb_data_wptr_vld 	= `SPARC_CORE3.sparc0.lsu.stb_data_wptr_vld;
wire        spc3_stb_data_rptr_vld 	= `SPARC_CORE3.sparc0.lsu.stb_data_rptr_vld;
wire        spc3_stbrwctl_flush_pipe_w = `SPARC_CORE3.sparc0.lsu.stb_rwctl.lsu_stbrwctl_flush_pipe_w;
wire        spc3_lsu_st_pcx_rq_pick 	= |`SPARC_CORE3.sparc0.lsu.stb_rwctl.lsu_st_pcx_rq_pick[3:0];

wire [3:0]  spc3_lsu_rd_dtag_parity_g = `SPARC_CORE3.sparc0.lsu.dctl.lsu_rd_dtag_parity_g[3:0];
wire [3:0]  spc3_dva_vld_g		 = `SPARC_CORE3.sparc0.lsu.dctl.dva_vld_g[3:0];

wire [3:0]  spc3_lsu_dc_tag_pe_g_unmasked    = spc3_lsu_rd_dtag_parity_g[3:0] & spc3_dva_vld_g[3:0];
wire        spc3_lsu_dc_tag_pe_g_unmasked_or = |spc3_lsu_dc_tag_pe_g_unmasked[3:0];

wire   C3T0_stb_full  = &`SPARC_CORE3.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   C3T1_stb_full  = &`SPARC_CORE3.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   C3T2_stb_full  = &`SPARC_CORE3.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   C3T3_stb_full  = &`SPARC_CORE3.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];

wire   [7:0] C3T0_stb_vld  = `SPARC_CORE3.sparc0.lsu.stb_ctl0.stb_state_vld[7:0];
wire   [7:0] C3T1_stb_vld  = `SPARC_CORE3.sparc0.lsu.stb_ctl1.stb_state_vld[7:0];
wire   [7:0] C3T2_stb_vld  = `SPARC_CORE3.sparc0.lsu.stb_ctl2.stb_state_vld[7:0];
wire   [7:0] C3T3_stb_vld  = `SPARC_CORE3.sparc0.lsu.stb_ctl3.stb_state_vld[7:0];
`endif

wire   [4:0] C3T0_stb_vld_sum  =  C3T0_stb_vld[0] +  C3T0_stb_vld[1] +  C3T0_stb_vld[2] +  C3T0_stb_vld[3] +
                                     C3T0_stb_vld[4] +  C3T0_stb_vld[5] +  C3T0_stb_vld[6] +  C3T0_stb_vld[7] ;
wire   [4:0] C3T1_stb_vld_sum  =  C3T1_stb_vld[0] +  C3T1_stb_vld[1] +  C3T1_stb_vld[2] +  C3T1_stb_vld[3] +
                                     C3T1_stb_vld[4] +  C3T1_stb_vld[5] +  C3T1_stb_vld[6] +  C3T1_stb_vld[7] ;
wire   [4:0] C3T2_stb_vld_sum  =  C3T2_stb_vld[0] +  C3T2_stb_vld[1] +  C3T2_stb_vld[2] +  C3T2_stb_vld[3] +
                                     C3T2_stb_vld[4] +  C3T2_stb_vld[5] +  C3T2_stb_vld[6] +  C3T2_stb_vld[7] ;
wire   [4:0] C3T3_stb_vld_sum  =  C3T3_stb_vld[0] +  C3T3_stb_vld[1] +  C3T3_stb_vld[2] +  C3T3_stb_vld[3] +
                                     C3T3_stb_vld[4] +  C3T3_stb_vld[5] +  C3T3_stb_vld[6] +  C3T3_stb_vld[7] ;

reg [4:0] C3T0_stb_vld_sum_d1;
reg [4:0] C3T1_stb_vld_sum_d1;
reg [4:0] C3T2_stb_vld_sum_d1;
reg [4:0] C3T3_stb_vld_sum_d1;

`ifndef RTL_SPU
wire   C3T0_st_ack  = &`SPARC_CORE3.sparc0.lsu.lsu.cpx_st_ack_tid0;
wire   C3T1_st_ack  = &`SPARC_CORE3.sparc0.lsu.lsu.cpx_st_ack_tid1;
wire   C3T2_st_ack  = &`SPARC_CORE3.sparc0.lsu.lsu.cpx_st_ack_tid2;
wire   C3T3_st_ack  = &`SPARC_CORE3.sparc0.lsu.lsu.cpx_st_ack_tid3;

wire   C3T0_defr_trp_en = &`SPARC_CORE3.sparc0.lsu.lsu.excpctl.st_defr_trp_en0;
wire   C3T1_defr_trp_en = &`SPARC_CORE3.sparc0.lsu.lsu.excpctl.st_defr_trp_en1;
wire   C3T2_defr_trp_en = &`SPARC_CORE3.sparc0.lsu.lsu.excpctl.st_defr_trp_en2;
wire   C3T3_defr_trp_en = &`SPARC_CORE3.sparc0.lsu.lsu.excpctl.st_defr_trp_en3;
`else
wire   C3T0_st_ack  = &`SPARC_CORE3.sparc0.lsu.cpx_st_ack_tid0;
wire   C3T1_st_ack  = &`SPARC_CORE3.sparc0.lsu.cpx_st_ack_tid1;
wire   C3T2_st_ack  = &`SPARC_CORE3.sparc0.lsu.cpx_st_ack_tid2;
wire   C3T3_st_ack  = &`SPARC_CORE3.sparc0.lsu.cpx_st_ack_tid3;

wire   C3T0_defr_trp_en	= &`SPARC_CORE3.sparc0.lsu.excpctl.st_defr_trp_en0;
wire   C3T1_defr_trp_en	= &`SPARC_CORE3.sparc0.lsu.excpctl.st_defr_trp_en1;
wire   C3T2_defr_trp_en	= &`SPARC_CORE3.sparc0.lsu.excpctl.st_defr_trp_en2;
wire   C3T3_defr_trp_en	= &`SPARC_CORE3.sparc0.lsu.excpctl.st_defr_trp_en3;
`endif

reg C3T0_defr_trp_en_d1;
reg C3T1_defr_trp_en_d1;
reg C3T2_defr_trp_en_d1;
reg C3T3_defr_trp_en_d1;

integer C3T0_stb_drain_cnt;
integer C3T1_stb_drain_cnt;
integer C3T2_stb_drain_cnt;
integer C3T3_stb_drain_cnt;

// Hits in the store buffer
//-------------------------
`ifndef RTL_SPU
wire       spc3_inst_vld_w      = `SPARC_CORE3.sparc0.ifu.ifu.fcl.inst_vld_w;
wire [1:0] spc3_sas_thrid_w     = `SPARC_CORE3.sparc0.ifu.ifu.fcl.sas_thrid_w[1:0];
`else
wire       spc3_inst_vld_w		= `SPARC_CORE3.sparc0.ifu.fcl.inst_vld_w;
wire [1:0] spc3_sas_thrid_w		= `SPARC_CORE3.sparc0.ifu.fcl.sas_thrid_w[1:0];
`endif

wire C3_st_ack_w = (spc3_sas_thrid_w == 2'b00) & C3T0_st_ack |
                      (spc3_sas_thrid_w == 2'b01) & C3T1_st_ack |
                      (spc3_sas_thrid_w == 2'b10) & C3T2_st_ack |
                      (spc3_sas_thrid_w == 2'b11) & C3T3_st_ack;

`ifndef RTL_SPU
wire [7:0] spc3_stb_ld_full_raw = `SPARC_CORE3.sparc0.lsu.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc3_stb_ld_partial_raw  = `SPARC_CORE3.sparc0.lsu.lsu.stb_ld_partial_raw[7:0];
wire       spc3_stb_cam_mhit        = `SPARC_CORE3.sparc0.lsu.lsu.stb_cam_mhit;
wire       spc3_stb_cam_hit     = `SPARC_CORE3.sparc0.lsu.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc3_lsu_way_hit     = `SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc3_lsu_ifu_ldst_miss_w = `SPARC_CORE3.sparc0.lsu.lsu.lsu_ifu_ldst_miss_w;
wire       spc3_ld_inst_vld_g   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.ld_inst_vld_g;
wire       spc3_ldst_dbl_g      = `SPARC_CORE3.sparc0.lsu.lsu.dctl.ldst_dbl_g;
wire       spc3_quad_asi_g      = `SPARC_CORE3.sparc0.lsu.lsu.dctl.quad_asi_g;
wire [1:0] spc3_ldst_sz_g       = `SPARC_CORE3.sparc0.lsu.lsu.dctl.ldst_sz_g;
wire       spc3_lsu_alt_space_g = `SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_alt_space_g;

wire       spc3_mbar_inst0_g        = `SPARC_CORE3.sparc0.lsu.lsu.dctl.mbar_inst0_g;
wire       spc3_mbar_inst1_g        = `SPARC_CORE3.sparc0.lsu.lsu.dctl.mbar_inst1_g;
wire       spc3_mbar_inst2_g        = `SPARC_CORE3.sparc0.lsu.lsu.dctl.mbar_inst2_g;
wire       spc3_mbar_inst3_g        = `SPARC_CORE3.sparc0.lsu.lsu.dctl.mbar_inst3_g;

wire       spc3_flush_inst0_g   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.flush_inst0_g;
wire       spc3_flush_inst1_g   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.flush_inst1_g;
wire       spc3_flush_inst2_g   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.flush_inst2_g;
wire       spc3_flush_inst3_g   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.flush_inst3_g;

wire       spc3_intrpt_disp_asi0_g  = `SPARC_CORE3.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b00);
wire       spc3_intrpt_disp_asi1_g  = `SPARC_CORE3.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b01);
wire       spc3_intrpt_disp_asi2_g  = `SPARC_CORE3.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b10);
wire       spc3_intrpt_disp_asi3_g  = `SPARC_CORE3.sparc0.lsu.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b11);

wire       spc3_st_inst_vld_g   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.st_inst_vld_g;
wire       spc3_non_altspace_ldst_g = `SPARC_CORE3.sparc0.lsu.lsu.dctl.non_altspace_ldst_g;

wire       spc3_dctl_flush_pipe_w   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc3_no_spc_rmo_st   = `SPARC_CORE3.sparc0.lsu.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc3_ldst_fp_e       = `SPARC_CORE3.sparc0.lsu.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc3_stb_rdptr       = `SPARC_CORE3.sparc0.lsu.lsu.stb_rwctl.stb_rdptr_l;

wire       spc3_ld_l2cache_req  = `SPARC_CORE3.sparc0.lsu.lsu.qctl1.ld3_l2cache_rq |
                      `SPARC_CORE3.sparc0.lsu.lsu.qctl1.ld2_l2cache_rq |
                              `SPARC_CORE3.sparc0.lsu.lsu.qctl1.ld1_l2cache_rq |
                      `SPARC_CORE3.sparc0.lsu.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc3_dcache_enable   = {`SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_ctl_reg0[1],
                                           `SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_ctl_reg1[1],
                       `SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_ctl_reg2[1],
                       `SPARC_CORE3.sparc0.lsu.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc3_icache_enable   = `SPARC_CORE3.sparc0.lsu.lsu.lsu_ifu_icache_en[3:0];

wire spc3_dc_direct_map         = `SPARC_CORE3.sparc0.lsu.lsu.dc_direct_map;
wire spc3_lsu_ifu_direct_map_l1 = `SPARC_CORE3.sparc0.lsu.lsu.lsu_ifu_direct_map_l1;
`else
wire [7:0] spc3_stb_ld_full_raw	= `SPARC_CORE3.sparc0.lsu.stb_ld_full_raw[7:0];
wire [7:0] spc3_stb_ld_partial_raw	= `SPARC_CORE3.sparc0.lsu.stb_ld_partial_raw[7:0];
wire       spc3_stb_cam_mhit		= `SPARC_CORE3.sparc0.lsu.stb_cam_mhit;
wire       spc3_stb_cam_hit		= `SPARC_CORE3.sparc0.lsu.stb_cam_hit;
wire [`L1D_WAY_ARRAY_MASK] spc3_lsu_way_hit		= `SPARC_CORE3.sparc0.lsu.dctl.lsu_way_hit[`L1D_WAY_ARRAY_MASK];
wire       spc3_lsu_ifu_ldst_miss_w	= `SPARC_CORE3.sparc0.lsu.lsu_ifu_ldst_miss_w;
wire       spc3_ld_inst_vld_g	= `SPARC_CORE3.sparc0.lsu.dctl.ld_inst_vld_g;
wire       spc3_ldst_dbl_g		= `SPARC_CORE3.sparc0.lsu.dctl.ldst_dbl_g;
wire       spc3_quad_asi_g		= `SPARC_CORE3.sparc0.lsu.dctl.quad_asi_g;
wire [1:0] spc3_ldst_sz_g		= `SPARC_CORE3.sparc0.lsu.dctl.ldst_sz_g;
wire       spc3_lsu_alt_space_g	= `SPARC_CORE3.sparc0.lsu.dctl.lsu_alt_space_g;

wire       spc3_mbar_inst0_g		= `SPARC_CORE3.sparc0.lsu.dctl.mbar_inst0_g;
wire       spc3_mbar_inst1_g		= `SPARC_CORE3.sparc0.lsu.dctl.mbar_inst1_g;
wire       spc3_mbar_inst2_g		= `SPARC_CORE3.sparc0.lsu.dctl.mbar_inst2_g;
wire       spc3_mbar_inst3_g		= `SPARC_CORE3.sparc0.lsu.dctl.mbar_inst3_g;

wire       spc3_flush_inst0_g	= `SPARC_CORE3.sparc0.lsu.dctl.flush_inst0_g;
wire       spc3_flush_inst1_g	= `SPARC_CORE3.sparc0.lsu.dctl.flush_inst1_g;
wire       spc3_flush_inst2_g	= `SPARC_CORE3.sparc0.lsu.dctl.flush_inst2_g;
wire       spc3_flush_inst3_g	= `SPARC_CORE3.sparc0.lsu.dctl.flush_inst3_g;

wire       spc3_intrpt_disp_asi0_g	= `SPARC_CORE3.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b00);
wire       spc3_intrpt_disp_asi1_g	= `SPARC_CORE3.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b01);
wire       spc3_intrpt_disp_asi2_g	= `SPARC_CORE3.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b10);
wire       spc3_intrpt_disp_asi3_g	= `SPARC_CORE3.sparc0.lsu.dctl.intrpt_disp_asi_g & (spc3_sas_thrid_w == 2'b11);

wire       spc3_st_inst_vld_g	= `SPARC_CORE3.sparc0.lsu.dctl.st_inst_vld_g;
wire       spc3_non_altspace_ldst_g	= `SPARC_CORE3.sparc0.lsu.dctl.non_altspace_ldst_g;

wire       spc3_dctl_flush_pipe_w	= `SPARC_CORE3.sparc0.lsu.dctl.dctl_flush_pipe_w;

wire [3:0] spc3_no_spc_rmo_st	= `SPARC_CORE3.sparc0.lsu.dctl.no_spc_rmo_st[3:0];


wire       spc3_ldst_fp_e		= `SPARC_CORE3.sparc0.lsu.ifu_lsu_ldst_fp_e;
wire [2:0] spc3_stb_rdptr		= `SPARC_CORE3.sparc0.lsu.stb_rwctl.stb_rdptr_l;

wire 	   spc3_ld_l2cache_req 	= `SPARC_CORE3.sparc0.lsu.qctl1.ld3_l2cache_rq |
					  `SPARC_CORE3.sparc0.lsu.qctl1.ld2_l2cache_rq |
                 			  `SPARC_CORE3.sparc0.lsu.qctl1.ld1_l2cache_rq |
					  `SPARC_CORE3.sparc0.lsu.qctl1.ld0_l2cache_rq;

wire [3:0] spc3_dcache_enable	= {`SPARC_CORE3.sparc0.lsu.dctl.lsu_ctl_reg0[1],
                                    	   `SPARC_CORE3.sparc0.lsu.dctl.lsu_ctl_reg1[1],
					   `SPARC_CORE3.sparc0.lsu.dctl.lsu_ctl_reg2[1],
					   `SPARC_CORE3.sparc0.lsu.dctl.lsu_ctl_reg3[1]};

wire [3:0] spc3_icache_enable	= `SPARC_CORE3.sparc0.lsu.lsu_ifu_icache_en[3:0];

wire spc3_dc_direct_map 		= `SPARC_CORE3.sparc0.lsu.dc_direct_map;
wire spc3_lsu_ifu_direct_map_l1	= `SPARC_CORE3.sparc0.lsu.lsu_ifu_direct_map_l1;
`endif

always @(spc3_dcache_enable)
    $display("%0d tso_mon: spc3_dcache_enable changed to %x", $time, spc3_dcache_enable);

always @(spc3_icache_enable)
    $display("%0d tso_mon: spc3_icache_enable changed to %x", $time, spc3_icache_enable);

always @(spc3_dc_direct_map)
    $display("%0d tso_mon: spc3_dc_direct_map changed to %x", $time, spc3_dc_direct_map);

always @(spc3_lsu_ifu_direct_map_l1)
   $display("%0d tso_mon: spc3_lsu_ifu_direct_map_l1 changed to %x", $time, spc3_lsu_ifu_direct_map_l1);

reg 		spc3_dva_svld_e_d1;
reg 		spc3_dva_rvld_e_d1;
reg [`L1D_ADDRESS_HI:4] 	spc3_dva_rd_addr_e_d1;
reg [4:0]  	spc3_dva_snp_addr_e_d1;

reg   		spc3_lsu_snp_after_rd;
reg   		spc3_lsu_rd_after_snp;

reg 	   	spc3_ldst_fp_m, spc3_ldst_fp_g;

integer 	spc3_multiple_hits;

reg spc3_skid_d1, spc3_skid_d2, spc3_skid_d3;
initial begin
  spc3_skid_d1 = 0;
  spc3_skid_d2 = 0;
  spc3_skid_d3 = 0;
end

always @(posedge clk)
begin

  spc3_skid_d1 <= (~spc3_ifu_lsu_inv_clear & spc3_dfq_rd_advance & spc3_dfq_int_type);
  spc3_skid_d2 <= spc3_skid_d1 & ~spc3_ifu_lsu_inv_clear;
  spc3_skid_d3 <= spc3_skid_d2 & ~spc3_ifu_lsu_inv_clear;

// The full tracking of this condition is complicated since after the interrupt is advanced
// there may be more invalidations to the IFQ.
// All we care about is that the invalidations BEFORE the interrupt are finished.
// I provided a command line argument to disable this check.
  if(spc3_skid_d3 & enable_ifu_lsu_inv_clear)
     finish_test("spc", "tso_mon:   spc3_ifu_lsu_inv_clear should have been clear by now", 3);

  spc3_dva_svld_e_d1 	<= spc3_dva_svld_e;
  spc3_dva_rvld_e_d1 	<= spc3_dva_rvld_e;
  spc3_dva_rd_addr_e_d1 	<= spc3_dva_rd_addr_e;
  spc3_dva_snp_addr_e_d1 	<= spc3_dva_snp_addr_e;

  if(spc3_dva_svld_e_d1 & spc3_dva_rvld_e & (spc3_dva_rd_addr_e_d1[`L1D_ADDRESS_HI:6] == spc3_dva_snp_addr_e[4:0]))
    spc3_lsu_rd_after_snp <= 1'b1;
  else
    spc3_lsu_rd_after_snp <= 1'b0;

  if(spc3_dva_svld_e & spc3_dva_rvld_e_d1 & (spc3_dva_rd_addr_e[`L1D_ADDRESS_HI:6] == spc3_dva_snp_addr_e_d1[4:0]))
    spc3_lsu_snp_after_rd <= 1'b1;
  else
    spc3_lsu_snp_after_rd <= 1'b0;

  spc3_ldst_fp_m <= spc3_ldst_fp_e;
  spc3_ldst_fp_g <= spc3_ldst_fp_m;

  if(spc3_stb_data_rptr_vld & spc3_stb_data_wptr_vld & ~spc3_stbrwctl_flush_pipe_w &
     (spc3_stb_data_rd_ptr == spc3_stb_data_wr_ptr) & spc3_lsu_st_pcx_rq_pick)
  begin
    finish_test("spc", "tso_mon: LSU stb data write and read in the same cycle", 3);
  end

   spc3_multiple_hits = (spc3_lsu_way_hit[3] + spc3_lsu_way_hit[2] + spc3_lsu_way_hit[1] + spc3_lsu_way_hit[0]);
   if(!spc3_lsu_ifu_ldst_miss_w && (spc3_multiple_hits >1) && spc3_inst_vld_w && !spc3_dctl_flush_pipe_w && !spc3_lsu_dc_tag_pe_g_unmasked_or)
     finish_test("spc", "tso_mon: LSU multiple hits ", 3);
end

wire spc3_ld_dbl      = spc3_ld_inst_vld_g &  spc3_ldst_dbl_g &  ~spc3_quad_asi_g;
wire spc3_ld_quad     = spc3_ld_inst_vld_g &  spc3_ldst_dbl_g &  spc3_quad_asi_g;
wire spc3_ld_other    = spc3_ld_inst_vld_g & ~spc3_ldst_dbl_g;

wire spc3_ld_dbl_fp   = spc3_ld_dbl        &  spc3_ldst_fp_g;
wire spc3_ld_other_fp = spc3_ld_other      &  spc3_ldst_fp_g;

wire spc3_ld_dbl_int  = spc3_ld_dbl        & ~spc3_ldst_fp_g;
wire spc3_ld_quad_int = spc3_ld_quad       & ~spc3_ldst_fp_g;
wire spc3_ld_other_int= spc3_ld_other      & ~spc3_ldst_fp_g;

wire spc3_ld_bypassok_hit = |spc3_stb_ld_full_raw[7:0] & ~spc3_stb_cam_mhit;
wire spc3_ld_partial_hit  = |spc3_stb_ld_partial_raw[7:0] & ~spc3_stb_cam_mhit;
wire spc3_ld_multiple_hit =  spc3_stb_cam_mhit;

wire spc3_any_lsu_way_hit = |spc3_lsu_way_hit;

wire [7:0] spc3_stb_rdptr_decoded = 	(spc3_stb_rdptr ==3'b000) ? 8'b00000001 :
                               		(spc3_stb_rdptr ==3'b001) ? 8'b00000010 :
                               		(spc3_stb_rdptr ==3'b010) ? 8'b00000100 :
                              		(spc3_stb_rdptr ==3'b011) ? 8'b00001000 :
                              		(spc3_stb_rdptr ==3'b100) ? 8'b00010000 :
                              		(spc3_stb_rdptr ==3'b101) ? 8'b00100000 :
                             		(spc3_stb_rdptr ==3'b110) ? 8'b01000000 :
                              		(spc3_stb_rdptr ==3'b111) ? 8'b10000000 : 8'h00;


wire spc3_stb_top_hit = |(spc3_stb_rdptr_decoded & (spc3_stb_ld_full_raw | spc3_stb_ld_partial_raw));

//---------------------------------------------------------------------
// ld_type[4:0] hit_type[2:0], cache_hit, hit_top
// this is passed to the coverage monitor.
//---------------------------------------------------------------------
wire [10:0] spc3_stb_ld_hit_info =
	{spc3_ld_dbl_fp,        spc3_ld_other_fp,
	 spc3_ld_dbl_int, 	   spc3_ld_quad_int,    spc3_ld_other_int,
	 spc3_ld_bypassok_hit,  spc3_ld_partial_hit, spc3_ld_multiple_hit,
	 spc3_any_lsu_way_hit,
	 spc3_stb_top_hit, C3_st_ack_w};

reg spc3_mbar0_active;
reg spc3_mbar1_active;
reg spc3_mbar2_active;
reg spc3_mbar3_active;

reg spc3_flush0_active;
reg spc3_flush1_active;
reg spc3_flush2_active;
reg spc3_flush3_active;

reg spc3_intr0_active;
reg spc3_intr1_active;
reg spc3_intr2_active;
reg spc3_intr3_active;

always @(negedge clk)
begin
  if(~rst_l)
  begin
     spc3_mbar0_active <= 1'b0;
     spc3_mbar1_active <= 1'b0;
     spc3_mbar2_active <= 1'b0;
     spc3_mbar3_active <= 1'b0;

     spc3_flush0_active <= 1'b0;
     spc3_flush1_active <= 1'b0;
     spc3_flush2_active <= 1'b0;
     spc3_flush3_active <= 1'b0;

     spc3_intr0_active <= 1'b0;
     spc3_intr1_active <= 1'b0;
     spc3_intr2_active <= 1'b0;
     spc3_intr3_active <= 1'b0;

  end
  else
  begin
    if(spc3_mbar_inst0_g & ~spc3_dctl_flush_pipe_w & (C3T0_stb_ne|~spc3_no_spc_rmo_st[0]))
	spc3_mbar0_active <= 1'b1;
    else if(~C3T0_stb_ne & spc3_no_spc_rmo_st[0])
	spc3_mbar0_active <= 1'b0;
    if(spc3_mbar_inst1_g & ~ spc3_dctl_flush_pipe_w & (C3T1_stb_ne|~spc3_no_spc_rmo_st[1]))
	spc3_mbar1_active <= 1'b1;
    else if(~C3T1_stb_ne & spc3_no_spc_rmo_st[1])
	spc3_mbar1_active <= 1'b0;
    if(spc3_mbar_inst2_g & ~ spc3_dctl_flush_pipe_w & (C3T2_stb_ne|~spc3_no_spc_rmo_st[2]))
	spc3_mbar2_active <= 1'b1;
    else if(~C3T2_stb_ne & spc3_no_spc_rmo_st[2])
	spc3_mbar2_active <= 1'b0;
    if(spc3_mbar_inst3_g & ~ spc3_dctl_flush_pipe_w & (C3T3_stb_ne|~spc3_no_spc_rmo_st[3]))
	spc3_mbar3_active <= 1'b1;
    else if(~C3T3_stb_ne & spc3_no_spc_rmo_st[3])
	spc3_mbar3_active <= 1'b0;

    if(spc3_flush_inst0_g & ~spc3_dctl_flush_pipe_w & C3T0_stb_ne) 	spc3_flush0_active <= 1'b1;
    else if(~C3T0_stb_ne)			  				spc3_flush0_active <= 1'b0;
    if(spc3_flush_inst1_g & ~spc3_dctl_flush_pipe_w & C3T1_stb_ne) 	spc3_flush1_active <= 1'b1;
    else if(~C3T1_stb_ne)			  				spc3_flush1_active <= 1'b0;
    if(spc3_flush_inst2_g & ~spc3_dctl_flush_pipe_w & C3T2_stb_ne) 	spc3_flush2_active <= 1'b1;
    else if(~C3T2_stb_ne)			  				spc3_flush2_active <= 1'b0;
    if(spc3_flush_inst3_g & ~spc3_dctl_flush_pipe_w & C3T3_stb_ne) 	spc3_flush3_active <= 1'b1;
    else if(~C3T3_stb_ne)			  				spc3_flush3_active <= 1'b0;

    if(spc3_intrpt_disp_asi0_g & spc3_st_inst_vld_g & ~spc3_non_altspace_ldst_g & ~spc3_dctl_flush_pipe_w & C3T0_stb_ne)
	spc3_intr0_active <= 1'b1;
    else if(~C3T0_stb_ne)
	spc3_intr0_active <= 1'b0;
    if(spc3_intrpt_disp_asi1_g &  spc3_st_inst_vld_g & ~spc3_non_altspace_ldst_g & ~spc3_dctl_flush_pipe_w & C3T1_stb_ne)
	spc3_intr1_active <= 1'b1;
    else if(~C3T1_stb_ne)
	spc3_intr1_active <= 1'b0;
    if(spc3_intrpt_disp_asi2_g &  spc3_st_inst_vld_g & ~spc3_non_altspace_ldst_g & ~spc3_dctl_flush_pipe_w & C3T2_stb_ne)
	spc3_intr2_active <= 1'b1;
    else if(~C3T2_stb_ne)
	spc3_intr2_active <= 1'b0;
    if(spc3_intrpt_disp_asi3_g &  spc3_st_inst_vld_g & ~spc3_non_altspace_ldst_g & ~spc3_dctl_flush_pipe_w & C3T3_stb_ne)
	spc3_intr3_active <= 1'b1;
    else if(~C3T3_stb_ne)
	spc3_intr3_active <= 1'b0;
  end

  if(spc3_mbar0_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "membar violation thread 0", 3);
  if(spc3_mbar1_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "membar violation thread 1", 3);
  if(spc3_mbar2_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "membar violation thread 2", 3);
  if(spc3_mbar3_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "membar violation thread 3", 3);

  if(spc3_flush0_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "flush violation thread 0", 3);
  if(spc3_flush1_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "flush violation thread 1", 3);
  if(spc3_flush2_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "flush violation thread 2", 3);
  if(spc3_flush3_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "flush violation thread 3", 3);

  if(spc3_intr0_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b00)
    finish_test("spc", "intr violation thread 0", 3);
  if(spc3_intr1_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b01)
    finish_test("spc", "intr violation thread 1", 3);
  if(spc3_intr2_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b10)
    finish_test("spc", "intr violation thread 2", 3);
  if(spc3_intr3_active & spc3_inst_vld_w & spc3_sas_thrid_w[1:0] == 2'b11)
    finish_test("spc", "intr violation thread 3", 3);

   else							C3T0_stb_drain_cnt = C3T0_stb_drain_cnt + 1;
   if(C3T0_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 0 is not draining", 3);

   else							C3T1_stb_drain_cnt = C3T1_stb_drain_cnt + 1;
   if(C3T1_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 1 is not draining", 3);

   else							C3T2_stb_drain_cnt = C3T2_stb_drain_cnt + 1;
   if(C3T2_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 2 is not draining", 3);

   else							C3T3_stb_drain_cnt = C3T3_stb_drain_cnt + 1;
   if(C3T3_stb_drain_cnt > stb_drain_to_max)
     finish_test("spc", "stb 3 is not draining", 3);

  C3T0_stb_vld_sum_d1 <= C3T0_stb_vld_sum;
  C3T1_stb_vld_sum_d1 <= C3T1_stb_vld_sum;
  C3T2_stb_vld_sum_d1 <= C3T2_stb_vld_sum;
  C3T3_stb_vld_sum_d1 <= C3T3_stb_vld_sum;
  C3T0_defr_trp_en_d1 <= C3T0_defr_trp_en;
  C3T1_defr_trp_en_d1 <= C3T1_defr_trp_en;
  C3T2_defr_trp_en_d1 <= C3T2_defr_trp_en;
  C3T3_defr_trp_en_d1 <= C3T3_defr_trp_en;

  if(rst_l & C3T0_defr_trp_en_d1 & (C3T0_stb_vld_sum_d1 < C3T0_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T0", 3);
  if(rst_l & C3T1_defr_trp_en_d1 & (C3T1_stb_vld_sum_d1 < C3T1_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T1", 3);
  if(rst_l & C3T2_defr_trp_en_d1 & (C3T2_stb_vld_sum_d1 < C3T2_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T2", 3);
  if(rst_l & C3T3_defr_trp_en_d1 & (C3T3_stb_vld_sum_d1 < C3T3_stb_vld_sum))
     finish_test("spc", "tso_mon: deferred trap problems for store T3", 3);

end
`endif





//-----------------------------------------------------------------------------
// This is put to catch a nasty rust bug where IFILL packet does not invalidate the
// D I exclusivity
// pardon my hardwired numbers
// FSM - 00 iDLE
//       01 started
//       10 ifill_pkt is out the ibuf_busy is high so handshake not finished
//----------------------------------------------------------------------------

`ifdef RTL_SPARC0
reg [1:0] spc0_dfq_fsm1;
integer  spc0_dfq_forced;

initial begin
    spc0_dfq_fsm1   = 2'b00;
    spc0_dfq_forced = 0;
end

always @(posedge clk)
begin
  if(~rst_l)
  begin
    cpx_spc0_data_cx2_d2  <= `CPX_WIDTH'b0;
    cpx_spc0_data_cx2_d1  <= `CPX_WIDTH'b0;
    spc0_dfq_byp_ff_en_d1 <= 1'b0;
    spc0_dfq_wr_en_d1     <= 1'b0;
    spc0_dfq_fsm1	     <= 2'b00;
    spc0_dfq_forced       <= 0;

  end
  else
  begin

    cpx_spc0_data_cx2_d2  <= cpx_spc0_data_cx2_d1;
    cpx_spc0_data_cx2_d1  <= cpx_spc0_data_cx2;
    spc0_dfq_byp_ff_en_d1 <= spc0_dfq_byp_ff_en;
    spc0_dfq_wr_en_d1     <= spc0_dfq_wr_en;

    if(cpx_spc0_data_cx2_d2[144] & (cpx_spc0_data_cx2_d2[143:140] == 4'h1) & ~cpx_spc0_data_cx2_d2[133] &
       cpx_spc0_data_cx2_d1[144] & (cpx_spc0_data_cx2_d1[143:140] == 4'h1) &  cpx_spc0_data_cx2_d1[133])
    begin
      $display("%0d: spc%0d tso_mon:condition1 for bug6362\n", $time, 0);
      if(spc0_dfq_wr_en & ~spc0_dfq_wr_en_d1 & ~spc0_dfq_byp_ff_en)
      begin
        $display("%0d: spc%0d tso_mon:condition2 for bug6362\n", $time, 0);

        if(spc0_dfq_fsm1 == 2'b00)
          spc0_dfq_fsm1 <= 2'b01;
        else
          finish_test("spc", "tso_mon:something is wrong with dfq_fsm1", 0);

        if(kill_on_cross_mod_code)
          finish_test("spc", "tso_mon:condition2 for bug6362", 0);
      end
    end

    if((spc0_dfq_fsm1 == 2'b01) & spc0_lsu_ifill_pkt_vld & spc0_dfq_rd_advance)
    begin
      spc0_dfq_fsm1 <= 2'b00;	// IDLE
    end
    else if((spc0_dfq_fsm1 == 2'b01) & spc0_lsu_ifill_pkt_vld & ~spc0_dfq_rd_advance)
    begin
      spc0_dfq_fsm1 <= 2'b10;	// UNFINISHED HANDSHAKE
    end
    else if((spc0_dfq_fsm1 == 2'b10) & spc0_lsu_ifill_pkt_vld & spc0_dfq_rd_advance)
    begin
      spc0_dfq_fsm1 <= 2'b00;
    end
    else if((spc0_dfq_fsm1 == 2'b10) & ~spc0_lsu_ifill_pkt_vld)
    begin
          finish_test("spc", "tso_mon:bug6362 hit - ifill_pkt goes out BEFORE dfq_rd_advance", 0);
    end

    if(force_dfq & ~spc0_dfq_byp_ff_en & (spc0_dfq_forced == 0))
    begin
      $display("%0d: spc%0d forcing spc0_dfq_forced\n", $time, 0);
`ifndef RTL_SPU
      force `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`else
      force `SPARC_CORE0.sparc0.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`endif
      spc0_dfq_forced = 1;
    end
    else if((spc0_dfq_forced >0) && (spc0_dfq_forced <10))
         spc0_dfq_forced =  spc0_dfq_forced + 1;
    else if(spc0_dfq_forced !=0)
    begin
      $display("%0d: spc%0d releasing spc0_dfq_forced\n", $time, 0);
`ifndef RTL_SPU
      release `SPARC_CORE0.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
`else
      release `SPARC_CORE0.sparc0.lsu.qctl2.dfq_byp_ff_en;
`endif
      spc0_dfq_forced  = 0;
    end

//-------------
  end // of else reset

end
`endif


`ifdef RTL_SPARC1
reg [1:0] spc1_dfq_fsm1;
integer  spc1_dfq_forced;

initial begin
    spc1_dfq_fsm1   = 2'b00;
    spc1_dfq_forced = 0;
end

always @(posedge clk)
begin
  if(~rst_l)
  begin
    cpx_spc1_data_cx2_d2  <= `CPX_WIDTH'b0;
    cpx_spc1_data_cx2_d1  <= `CPX_WIDTH'b0;
    spc1_dfq_byp_ff_en_d1 <= 1'b0;
    spc1_dfq_wr_en_d1     <= 1'b0;
    spc1_dfq_fsm1	     <= 2'b00;
    spc1_dfq_forced       <= 0;

  end
  else
  begin

    cpx_spc1_data_cx2_d2  <= cpx_spc1_data_cx2_d1;
    cpx_spc1_data_cx2_d1  <= cpx_spc1_data_cx2;
    spc1_dfq_byp_ff_en_d1 <= spc1_dfq_byp_ff_en;
    spc1_dfq_wr_en_d1     <= spc1_dfq_wr_en;

    if(cpx_spc1_data_cx2_d2[144] & (cpx_spc1_data_cx2_d2[143:140] == 4'h1) & ~cpx_spc1_data_cx2_d2[133] &
       cpx_spc1_data_cx2_d1[144] & (cpx_spc1_data_cx2_d1[143:140] == 4'h1) &  cpx_spc1_data_cx2_d1[133])
    begin
      $display("%0d: spc%0d tso_mon:condition1 for bug6362\n", $time, 1);
      if(spc1_dfq_wr_en & ~spc1_dfq_wr_en_d1 & ~spc1_dfq_byp_ff_en)
      begin
        $display("%0d: spc%0d tso_mon:condition2 for bug6362\n", $time, 1);

        if(spc1_dfq_fsm1 == 2'b00)
          spc1_dfq_fsm1 <= 2'b01;
        else
          finish_test("spc", "tso_mon:something is wrong with dfq_fsm1", 1);

        if(kill_on_cross_mod_code)
          finish_test("spc", "tso_mon:condition2 for bug6362", 1);
      end
    end

    if((spc1_dfq_fsm1 == 2'b01) & spc1_lsu_ifill_pkt_vld & spc1_dfq_rd_advance)
    begin
      spc1_dfq_fsm1 <= 2'b00;	// IDLE
    end
    else if((spc1_dfq_fsm1 == 2'b01) & spc1_lsu_ifill_pkt_vld & ~spc1_dfq_rd_advance)
    begin
      spc1_dfq_fsm1 <= 2'b10;	// UNFINISHED HANDSHAKE
    end
    else if((spc1_dfq_fsm1 == 2'b10) & spc1_lsu_ifill_pkt_vld & spc1_dfq_rd_advance)
    begin
      spc1_dfq_fsm1 <= 2'b00;
    end
    else if((spc1_dfq_fsm1 == 2'b10) & ~spc1_lsu_ifill_pkt_vld)
    begin
          finish_test("spc", "tso_mon:bug6362 hit - ifill_pkt goes out BEFORE dfq_rd_advance", 1);
    end

    if(force_dfq & ~spc1_dfq_byp_ff_en & (spc1_dfq_forced == 0))
    begin
      $display("%0d: spc%0d forcing spc1_dfq_forced\n", $time, 1);
`ifndef RTL_SPU
      force `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`else
      force `SPARC_CORE1.sparc0.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`endif
      spc1_dfq_forced = 1;
    end
    else if((spc1_dfq_forced >0) && (spc1_dfq_forced <10))
         spc1_dfq_forced =  spc1_dfq_forced + 1;
    else if(spc1_dfq_forced !=0)
    begin
      $display("%0d: spc%0d releasing spc1_dfq_forced\n", $time, 1);
`ifndef RTL_SPU
      release `SPARC_CORE1.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
`else
      release `SPARC_CORE1.sparc0.lsu.qctl2.dfq_byp_ff_en;
`endif
      spc1_dfq_forced  = 0;
    end

//-------------
  end // of else reset

end
`endif


`ifdef RTL_SPARC2
reg [1:0] spc2_dfq_fsm1;
integer  spc2_dfq_forced;

initial begin
    spc2_dfq_fsm1   = 2'b00;
    spc2_dfq_forced = 0;
end

always @(posedge clk)
begin
  if(~rst_l)
  begin
    cpx_spc2_data_cx2_d2  <= `CPX_WIDTH'b0;
    cpx_spc2_data_cx2_d1  <= `CPX_WIDTH'b0;
    spc2_dfq_byp_ff_en_d1 <= 1'b0;
    spc2_dfq_wr_en_d1     <= 1'b0;
    spc2_dfq_fsm1	     <= 2'b00;
    spc2_dfq_forced       <= 0;

  end
  else
  begin

    cpx_spc2_data_cx2_d2  <= cpx_spc2_data_cx2_d1;
    cpx_spc2_data_cx2_d1  <= cpx_spc2_data_cx2;
    spc2_dfq_byp_ff_en_d1 <= spc2_dfq_byp_ff_en;
    spc2_dfq_wr_en_d1     <= spc2_dfq_wr_en;

    if(cpx_spc2_data_cx2_d2[144] & (cpx_spc2_data_cx2_d2[143:140] == 4'h1) & ~cpx_spc2_data_cx2_d2[133] &
       cpx_spc2_data_cx2_d1[144] & (cpx_spc2_data_cx2_d1[143:140] == 4'h1) &  cpx_spc2_data_cx2_d1[133])
    begin
      $display("%0d: spc%0d tso_mon:condition1 for bug6362\n", $time, 2);
      if(spc2_dfq_wr_en & ~spc2_dfq_wr_en_d1 & ~spc2_dfq_byp_ff_en)
      begin
        $display("%0d: spc%0d tso_mon:condition2 for bug6362\n", $time, 2);

        if(spc2_dfq_fsm1 == 2'b00)
          spc2_dfq_fsm1 <= 2'b01;
        else
          finish_test("spc", "tso_mon:something is wrong with dfq_fsm1", 2);

        if(kill_on_cross_mod_code)
          finish_test("spc", "tso_mon:condition2 for bug6362", 2);
      end
    end

    if((spc2_dfq_fsm1 == 2'b01) & spc2_lsu_ifill_pkt_vld & spc2_dfq_rd_advance)
    begin
      spc2_dfq_fsm1 <= 2'b00;	// IDLE
    end
    else if((spc2_dfq_fsm1 == 2'b01) & spc2_lsu_ifill_pkt_vld & ~spc2_dfq_rd_advance)
    begin
      spc2_dfq_fsm1 <= 2'b10;	// UNFINISHED HANDSHAKE
    end
    else if((spc2_dfq_fsm1 == 2'b10) & spc2_lsu_ifill_pkt_vld & spc2_dfq_rd_advance)
    begin
      spc2_dfq_fsm1 <= 2'b00;
    end
    else if((spc2_dfq_fsm1 == 2'b10) & ~spc2_lsu_ifill_pkt_vld)
    begin
          finish_test("spc", "tso_mon:bug6362 hit - ifill_pkt goes out BEFORE dfq_rd_advance", 2);
    end

    if(force_dfq & ~spc2_dfq_byp_ff_en & (spc2_dfq_forced == 0))
    begin
      $display("%0d: spc%0d forcing spc2_dfq_forced\n", $time, 2);
`ifndef RTL_SPU
      force `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`else
      force `SPARC_CORE2.sparc0.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`endif
      spc2_dfq_forced = 1;
    end
    else if((spc2_dfq_forced >0) && (spc2_dfq_forced <10))
         spc2_dfq_forced =  spc2_dfq_forced + 1;
    else if(spc2_dfq_forced !=0)
    begin
      $display("%0d: spc%0d releasing spc2_dfq_forced\n", $time, 2);
`ifndef RTL_SPU
      release `SPARC_CORE2.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
`else
      release `SPARC_CORE2.sparc0.lsu.qctl2.dfq_byp_ff_en;
`endif
      spc2_dfq_forced  = 0;
    end

//-------------
  end // of else reset

end
`endif


`ifdef RTL_SPARC3
reg [1:0] spc3_dfq_fsm1;
integer  spc3_dfq_forced;

initial begin
    spc3_dfq_fsm1   = 2'b00;
    spc3_dfq_forced = 0;
end

always @(posedge clk)
begin
  if(~rst_l)
  begin
    cpx_spc3_data_cx2_d2  <= `CPX_WIDTH'b0;
    cpx_spc3_data_cx2_d1  <= `CPX_WIDTH'b0;
    spc3_dfq_byp_ff_en_d1 <= 1'b0;
    spc3_dfq_wr_en_d1     <= 1'b0;
    spc3_dfq_fsm1	     <= 2'b00;
    spc3_dfq_forced       <= 0;

  end
  else
  begin

    cpx_spc3_data_cx2_d2  <= cpx_spc3_data_cx2_d1;
    cpx_spc3_data_cx2_d1  <= cpx_spc3_data_cx2;
    spc3_dfq_byp_ff_en_d1 <= spc3_dfq_byp_ff_en;
    spc3_dfq_wr_en_d1     <= spc3_dfq_wr_en;

    if(cpx_spc3_data_cx2_d2[144] & (cpx_spc3_data_cx2_d2[143:140] == 4'h1) & ~cpx_spc3_data_cx2_d2[133] &
       cpx_spc3_data_cx2_d1[144] & (cpx_spc3_data_cx2_d1[143:140] == 4'h1) &  cpx_spc3_data_cx2_d1[133])
    begin
      $display("%0d: spc%0d tso_mon:condition1 for bug6362\n", $time, 3);
      if(spc3_dfq_wr_en & ~spc3_dfq_wr_en_d1 & ~spc3_dfq_byp_ff_en)
      begin
        $display("%0d: spc%0d tso_mon:condition2 for bug6362\n", $time, 3);

        if(spc3_dfq_fsm1 == 2'b00)
          spc3_dfq_fsm1 <= 2'b01;
        else
          finish_test("spc", "tso_mon:something is wrong with dfq_fsm1", 3);

        if(kill_on_cross_mod_code)
          finish_test("spc", "tso_mon:condition2 for bug6362", 3);
      end
    end

    if((spc3_dfq_fsm1 == 2'b01) & spc3_lsu_ifill_pkt_vld & spc3_dfq_rd_advance)
    begin
      spc3_dfq_fsm1 <= 2'b00;	// IDLE
    end
    else if((spc3_dfq_fsm1 == 2'b01) & spc3_lsu_ifill_pkt_vld & ~spc3_dfq_rd_advance)
    begin
      spc3_dfq_fsm1 <= 2'b10;	// UNFINISHED HANDSHAKE
    end
    else if((spc3_dfq_fsm1 == 2'b10) & spc3_lsu_ifill_pkt_vld & spc3_dfq_rd_advance)
    begin
      spc3_dfq_fsm1 <= 2'b00;
    end
    else if((spc3_dfq_fsm1 == 2'b10) & ~spc3_lsu_ifill_pkt_vld)
    begin
          finish_test("spc", "tso_mon:bug6362 hit - ifill_pkt goes out BEFORE dfq_rd_advance", 3);
    end

    if(force_dfq & ~spc3_dfq_byp_ff_en & (spc3_dfq_forced == 0))
    begin
      $display("%0d: spc%0d forcing spc3_dfq_forced\n", $time, 3);
`ifndef RTL_SPU
      force `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`else
      force `SPARC_CORE3.sparc0.lsu.qctl2.dfq_byp_ff_en = 1'b0;
`endif
      spc3_dfq_forced = 1;
    end
    else if((spc3_dfq_forced >0) && (spc3_dfq_forced <10))
         spc3_dfq_forced =  spc3_dfq_forced + 1;
    else if(spc3_dfq_forced !=0)
    begin
      $display("%0d: spc%0d releasing spc3_dfq_forced\n", $time, 3);
`ifndef RTL_SPU
      release `SPARC_CORE3.sparc0.lsu.lsu.qctl2.dfq_byp_ff_en;
`else
      release `SPARC_CORE3.sparc0.lsu.qctl2.dfq_byp_ff_en;
`endif
      spc3_dfq_forced  = 0;
    end

//-------------
  end // of else reset

end
`endif





//==============================================================================
//==    End of Main program ====================================================
//==============================================================================


//=====================================================================
`define TSO_MON_PCX_VLD        	pcx_data[123]
`define TSO_MON_PCX_TYPE  	pcx_data[122:118]
`define TSO_MON_PCX_NC     	pcx_data[117]
`define TSO_MON_PCX_CPU_ID 	pcx_data[116:114]
`define TSO_MON_PCX_THR_ID 	pcx_data[113:112]
`define TSO_MON_PCX_INV   	pcx_data[111]
`define TSO_MON_PCX_PRF   	pcx_data[110]
`define TSO_MON_PCX_BST   	pcx_data[109]
`define TSO_MON_PCX_RPL   	pcx_data[108:107]
`define TSO_MON_PCX_SIZ   	pcx_data[106:104]
`define TSO_MON_PCX_ADD   	pcx_data[103:64]
`define TSO_MON_PCX_ADD39   	pcx_data[103]
`define TSO_MON_PCX_DAT   	pcx_data[63:0]


//=====================================================================
// This task analyzes PCX packets
//=====================================================================
task get_pcx;

output [127:0] 		pcx_type_str;

input [`PCX_WIDTH-1:0]	pcx_data;
input [5:0] 		pcx_type_d1;
input      		pcx_atom_pq_d1;
input      		pcx_atom_pq_d2;
// TODO: I'd like to make this 31:0 and pass the core ID in, but it's checked against TSO_MON_PCX_CPU_ID
input [2:0] 		spc_id;
input [4:0]		pcx_req_pq_d1;

reg			current_stb_nced;

begin

// This is just for easy debug
//-----------------------------
  case(`TSO_MON_PCX_TYPE)
	  `LOAD_RQ   : pcx_type_str = "LOAD_RQ";
	  `IMISS_RQ  : pcx_type_str = "IMISS_RQ";
	  `STORE_RQ  : pcx_type_str = "STORE_RQ";
	  `CAS1_RQ   : pcx_type_str = "CAS1_RQ";
	  `CAS2_RQ   : pcx_type_str = "CAS2_RQ";
	  `SWAP_RQ   : pcx_type_str = "SWAP_RQ";
	  `STRLOAD_RQ: pcx_type_str = "STRLOAD_RQ";
	  `STRST_RQ  : pcx_type_str = "STRST_RQ";
	  `STQ_RQ    : pcx_type_str = "STQ_RQ";
	  `INT_RQ    : pcx_type_str = "INT_RQ";
	  `FWD_RQ    : pcx_type_str = "FWD_RQ";
	  `FWD_RPY   : pcx_type_str = "FWD_RPY";
	  `RSVD_RQ   : pcx_type_str = "RSVD_RQ";
	  `FPOP1_RQ  : pcx_type_str = "FPOP1";
	  `FPOP2_RQ  : pcx_type_str = "FPOP2";
           default   : pcx_type_str = "ILLEGAL";
  endcase

  if(tso_mon_msg)
    $display("%0d tso_mon: cpu(%x) thr(%x) pcx pkt: TYPE= %s NC= %x INV= %x PRF= %x BST= %x RPL= %x SZ= %x PA= %x D= %x",
    $time, `TSO_MON_PCX_CPU_ID, `TSO_MON_PCX_THR_ID, pcx_type_str, `TSO_MON_PCX_NC, `TSO_MON_PCX_INV, `TSO_MON_PCX_PRF, `TSO_MON_PCX_BST, `TSO_MON_PCX_RPL, `TSO_MON_PCX_SIZ, `TSO_MON_PCX_ADD, `TSO_MON_PCX_DAT);

// SOme sanity checks
//--------------------

  if(`TSO_MON_PCX_VLD === 1'bx)
     finish_test("spc", "valid bit -  pcx_data[123] is X", spc_id);

// victorm Feb 2003 - removing the L1 way replacement info from the X checking
// since for prefetches and non-cacheables the way can be an X.
  if(`TSO_MON_PCX_VLD & ~((`TSO_MON_PCX_TYPE == `FWD_RPY) || (`TSO_MON_PCX_TYPE == `INT_RQ)) & ((^pcx_data[122:109] === 1'bx) | (^pcx_data[106:64] === 1'bx)))
     finish_test("spc", "PCX request with valid bit is 1, but  pcx_data[122:64] is X", spc_id);

  if(`TSO_MON_PCX_VLD & (`TSO_MON_PCX_TYPE == `INT_RQ) & (^pcx_data[122:109] === 1'bx))
     finish_test("spc", "PCX INT request with valid bit is 1, but  pcx_data[122:109] is X", spc_id);

  if(`TSO_MON_PCX_VLD & ((`TSO_MON_PCX_TYPE == `CAS1_RQ) || (`TSO_MON_PCX_TYPE == `CAS2_RQ)) & (^pcx_data[122:0] === 1'bx))
     finish_test("spc", "X in CAS packets", spc_id);

// victorm - when the request type is interrupt then this check is not valid.
//--------------------------------------------------------------------------
  if(~((`TSO_MON_PCX_TYPE == `INT_RQ) | (`TSO_MON_PCX_TYPE == `FWD_RQ) | (`TSO_MON_PCX_TYPE == `FWD_RPY)) & ~(`TSO_MON_PCX_CPU_ID == spc_id))
  begin
      $display("expected spcid to be %d but is %d instead", `TSO_MON_PCX_CPU_ID, spc_id);
     finish_test("spc", "messed up pcx_id", spc_id); // Tri: reenable this asap
  end

  if((pcx_type_d1 == `FPOP1_RQ) & ~(`TSO_MON_PCX_TYPE == `FPOP2_RQ))
     finish_test("spc", "FPOP1 without FPOP2", spc_id);

  if(pcx_atom_pq_d1 & ~((`TSO_MON_PCX_TYPE == `FPOP1_RQ) | (`TSO_MON_PCX_TYPE == `CAS1_RQ)))
  begin
     $display("pcx atomic1 problems heads up: pcx_type = %x", `TSO_MON_PCX_TYPE);
     finish_test("spc", "pcx atomic1 problems ", spc_id);
  end

  if(pcx_atom_pq_d2 & ~((`TSO_MON_PCX_TYPE == `FPOP2_RQ) | (`TSO_MON_PCX_TYPE == `CAS2_RQ)))
  begin
     $display("pcx atomic2 problems heads up: pcx_type = %x", `TSO_MON_PCX_TYPE);
     finish_test("spc", "pcx atomic2 problems ", spc_id);
  end

  if(~`TSO_MON_PCX_VLD & tso_mon_msg)
    $display("%0d INFO: spc %d speculative request backoff", $time, spc_id);

  case({`TSO_MON_PCX_CPU_ID, `TSO_MON_PCX_THR_ID})
`ifdef RTL_SPARC0
    5'h00:	current_stb_nced = C0T0_stb_nced;
    5'h01:	current_stb_nced = C0T1_stb_nced;
    5'h02:	current_stb_nced = C0T2_stb_nced;
    5'h03:	current_stb_nced = C0T3_stb_nced;
`endif
//    5'h04:	current_stb_nced = C1T0_stb_nced;
//    5'h05:	current_stb_nced = C1T1_stb_nced;
//    5'h06:	current_stb_nced = C1T2_stb_nced;
//    5'h07:	current_stb_nced = C1T3_stb_nced;
//    5'h08:	current_stb_nced = C2T0_stb_nced;
//    5'h09:	current_stb_nced = C2T1_stb_nced;
//    5'h0a:	current_stb_nced = C2T2_stb_nced;
//    5'h0b:	current_stb_nced = C2T3_stb_nced;
//    5'h0c:	current_stb_nced = C3T0_stb_nced;
//    5'h0d:	current_stb_nced = C3T1_stb_nced;
//    5'h0e:	current_stb_nced = C3T2_stb_nced;
//    5'h0f:	current_stb_nced = C3T3_stb_nced;
//    5'h10:	current_stb_nced = C4T0_stb_nced;
//    5'h11:	current_stb_nced = C4T1_stb_nced;
//    5'h12:	current_stb_nced = C4T2_stb_nced;
//    5'h13:	current_stb_nced = C4T3_stb_nced;
//    5'h14:	current_stb_nced = C5T0_stb_nced;
//    5'h15:	current_stb_nced = C5T1_stb_nced;
//    5'h16:	current_stb_nced = C5T2_stb_nced;
//    5'h17:	current_stb_nced = C5T3_stb_nced;
//    5'h18:	current_stb_nced = C6T0_stb_nced;
//    5'h19:	current_stb_nced = C6T1_stb_nced;
//    5'h1a:	current_stb_nced = C6T2_stb_nced;
//    5'h1b:	current_stb_nced = C6T3_stb_nced;
//    5'h1c:	current_stb_nced = C7T0_stb_nced;
//    5'h1d:	current_stb_nced = C7T1_stb_nced;
//    5'h1e:	current_stb_nced = C7T2_stb_nced;
//    5'h1f:	current_stb_nced = C7T3_stb_nced;
    default:	current_stb_nced = 1'b1;
  endcase

  if(`TSO_MON_PCX_VLD & ((`TSO_MON_PCX_TYPE == `LOAD_RQ) | (`TSO_MON_PCX_TYPE == `STRLOAD_RQ)) & (`TSO_MON_PCX_ADD39 | pcx_req_pq_d1[4]) & current_stb_nced)
  begin
     // finish_test("spc", "IO strong ordering problems ", spc_id); // Tri: please remember to re-enable this
  end

  if(`TSO_MON_PCX_VLD & ((`TSO_MON_PCX_TYPE == `LOAD_RQ) | (`TSO_MON_PCX_TYPE == `STRLOAD_RQ)) & (`TSO_MON_PCX_ADD39 | pcx_req_pq_d1[4]) & `TSO_MON_PCX_PRF)
  begin
     finish_test("spc", "prefetch to IO space ", spc_id);
  end
end
endtask

//=====================================================================
// This task analyzes CPX to spc packets
//=====================================================================
task get_cpx_spc;

output [127:0] cpx_spc_type_str;

input [4:0]	cpx_spc_type;

begin

  case(cpx_spc_type)
    `LOAD_RET : 	cpx_spc_type_str = "LOAD_RET";
    `IFILL_RET: 	cpx_spc_type_str = "IFILL_RET";
    `INV_RET  : 	cpx_spc_type_str = "INV_RET";
    `ST_ACK   : 	cpx_spc_type_str = "ST_ACK";
    `AT_ACK   : 	cpx_spc_type_str = "AT_ACK";
    `INT_RET  : 	cpx_spc_type_str = "INT_RET";
    `TEST_RET : 	cpx_spc_type_str = "TEST_RET";
    `FP_RET   : 	cpx_spc_type_str = "FP_RET";
    `EVICT_REQ: 	cpx_spc_type_str = "EVICT_REQ";
    `ERR_RET  : 	cpx_spc_type_str = "ERR_RET";
    `STRLOAD_RET : 	cpx_spc_type_str = "STRLOAD_RET";
    `STRST_ACK: 	cpx_spc_type_str = "STRST_ACK";
    `FWD_RQ_RET:	cpx_spc_type_str = "FWD_RQ_RET";
    `FWD_RPY_RET:	cpx_spc_type_str = "FWD_RPY_RET";
    `RSVD_RET : 	cpx_spc_type_str = "RSVD_RET";
     default:		cpx_spc_type_str = "ILLEGAL";
  endcase

end
endtask
//------------------------------------------------

//=====================================================================
// This task allows some more clocks and kills the test
//=====================================================================
task finish_test;
input [512:0] message0;
input [512:0] message1;
input [2:0]   id;

begin
  $display("%0d ERROR: %s: %d %s", $time, message0, id, message1);
  repeat(100) @(posedge clk);
  $finish;
end
endtask

`endif	// ifdef GATE_SIM
endmodule
`endif // ifndef VERILATOR
