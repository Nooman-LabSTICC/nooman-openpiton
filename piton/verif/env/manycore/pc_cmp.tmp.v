// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: pc_cmp.v
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

`include "define.tmp.h"
`include "ifu.tmp.h"

// /home/ruaro/nooman-openpiton/piton/verif/env/manycore/devices_ariane.xml
`define GOOD_TRAP_COUNTER 32


 module pc_cmp(/*AUTOARG*/
     // Inputs
     clk,
     rst_l
 );
input clk;
input rst_l;

// trap register

`ifndef VERILATOR
reg [35:0]   finish_mask;
`else
integer      finish_mask;
`endif
reg [35:0]   diag_mask;
reg [35:0]   active_thread;
reg [35:0]   back_thread, good_delay;
reg [35:0]   good, good_for;
reg [4:0]    thread_status[35:0];
reg [8:0]   done;
reg [31:0]     timeout [35:0];


reg [39:0]    good_trap[`GOOD_TRAP_COUNTER-1:0];
reg [39:0]    bad_trap [`GOOD_TRAP_COUNTER-1:0];

reg [`GOOD_TRAP_COUNTER-1:0] good_trap_exists;
reg [`GOOD_TRAP_COUNTER-1:0] bad_trap_exists;

reg           dum;
reg           hit_bad;

integer       max, time_tmp, trap_count;


    reg spc0_inst_done;
    wire [1:0]   spc0_thread_id;
    wire [63:0]      spc0_rtl_pc;
    wire sas_m0;
    reg [63:0] spc0_phy_pc_w;

    

    reg spc1_inst_done;
    wire [1:0]   spc1_thread_id;
    wire [63:0]      spc1_rtl_pc;
    wire sas_m1;
    reg [63:0] spc1_phy_pc_w;

    

    reg spc2_inst_done;
    wire [1:0]   spc2_thread_id;
    wire [63:0]      spc2_rtl_pc;
    wire sas_m2;
    reg [63:0] spc2_phy_pc_w;

    

    reg spc3_inst_done;
    wire [1:0]   spc3_thread_id;
    wire [63:0]      spc3_rtl_pc;
    wire sas_m3;
    reg [63:0] spc3_phy_pc_w;

    

    reg spc4_inst_done;
    wire [1:0]   spc4_thread_id;
    wire [63:0]      spc4_rtl_pc;
    wire sas_m4;
    reg [63:0] spc4_phy_pc_w;

    

    reg spc5_inst_done;
    wire [1:0]   spc5_thread_id;
    wire [63:0]      spc5_rtl_pc;
    wire sas_m5;
    reg [63:0] spc5_phy_pc_w;

    

    reg spc6_inst_done;
    wire [1:0]   spc6_thread_id;
    wire [63:0]      spc6_rtl_pc;
    wire sas_m6;
    reg [63:0] spc6_phy_pc_w;

    

    reg spc7_inst_done;
    wire [1:0]   spc7_thread_id;
    wire [63:0]      spc7_rtl_pc;
    wire sas_m7;
    reg [63:0] spc7_phy_pc_w;

    

    reg spc8_inst_done;
    wire [1:0]   spc8_thread_id;
    wire [63:0]      spc8_rtl_pc;
    wire sas_m8;
    reg [63:0] spc8_phy_pc_w;

    


reg           max_cycle;
integer      good_trap_count;
integer      bad_trap_count;
//argment for stub
integer    stub_mask;
reg [7:0]     stub_good;
reg          good_flag;
reg         local_diag_done;

//use this for the second reset.
initial begin
    back_thread = 0;
    good_delay  = 0;
    good_for    = 0;
    stub_good   = 0;
    local_diag_done = 0;

    good_trap_exists = {`GOOD_TRAP_COUNTER{1'b0}};
    bad_trap_exists = {`GOOD_TRAP_COUNTER{1'b0}};

    good_flag = 0;
    if($test$plusargs("stop_2nd_good"))good_flag= 1;

    max_cycle = 1;
    if($test$plusargs("thread_timeout_off"))max_cycle = 0;
end
//-----------------------------------------------------------

`ifdef INCLUDE_SAS_TASKS
task get_thread_status;
    begin
    thread_status[0] = `IFUPATH0.swl.thr0_state;
thread_status[1] = `IFUPATH0.swl.thr1_state;
thread_status[2] = `IFUPATH0.swl.thr2_state;
thread_status[3] = `IFUPATH0.swl.thr3_state;
thread_status[4] = `IFUPATH1.swl.thr0_state;
thread_status[5] = `IFUPATH1.swl.thr1_state;
thread_status[6] = `IFUPATH1.swl.thr2_state;
thread_status[7] = `IFUPATH1.swl.thr3_state;
thread_status[8] = `IFUPATH2.swl.thr0_state;
thread_status[9] = `IFUPATH2.swl.thr1_state;
thread_status[10] = `IFUPATH2.swl.thr2_state;
thread_status[11] = `IFUPATH2.swl.thr3_state;
thread_status[12] = `IFUPATH3.swl.thr0_state;
thread_status[13] = `IFUPATH3.swl.thr1_state;
thread_status[14] = `IFUPATH3.swl.thr2_state;
thread_status[15] = `IFUPATH3.swl.thr3_state;
thread_status[16] = `IFUPATH4.swl.thr0_state;
thread_status[17] = `IFUPATH4.swl.thr1_state;
thread_status[18] = `IFUPATH4.swl.thr2_state;
thread_status[19] = `IFUPATH4.swl.thr3_state;
thread_status[20] = `IFUPATH5.swl.thr0_state;
thread_status[21] = `IFUPATH5.swl.thr1_state;
thread_status[22] = `IFUPATH5.swl.thr2_state;
thread_status[23] = `IFUPATH5.swl.thr3_state;
thread_status[24] = `IFUPATH6.swl.thr0_state;
thread_status[25] = `IFUPATH6.swl.thr1_state;
thread_status[26] = `IFUPATH6.swl.thr2_state;
thread_status[27] = `IFUPATH6.swl.thr3_state;
thread_status[28] = `IFUPATH7.swl.thr0_state;
thread_status[29] = `IFUPATH7.swl.thr1_state;
thread_status[30] = `IFUPATH7.swl.thr2_state;
thread_status[31] = `IFUPATH7.swl.thr3_state;
thread_status[32] = `IFUPATH8.swl.thr0_state;
thread_status[33] = `IFUPATH8.swl.thr1_state;
thread_status[34] = `IFUPATH8.swl.thr2_state;
thread_status[35] = `IFUPATH8.swl.thr3_state;

    end
endtask // get_thread_status
`endif


    `ifdef RTL_SPARC0
    `ifdef GATE_SIM_SPARC
        assign sas_m0                = `INSTPATH0.runw_ff_u_dff_0_.d &
               (~`INSTPATH0.exu_ifu_ecc_ce_m | `INSTPATH0.trapm_ff_u_dff_0_.q);
        assign spc0_thread_id        = {`PCPATH0.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH0.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH0.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH0.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc0_rtl_pc           = `SPCPATH0.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m0                = `INSTPATH0.inst_vld_m       & ~`INSTPATH0.kill_thread_m &
               ~(`INSTPATH0.exu_ifu_ecc_ce_m & `INSTPATH0.inst_vld_m & ~`INSTPATH0.trap_m);
        assign spc0_thread_id        = `PCPATH0.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc0_rtl_pc           = `SPCPATH0.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc0_rtl_pc           = `SPCPATH0.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc0_phy_pc_d,  spc0_phy_pc_e,  spc0_phy_pc_m,
                spc0_t0pc_s,    spc0_t1pc_s,    spc0_t2pc_s,  spc0_t3pc_s ;

            reg [3:0]  spc0_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc0_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc0_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc0_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs0 = spc0_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf0 = spc0_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd0 = spc0_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce0 = spc0_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc0_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc0_imiss_paddr_s = {`IFQDP0.itlb_ifq_paddr_s, `IFQDP0.lcl_paddr_s, 2'b0} ;
    `else
            assign spc0_imiss_paddr_s = `IFQDP0.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc0_inst_done                     <= sas_m0;

                //next pc select
                spc0_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH0.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc0_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH0.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc0_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH0.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc0_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH0.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf0[0] == 0)spc0_t0pc_s          <= spc0_imiss_paddr_s;
                else if(pcs0[0] == 0)spc0_t0pc_s     <= spc0_t0pc_s;
                else if(pcd0[0] == 0)spc0_t0pc_s     <= spc0_phy_pc_e;
                else if(pce0[0] == 0)spc0_t0pc_s     <= spc0_phy_pc_m;

                if(pcf0[1] == 0)spc0_t1pc_s          <= spc0_imiss_paddr_s;
                else if(pcs0[1] == 0)spc0_t1pc_s     <= spc0_t1pc_s;
                else if(pcd0[1] == 0)spc0_t1pc_s     <= spc0_phy_pc_e;
                else if(pce0[1] == 0)spc0_t1pc_s     <= spc0_phy_pc_m;

                if(pcf0[2] == 0)spc0_t2pc_s          <= spc0_imiss_paddr_s;
                else if(pcs0[2] == 0)spc0_t2pc_s     <= spc0_t2pc_s;
                else if(pcd0[2] == 0)spc0_t2pc_s     <= spc0_phy_pc_e;
                else if(pce0[2] == 0)spc0_t2pc_s     <= spc0_phy_pc_m;

                if(pcf0[3] == 0)spc0_t3pc_s          <= spc0_imiss_paddr_s;
                else if(pcs0[3] == 0)spc0_t3pc_s     <= spc0_t3pc_s;
                else if(pcd0[3] == 0)spc0_t3pc_s     <= spc0_phy_pc_e;
                else if(pce0[3] == 0)spc0_t3pc_s     <= spc0_phy_pc_m;

                if(~`DTUPATH0.fcl_fdp_thr_s2_l[0])     spc0_phy_pc_d <= pcf0[0] ? spc0_t0pc_s : spc0_imiss_paddr_s;
                else if(~`DTUPATH0.fcl_fdp_thr_s2_l[1])spc0_phy_pc_d <= pcf0[1] ? spc0_t1pc_s : spc0_imiss_paddr_s;
                else if(~`DTUPATH0.fcl_fdp_thr_s2_l[2])spc0_phy_pc_d <= pcf0[2] ? spc0_t2pc_s : spc0_imiss_paddr_s;
                else if(~`DTUPATH0.fcl_fdp_thr_s2_l[3])spc0_phy_pc_d <= pcf0[3] ? spc0_t3pc_s : spc0_imiss_paddr_s;

                spc0_phy_pc_e   <= spc0_phy_pc_d;
                spc0_phy_pc_m   <= spc0_phy_pc_e;
                spc0_phy_pc_w   <= {{8{spc0_phy_pc_m[39]}}, spc0_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC0
    `ifdef RTL_ARIANE0
            assign spc0_thread_id = 2'b00;
            assign spc0_rtl_pc = spc0_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(0*4)]   <= 1'b0;
                  active_thread[(0*4)+1] <= 1'b0;
                  active_thread[(0*4)+2] <= 1'b0;
                  active_thread[(0*4)+3] <= 1'b0;
                  spc0_inst_done         <= 0;
                  spc0_phy_pc_w          <= 0;
                end else begin
                  active_thread[(0*4)]   <= 1'b1;
                  active_thread[(0*4)+1] <= 1'b1;
                  active_thread[(0*4)+2] <= 1'b1;
                  active_thread[(0*4)+3] <= 1'b1;
                  spc0_inst_done         <= `ARIANE_CORE0.piton_pc_vld;
                  spc0_phy_pc_w          <= `ARIANE_CORE0.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc0_thread_id = 2'b00;
            assign spc0_rtl_pc = spc0_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE0.pico_int == 1'b1)
                begin
                    active_thread[(0*4)] = 1'b1;
                    active_thread[(0*4)+1] = 1'b1;
                    active_thread[(0*4)+2] = 1'b1;
                    active_thread[(0*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc0_inst_done <= `PICO_CORE0.launch_next_insn;
                spc0_phy_pc_w <= {{16{`PICO_CORE0.reg_pc[31]}}, `PICO_CORE0.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC0
    

    `ifdef RTL_SPARC1
    `ifdef GATE_SIM_SPARC
        assign sas_m1                = `INSTPATH1.runw_ff_u_dff_0_.d &
               (~`INSTPATH1.exu_ifu_ecc_ce_m | `INSTPATH1.trapm_ff_u_dff_0_.q);
        assign spc1_thread_id        = {`PCPATH1.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH1.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH1.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH1.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc1_rtl_pc           = `SPCPATH1.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m1                = `INSTPATH1.inst_vld_m       & ~`INSTPATH1.kill_thread_m &
               ~(`INSTPATH1.exu_ifu_ecc_ce_m & `INSTPATH1.inst_vld_m & ~`INSTPATH1.trap_m);
        assign spc1_thread_id        = `PCPATH1.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc1_rtl_pc           = `SPCPATH1.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc1_rtl_pc           = `SPCPATH1.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc1_phy_pc_d,  spc1_phy_pc_e,  spc1_phy_pc_m,
                spc1_t0pc_s,    spc1_t1pc_s,    spc1_t2pc_s,  spc1_t3pc_s ;

            reg [3:0]  spc1_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc1_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc1_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc1_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs1 = spc1_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf1 = spc1_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd1 = spc1_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce1 = spc1_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc1_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc1_imiss_paddr_s = {`IFQDP1.itlb_ifq_paddr_s, `IFQDP1.lcl_paddr_s, 2'b0} ;
    `else
            assign spc1_imiss_paddr_s = `IFQDP1.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc1_inst_done                     <= sas_m1;

                //next pc select
                spc1_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH1.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc1_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH1.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc1_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH1.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc1_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH1.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf1[0] == 0)spc1_t0pc_s          <= spc1_imiss_paddr_s;
                else if(pcs1[0] == 0)spc1_t0pc_s     <= spc1_t0pc_s;
                else if(pcd1[0] == 0)spc1_t0pc_s     <= spc1_phy_pc_e;
                else if(pce1[0] == 0)spc1_t0pc_s     <= spc1_phy_pc_m;

                if(pcf1[1] == 0)spc1_t1pc_s          <= spc1_imiss_paddr_s;
                else if(pcs1[1] == 0)spc1_t1pc_s     <= spc1_t1pc_s;
                else if(pcd1[1] == 0)spc1_t1pc_s     <= spc1_phy_pc_e;
                else if(pce1[1] == 0)spc1_t1pc_s     <= spc1_phy_pc_m;

                if(pcf1[2] == 0)spc1_t2pc_s          <= spc1_imiss_paddr_s;
                else if(pcs1[2] == 0)spc1_t2pc_s     <= spc1_t2pc_s;
                else if(pcd1[2] == 0)spc1_t2pc_s     <= spc1_phy_pc_e;
                else if(pce1[2] == 0)spc1_t2pc_s     <= spc1_phy_pc_m;

                if(pcf1[3] == 0)spc1_t3pc_s          <= spc1_imiss_paddr_s;
                else if(pcs1[3] == 0)spc1_t3pc_s     <= spc1_t3pc_s;
                else if(pcd1[3] == 0)spc1_t3pc_s     <= spc1_phy_pc_e;
                else if(pce1[3] == 0)spc1_t3pc_s     <= spc1_phy_pc_m;

                if(~`DTUPATH1.fcl_fdp_thr_s2_l[0])     spc1_phy_pc_d <= pcf1[0] ? spc1_t0pc_s : spc1_imiss_paddr_s;
                else if(~`DTUPATH1.fcl_fdp_thr_s2_l[1])spc1_phy_pc_d <= pcf1[1] ? spc1_t1pc_s : spc1_imiss_paddr_s;
                else if(~`DTUPATH1.fcl_fdp_thr_s2_l[2])spc1_phy_pc_d <= pcf1[2] ? spc1_t2pc_s : spc1_imiss_paddr_s;
                else if(~`DTUPATH1.fcl_fdp_thr_s2_l[3])spc1_phy_pc_d <= pcf1[3] ? spc1_t3pc_s : spc1_imiss_paddr_s;

                spc1_phy_pc_e   <= spc1_phy_pc_d;
                spc1_phy_pc_m   <= spc1_phy_pc_e;
                spc1_phy_pc_w   <= {{8{spc1_phy_pc_m[39]}}, spc1_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC1
    `ifdef RTL_ARIANE0
            assign spc1_thread_id = 2'b00;
            assign spc1_rtl_pc = spc1_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(1*4)]   <= 1'b0;
                  active_thread[(1*4)+1] <= 1'b0;
                  active_thread[(1*4)+2] <= 1'b0;
                  active_thread[(1*4)+3] <= 1'b0;
                  spc1_inst_done         <= 0;
                  spc1_phy_pc_w          <= 0;
                end else begin
                  active_thread[(1*4)]   <= 1'b1;
                  active_thread[(1*4)+1] <= 1'b1;
                  active_thread[(1*4)+2] <= 1'b1;
                  active_thread[(1*4)+3] <= 1'b1;
                  spc1_inst_done         <= `ARIANE_CORE1.piton_pc_vld;
                  spc1_phy_pc_w          <= `ARIANE_CORE1.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc1_thread_id = 2'b00;
            assign spc1_rtl_pc = spc1_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE1.pico_int == 1'b1)
                begin
                    active_thread[(1*4)] = 1'b1;
                    active_thread[(1*4)+1] = 1'b1;
                    active_thread[(1*4)+2] = 1'b1;
                    active_thread[(1*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc1_inst_done <= `PICO_CORE1.launch_next_insn;
                spc1_phy_pc_w <= {{16{`PICO_CORE1.reg_pc[31]}}, `PICO_CORE1.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC1
    

    `ifdef RTL_SPARC2
    `ifdef GATE_SIM_SPARC
        assign sas_m2                = `INSTPATH2.runw_ff_u_dff_0_.d &
               (~`INSTPATH2.exu_ifu_ecc_ce_m | `INSTPATH2.trapm_ff_u_dff_0_.q);
        assign spc2_thread_id        = {`PCPATH2.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH2.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH2.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH2.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc2_rtl_pc           = `SPCPATH2.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m2                = `INSTPATH2.inst_vld_m       & ~`INSTPATH2.kill_thread_m &
               ~(`INSTPATH2.exu_ifu_ecc_ce_m & `INSTPATH2.inst_vld_m & ~`INSTPATH2.trap_m);
        assign spc2_thread_id        = `PCPATH2.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc2_rtl_pc           = `SPCPATH2.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc2_rtl_pc           = `SPCPATH2.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc2_phy_pc_d,  spc2_phy_pc_e,  spc2_phy_pc_m,
                spc2_t0pc_s,    spc2_t1pc_s,    spc2_t2pc_s,  spc2_t3pc_s ;

            reg [3:0]  spc2_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc2_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc2_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc2_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs2 = spc2_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf2 = spc2_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd2 = spc2_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce2 = spc2_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc2_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc2_imiss_paddr_s = {`IFQDP2.itlb_ifq_paddr_s, `IFQDP2.lcl_paddr_s, 2'b0} ;
    `else
            assign spc2_imiss_paddr_s = `IFQDP2.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc2_inst_done                     <= sas_m2;

                //next pc select
                spc2_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH2.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc2_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH2.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc2_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH2.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc2_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH2.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf2[0] == 0)spc2_t0pc_s          <= spc2_imiss_paddr_s;
                else if(pcs2[0] == 0)spc2_t0pc_s     <= spc2_t0pc_s;
                else if(pcd2[0] == 0)spc2_t0pc_s     <= spc2_phy_pc_e;
                else if(pce2[0] == 0)spc2_t0pc_s     <= spc2_phy_pc_m;

                if(pcf2[1] == 0)spc2_t1pc_s          <= spc2_imiss_paddr_s;
                else if(pcs2[1] == 0)spc2_t1pc_s     <= spc2_t1pc_s;
                else if(pcd2[1] == 0)spc2_t1pc_s     <= spc2_phy_pc_e;
                else if(pce2[1] == 0)spc2_t1pc_s     <= spc2_phy_pc_m;

                if(pcf2[2] == 0)spc2_t2pc_s          <= spc2_imiss_paddr_s;
                else if(pcs2[2] == 0)spc2_t2pc_s     <= spc2_t2pc_s;
                else if(pcd2[2] == 0)spc2_t2pc_s     <= spc2_phy_pc_e;
                else if(pce2[2] == 0)spc2_t2pc_s     <= spc2_phy_pc_m;

                if(pcf2[3] == 0)spc2_t3pc_s          <= spc2_imiss_paddr_s;
                else if(pcs2[3] == 0)spc2_t3pc_s     <= spc2_t3pc_s;
                else if(pcd2[3] == 0)spc2_t3pc_s     <= spc2_phy_pc_e;
                else if(pce2[3] == 0)spc2_t3pc_s     <= spc2_phy_pc_m;

                if(~`DTUPATH2.fcl_fdp_thr_s2_l[0])     spc2_phy_pc_d <= pcf2[0] ? spc2_t0pc_s : spc2_imiss_paddr_s;
                else if(~`DTUPATH2.fcl_fdp_thr_s2_l[1])spc2_phy_pc_d <= pcf2[1] ? spc2_t1pc_s : spc2_imiss_paddr_s;
                else if(~`DTUPATH2.fcl_fdp_thr_s2_l[2])spc2_phy_pc_d <= pcf2[2] ? spc2_t2pc_s : spc2_imiss_paddr_s;
                else if(~`DTUPATH2.fcl_fdp_thr_s2_l[3])spc2_phy_pc_d <= pcf2[3] ? spc2_t3pc_s : spc2_imiss_paddr_s;

                spc2_phy_pc_e   <= spc2_phy_pc_d;
                spc2_phy_pc_m   <= spc2_phy_pc_e;
                spc2_phy_pc_w   <= {{8{spc2_phy_pc_m[39]}}, spc2_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC2
    `ifdef RTL_ARIANE0
            assign spc2_thread_id = 2'b00;
            assign spc2_rtl_pc = spc2_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(2*4)]   <= 1'b0;
                  active_thread[(2*4)+1] <= 1'b0;
                  active_thread[(2*4)+2] <= 1'b0;
                  active_thread[(2*4)+3] <= 1'b0;
                  spc2_inst_done         <= 0;
                  spc2_phy_pc_w          <= 0;
                end else begin
                  active_thread[(2*4)]   <= 1'b1;
                  active_thread[(2*4)+1] <= 1'b1;
                  active_thread[(2*4)+2] <= 1'b1;
                  active_thread[(2*4)+3] <= 1'b1;
                  spc2_inst_done         <= `ARIANE_CORE2.piton_pc_vld;
                  spc2_phy_pc_w          <= `ARIANE_CORE2.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc2_thread_id = 2'b00;
            assign spc2_rtl_pc = spc2_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE2.pico_int == 1'b1)
                begin
                    active_thread[(2*4)] = 1'b1;
                    active_thread[(2*4)+1] = 1'b1;
                    active_thread[(2*4)+2] = 1'b1;
                    active_thread[(2*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc2_inst_done <= `PICO_CORE2.launch_next_insn;
                spc2_phy_pc_w <= {{16{`PICO_CORE2.reg_pc[31]}}, `PICO_CORE2.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC2
    

    `ifdef RTL_SPARC3
    `ifdef GATE_SIM_SPARC
        assign sas_m3                = `INSTPATH3.runw_ff_u_dff_0_.d &
               (~`INSTPATH3.exu_ifu_ecc_ce_m | `INSTPATH3.trapm_ff_u_dff_0_.q);
        assign spc3_thread_id        = {`PCPATH3.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH3.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH3.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH3.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc3_rtl_pc           = `SPCPATH3.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m3                = `INSTPATH3.inst_vld_m       & ~`INSTPATH3.kill_thread_m &
               ~(`INSTPATH3.exu_ifu_ecc_ce_m & `INSTPATH3.inst_vld_m & ~`INSTPATH3.trap_m);
        assign spc3_thread_id        = `PCPATH3.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc3_rtl_pc           = `SPCPATH3.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc3_rtl_pc           = `SPCPATH3.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc3_phy_pc_d,  spc3_phy_pc_e,  spc3_phy_pc_m,
                spc3_t0pc_s,    spc3_t1pc_s,    spc3_t2pc_s,  spc3_t3pc_s ;

            reg [3:0]  spc3_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc3_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc3_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc3_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs3 = spc3_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf3 = spc3_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd3 = spc3_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce3 = spc3_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc3_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc3_imiss_paddr_s = {`IFQDP3.itlb_ifq_paddr_s, `IFQDP3.lcl_paddr_s, 2'b0} ;
    `else
            assign spc3_imiss_paddr_s = `IFQDP3.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc3_inst_done                     <= sas_m3;

                //next pc select
                spc3_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH3.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc3_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH3.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc3_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH3.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc3_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH3.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf3[0] == 0)spc3_t0pc_s          <= spc3_imiss_paddr_s;
                else if(pcs3[0] == 0)spc3_t0pc_s     <= spc3_t0pc_s;
                else if(pcd3[0] == 0)spc3_t0pc_s     <= spc3_phy_pc_e;
                else if(pce3[0] == 0)spc3_t0pc_s     <= spc3_phy_pc_m;

                if(pcf3[1] == 0)spc3_t1pc_s          <= spc3_imiss_paddr_s;
                else if(pcs3[1] == 0)spc3_t1pc_s     <= spc3_t1pc_s;
                else if(pcd3[1] == 0)spc3_t1pc_s     <= spc3_phy_pc_e;
                else if(pce3[1] == 0)spc3_t1pc_s     <= spc3_phy_pc_m;

                if(pcf3[2] == 0)spc3_t2pc_s          <= spc3_imiss_paddr_s;
                else if(pcs3[2] == 0)spc3_t2pc_s     <= spc3_t2pc_s;
                else if(pcd3[2] == 0)spc3_t2pc_s     <= spc3_phy_pc_e;
                else if(pce3[2] == 0)spc3_t2pc_s     <= spc3_phy_pc_m;

                if(pcf3[3] == 0)spc3_t3pc_s          <= spc3_imiss_paddr_s;
                else if(pcs3[3] == 0)spc3_t3pc_s     <= spc3_t3pc_s;
                else if(pcd3[3] == 0)spc3_t3pc_s     <= spc3_phy_pc_e;
                else if(pce3[3] == 0)spc3_t3pc_s     <= spc3_phy_pc_m;

                if(~`DTUPATH3.fcl_fdp_thr_s2_l[0])     spc3_phy_pc_d <= pcf3[0] ? spc3_t0pc_s : spc3_imiss_paddr_s;
                else if(~`DTUPATH3.fcl_fdp_thr_s2_l[1])spc3_phy_pc_d <= pcf3[1] ? spc3_t1pc_s : spc3_imiss_paddr_s;
                else if(~`DTUPATH3.fcl_fdp_thr_s2_l[2])spc3_phy_pc_d <= pcf3[2] ? spc3_t2pc_s : spc3_imiss_paddr_s;
                else if(~`DTUPATH3.fcl_fdp_thr_s2_l[3])spc3_phy_pc_d <= pcf3[3] ? spc3_t3pc_s : spc3_imiss_paddr_s;

                spc3_phy_pc_e   <= spc3_phy_pc_d;
                spc3_phy_pc_m   <= spc3_phy_pc_e;
                spc3_phy_pc_w   <= {{8{spc3_phy_pc_m[39]}}, spc3_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC3
    `ifdef RTL_ARIANE0
            assign spc3_thread_id = 2'b00;
            assign spc3_rtl_pc = spc3_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(3*4)]   <= 1'b0;
                  active_thread[(3*4)+1] <= 1'b0;
                  active_thread[(3*4)+2] <= 1'b0;
                  active_thread[(3*4)+3] <= 1'b0;
                  spc3_inst_done         <= 0;
                  spc3_phy_pc_w          <= 0;
                end else begin
                  active_thread[(3*4)]   <= 1'b1;
                  active_thread[(3*4)+1] <= 1'b1;
                  active_thread[(3*4)+2] <= 1'b1;
                  active_thread[(3*4)+3] <= 1'b1;
                  spc3_inst_done         <= `ARIANE_CORE3.piton_pc_vld;
                  spc3_phy_pc_w          <= `ARIANE_CORE3.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc3_thread_id = 2'b00;
            assign spc3_rtl_pc = spc3_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE3.pico_int == 1'b1)
                begin
                    active_thread[(3*4)] = 1'b1;
                    active_thread[(3*4)+1] = 1'b1;
                    active_thread[(3*4)+2] = 1'b1;
                    active_thread[(3*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc3_inst_done <= `PICO_CORE3.launch_next_insn;
                spc3_phy_pc_w <= {{16{`PICO_CORE3.reg_pc[31]}}, `PICO_CORE3.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC3
    

    `ifdef RTL_SPARC4
    `ifdef GATE_SIM_SPARC
        assign sas_m4                = `INSTPATH4.runw_ff_u_dff_0_.d &
               (~`INSTPATH4.exu_ifu_ecc_ce_m | `INSTPATH4.trapm_ff_u_dff_0_.q);
        assign spc4_thread_id        = {`PCPATH4.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH4.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH4.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH4.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc4_rtl_pc           = `SPCPATH4.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m4                = `INSTPATH4.inst_vld_m       & ~`INSTPATH4.kill_thread_m &
               ~(`INSTPATH4.exu_ifu_ecc_ce_m & `INSTPATH4.inst_vld_m & ~`INSTPATH4.trap_m);
        assign spc4_thread_id        = `PCPATH4.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc4_rtl_pc           = `SPCPATH4.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc4_rtl_pc           = `SPCPATH4.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc4_phy_pc_d,  spc4_phy_pc_e,  spc4_phy_pc_m,
                spc4_t0pc_s,    spc4_t1pc_s,    spc4_t2pc_s,  spc4_t3pc_s ;

            reg [3:0]  spc4_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc4_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc4_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc4_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs4 = spc4_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf4 = spc4_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd4 = spc4_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce4 = spc4_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc4_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc4_imiss_paddr_s = {`IFQDP4.itlb_ifq_paddr_s, `IFQDP4.lcl_paddr_s, 2'b0} ;
    `else
            assign spc4_imiss_paddr_s = `IFQDP4.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc4_inst_done                     <= sas_m4;

                //next pc select
                spc4_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH4.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc4_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH4.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc4_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH4.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc4_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH4.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf4[0] == 0)spc4_t0pc_s          <= spc4_imiss_paddr_s;
                else if(pcs4[0] == 0)spc4_t0pc_s     <= spc4_t0pc_s;
                else if(pcd4[0] == 0)spc4_t0pc_s     <= spc4_phy_pc_e;
                else if(pce4[0] == 0)spc4_t0pc_s     <= spc4_phy_pc_m;

                if(pcf4[1] == 0)spc4_t1pc_s          <= spc4_imiss_paddr_s;
                else if(pcs4[1] == 0)spc4_t1pc_s     <= spc4_t1pc_s;
                else if(pcd4[1] == 0)spc4_t1pc_s     <= spc4_phy_pc_e;
                else if(pce4[1] == 0)spc4_t1pc_s     <= spc4_phy_pc_m;

                if(pcf4[2] == 0)spc4_t2pc_s          <= spc4_imiss_paddr_s;
                else if(pcs4[2] == 0)spc4_t2pc_s     <= spc4_t2pc_s;
                else if(pcd4[2] == 0)spc4_t2pc_s     <= spc4_phy_pc_e;
                else if(pce4[2] == 0)spc4_t2pc_s     <= spc4_phy_pc_m;

                if(pcf4[3] == 0)spc4_t3pc_s          <= spc4_imiss_paddr_s;
                else if(pcs4[3] == 0)spc4_t3pc_s     <= spc4_t3pc_s;
                else if(pcd4[3] == 0)spc4_t3pc_s     <= spc4_phy_pc_e;
                else if(pce4[3] == 0)spc4_t3pc_s     <= spc4_phy_pc_m;

                if(~`DTUPATH4.fcl_fdp_thr_s2_l[0])     spc4_phy_pc_d <= pcf4[0] ? spc4_t0pc_s : spc4_imiss_paddr_s;
                else if(~`DTUPATH4.fcl_fdp_thr_s2_l[1])spc4_phy_pc_d <= pcf4[1] ? spc4_t1pc_s : spc4_imiss_paddr_s;
                else if(~`DTUPATH4.fcl_fdp_thr_s2_l[2])spc4_phy_pc_d <= pcf4[2] ? spc4_t2pc_s : spc4_imiss_paddr_s;
                else if(~`DTUPATH4.fcl_fdp_thr_s2_l[3])spc4_phy_pc_d <= pcf4[3] ? spc4_t3pc_s : spc4_imiss_paddr_s;

                spc4_phy_pc_e   <= spc4_phy_pc_d;
                spc4_phy_pc_m   <= spc4_phy_pc_e;
                spc4_phy_pc_w   <= {{8{spc4_phy_pc_m[39]}}, spc4_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC4
    `ifdef RTL_ARIANE0
            assign spc4_thread_id = 2'b00;
            assign spc4_rtl_pc = spc4_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(4*4)]   <= 1'b0;
                  active_thread[(4*4)+1] <= 1'b0;
                  active_thread[(4*4)+2] <= 1'b0;
                  active_thread[(4*4)+3] <= 1'b0;
                  spc4_inst_done         <= 0;
                  spc4_phy_pc_w          <= 0;
                end else begin
                  active_thread[(4*4)]   <= 1'b1;
                  active_thread[(4*4)+1] <= 1'b1;
                  active_thread[(4*4)+2] <= 1'b1;
                  active_thread[(4*4)+3] <= 1'b1;
                  spc4_inst_done         <= `ARIANE_CORE4.piton_pc_vld;
                  spc4_phy_pc_w          <= `ARIANE_CORE4.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc4_thread_id = 2'b00;
            assign spc4_rtl_pc = spc4_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE4.pico_int == 1'b1)
                begin
                    active_thread[(4*4)] = 1'b1;
                    active_thread[(4*4)+1] = 1'b1;
                    active_thread[(4*4)+2] = 1'b1;
                    active_thread[(4*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc4_inst_done <= `PICO_CORE4.launch_next_insn;
                spc4_phy_pc_w <= {{16{`PICO_CORE4.reg_pc[31]}}, `PICO_CORE4.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC4
    

    `ifdef RTL_SPARC5
    `ifdef GATE_SIM_SPARC
        assign sas_m5                = `INSTPATH5.runw_ff_u_dff_0_.d &
               (~`INSTPATH5.exu_ifu_ecc_ce_m | `INSTPATH5.trapm_ff_u_dff_0_.q);
        assign spc5_thread_id        = {`PCPATH5.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH5.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH5.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH5.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc5_rtl_pc           = `SPCPATH5.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m5                = `INSTPATH5.inst_vld_m       & ~`INSTPATH5.kill_thread_m &
               ~(`INSTPATH5.exu_ifu_ecc_ce_m & `INSTPATH5.inst_vld_m & ~`INSTPATH5.trap_m);
        assign spc5_thread_id        = `PCPATH5.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc5_rtl_pc           = `SPCPATH5.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc5_rtl_pc           = `SPCPATH5.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc5_phy_pc_d,  spc5_phy_pc_e,  spc5_phy_pc_m,
                spc5_t0pc_s,    spc5_t1pc_s,    spc5_t2pc_s,  spc5_t3pc_s ;

            reg [3:0]  spc5_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc5_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc5_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc5_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs5 = spc5_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf5 = spc5_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd5 = spc5_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce5 = spc5_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc5_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc5_imiss_paddr_s = {`IFQDP5.itlb_ifq_paddr_s, `IFQDP5.lcl_paddr_s, 2'b0} ;
    `else
            assign spc5_imiss_paddr_s = `IFQDP5.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc5_inst_done                     <= sas_m5;

                //next pc select
                spc5_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH5.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc5_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH5.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc5_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH5.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc5_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH5.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf5[0] == 0)spc5_t0pc_s          <= spc5_imiss_paddr_s;
                else if(pcs5[0] == 0)spc5_t0pc_s     <= spc5_t0pc_s;
                else if(pcd5[0] == 0)spc5_t0pc_s     <= spc5_phy_pc_e;
                else if(pce5[0] == 0)spc5_t0pc_s     <= spc5_phy_pc_m;

                if(pcf5[1] == 0)spc5_t1pc_s          <= spc5_imiss_paddr_s;
                else if(pcs5[1] == 0)spc5_t1pc_s     <= spc5_t1pc_s;
                else if(pcd5[1] == 0)spc5_t1pc_s     <= spc5_phy_pc_e;
                else if(pce5[1] == 0)spc5_t1pc_s     <= spc5_phy_pc_m;

                if(pcf5[2] == 0)spc5_t2pc_s          <= spc5_imiss_paddr_s;
                else if(pcs5[2] == 0)spc5_t2pc_s     <= spc5_t2pc_s;
                else if(pcd5[2] == 0)spc5_t2pc_s     <= spc5_phy_pc_e;
                else if(pce5[2] == 0)spc5_t2pc_s     <= spc5_phy_pc_m;

                if(pcf5[3] == 0)spc5_t3pc_s          <= spc5_imiss_paddr_s;
                else if(pcs5[3] == 0)spc5_t3pc_s     <= spc5_t3pc_s;
                else if(pcd5[3] == 0)spc5_t3pc_s     <= spc5_phy_pc_e;
                else if(pce5[3] == 0)spc5_t3pc_s     <= spc5_phy_pc_m;

                if(~`DTUPATH5.fcl_fdp_thr_s2_l[0])     spc5_phy_pc_d <= pcf5[0] ? spc5_t0pc_s : spc5_imiss_paddr_s;
                else if(~`DTUPATH5.fcl_fdp_thr_s2_l[1])spc5_phy_pc_d <= pcf5[1] ? spc5_t1pc_s : spc5_imiss_paddr_s;
                else if(~`DTUPATH5.fcl_fdp_thr_s2_l[2])spc5_phy_pc_d <= pcf5[2] ? spc5_t2pc_s : spc5_imiss_paddr_s;
                else if(~`DTUPATH5.fcl_fdp_thr_s2_l[3])spc5_phy_pc_d <= pcf5[3] ? spc5_t3pc_s : spc5_imiss_paddr_s;

                spc5_phy_pc_e   <= spc5_phy_pc_d;
                spc5_phy_pc_m   <= spc5_phy_pc_e;
                spc5_phy_pc_w   <= {{8{spc5_phy_pc_m[39]}}, spc5_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC5
    `ifdef RTL_ARIANE0
            assign spc5_thread_id = 2'b00;
            assign spc5_rtl_pc = spc5_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(5*4)]   <= 1'b0;
                  active_thread[(5*4)+1] <= 1'b0;
                  active_thread[(5*4)+2] <= 1'b0;
                  active_thread[(5*4)+3] <= 1'b0;
                  spc5_inst_done         <= 0;
                  spc5_phy_pc_w          <= 0;
                end else begin
                  active_thread[(5*4)]   <= 1'b1;
                  active_thread[(5*4)+1] <= 1'b1;
                  active_thread[(5*4)+2] <= 1'b1;
                  active_thread[(5*4)+3] <= 1'b1;
                  spc5_inst_done         <= `ARIANE_CORE5.piton_pc_vld;
                  spc5_phy_pc_w          <= `ARIANE_CORE5.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc5_thread_id = 2'b00;
            assign spc5_rtl_pc = spc5_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE5.pico_int == 1'b1)
                begin
                    active_thread[(5*4)] = 1'b1;
                    active_thread[(5*4)+1] = 1'b1;
                    active_thread[(5*4)+2] = 1'b1;
                    active_thread[(5*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc5_inst_done <= `PICO_CORE5.launch_next_insn;
                spc5_phy_pc_w <= {{16{`PICO_CORE5.reg_pc[31]}}, `PICO_CORE5.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC5
    

    `ifdef RTL_SPARC6
    `ifdef GATE_SIM_SPARC
        assign sas_m6                = `INSTPATH6.runw_ff_u_dff_0_.d &
               (~`INSTPATH6.exu_ifu_ecc_ce_m | `INSTPATH6.trapm_ff_u_dff_0_.q);
        assign spc6_thread_id        = {`PCPATH6.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH6.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH6.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH6.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc6_rtl_pc           = `SPCPATH6.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m6                = `INSTPATH6.inst_vld_m       & ~`INSTPATH6.kill_thread_m &
               ~(`INSTPATH6.exu_ifu_ecc_ce_m & `INSTPATH6.inst_vld_m & ~`INSTPATH6.trap_m);
        assign spc6_thread_id        = `PCPATH6.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc6_rtl_pc           = `SPCPATH6.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc6_rtl_pc           = `SPCPATH6.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc6_phy_pc_d,  spc6_phy_pc_e,  spc6_phy_pc_m,
                spc6_t0pc_s,    spc6_t1pc_s,    spc6_t2pc_s,  spc6_t3pc_s ;

            reg [3:0]  spc6_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc6_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc6_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc6_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs6 = spc6_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf6 = spc6_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd6 = spc6_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce6 = spc6_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc6_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc6_imiss_paddr_s = {`IFQDP6.itlb_ifq_paddr_s, `IFQDP6.lcl_paddr_s, 2'b0} ;
    `else
            assign spc6_imiss_paddr_s = `IFQDP6.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc6_inst_done                     <= sas_m6;

                //next pc select
                spc6_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH6.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc6_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH6.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc6_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH6.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc6_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH6.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf6[0] == 0)spc6_t0pc_s          <= spc6_imiss_paddr_s;
                else if(pcs6[0] == 0)spc6_t0pc_s     <= spc6_t0pc_s;
                else if(pcd6[0] == 0)spc6_t0pc_s     <= spc6_phy_pc_e;
                else if(pce6[0] == 0)spc6_t0pc_s     <= spc6_phy_pc_m;

                if(pcf6[1] == 0)spc6_t1pc_s          <= spc6_imiss_paddr_s;
                else if(pcs6[1] == 0)spc6_t1pc_s     <= spc6_t1pc_s;
                else if(pcd6[1] == 0)spc6_t1pc_s     <= spc6_phy_pc_e;
                else if(pce6[1] == 0)spc6_t1pc_s     <= spc6_phy_pc_m;

                if(pcf6[2] == 0)spc6_t2pc_s          <= spc6_imiss_paddr_s;
                else if(pcs6[2] == 0)spc6_t2pc_s     <= spc6_t2pc_s;
                else if(pcd6[2] == 0)spc6_t2pc_s     <= spc6_phy_pc_e;
                else if(pce6[2] == 0)spc6_t2pc_s     <= spc6_phy_pc_m;

                if(pcf6[3] == 0)spc6_t3pc_s          <= spc6_imiss_paddr_s;
                else if(pcs6[3] == 0)spc6_t3pc_s     <= spc6_t3pc_s;
                else if(pcd6[3] == 0)spc6_t3pc_s     <= spc6_phy_pc_e;
                else if(pce6[3] == 0)spc6_t3pc_s     <= spc6_phy_pc_m;

                if(~`DTUPATH6.fcl_fdp_thr_s2_l[0])     spc6_phy_pc_d <= pcf6[0] ? spc6_t0pc_s : spc6_imiss_paddr_s;
                else if(~`DTUPATH6.fcl_fdp_thr_s2_l[1])spc6_phy_pc_d <= pcf6[1] ? spc6_t1pc_s : spc6_imiss_paddr_s;
                else if(~`DTUPATH6.fcl_fdp_thr_s2_l[2])spc6_phy_pc_d <= pcf6[2] ? spc6_t2pc_s : spc6_imiss_paddr_s;
                else if(~`DTUPATH6.fcl_fdp_thr_s2_l[3])spc6_phy_pc_d <= pcf6[3] ? spc6_t3pc_s : spc6_imiss_paddr_s;

                spc6_phy_pc_e   <= spc6_phy_pc_d;
                spc6_phy_pc_m   <= spc6_phy_pc_e;
                spc6_phy_pc_w   <= {{8{spc6_phy_pc_m[39]}}, spc6_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC6
    `ifdef RTL_ARIANE0
            assign spc6_thread_id = 2'b00;
            assign spc6_rtl_pc = spc6_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(6*4)]   <= 1'b0;
                  active_thread[(6*4)+1] <= 1'b0;
                  active_thread[(6*4)+2] <= 1'b0;
                  active_thread[(6*4)+3] <= 1'b0;
                  spc6_inst_done         <= 0;
                  spc6_phy_pc_w          <= 0;
                end else begin
                  active_thread[(6*4)]   <= 1'b1;
                  active_thread[(6*4)+1] <= 1'b1;
                  active_thread[(6*4)+2] <= 1'b1;
                  active_thread[(6*4)+3] <= 1'b1;
                  spc6_inst_done         <= `ARIANE_CORE6.piton_pc_vld;
                  spc6_phy_pc_w          <= `ARIANE_CORE6.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc6_thread_id = 2'b00;
            assign spc6_rtl_pc = spc6_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE6.pico_int == 1'b1)
                begin
                    active_thread[(6*4)] = 1'b1;
                    active_thread[(6*4)+1] = 1'b1;
                    active_thread[(6*4)+2] = 1'b1;
                    active_thread[(6*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc6_inst_done <= `PICO_CORE6.launch_next_insn;
                spc6_phy_pc_w <= {{16{`PICO_CORE6.reg_pc[31]}}, `PICO_CORE6.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC6
    

    `ifdef RTL_SPARC7
    `ifdef GATE_SIM_SPARC
        assign sas_m7                = `INSTPATH7.runw_ff_u_dff_0_.d &
               (~`INSTPATH7.exu_ifu_ecc_ce_m | `INSTPATH7.trapm_ff_u_dff_0_.q);
        assign spc7_thread_id        = {`PCPATH7.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH7.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH7.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH7.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc7_rtl_pc           = `SPCPATH7.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m7                = `INSTPATH7.inst_vld_m       & ~`INSTPATH7.kill_thread_m &
               ~(`INSTPATH7.exu_ifu_ecc_ce_m & `INSTPATH7.inst_vld_m & ~`INSTPATH7.trap_m);
        assign spc7_thread_id        = `PCPATH7.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc7_rtl_pc           = `SPCPATH7.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc7_rtl_pc           = `SPCPATH7.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc7_phy_pc_d,  spc7_phy_pc_e,  spc7_phy_pc_m,
                spc7_t0pc_s,    spc7_t1pc_s,    spc7_t2pc_s,  spc7_t3pc_s ;

            reg [3:0]  spc7_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc7_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc7_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc7_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs7 = spc7_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf7 = spc7_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd7 = spc7_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce7 = spc7_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc7_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc7_imiss_paddr_s = {`IFQDP7.itlb_ifq_paddr_s, `IFQDP7.lcl_paddr_s, 2'b0} ;
    `else
            assign spc7_imiss_paddr_s = `IFQDP7.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc7_inst_done                     <= sas_m7;

                //next pc select
                spc7_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH7.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc7_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH7.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc7_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH7.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc7_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH7.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf7[0] == 0)spc7_t0pc_s          <= spc7_imiss_paddr_s;
                else if(pcs7[0] == 0)spc7_t0pc_s     <= spc7_t0pc_s;
                else if(pcd7[0] == 0)spc7_t0pc_s     <= spc7_phy_pc_e;
                else if(pce7[0] == 0)spc7_t0pc_s     <= spc7_phy_pc_m;

                if(pcf7[1] == 0)spc7_t1pc_s          <= spc7_imiss_paddr_s;
                else if(pcs7[1] == 0)spc7_t1pc_s     <= spc7_t1pc_s;
                else if(pcd7[1] == 0)spc7_t1pc_s     <= spc7_phy_pc_e;
                else if(pce7[1] == 0)spc7_t1pc_s     <= spc7_phy_pc_m;

                if(pcf7[2] == 0)spc7_t2pc_s          <= spc7_imiss_paddr_s;
                else if(pcs7[2] == 0)spc7_t2pc_s     <= spc7_t2pc_s;
                else if(pcd7[2] == 0)spc7_t2pc_s     <= spc7_phy_pc_e;
                else if(pce7[2] == 0)spc7_t2pc_s     <= spc7_phy_pc_m;

                if(pcf7[3] == 0)spc7_t3pc_s          <= spc7_imiss_paddr_s;
                else if(pcs7[3] == 0)spc7_t3pc_s     <= spc7_t3pc_s;
                else if(pcd7[3] == 0)spc7_t3pc_s     <= spc7_phy_pc_e;
                else if(pce7[3] == 0)spc7_t3pc_s     <= spc7_phy_pc_m;

                if(~`DTUPATH7.fcl_fdp_thr_s2_l[0])     spc7_phy_pc_d <= pcf7[0] ? spc7_t0pc_s : spc7_imiss_paddr_s;
                else if(~`DTUPATH7.fcl_fdp_thr_s2_l[1])spc7_phy_pc_d <= pcf7[1] ? spc7_t1pc_s : spc7_imiss_paddr_s;
                else if(~`DTUPATH7.fcl_fdp_thr_s2_l[2])spc7_phy_pc_d <= pcf7[2] ? spc7_t2pc_s : spc7_imiss_paddr_s;
                else if(~`DTUPATH7.fcl_fdp_thr_s2_l[3])spc7_phy_pc_d <= pcf7[3] ? spc7_t3pc_s : spc7_imiss_paddr_s;

                spc7_phy_pc_e   <= spc7_phy_pc_d;
                spc7_phy_pc_m   <= spc7_phy_pc_e;
                spc7_phy_pc_w   <= {{8{spc7_phy_pc_m[39]}}, spc7_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC7
    `ifdef RTL_ARIANE0
            assign spc7_thread_id = 2'b00;
            assign spc7_rtl_pc = spc7_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(7*4)]   <= 1'b0;
                  active_thread[(7*4)+1] <= 1'b0;
                  active_thread[(7*4)+2] <= 1'b0;
                  active_thread[(7*4)+3] <= 1'b0;
                  spc7_inst_done         <= 0;
                  spc7_phy_pc_w          <= 0;
                end else begin
                  active_thread[(7*4)]   <= 1'b1;
                  active_thread[(7*4)+1] <= 1'b1;
                  active_thread[(7*4)+2] <= 1'b1;
                  active_thread[(7*4)+3] <= 1'b1;
                  spc7_inst_done         <= `ARIANE_CORE7.piton_pc_vld;
                  spc7_phy_pc_w          <= `ARIANE_CORE7.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc7_thread_id = 2'b00;
            assign spc7_rtl_pc = spc7_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE7.pico_int == 1'b1)
                begin
                    active_thread[(7*4)] = 1'b1;
                    active_thread[(7*4)+1] = 1'b1;
                    active_thread[(7*4)+2] = 1'b1;
                    active_thread[(7*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc7_inst_done <= `PICO_CORE7.launch_next_insn;
                spc7_phy_pc_w <= {{16{`PICO_CORE7.reg_pc[31]}}, `PICO_CORE7.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC7
    

    `ifdef RTL_SPARC8
    `ifdef GATE_SIM_SPARC
        assign sas_m8                = `INSTPATH8.runw_ff_u_dff_0_.d &
               (~`INSTPATH8.exu_ifu_ecc_ce_m | `INSTPATH8.trapm_ff_u_dff_0_.q);
        assign spc8_thread_id        = {`PCPATH8.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH8.ifu_fcl.thrw_reg_q_tmp_2_,
                                        `PCPATH8.ifu_fcl.thrw_reg_q_tmp_3_ | `PCPATH8.ifu_fcl.thrw_reg_q_tmp_1_};
        assign spc8_rtl_pc           = `SPCPATH8.ifu_fdp.pc_w[47:0];
    `else
        assign sas_m8                = `INSTPATH8.inst_vld_m       & ~`INSTPATH8.kill_thread_m &
               ~(`INSTPATH8.exu_ifu_ecc_ce_m & `INSTPATH8.inst_vld_m & ~`INSTPATH8.trap_m);
        assign spc8_thread_id        = `PCPATH8.fcl.sas_thrid_w;
    `ifndef RTL_SPU
            assign spc8_rtl_pc           = `SPCPATH8.ifu.ifu.fdp.pc_w[47:0];
    `else
            assign spc8_rtl_pc           = `SPCPATH8.ifu.fdp.pc_w[47:0];
    `endif
    `endif // ifdef GATE_SIM_SPARC

            reg [63:0] spc8_phy_pc_d,  spc8_phy_pc_e,  spc8_phy_pc_m,
                spc8_t0pc_s,    spc8_t1pc_s,    spc8_t2pc_s,  spc8_t3pc_s ;

            reg [3:0]  spc8_fcl_fdp_nextpcs_sel_pcf_f_l_e,
                spc8_fcl_fdp_nextpcs_sel_pcs_f_l_e,
                spc8_fcl_fdp_nextpcs_sel_pcd_f_l_e,
                spc8_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [3:0] pcs8 = spc8_fcl_fdp_nextpcs_sel_pcs_f_l_e;
            wire [3:0] pcf8 = spc8_fcl_fdp_nextpcs_sel_pcf_f_l_e;
            wire [3:0] pcd8 = spc8_fcl_fdp_nextpcs_sel_pcd_f_l_e;
            wire [3:0] pce8 = spc8_fcl_fdp_nextpcs_sel_pce_f_l_e;

            wire [63:0]  spc8_imiss_paddr_s ;

    `ifdef  GATE_SIM_SPARC
            assign spc8_imiss_paddr_s = {`IFQDP8.itlb_ifq_paddr_s, `IFQDP8.lcl_paddr_s, 2'b0} ;
    `else
            assign spc8_imiss_paddr_s = `IFQDP8.imiss_paddr_s ;
    `endif // GATE_SIM_SPARC



            always @(posedge clk) begin
                //done
                spc8_inst_done                     <= sas_m8;

                //next pc select
                spc8_fcl_fdp_nextpcs_sel_pcs_f_l_e <= `DTUPATH8.fcl_fdp_nextpcs_sel_pcs_f_l;
                spc8_fcl_fdp_nextpcs_sel_pcf_f_l_e <= `DTUPATH8.fcl_fdp_nextpcs_sel_pcf_f_l;
                spc8_fcl_fdp_nextpcs_sel_pcd_f_l_e <= `DTUPATH8.fcl_fdp_nextpcs_sel_pcd_f_l;
                spc8_fcl_fdp_nextpcs_sel_pce_f_l_e <= `DTUPATH8.fcl_fdp_nextpcs_sel_pce_f_l;

                //pipe physical pc

                if(pcf8[0] == 0)spc8_t0pc_s          <= spc8_imiss_paddr_s;
                else if(pcs8[0] == 0)spc8_t0pc_s     <= spc8_t0pc_s;
                else if(pcd8[0] == 0)spc8_t0pc_s     <= spc8_phy_pc_e;
                else if(pce8[0] == 0)spc8_t0pc_s     <= spc8_phy_pc_m;

                if(pcf8[1] == 0)spc8_t1pc_s          <= spc8_imiss_paddr_s;
                else if(pcs8[1] == 0)spc8_t1pc_s     <= spc8_t1pc_s;
                else if(pcd8[1] == 0)spc8_t1pc_s     <= spc8_phy_pc_e;
                else if(pce8[1] == 0)spc8_t1pc_s     <= spc8_phy_pc_m;

                if(pcf8[2] == 0)spc8_t2pc_s          <= spc8_imiss_paddr_s;
                else if(pcs8[2] == 0)spc8_t2pc_s     <= spc8_t2pc_s;
                else if(pcd8[2] == 0)spc8_t2pc_s     <= spc8_phy_pc_e;
                else if(pce8[2] == 0)spc8_t2pc_s     <= spc8_phy_pc_m;

                if(pcf8[3] == 0)spc8_t3pc_s          <= spc8_imiss_paddr_s;
                else if(pcs8[3] == 0)spc8_t3pc_s     <= spc8_t3pc_s;
                else if(pcd8[3] == 0)spc8_t3pc_s     <= spc8_phy_pc_e;
                else if(pce8[3] == 0)spc8_t3pc_s     <= spc8_phy_pc_m;

                if(~`DTUPATH8.fcl_fdp_thr_s2_l[0])     spc8_phy_pc_d <= pcf8[0] ? spc8_t0pc_s : spc8_imiss_paddr_s;
                else if(~`DTUPATH8.fcl_fdp_thr_s2_l[1])spc8_phy_pc_d <= pcf8[1] ? spc8_t1pc_s : spc8_imiss_paddr_s;
                else if(~`DTUPATH8.fcl_fdp_thr_s2_l[2])spc8_phy_pc_d <= pcf8[2] ? spc8_t2pc_s : spc8_imiss_paddr_s;
                else if(~`DTUPATH8.fcl_fdp_thr_s2_l[3])spc8_phy_pc_d <= pcf8[3] ? spc8_t3pc_s : spc8_imiss_paddr_s;

                spc8_phy_pc_e   <= spc8_phy_pc_d;
                spc8_phy_pc_m   <= spc8_phy_pc_e;
                spc8_phy_pc_w   <= {{8{spc8_phy_pc_m[39]}}, spc8_phy_pc_m[39:0]};
            end
    `else // RTL_SPARC8
    `ifdef RTL_ARIANE0
            assign spc8_thread_id = 2'b00;
            assign spc8_rtl_pc = spc8_phy_pc_w;

            always @(posedge clk) begin
                if (~rst_l) begin
                  active_thread[(8*4)]   <= 1'b0;
                  active_thread[(8*4)+1] <= 1'b0;
                  active_thread[(8*4)+2] <= 1'b0;
                  active_thread[(8*4)+3] <= 1'b0;
                  spc8_inst_done         <= 0;
                  spc8_phy_pc_w          <= 0;
                end else begin
                  active_thread[(8*4)]   <= 1'b1;
                  active_thread[(8*4)+1] <= 1'b1;
                  active_thread[(8*4)+2] <= 1'b1;
                  active_thread[(8*4)+3] <= 1'b1;
                  spc8_inst_done         <= `ARIANE_CORE8.piton_pc_vld;
                  spc8_phy_pc_w          <= `ARIANE_CORE8.piton_pc;
                end
            end
    `else // RTL_ARIANE0
    `ifdef RTL_PICO0
            assign spc8_thread_id = 2'b00;
            assign spc8_rtl_pc = spc8_phy_pc_w;

            always @*
            begin
                if (`PICO_CORE8.pico_int == 1'b1)
                begin
                    active_thread[(8*4)] = 1'b1;
                    active_thread[(8*4)+1] = 1'b1;
                    active_thread[(8*4)+2] = 1'b1;
                    active_thread[(8*4)+3] = 1'b1;
                end
            end

            always @(posedge clk) begin
                spc8_inst_done <= `PICO_CORE8.launch_next_insn;
                spc8_phy_pc_w <= {{16{`PICO_CORE8.reg_pc[31]}}, `PICO_CORE8.reg_pc[31:0]};
            end
    `endif // RTL_PICO0
    `endif // RTL_ARIANE0
    `endif // RTL_SPARC8
    




reg           dummy;

task trap_extract;
    reg [2048:0] pc_str;
    reg [63:0]  tmp_val;
    integer     i;
    begin
        bad_trap_count = 0;
        finish_mask    = 1;
        diag_mask      = 0;
        stub_mask      = 0;
        if($value$plusargs("finish_mask=%h", finish_mask))$display ("%t: finish_mask %h", $time, finish_mask);
            if($value$plusargs("good_trap0=%h", tmp_val)) begin
                good_trap[0] = tmp_val;
                good_trap_exists[0] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[0]);
            end

            if($value$plusargs("good_trap1=%h", tmp_val)) begin
                good_trap[1] = tmp_val;
                good_trap_exists[1] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[1]);
            end

            if($value$plusargs("good_trap2=%h", tmp_val)) begin
                good_trap[2] = tmp_val;
                good_trap_exists[2] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[2]);
            end

            if($value$plusargs("good_trap3=%h", tmp_val)) begin
                good_trap[3] = tmp_val;
                good_trap_exists[3] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[3]);
            end

            if($value$plusargs("good_trap4=%h", tmp_val)) begin
                good_trap[4] = tmp_val;
                good_trap_exists[4] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[4]);
            end

            if($value$plusargs("good_trap5=%h", tmp_val)) begin
                good_trap[5] = tmp_val;
                good_trap_exists[5] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[5]);
            end

            if($value$plusargs("good_trap6=%h", tmp_val)) begin
                good_trap[6] = tmp_val;
                good_trap_exists[6] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[6]);
            end

            if($value$plusargs("good_trap7=%h", tmp_val)) begin
                good_trap[7] = tmp_val;
                good_trap_exists[7] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[7]);
            end

            if($value$plusargs("good_trap8=%h", tmp_val)) begin
                good_trap[8] = tmp_val;
                good_trap_exists[8] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[8]);
            end

            if($value$plusargs("good_trap9=%h", tmp_val)) begin
                good_trap[9] = tmp_val;
                good_trap_exists[9] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[9]);
            end

            if($value$plusargs("good_trap10=%h", tmp_val)) begin
                good_trap[10] = tmp_val;
                good_trap_exists[10] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[10]);
            end

            if($value$plusargs("good_trap11=%h", tmp_val)) begin
                good_trap[11] = tmp_val;
                good_trap_exists[11] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[11]);
            end

            if($value$plusargs("good_trap12=%h", tmp_val)) begin
                good_trap[12] = tmp_val;
                good_trap_exists[12] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[12]);
            end

            if($value$plusargs("good_trap13=%h", tmp_val)) begin
                good_trap[13] = tmp_val;
                good_trap_exists[13] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[13]);
            end

            if($value$plusargs("good_trap14=%h", tmp_val)) begin
                good_trap[14] = tmp_val;
                good_trap_exists[14] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[14]);
            end

            if($value$plusargs("good_trap15=%h", tmp_val)) begin
                good_trap[15] = tmp_val;
                good_trap_exists[15] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[15]);
            end

            if($value$plusargs("good_trap16=%h", tmp_val)) begin
                good_trap[16] = tmp_val;
                good_trap_exists[16] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[16]);
            end

            if($value$plusargs("good_trap17=%h", tmp_val)) begin
                good_trap[17] = tmp_val;
                good_trap_exists[17] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[17]);
            end

            if($value$plusargs("good_trap18=%h", tmp_val)) begin
                good_trap[18] = tmp_val;
                good_trap_exists[18] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[18]);
            end

            if($value$plusargs("good_trap19=%h", tmp_val)) begin
                good_trap[19] = tmp_val;
                good_trap_exists[19] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[19]);
            end

            if($value$plusargs("good_trap20=%h", tmp_val)) begin
                good_trap[20] = tmp_val;
                good_trap_exists[20] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[20]);
            end

            if($value$plusargs("good_trap21=%h", tmp_val)) begin
                good_trap[21] = tmp_val;
                good_trap_exists[21] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[21]);
            end

            if($value$plusargs("good_trap22=%h", tmp_val)) begin
                good_trap[22] = tmp_val;
                good_trap_exists[22] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[22]);
            end

            if($value$plusargs("good_trap23=%h", tmp_val)) begin
                good_trap[23] = tmp_val;
                good_trap_exists[23] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[23]);
            end

            if($value$plusargs("good_trap24=%h", tmp_val)) begin
                good_trap[24] = tmp_val;
                good_trap_exists[24] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[24]);
            end

            if($value$plusargs("good_trap25=%h", tmp_val)) begin
                good_trap[25] = tmp_val;
                good_trap_exists[25] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[25]);
            end

            if($value$plusargs("good_trap26=%h", tmp_val)) begin
                good_trap[26] = tmp_val;
                good_trap_exists[26] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[26]);
            end

            if($value$plusargs("good_trap27=%h", tmp_val)) begin
                good_trap[27] = tmp_val;
                good_trap_exists[27] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[27]);
            end

            if($value$plusargs("good_trap28=%h", tmp_val)) begin
                good_trap[28] = tmp_val;
                good_trap_exists[28] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[28]);
            end

            if($value$plusargs("good_trap29=%h", tmp_val)) begin
                good_trap[29] = tmp_val;
                good_trap_exists[29] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[29]);
            end

            if($value$plusargs("good_trap30=%h", tmp_val)) begin
                good_trap[30] = tmp_val;
                good_trap_exists[30] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[30]);
            end

            if($value$plusargs("good_trap31=%h", tmp_val)) begin
                good_trap[31] = tmp_val;
                good_trap_exists[31] = 1'b1;
                $display ("%t: good_trap %h", $time, good_trap[31]);
            end

        if($value$plusargs("stub_mask=%h", stub_mask))    $display ("%t: stub_mask  %h", $time, stub_mask);

`ifndef VERILATOR
        for(i = 0; i < `NUM_TILES;i = i + 1)if(finish_mask[i] === 1'bx)finish_mask[i] = 1'b0;
        for(i = 0; i < 8;i = i + 1) if(stub_mask[i] === 1'bx)stub_mask[i] = 1'b0;
`endif


            if($value$plusargs("bad_trap0=%h", tmp_val)) begin
                bad_trap[0] = tmp_val;
                bad_trap_exists[0] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[0]);
            end

            if($value$plusargs("bad_trap1=%h", tmp_val)) begin
                bad_trap[1] = tmp_val;
                bad_trap_exists[1] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[1]);
            end

            if($value$plusargs("bad_trap2=%h", tmp_val)) begin
                bad_trap[2] = tmp_val;
                bad_trap_exists[2] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[2]);
            end

            if($value$plusargs("bad_trap3=%h", tmp_val)) begin
                bad_trap[3] = tmp_val;
                bad_trap_exists[3] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[3]);
            end

            if($value$plusargs("bad_trap4=%h", tmp_val)) begin
                bad_trap[4] = tmp_val;
                bad_trap_exists[4] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[4]);
            end

            if($value$plusargs("bad_trap5=%h", tmp_val)) begin
                bad_trap[5] = tmp_val;
                bad_trap_exists[5] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[5]);
            end

            if($value$plusargs("bad_trap6=%h", tmp_val)) begin
                bad_trap[6] = tmp_val;
                bad_trap_exists[6] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[6]);
            end

            if($value$plusargs("bad_trap7=%h", tmp_val)) begin
                bad_trap[7] = tmp_val;
                bad_trap_exists[7] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[7]);
            end

            if($value$plusargs("bad_trap8=%h", tmp_val)) begin
                bad_trap[8] = tmp_val;
                bad_trap_exists[8] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[8]);
            end

            if($value$plusargs("bad_trap9=%h", tmp_val)) begin
                bad_trap[9] = tmp_val;
                bad_trap_exists[9] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[9]);
            end

            if($value$plusargs("bad_trap10=%h", tmp_val)) begin
                bad_trap[10] = tmp_val;
                bad_trap_exists[10] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[10]);
            end

            if($value$plusargs("bad_trap11=%h", tmp_val)) begin
                bad_trap[11] = tmp_val;
                bad_trap_exists[11] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[11]);
            end

            if($value$plusargs("bad_trap12=%h", tmp_val)) begin
                bad_trap[12] = tmp_val;
                bad_trap_exists[12] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[12]);
            end

            if($value$plusargs("bad_trap13=%h", tmp_val)) begin
                bad_trap[13] = tmp_val;
                bad_trap_exists[13] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[13]);
            end

            if($value$plusargs("bad_trap14=%h", tmp_val)) begin
                bad_trap[14] = tmp_val;
                bad_trap_exists[14] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[14]);
            end

            if($value$plusargs("bad_trap15=%h", tmp_val)) begin
                bad_trap[15] = tmp_val;
                bad_trap_exists[15] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[15]);
            end

            if($value$plusargs("bad_trap16=%h", tmp_val)) begin
                bad_trap[16] = tmp_val;
                bad_trap_exists[16] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[16]);
            end

            if($value$plusargs("bad_trap17=%h", tmp_val)) begin
                bad_trap[17] = tmp_val;
                bad_trap_exists[17] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[17]);
            end

            if($value$plusargs("bad_trap18=%h", tmp_val)) begin
                bad_trap[18] = tmp_val;
                bad_trap_exists[18] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[18]);
            end

            if($value$plusargs("bad_trap19=%h", tmp_val)) begin
                bad_trap[19] = tmp_val;
                bad_trap_exists[19] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[19]);
            end

            if($value$plusargs("bad_trap20=%h", tmp_val)) begin
                bad_trap[20] = tmp_val;
                bad_trap_exists[20] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[20]);
            end

            if($value$plusargs("bad_trap21=%h", tmp_val)) begin
                bad_trap[21] = tmp_val;
                bad_trap_exists[21] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[21]);
            end

            if($value$plusargs("bad_trap22=%h", tmp_val)) begin
                bad_trap[22] = tmp_val;
                bad_trap_exists[22] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[22]);
            end

            if($value$plusargs("bad_trap23=%h", tmp_val)) begin
                bad_trap[23] = tmp_val;
                bad_trap_exists[23] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[23]);
            end

            if($value$plusargs("bad_trap24=%h", tmp_val)) begin
                bad_trap[24] = tmp_val;
                bad_trap_exists[24] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[24]);
            end

            if($value$plusargs("bad_trap25=%h", tmp_val)) begin
                bad_trap[25] = tmp_val;
                bad_trap_exists[25] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[25]);
            end

            if($value$plusargs("bad_trap26=%h", tmp_val)) begin
                bad_trap[26] = tmp_val;
                bad_trap_exists[26] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[26]);
            end

            if($value$plusargs("bad_trap27=%h", tmp_val)) begin
                bad_trap[27] = tmp_val;
                bad_trap_exists[27] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[27]);
            end

            if($value$plusargs("bad_trap28=%h", tmp_val)) begin
                bad_trap[28] = tmp_val;
                bad_trap_exists[28] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[28]);
            end

            if($value$plusargs("bad_trap29=%h", tmp_val)) begin
                bad_trap[29] = tmp_val;
                bad_trap_exists[29] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[29]);
            end

            if($value$plusargs("bad_trap30=%h", tmp_val)) begin
                bad_trap[30] = tmp_val;
                bad_trap_exists[30] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[30]);
            end

            if($value$plusargs("bad_trap31=%h", tmp_val)) begin
                bad_trap[31] = tmp_val;
                bad_trap_exists[31] = 1'b1;
                $display ("%t: bad_trap %h", $time, bad_trap[31]);
            end

        trap_count = good_trap_count > bad_trap_count ? good_trap_count :  bad_trap_count;

    end
endtask // trap_extract
// deceide pass or fail
integer       ind;
//post-silicon request
reg [63:0]    last_hit [31:0];
//indicate the 2nd time hit.
reg [31:0]    hitted;
initial hitted = 0;

reg first_rst;
initial begin
    max = 1000;
    if($value$plusargs("TIMEOUT=%d", max)) $display("rtl_timeout = %d", max);
    #20//need to wait for socket initializing.
     trap_extract;
    done    = 0;
    good    = 0;
`ifndef PITON_PICO
`ifndef PITON_ARIANE
    active_thread = 0;
`endif
`endif
    hit_bad   = 0;
    first_rst = 1;
    for(ind = 0;ind < `NUM_TILES; ind = ind + 1)timeout[ind] = 0;
end // initial begin
always @(posedge rst_l)begin
    if(first_rst)begin
`ifndef PITON_PICO
`ifndef PITON_ARIANE
        active_thread = 0;
`endif
`endif
        first_rst     = 0;
        done          = 0;
        good          = 0;
        hit_bad       = 0;
    end
end
//speed up checkeing
task check_time;
    input [9:0] head; // Tri
    input [9:0] tail;

    integer  ind;
    begin
        for(ind = head; ind < tail; ind = ind + 1)begin
            if(timeout[ind] > max && (good[ind] == 0))begin
                if((max_cycle == 0 || finish_mask[ind] == 0) && (thread_status[ind] == `THRFSM_HALT)
                  )begin
                    timeout[ind] = 0;
                end
                else begin
                    $display("Info: spc(%0d) thread(%0d) -> timeout happen", ind / 4, ind % 4);
                    `MONITOR_PATH.fail("TIMEOUT");
                end
            end
            else if(active_thread[ind] != good[ind])begin
                timeout[ind] = timeout[ind] + 1;
            end // if (finish_mask[ind] != good[ind])
        end // for (ind = head; ind < tail; ind = ind + 1)
    end
endtask // check_time

//deceide whether stub done or not.
task check_stub;
    reg [3:0] i;
    begin
        for(i = 0; i < 8; i = i + 1)begin
            if(stub_mask[i] &&
                    `TOP_MOD.stub_done[i] &&
                    `TOP_MOD.stub_pass[i])stub_good[i] = 1'b1;
            else if(stub_mask[i] &&
                    `TOP_MOD.stub_done[i] &&
                    `TOP_MOD.stub_pass[i] == 0)begin
                $display("Info->Simulation terminated by stub.");
                `MONITOR_PATH.fail("HIT BAD TRAP");
            end
        end
        if ((good == finish_mask) && (stub_mask == stub_good)) begin
            `TOP_MOD.diag_done = 1;
            `ifndef VERILATOR
            @(posedge clk);
            `endif
            $display("Info->Simulation terminated by stub.");
            $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
            $finish;
        end
    end
endtask // check_stub

task set_diag_done;
    input local_diag_done;

    begin
        if (local_diag_done) begin
            `TOP_MOD.diag_done = 1;
        end
    end
endtask


    wire[31:0] long_cpuid0;
    assign long_cpuid0 = {30'd0, spc0_thread_id};

    wire[31:0] long_cpuid1;
    assign long_cpuid1 = {30'd1, spc1_thread_id};

    wire[31:0] long_cpuid2;
    assign long_cpuid2 = {30'd2, spc2_thread_id};

    wire[31:0] long_cpuid3;
    assign long_cpuid3 = {30'd3, spc3_thread_id};

    wire[31:0] long_cpuid4;
    assign long_cpuid4 = {30'd4, spc4_thread_id};

    wire[31:0] long_cpuid5;
    assign long_cpuid5 = {30'd5, spc5_thread_id};

    wire[31:0] long_cpuid6;
    assign long_cpuid6 = {30'd6, spc6_thread_id};

    wire[31:0] long_cpuid7;
    assign long_cpuid7 = {30'd7, spc7_thread_id};

    wire[31:0] long_cpuid8;
    assign long_cpuid8 = {30'd8, spc8_thread_id};


always @* begin
done[0]   = spc0_inst_done;//sparc 0
done[1]   = spc1_inst_done;//sparc 1
done[2]   = spc2_inst_done;//sparc 2
done[3]   = spc3_inst_done;//sparc 3
done[4]   = spc4_inst_done;//sparc 4
done[5]   = spc5_inst_done;//sparc 5
done[6]   = spc6_inst_done;//sparc 6
done[7]   = spc7_inst_done;//sparc 7
done[8]   = spc8_inst_done;//sparc 8


end

//main routine of pc cmp to finish the simulation.
always @(posedge clk)begin
    if(rst_l)begin
        if(`TOP_MOD.stub_done)check_stub;

        if(|done[`NUM_TILES-1:0]) begin

        if (done[0]) begin
            timeout[long_cpuid0] = 0;
            //check_bad_trap(spc0_phy_pc_w, 0, long_cpuid0);
            if(active_thread[long_cpuid0])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc0_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid0]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 0, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid0]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc0_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid0] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid0 / 4, long_cpuid0 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid0])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid0])
                            begin
                                last_hit[long_cpuid0] = spc0_phy_pc_w[39:0];
                                hitted[long_cpuid0]   = 1;
                            end
                            else if(last_hit[long_cpuid0] == spc0_phy_pc_w[39:0])
                                good[long_cpuid0] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid0] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid0])
        end // if (done[0])

        if (done[1]) begin
            timeout[long_cpuid1] = 0;
            //check_bad_trap(spc1_phy_pc_w, 1, long_cpuid1);
            if(active_thread[long_cpuid1])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc1_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid1]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 1, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid1]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc1_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid1] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid1 / 4, long_cpuid1 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid1])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid1])
                            begin
                                last_hit[long_cpuid1] = spc1_phy_pc_w[39:0];
                                hitted[long_cpuid1]   = 1;
                            end
                            else if(last_hit[long_cpuid1] == spc1_phy_pc_w[39:0])
                                good[long_cpuid1] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid1] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid1])
        end // if (done[1])

        if (done[2]) begin
            timeout[long_cpuid2] = 0;
            //check_bad_trap(spc2_phy_pc_w, 2, long_cpuid2);
            if(active_thread[long_cpuid2])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc2_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid2]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 2, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid2]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc2_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid2] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid2 / 4, long_cpuid2 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid2])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid2])
                            begin
                                last_hit[long_cpuid2] = spc2_phy_pc_w[39:0];
                                hitted[long_cpuid2]   = 1;
                            end
                            else if(last_hit[long_cpuid2] == spc2_phy_pc_w[39:0])
                                good[long_cpuid2] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid2] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid2])
        end // if (done[2])

        if (done[3]) begin
            timeout[long_cpuid3] = 0;
            //check_bad_trap(spc3_phy_pc_w, 3, long_cpuid3);
            if(active_thread[long_cpuid3])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc3_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid3]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 3, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid3]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc3_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid3] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid3 / 4, long_cpuid3 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid3])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid3])
                            begin
                                last_hit[long_cpuid3] = spc3_phy_pc_w[39:0];
                                hitted[long_cpuid3]   = 1;
                            end
                            else if(last_hit[long_cpuid3] == spc3_phy_pc_w[39:0])
                                good[long_cpuid3] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid3] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid3])
        end // if (done[3])

        if (done[4]) begin
            timeout[long_cpuid4] = 0;
            //check_bad_trap(spc4_phy_pc_w, 4, long_cpuid4);
            if(active_thread[long_cpuid4])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc4_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid4]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 4, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid4]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc4_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid4] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid4 / 4, long_cpuid4 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid4])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid4])
                            begin
                                last_hit[long_cpuid4] = spc4_phy_pc_w[39:0];
                                hitted[long_cpuid4]   = 1;
                            end
                            else if(last_hit[long_cpuid4] == spc4_phy_pc_w[39:0])
                                good[long_cpuid4] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid4] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid4])
        end // if (done[4])

        if (done[5]) begin
            timeout[long_cpuid5] = 0;
            //check_bad_trap(spc5_phy_pc_w, 5, long_cpuid5);
            if(active_thread[long_cpuid5])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc5_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid5]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 5, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid5]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc5_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid5] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid5 / 4, long_cpuid5 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid5])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid5])
                            begin
                                last_hit[long_cpuid5] = spc5_phy_pc_w[39:0];
                                hitted[long_cpuid5]   = 1;
                            end
                            else if(last_hit[long_cpuid5] == spc5_phy_pc_w[39:0])
                                good[long_cpuid5] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid5] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid5])
        end // if (done[5])

        if (done[6]) begin
            timeout[long_cpuid6] = 0;
            //check_bad_trap(spc6_phy_pc_w, 6, long_cpuid6);
            if(active_thread[long_cpuid6])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc6_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid6]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 6, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid6]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc6_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid6] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid6 / 4, long_cpuid6 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid6])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid6])
                            begin
                                last_hit[long_cpuid6] = spc6_phy_pc_w[39:0];
                                hitted[long_cpuid6]   = 1;
                            end
                            else if(last_hit[long_cpuid6] == spc6_phy_pc_w[39:0])
                                good[long_cpuid6] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid6] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid6])
        end // if (done[6])

        if (done[7]) begin
            timeout[long_cpuid7] = 0;
            //check_bad_trap(spc7_phy_pc_w, 7, long_cpuid7);
            if(active_thread[long_cpuid7])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc7_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid7]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 7, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid7]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc7_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid7] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid7 / 4, long_cpuid7 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid7])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid7])
                            begin
                                last_hit[long_cpuid7] = spc7_phy_pc_w[39:0];
                                hitted[long_cpuid7]   = 1;
                            end
                            else if(last_hit[long_cpuid7] == spc7_phy_pc_w[39:0])
                                good[long_cpuid7] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid7] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid7])
        end // if (done[7])

        if (done[8]) begin
            timeout[long_cpuid8] = 0;
            //check_bad_trap(spc8_phy_pc_w, 8, long_cpuid8);
            if(active_thread[long_cpuid8])begin

                if(bad_trap_exists[0] & (bad_trap[0] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 0 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[1] & (bad_trap[1] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 1 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[2] & (bad_trap[2] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 2 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[3] & (bad_trap[3] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 3 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[4] & (bad_trap[4] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 4 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[5] & (bad_trap[5] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 5 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[6] & (bad_trap[6] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 6 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[7] & (bad_trap[7] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 7 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[8] & (bad_trap[8] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 8 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[9] & (bad_trap[9] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 9 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[10] & (bad_trap[10] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 10 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[11] & (bad_trap[11] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 11 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[12] & (bad_trap[12] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 12 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[13] & (bad_trap[13] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 13 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[14] & (bad_trap[14] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 14 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[15] & (bad_trap[15] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 15 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[16] & (bad_trap[16] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 16 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[17] & (bad_trap[17] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 17 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[18] & (bad_trap[18] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 18 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[19] & (bad_trap[19] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 19 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[20] & (bad_trap[20] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 20 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[21] & (bad_trap[21] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 21 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[22] & (bad_trap[22] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 22 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[23] & (bad_trap[23] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 23 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[24] & (bad_trap[24] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 24 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[25] & (bad_trap[25] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 25 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[26] & (bad_trap[26] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 26 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[27] & (bad_trap[27] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 27 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[28] & (bad_trap[28] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 28 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[29] & (bad_trap[29] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 29 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[30] & (bad_trap[30] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 30 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

                if(bad_trap_exists[31] & (bad_trap[31] == spc8_phy_pc_w))begin
                    hit_bad     = 1'b1;
                    good[long_cpuid8]     = 1;
                    local_diag_done = 1;
                    $display("%0d: Info - > Hit Bad trap. spc(%0d) thread(%0d)", $time, 8, 31 % 4);
                    `MONITOR_PATH.fail("HIT BAD TRAP");
                end

            end
        if (active_thread[long_cpuid8]) begin
    
if(good_trap_exists[0] & (good_trap[0] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[1] & (good_trap[1] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[2] & (good_trap[2] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[3] & (good_trap[3] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[4] & (good_trap[4] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[5] & (good_trap[5] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[6] & (good_trap[6] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[7] & (good_trap[7] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[8] & (good_trap[8] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[9] & (good_trap[9] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[10] & (good_trap[10] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[11] & (good_trap[11] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[12] & (good_trap[12] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[13] & (good_trap[13] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[14] & (good_trap[14] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[15] & (good_trap[15] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[16] & (good_trap[16] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[17] & (good_trap[17] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[18] & (good_trap[18] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[19] & (good_trap[19] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[20] & (good_trap[20] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[21] & (good_trap[21] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[22] & (good_trap[22] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[23] & (good_trap[23] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[24] & (good_trap[24] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[25] & (good_trap[25] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[26] & (good_trap[26] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[27] & (good_trap[27] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[28] & (good_trap[28] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[29] & (good_trap[29] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[30] & (good_trap[30] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end
if(good_trap_exists[31] & (good_trap[31] == spc8_phy_pc_w[39:0]))
                begin
                    if(good[long_cpuid8] == 0)
                        $display("Info: spc(%0x) thread(%0x) Hit Good trap", long_cpuid8 / 4, long_cpuid8 % 4);

                    //post-silicon debug
                    if(finish_mask[long_cpuid8])
                    begin
                        if(good_flag)
                        begin
                            if(!hitted[long_cpuid8])
                            begin
                                last_hit[long_cpuid8] = spc8_phy_pc_w[39:0];
                                hitted[long_cpuid8]   = 1;
                            end
                            else if(last_hit[long_cpuid8] == spc8_phy_pc_w[39:0])
                                good[long_cpuid8] = 1'b1;
                        end
                        else
                        begin
                            good[long_cpuid8] = 1'b1;
                        end
                    end
                end

                if((good == finish_mask) &&
                   (hit_bad == 0)        &&
                   (stub_mask == stub_good))
                begin
                    local_diag_done = 1;
                    `ifndef VERILATOR
                    @(posedge clk);
                    `endif
                    $display("%0d: Simulation -> PASS (HIT GOOD TRAP)", $time);
                    $finish;
                end
            end // if (active_thread[long_cpuid8])
        end // if (done[8])

        
        end
`ifdef INCLUDE_SAS_TASKS
        get_thread_status;
`endif
        if(active_thread[3:0])check_time(0, 4);
if(active_thread[7:4])check_time(4, 8);
if(active_thread[11:8])check_time(8, 12);
if(active_thread[15:12])check_time(12, 16);
if(active_thread[19:16])check_time(16, 20);
if(active_thread[23:20])check_time(20, 24);
if(active_thread[27:24])check_time(24, 28);
if(active_thread[31:28])check_time(28, 32);
if(active_thread[35:32])check_time(32, 36);


        set_diag_done(local_diag_done);
    end // if (rst_l)
end // always @ (posedge clk)
endmodule


