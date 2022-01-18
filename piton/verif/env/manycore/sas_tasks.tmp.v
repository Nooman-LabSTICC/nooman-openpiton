// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: sas_tasks.v
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
`include "cross_module.tmp.h"
`ifdef PITON_PROTO
    //`define FPGA_SYN_16x160
`endif

`ifdef USE_IBM_SRAMS
// `define FPGA_SYN_16x160
`endif

// /home/ruaro/nooman-openpiton/piton/verif/env/manycore/devices_ariane.xml




//
//define special register
//define special register
`define MONITOR_SIGNAL                    155
`define FLOAT_X                           154
`define FLOAT_I                           153
`define REG_WRITE_BACK                    152

`define     PC                         32
`define     NPC                        33
`define     Y                          34
`define     CCR                        35
`define     FPRS                       36
`define     FSR                        37
`define     ASI                        38
`define     TICK_SAS                   39
`define     GSR                        40
`define     TICK_CMPR                  41
`define     STICK                      42
`define     STICK_CMPR                 43
`define     PSTATE_SAS                 44
`define     TL_SAS                     45
`define     PIL_SAS                    46

`define     TPC1                       47
`define     TPC2                       48
`define     TPC3                       49
`define     TPC4                       50
`define     TPC5                       51
`define     TPC6                       52

`define     TNPC1                      57
`define     TNPC2                      58
`define     TNPC3                      59
`define     TNPC4                      60
`define     TNPC5                      61
`define     TNPC6                      62

`define     TSTATE1                    67
`define     TSTATE2                    68
`define     TSTATE3                    69
`define     TSTATE4                    70
`define     TSTATE5                    71
`define     TSTATE6                    72

`define     TT1                        77
`define     TT2                        78
`define     TT3                        79
`define     TT4                        80
`define     TT5                        81
`define     TT6                        82
`define     TBA_SAS                    87
`define     VER                        88
`define     CWP                        89
`define     CANSAVE                    90
`define     CANRESTORE                 91
`define     OTHERWIN                   92
`define     WSTATE                     93
`define     CLEANWIN                   94
`define     SOFTINT                    95
`define     ECACHE_ERROR_ENABLE        96
`define     ASYNCHRONOUS_FAULT_STATUS  97
`define     ASYNCHRONOUS_FAULT_ADDRESS 98
`define     OUT_INTR_DATA0             99
`define     OUT_INTR_DATA1             100
`define     OUT_INTR_DATA2             101
`define     INTR_DISPATCH_STATUS       102
`define     IN_INTR_DATA0              103
`define     IN_INTR_DATA1              104
`define     IN_INTR_DATA2              105
`define     INTR_RECEIVE               106
`define     GL                         107
`define     HPSTATE_SAS                108
`define     HTSTATE1                   109
`define     HTSTATE2                   110
`define     HTSTATE3                   111
`define     HTSTATE4                   112
`define     HTSTATE5                   113
`define     HTSTATE6                   114
`define     HTSTATE7                   115
`define     HTSTATE8                   116
`define     HTSTATE9                   117
`define     HTSTATE10                  118
`define     HTBA_SAS                   119
`define     HINTP_SAS                  120
`define     HSTICK_CMPR                121
`define     MID                        122
`define     ISFSR                      123
`define     DSFSR                      124
`define     SFAR                       125

//new mmu registers
`define     I_TAG_ACCESS            126
`define     D_TAG_ACCESS            127
`define     CTXT_PRIM               128
`define     CTXT_SEC                129
`define     SFP_REG                 130
`define     I_CTXT_ZERO_PS0         131
`define     D_CTXT_ZERO_PS0         132
`define     I_CTXT_ZERO_PS1         133
`define     D_CTXT_ZERO_PS1         134
`define     I_CTXT_ZERO_CONFIG      135
`define     D_CTXT_ZERO_CONFIG      136
`define     I_CTXT_NONZERO_PS0      137
`define     D_CTXT_NONZERO_PS0      138
`define     I_CTXT_NONZERO_PS1      139
`define     D_CTXT_NONZERO_PS1      140
`define     I_CTXT_NONZERO_CONFIG   141
`define     D_CTXT_NONZERO_CONFIG   142
`define     I_TAG_TARGET            143
`define     D_TAG_TARGET            144
`define     I_TSB_PTR_PS0           145
`define     D_TSB_PTR_PS0           146
`define     I_TSB_PTR_PS1           147
`define     D_TSB_PTR_PS1           148
`define     D_TSB_DIR_PTR           149
`define     VA_WP_ADDR              150
`define     PID                     151
`define     RESET_COMMAND           500
`define     PLI_INST_TTE           17    /* %1 th id, %2-%9 I-TTE value */
`define     PLI_DATA_TTE           18    /* %1 th id, %2-%9 D-TTE value */
`define  TIMESTAMP              19    /* %1-%8 RTL timestamp value */
module sas_tasks (/*AUTOARG*/
           // Inputs
           clk, rst_l
       );
//inputs
input   clk;
input   rst_l;
reg [7:0] in_used;
reg [2:0] cpu_num;
reg       dead_socket;
reg       inst_checker_off;

`ifdef SAS_DISABLE
`else
initial begin
    in_used = 0;
`ifndef VERILATOR
    if($value$plusargs("cpu_num=%d", cpu_num))
        $display("Info:Number of cpu = %d", cpu_num);
    else cpu_num = 0;
`else // ifndef VERILATOR
    cpu_num = 0;
`endif // ifndef VERILATOR
    dead_socket      = 0;
    inst_checker_off = 0;
`ifndef VERILATOR
    if($value$plusargs("inst_check_off=%d", inst_checker_off))begin
        $display("Info:instruction checker is on", inst_checker_off);
        inst_checker_off =1;
    end
`endif // ifndef VERILATOR
end // initial begin

`ifdef SAS_DISABLE
`else



 `ifdef RTL_SPARC0
sas_task task0 (/*AUTOINST*/
             // Inputs
             .tlu_pich_wrap_flg_m (`TLUPATH0.tcl.tlu_pich_wrap_flg_m), // Templated
             .tlu_pic_cnt_en_m  (`TLUPATH0.tcl.tlu_pic_cnt_en_m), // Templated
             .final_ttype_sel_g (`TLUPATH0.tcl.final_ttype_sel_g), // Templated
             .rst_ttype_w2  (`TLUPATH0.tcl.rst_ttype_w2), // Templated
             .sync_trap_taken_m (`TLUPATH0.tcl.sync_trap_taken_m), // Templated
             .pib_picl_wrap (`TLUPATH0.pib_picl_wrap), // Templated
             .pib_pich_wrap_m (`TLUPATH0.tcl.pib_pich_wrap_m), // Templated
             .pib_pich_wrap (`TLUPATH0.pib_pich_wrap), // Templated
             .pic_wrap_trap_g (`TLUPATH0.tcl.pib_wrap_trap_g), // Templated
             .pib_wrap_trap_m (`TLUPATH0.tcl.pib_wrap_trap_m), // Templated
             .pcr_rw_e    (`TLUPATH0.tlu_pib.pcr_rw_e), // Templated
             .tlu_rsr_inst_e  (`TLUPATH0.tlu_pib.tlu_rsr_inst_e), // Templated
             .pcr0    (`TLUPATH0.tlu_pib.pcr0), // Templated
             .pcr1    (`TLUPATH0.tlu_pib.pcr1), // Templated
             .pcr2    (`TLUPATH0.tlu_pib.pcr2), // Templated
             .pcr3    (`TLUPATH0.tlu_pib.pcr3), // Templated
             .wsr_pcr_sel   (`TLUPATH0.tlu_pib.wsr_pcr_sel), // Templated
             .pich_cnt0   (`TLUPATH0.tlu_pib.pich_cnt0), // Templated
             .pich_cnt1   (`TLUPATH0.tlu_pib.pich_cnt1), // Templated
             .pich_cnt2   (`TLUPATH0.tlu_pib.pich_cnt2), // Templated
             .pich_cnt3   (`TLUPATH0.tlu_pib.pich_cnt3), // Templated
             .picl_cnt0   (`TLUPATH0.tlu_pib.picl_cnt0), // Templated
             .picl_cnt1   (`TLUPATH0.tlu_pib.picl_cnt1), // Templated
             .picl_cnt2   (`TLUPATH0.tlu_pib.picl_cnt2), // Templated
             .picl_cnt3   (`TLUPATH0.tlu_pib.picl_cnt3), // Templated
             .update_pich_sel (`TLUPATH0.tlu_pib.update_pich_sel), // Templated
             .update_picl_sel (`TLUPATH0.tlu_pib.update_picl_sel), // Templated
`ifndef RTL_SPU
             .const_maskid  (`PCXPATH0.ifu.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH0.ifu.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH0.ifu.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH0.ifu.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH0.ifu.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH0.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH0.ifu.ifu.errdp.formatted_tte_data), // Templated
`else
             .const_maskid  (`PCXPATH0.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH0.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH0.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH0.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH0.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH0.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH0.ifu.errdp.formatted_tte_data), // Templated
`endif
             .dformatted_tte_data (`SPARC_CORE0.`LSU_PATH.tlbdp.formatted_tte_data), // Templated
             .dtlb_cam_vld  (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_cam_vld), // Templated
             .dtlb_tte_vld_g  (`SPARC_CORE0.`LSU_PATH.excpctl.tlb_tte_vld_g), // Templated
             .tlu_hpstate_priv  (`PCXPATH0.tlu_hpstate_priv), // Templated
             .tlu_hpstate_enb (`PCXPATH0.tlu_hpstate_enb), // Templated
`ifndef RTL_SPU
             .fcl_dtu_inst_vld_d  (`PCXPATH0.ifu.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH0.ifu.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH0.ifu.ifu.fcl.xlate_en), // Templated
`else
             .fcl_dtu_inst_vld_d  (`PCXPATH0.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH0.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH0.ifu.fcl.xlate_en), // Templated
`endif
             .ifu_lsu_thrid_s (`PCXPATH0.ifu_lsu_thrid_s), // Templated
             .fcl_ifq_icmiss_s1 (`IFUPATH0.fcl.fcl_ifq_icmiss_s1), // Templated
             .tlu_exu_early_flush_pipe_w(`PCXPATH0.tlu_exu_early_flush_pipe_w), // Templated
             .rst_hwint_ttype_g (`TLUPATH0.tcl.rst_hwint_ttype_g), // Templated
             .trap_taken_g  (`TLUPATH0.tcl.trap_taken_g), // Templated
`ifndef RTL_SPU
             .spu_lsu_ldxa_illgl_va_w2(1'b0), // Templated
             .spu_lsu_ldxa_data_vld_w2(1'b0), // Templated
             .spu_lsu_ldxa_tid_w2 (2'b0), // Templated
`else
             .spu_lsu_ldxa_illgl_va_w2(`PCXPATH0.spu.spu_ctl.spu_lsu_ldxa_illgl_va_w2), // Templated
             .spu_lsu_ldxa_data_vld_w2(`PCXPATH0.spu.spu_ctl.spu_lsu_ldxa_data_vld_w2), // Templated
             .spu_lsu_ldxa_tid_w2 (`PCXPATH0.spu.spu_ctl.spu_lsu_ldxa_tid_w2), // Templated
`endif
             .mra_field1_en (`TLUPATH0.mmu_ctl.mra_field1_en), // Templated
             .mra_field2_en (`TLUPATH0.mmu_ctl.mra_field2_en), // Templated
             .mra_field3_en (`TLUPATH0.mmu_ctl.mra_field3_en), // Templated
             .mra_field4_en (`TLUPATH0.mmu_ctl.mra_field4_en), // Templated
             .pmem_unc_error_g  (`SPARC_CORE0.`LSU_PATH.dctl.pmem_unc_error_g), // Templated
`ifndef RTL_SPU
             .pc_f    (`PCXPATH0.ifu.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH0.ifu.ifu.fcl.cam_vld_f), // Templated
`else
             .pc_f    (`PCXPATH0.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH0.ifu.fcl.cam_vld_f), // Templated
`endif
             .cam_vld   (`SPARC_CORE0.`LSU_PATH.dtlb.cam_vld), // Templated
             .defr_trp_taken_m_din(`SPARC_CORE0.`LSU_PATH.excpctl.defr_trp_taken_m_din), // Templated
             .illgl_va_vld_or_drop_ldxa2masync(1'b0), // Templated
`ifndef RTL_SPU
             .ecc_wen   (`PCXPATH0.ffu.ffu.ctl.ecc_wen), // Templated
`else
             .ecc_wen   (`PCXPATH0.ffu.ctl.ecc_wen), // Templated
`endif
             .fpdis_trap_e  (`IFUPATH0.dec.fpdis_trap_e), // Templated
             .ceen    (`IFUPATH0.errctl.ceen), // Templated
             .nceen   (`IFUPATH0.errctl.nceen), // Templated
             .ifu_tlu_flush_m (`TLUPATH0.ifu_tlu_flush_m), // Templated
             .lsu_tlu_ttype_m2  (`TLUPATH0.lsu_tlu_ttype_m2), // Templated
             .lsu_tlu_ttype_vld_m2(`TLUPATH0.lsu_tlu_ttype_vld_m2), // Templated
             .tlu_final_ttype_w2  (`TLUPATH0.tlu_final_ttype_w2), // Templated
             .tlu_ifu_trappc_vld_w1(`TLUPATH0.tlu_ifu_trappc_vld_w1), // Templated
             .mra_wr_ptr    (`TLUPATH0.mra_wr_ptr),  // Templated
             .mra_wr_vld    (`TLUPATH0.mra_wr_vld),  // Templated
             .lsu_pid_state0  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state0), // Templated
             .lsu_pid_state1  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state1), // Templated
             .lsu_pid_state2  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state2), // Templated
             .lsu_pid_state3  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state3), // Templated
             .pid_state_wr_en (`SPARC_CORE0.`LSU_PATH.pid_state_wr_en), // Templated
             .lsu_t0_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t0_pctxt_state), // Templated
             .lsu_t1_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t1_pctxt_state), // Templated
             .lsu_t2_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t2_pctxt_state), // Templated
             .lsu_t3_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t3_pctxt_state), // Templated
             .pctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.pctxt_state_wr_thrd), // Templated
             .sctxt_state0  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state0), // Templated
             .sctxt_state1  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state1), // Templated
             .sctxt_state2  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state2), // Templated
             .sctxt_state3  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state3), // Templated
             .sctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state_wr_thrd), // Templated
             .va_wtchpt0_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt0_addr), // Templated
             .va_wtchpt1_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt1_addr), // Templated
             .va_wtchpt2_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt2_addr), // Templated
             .va_wtchpt3_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt3_addr), // Templated
             .lsu_va_wtchpt0_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt0_wr_en_l), // Templated
             .lsu_va_wtchpt1_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt1_wr_en_l), // Templated
             .lsu_va_wtchpt2_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt2_wr_en_l), // Templated
             .lsu_va_wtchpt3_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt3_wr_en_l), // Templated
             .ifu_rstint_m  (`TLPATH0.ifu_rstint_m), // Templated
`ifndef RTL_SPU
             .spu_tlu_rsrv_illgl_m(`PCXPATH0.tlu.tlu.spu_tlu_rsrv_illgl_m), // Templated
`else
             .spu_tlu_rsrv_illgl_m(`PCXPATH0.tlu.spu_tlu_rsrv_illgl_m), // Templated
`endif
             .cam_vld_s1    (`IFUPATH0.fcl.cam_vld_s1), // Templated
             .val_thr_s1    (`IFUPATH0.fcl.val_thr_s1), // Templated
             .pc_s    (`IFUPATH0.fdp.pc_s),  // Templated
`ifndef RTL_SPU
             .rs2_fst_ue_w3 (`PCXPATH0.ffu.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH0.ffu.ffu.ctl.rs2_fst_ce_w3), // Templated
`else
             .rs2_fst_ue_w3 (`PCXPATH0.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH0.ffu.ctl.rs2_fst_ce_w3), // Templated
`endif
             .lsu_tlu_async_ttype_vld_w2(`PCXPATH0.lsu_tlu_async_ttype_vld_w2), // Templated
             .lsu_tlu_defr_trp_taken_g(`PCXPATH0.lsu_tlu_defr_trp_taken_g), // Templated
             .lsu_tlu_async_ttype_w2(`PCXPATH0.lsu_tlu_async_ttype_w2), // Templated
             .lsu_tlu_async_tid_w2(`PCXPATH0.lsu_tlu_async_tid_w2), // Templated
`ifndef RTL_SPU
             .itlb_rw_index (`PCXPATH0.ifu.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH0.ifu.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH0.ifu.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH0.ifu.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH0.ifu.ifu.itlb.cam_hit}), // Templated
`else
             .itlb_rw_index (`PCXPATH0.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH0.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH0.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH0.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH0.ifu.itlb.cam_hit}), // Templated
`endif
             .dtlb_rw_index (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index), // Templated
             .dtlb_rw_index_vld (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index_vld), // Templated
             .dtlb_rd_tte_tag (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rd_tte_tag), // Templated
             .dtlb_rd_tte_data  (`SPARC_CORE0.`LSU_PATH.dtlb.rd_tte_data), // Templated
             .dcam_hit    ({48'b0,`SPARC_CORE0.`LSU_PATH.dtlb.cam_hit}), // Templated
             .wrt_spec_w    (`IFUPATH0.swl.wrt_spec_w), // Templated
             .spc_pcx_data_pa (124'b0), // Templated //tttttttttttttt
             .fcl_fdp_inst_sel_nop_s_l(`IFUPATH0.fdp.fcl_fdp_inst_sel_nop_s_l), // Templated
             .retract_iferr_d (`IFUPATH0.swl.retract_iferr_d), // Templated
             .inst_vld_w    (`INSTPATH0.inst_vld_w), // Templated
             .dmmu_async_illgl_va_g(`TLUPATH0.mmu_ctl.dmmu_async_illgl_va_g), // Templated
             .immu_async_illgl_va_g(`TLUPATH0.mmu_ctl.immu_async_illgl_va_g), // Templated
             .lsu_tlu_tlb_ld_inst_m(`TLUPATH0.mmu_ctl.lsu_tlu_tlb_ld_inst_m), // Templated
             .lsu_tlu_tlb_st_inst_m(`TLUPATH0.mmu_ctl.lsu_tlu_tlb_st_inst_m), // Templated
             .immu_sfsr_wr_en_l (`TLUPATH0.immu_sfsr_wr_en_l), // Templated
             .dmmu_sfsr_wr_en_l (`TLUPATH0.dmmu_sfsr_wr_en_l), // Templated
             .dmmu_sfar_wr_en_l (`TLUPATH0.dmmu_sfar_wr_en_l), // Templated
             .lsu_quad_asi_e  (`SPARC_CORE0.`LSU_PATH.lsu_quad_asi_e), // Templated
             .clk     (clk),       // Templated
             .rst_l   (rst_l),     // Templated
             .back    (`PC_CMP.back_thread[1*4-1:0*4]), // Templated
             .lsu_ifu_ldsta_internal_e(`IFUPATH0.lsu_ifu_ldsta_internal_e), // Templated
             .lsu_mmu_flush_pipe_w(`TLUPATH0.lsu_mmu_flush_pipe_w), // Templated
             .dtlb_wr_vld   (`DTLBPATH0.tlb_wr_vld), // Templated
             .dtlb_demap    (`DTLBPATH0.tlb_demap),  // Templated
             .dtlb_rd_tag_vld (`DTLBPATH0.tlb_rd_tag_vld), // Templated
             .dtlb_rd_data_vld  (`DTLBPATH0.tlb_rd_data_vld), // Templated
             .dtlb_entry_vld  ({48'd0,`DTLBPATH0.tlb_entry_vld}), // Templated
             .itlb_wr_vld   (`ITLBPATH0.tlb_wr_vld), // Templated
             .itlb_demap    (`ITLBPATH0.tlb_demap),  // Templated
             .itlb_rd_tag_vld (`ITLBPATH0.tlb_rd_tag_vld), // Templated
             .itlb_rd_data_vld  (`ITLBPATH0.tlb_rd_data_vld), // Templated
             .itlb_entry_vld  ({48'd0,`ITLBPATH0.tlb_entry_vld}), // Templated
             .tlb_access_tid_g  (`TLUPATH0.mmu_ctl.tlb_access_tid_g), // Templated
             .dsfar0_clk    (`TLUPATH0.mmu_dp.dsfar0_clk), // Templated
             .dsfar1_clk    (`TLUPATH0.mmu_dp.dsfar1_clk), // Templated
             .dsfar2_clk    (`TLUPATH0.mmu_dp.dsfar2_clk), // Templated
             .dsfar3_clk    (`TLUPATH0.mmu_dp.dsfar3_clk), // Templated
             .dsfar_din   (`TLUPATH0.mmu_dp.dsfar_din), // Templated
             .dtu_inst_d    (`IFUPATH0.dec.dtu_inst_d), // Templated
             .local_rdpr_mx1_sel  (`TLPATH0.local_rdpr_mx1_sel), // Templated
             .tlu_rdpr_mx5_sel  (`TLPATH0.tlu_rdpr_mx5_sel), // Templated
             .tlu_rdpr_mx7_sel  (`TLPATH0.tlu_rdpr_mx7_sel), // Templated
             .tlu_rst_l   (`TLPATH0.tlu_rst_l),  // Templated
             .tick_match    (`TDPPATH0.tick_match),  // Templated
             .tlu_wr_sftint_l_g (`TLUPATH0.tlu_wr_sftint_l_g), // Templated
             .dsfsr_din   (`TLUPATH0.mmu_dp.dsfsr_din), // Templated
             .dsfsr0_clk    (`TLUPATH0.mmu_dp.dsfsr0_clk), // Templated
             .dsfsr1_clk    (`TLUPATH0.mmu_dp.dsfsr1_clk), // Templated
             .dsfsr2_clk    (`TLUPATH0.mmu_dp.dsfsr2_clk), // Templated
             .dsfsr3_clk    (`TLUPATH0.mmu_dp.dsfsr3_clk), // Templated
             .isfsr_din   (`TLUPATH0.mmu_dp.isfsr_din), // Templated
             .isfsr0_clk    (`TLUPATH0.mmu_dp.isfsr0_clk), // Templated
             .isfsr1_clk    (`TLUPATH0.mmu_dp.isfsr1_clk), // Templated
             .isfsr2_clk    (`TLUPATH0.mmu_dp.isfsr2_clk), // Templated
             .isfsr3_clk    (`TLUPATH0.mmu_dp.isfsr3_clk), // Templated
             .ecl_byp_sel_ecc_w (`IFUPATH0.errctl.irf_ce_unq), // Templated
             .ifu_exu_inst_w  (`INSTPATH0.ifu_exu_inst_vld_w), // Templated
             .ctl_dp_fp_thr (`FLOATPATH0.ctl_dp_fp_thr), // Templated
             .ifu_ffu_fst_d (`FLOATPATH0.ifu_ffu_fst_d), // Templated
             .pc_e    (`DTUPATH0.pc_e),  // Templated
             .fcl_dtu_inst_vld_e  (`INSTPATH0.fcl_dtu_inst_vld_e), // Templated
             .exu_lsu_rs3_data_e  (`PCXPATH0.exu_lsu_rs3_data_e), // Templated
             .tick_ctl_din  (`TLPATH0.tick_ctl_din), // Templated
             .ifu_tlu_ttype_m (`PCXPATH0.ifu_tlu_ttype_m), // Templated
             .tlu_rerr_vld  (`PCXPATH0.tlu_rerr_vld), // Templated
             .sftint0   (`TDPPATH0.sftint0),   // Templated
             .sftint1   (`TDPPATH0.sftint1),   // Templated
             .sftint2   (`TDPPATH0.sftint2),   // Templated
             .sftint3   (`TDPPATH0.sftint3),   // Templated
             .sftint0_clk   (`TDPPATH0.sftint0_clk), // Templated
             .sftint1_clk   (`TDPPATH0.sftint1_clk), // Templated
             .sftint2_clk   (`TDPPATH0.sftint2_clk), // Templated
             .sftint3_clk   (`TDPPATH0.sftint3_clk), // Templated
             .sftint_b0_en  (`TDPPATH0.sftint_b0_en), // Templated
             .sftint_b15_en (`TDPPATH0.sftint_b15_en), // Templated
             .sftint_b16_en (`TDPPATH0.sftint_b16_en), // Templated
             .cpx_spc_data_cx2  (`PCXPATH0.cpx_spc_data_cx2), // Templated
             .ifu_exu_save_d  (`PCXPATH0.ifu_exu_save_d), // Templated
             .ifu_exu_restore_d (`PCXPATH0.ifu_exu_restore_d), // Templated
             .ifu_tlu_thrid_d (`PCXPATH0.ifu_tlu_thrid_d), // Templated
             .tlu_ifu_hwint_i3  (`TLUPATH0.tlu_ifu_hwint_i3), // Templated
             .ifu_tlu_hwint_m (`TLUPATH0.ifu_tlu_hwint_m), // Templated
             .ifu_tlu_rstint_m  (`TLUPATH0.ifu_tlu_rstint_m), // Templated
             .ifu_tlu_swint_m (`TLUPATH0.ifu_tlu_swint_m), // Templated
             .tlu_ifu_flush_pipe_w(`TLPATH0.tlu_ifu_flush_pipe_w), // Templated
             .ifu_tlu_flush_w (`PCXPATH0.ifu_tlu_flush_w), // Templated
             .ffu_ifu_fst_ce_w  (`PCXPATH0.ffu_ifu_fst_ce_w), // Templated
`ifndef RTL_SPU
             .ffu_ifu_ecc_ue_w2 (`PCXPATH0.ffu.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH0.ffu.ffu.ffu_ifu_ecc_ce_w2), // Templated
`else
             .ffu_ifu_ecc_ue_w2 (`PCXPATH0.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH0.ffu.ffu_ifu_ecc_ce_w2), // Templated
`endif
             .any_err_vld   (`IFUPATH0.errctl.any_err_vld), // Templated
             .any_ue_vld    (`IFUPATH0.errctl.any_ue_vld), // Templated
             .tsa_htstate_en  (`TLPATH0.tsa_htstate_en), // Templated
             .stickcmp_intdis_en  (`TDPPATH0.stickcmp_intdis_en), // Templated
             .tick_npt0   (`TLPATH0.tick_npt0),  // Templated
             .tick_npt1   (`TLPATH0.tick_npt1),  // Templated
             .tick_npt2   (`TLPATH0.tick_npt2),  // Templated
             .tick_npt3   (`TLPATH0.tick_npt3),  // Templated
             .true_tick   (`TDPPATH0.true_tick),   // Templated
             .htick_intdis0 (`TLU_HYPER0.htick_intdis0), // Templated
             .htick_intdis1 (`TLU_HYPER0.htick_intdis1), // Templated
             .htick_intdis2 (`TLU_HYPER0.htick_intdis2), // Templated
             .htick_intdis3 (`TLU_HYPER0.htick_intdis3), // Templated
             .true_stickcmp0  (`TDPPATH0.true_stickcmp0), // Templated
             .true_stickcmp1  (`TDPPATH0.true_stickcmp1), // Templated
             .true_stickcmp2  (`TDPPATH0.true_stickcmp2), // Templated
             .true_stickcmp3  (`TDPPATH0.true_stickcmp3), // Templated
             .tlu_hintp_en_l_g  (`TDPPATH0.tlu_hintp_en_l_g), // Templated
             .tlu_hintp   (`TDPPATH0.tlu_hintp),   // Templated
             .tlu_htba_en_l (`TDPPATH0.tlu_htba_en_l), // Templated
             .true_htba0    (`TDPPATH0.true_htba0),  // Templated
             .true_htba1    (`TDPPATH0.true_htba1),  // Templated
             .true_htba2    (`TDPPATH0.true_htba2),  // Templated
             .true_htba3    (`TDPPATH0.true_htba3),  // Templated
             .update_hpstate_l_w2 (`TDPPATH0.tlu_update_hpstate_l_w2[3:0]), // Templated
             .restore_hpstate0  (`TDPPATH0.restore_hpstate0), // Templated
             .restore_hpstate1  (`TDPPATH0.restore_hpstate1), // Templated
             .restore_hpstate2  (`TDPPATH0.restore_hpstate2), // Templated
             .restore_hpstate3  (`TDPPATH0.restore_hpstate3), // Templated
             .htickcmp_intdis_en  (`TLU_HYPER0.htickcmp_intdis_en), // Templated
             .true_htickcmp0  (`TDPPATH0.true_htickcmp0), // Templated
             .true_htickcmp1  (`TDPPATH0.true_htickcmp1), // Templated
             .true_htickcmp2  (`TDPPATH0.true_htickcmp2), // Templated
             .true_htickcmp3  (`TDPPATH0.true_htickcmp3), // Templated
             .gl0_en    (`TLU_HYPER0.gl0_en),  // Templated
             .gl1_en    (`TLU_HYPER0.gl1_en),  // Templated
             .gl2_en    (`TLU_HYPER0.gl2_en),  // Templated
             .gl3_en    (`TLU_HYPER0.gl3_en),  // Templated
             .gl_lvl0_new   (`TLU_HYPER0.gl_lvl0_new), // Templated
             .gl_lvl1_new   (`TLU_HYPER0.gl_lvl1_new), // Templated
             .gl_lvl2_new   (`TLU_HYPER0.gl_lvl2_new), // Templated
             .gl_lvl3_new   (`TLU_HYPER0.gl_lvl3_new), // Templated
             .t0_gsr_nxt    (`FFUPATH0.dp.t0_gsr_nxt), // Templated
             .t0_gsr_rnd_next (`FFUPATH0.ctl.visctl.t0_gsr_rnd_next), // Templated
             .t0_gsr_align_next (`FFUPATH0.ctl.visctl.t0_gsr_align_next), // Templated
             .t0_gsr_wsr_w  (`FFUPATH0.ctl.visctl.t0_gsr_wsr_w2), // Templated
             .t0_siam_w   (`FFUPATH0.ctl.visctl.t0_siam_w2), // Templated
             .t0_alignaddr_w  (`FFUPATH0.ctl.visctl.t0_alignaddr_w2), // Templated
             .t1_gsr_nxt    (`FFUPATH0.dp.t1_gsr_nxt), // Templated
             .t1_gsr_rnd_next (`FFUPATH0.ctl.visctl.t1_gsr_rnd_next), // Templated
             .t1_gsr_align_next (`FFUPATH0.ctl.visctl.t1_gsr_align_next), // Templated
             .t1_gsr_wsr_w  (`FFUPATH0.ctl.visctl.t1_gsr_wsr_w2), // Templated
             .t1_siam_w   (`FFUPATH0.ctl.visctl.t1_siam_w2), // Templated
             .t1_alignaddr_w  (`FFUPATH0.ctl.visctl.t1_alignaddr_w2), // Templated
             .t2_gsr_nxt    (`FFUPATH0.dp.t2_gsr_nxt), // Templated
             .t2_gsr_rnd_next (`FFUPATH0.ctl.visctl.t2_gsr_rnd_next), // Templated
             .t2_gsr_align_next (`FFUPATH0.ctl.visctl.t2_gsr_align_next), // Templated
             .t2_gsr_wsr_w  (`FFUPATH0.ctl.visctl.t2_gsr_wsr_w2), // Templated
             .t2_siam_w   (`FFUPATH0.ctl.visctl.t2_siam_w2), // Templated
             .t2_alignaddr_w  (`FFUPATH0.ctl.visctl.t2_alignaddr_w2), // Templated
             .t3_gsr_nxt    (`FFUPATH0.dp.t3_gsr_nxt), // Templated
             .t3_gsr_rnd_next (`FFUPATH0.ctl.visctl.t3_gsr_rnd_next), // Templated
             .t3_gsr_align_next (`FFUPATH0.ctl.visctl.t3_gsr_align_next), // Templated
             .t3_gsr_wsr_w  (`FFUPATH0.ctl.visctl.t3_gsr_wsr_w2), // Templated
             .t3_siam_w   (`FFUPATH0.ctl.visctl.t3_siam_w2), // Templated
             .t3_alignaddr_w  (`FFUPATH0.ctl.visctl.t3_alignaddr_w2), // Templated
             .exu_lsu_ldst_va_e (`ASIDPPATH0.exu_lsu_ldst_va_e[47:0]), // Templated
             .asi_state_e   (`ASIDPPATH0.asi_state_e[7:0]), // Templated
             .cpu_num   (cpu_num),     // Templated
             .good    (`PC_CMP.good[1*4-1:0*4]),   // Templated
             .active    (`PC_CMP.active_thread[1*4-1:0*4]), // Templated
             .finish    (`PC_CMP.finish_mask[1*4-1:0*4]), // Templated
             .lda_internal_e  (`ASIPATH0.lda_internal_e), // Templated
             .sta_internal_e  (`ASIPATH0.sta_internal_e), // Templated
             .ifu_spu_trap_ack  ({1'b0,`SPCPATH0.ifu_spu_trap_ack}), // Templated
             .ifu_exu_muls_d  (`SPCPATH0.ifu_exu_muls_d), // Templated
             .ifu_exu_tid_s2  (`EXUPATH0.ifu_exu_tid_s2[1:0]), // Templated
             .rml_irf_restore_local_m(`EXUPATH0.irf.irf.swap_local_w), // Templated
             .rml_irf_cwp_m (`EXUPATH0.irf.irf.old_lo_cwp_m[2:0]), // Templated
             .rml_irf_save_local_m(`EXUPATH0.irf.irf.swap_local_m), // Templated
             .rml_irf_thr_m (`EXUPATH0.irf.irf.cwpswap_tid_m[1:0]), // Templated
             .ifu_exu_save_e  (`EXUPATH0.rml.save_e),  // Templated
             .exu_tlu_spill_e (`EXUPATH0.rml.exu_tlu_spill_e), // Templated
             .t0_fsr_nxt    (`FLOATPATH0.dp.t0_fsr_nxt[27:0]), // Templated
             .t1_fsr_nxt    (`FLOATPATH0.dp.t1_fsr_nxt[27:0]), // Templated
             .t2_fsr_nxt    (`FLOATPATH0.dp.t2_fsr_nxt[27:0]), // Templated
             .t3_fsr_nxt    (`FLOATPATH0.dp.t3_fsr_nxt[27:0]), // Templated
             .ctl_dp_fsr_sel_old  (`FLOATPATH0.ctl_dp_fsr_sel_old[3:0]), // Templated
             .tlu_sftint_en_l_g (`TLUPATH0.tlu_sftint_en_l_g[3:0]), // Templated
             .true_tickcmp0 (`TDPPATH0.true_tickcmp0), // Templated
             .true_tickcmp1 (`TDPPATH0.true_tickcmp1), // Templated
             .true_tickcmp2 (`TDPPATH0.true_tickcmp2), // Templated
             .true_tickcmp3 (`TDPPATH0.true_tickcmp3), // Templated
             .tickcmp_intdis_en (`TDPPATH0.tickcmp_intdis_en[3:0]), // Templated
             .dtu_fdp_rdsr_sel_thr_e_l(`DTUPATH0.fcl_fdp_rdsr_sel_thr_e_l), // Templated
             .ifu_exu_rd_ifusr_e  (`EXUPATH0.ifu_exu_rd_ifusr_e), // Templated
             .ifu_exu_use_rsr_e_l (`EXUPATH0.ifu_exu_use_rsr_e_l), // Templated
             .rml_irf_global_tid  (`EXUPATH0.irf.irf.rml_irf_global_tid[1:0]), // Templated
             .ecl_irf_wen_w (`REGPATH0.ecl_irf_wen_w), // Templated
             .ecl_irf_wen_w2  (`REGPATH0.ecl_irf_wen_w2), // Templated
             .byp_irf_rd_data_w (`REGPATH0.byp_irf_rd_data_w[71:0]), // Templated
             .byp_irf_rd_data_w2  (`REGPATH0.byp_irf_rd_data_w2[71:0]), // Templated
             .thr_rd_w    (`REGPATH0.thr_rd_w[4:0]), // Templated
             .thr_rd_w2   (`REGPATH0.thr_rd_w2[4:0]), // Templated
             .ecl_irf_tid_w (`REGPATH0.ecl_irf_tid_w[1:0]), // Templated
             .ecl_irf_tid_w2  (`REGPATH0.ecl_irf_tid_w2[1:0]), // Templated
`ifndef RTL_SPU
             .ifu_tlu_thrid_w (`SPCPATH0.ifu.ifu.fcl.sas_thrid_w[1:0]), // Templated
`else
             .ifu_tlu_thrid_w (`SPCPATH0.ifu.fcl.sas_thrid_w[1:0]), // Templated
`endif
             .wen_thr0_l    (`CCRPATH0.wen_thr0_l),  // Templated
             .wen_thr1_l    (`CCRPATH0.wen_thr1_l),  // Templated
             .wen_thr2_l    (`CCRPATH0.wen_thr2_l),  // Templated
             .wen_thr3_l    (`CCRPATH0.wen_thr3_l),  // Templated
             .ccrin_thr0    (`CCRPATH0.ccrin_thr0[7:0]), // Templated
             .ccrin_thr1    (`CCRPATH0.ccrin_thr1[7:0]), // Templated
             .ccrin_thr2    (`CCRPATH0.ccrin_thr2[7:0]), // Templated
             .ccrin_thr3    (`CCRPATH0.ccrin_thr3[7:0]), // Templated
             .cwp_thr0_next (`EXUPATH0.rml.cwp.cwp_thr0_next), // Templated
             .cwp_thr1_next (`EXUPATH0.rml.cwp.cwp_thr1_next), // Templated
             .cwp_thr2_next (`EXUPATH0.rml.cwp.cwp_thr2_next), // Templated
             .cwp_thr3_next (`EXUPATH0.rml.cwp.cwp_thr3_next), // Templated
             .cwp_wen_l   (`EXUPATH0.rml.cwp.cwp_wen_l[3:0]), // Templated
             .next_cansave_w  (`EXUPATH0.rml.next_cansave_w[2:0]), // Templated
             .cansave_wen_w (`EXUPATH0.rml.cansave_wen_w), // Templated
             .next_canrestore_w (`EXUPATH0.rml.next_canrestore_w[2:0]), // Templated
             .canrestore_wen_w  (`EXUPATH0.rml.canrestore_wen_w), // Templated
             .next_otherwin_w (`EXUPATH0.rml.next_otherwin_w[2:0]), // Templated
             .otherwin_wen_w  (`EXUPATH0.rml.otherwin_wen_w), // Templated
             .tl_exu_tlu_wsr_data_w(`EXUPATH0.rml.exu_tlu_wsr_data_w[5:0]), // Templated
             .ecl_rml_wstate_wen_w(`EXUPATH0.rml.wstate_wen_w), // Templated
             .next_cleanwin_w (`EXUPATH0.rml.next_cleanwin_w[2:0]), // Templated
             .cleanwin_wen_w  (`EXUPATH0.rml.cleanwin_wen_w), // Templated
             .next_yreg_thr0  (`EXUPATH0.div.yreg.next_yreg_thr0[31:0]), // Templated
             .next_yreg_thr1  (`EXUPATH0.div.yreg.next_yreg_thr1[31:0]), // Templated
             .next_yreg_thr2  (`EXUPATH0.div.yreg.next_yreg_thr2[31:0]), // Templated
             .next_yreg_thr3  (`EXUPATH0.div.yreg.next_yreg_thr3[31:0]), // Templated
             .ecl_div_yreg_wen_l  (`EXUPATH0.ecl_div_yreg_wen_l[3:0]), // Templated
             .ifu_tlu_wsr_inst_d  (`EXUPATH0.ifu_tlu_wsr_inst_d), // Templated
             .ifu_tlu_sraddr_d  (`EXUPATH0.ifu_tlu_sraddr_d[3:0]), // Templated
             .inst_done_w_for_sas (`PC_CMP.spc0_inst_done), // Templated
`ifndef RTL_SPU
             .ifu_tlu_pc_w  (`SPCPATH0.ifu.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH0.ifu.ifu.fdp.npc_w[47:0]), // Templated
`else
             .ifu_tlu_pc_w  (`SPCPATH0.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH0.ifu.fdp.npc_w[47:0]), // Templated
`endif
             .tl0_en    (`TLPATH0.tl0_en),   // Templated
             .tl1_en    (`TLPATH0.tl1_en),   // Templated
             .tl2_en    (`TLPATH0.tl2_en),   // Templated
             .tl3_en    (`TLPATH0.tl3_en),   // Templated
             .trp_lvl0_new  (`TLPATH0.trp_lvl0_new[2:0]), // Templated
             .trp_lvl1_new  (`TLPATH0.trp_lvl1_new[2:0]), // Templated
             .trp_lvl2_new  (`TLPATH0.trp_lvl2_new[2:0]), // Templated
             .trp_lvl3_new  (`TLPATH0.trp_lvl3_new[2:0]), // Templated
             .update_pstate0_w2 (`TLPATH0.update_pstate_w2[0]), // Templated
             .update_pstate1_w2 (`TLPATH0.update_pstate_w2[1]), // Templated
             .update_pstate2_w2 (`TLPATH0.update_pstate_w2[2]), // Templated
             .update_pstate3_w2 (`TLPATH0.update_pstate_w2[3]), // Templated
             .pstate_priv_update_w2(`TDPPATH0.pstate_priv_update_w2), // Templated
             .hpstate_priv_update_w2(`TDPPATH0.hpstate_priv_update_w2), // Templated
             .restore_pstate0 (`TDPPATH0.restore_pstate0), // Templated
             .restore_pstate1 (`TDPPATH0.restore_pstate1), // Templated
             .restore_pstate2 (`TDPPATH0.restore_pstate2), // Templated
             .restore_pstate3 (`TDPPATH0.restore_pstate3), // Templated
             .tick0_en    (`TLPATH0.tick_en[0]),   // Templated
             .tick1_en    (`TLPATH0.tick_en[1]),   // Templated
             .tick2_en    (`TLPATH0.tick_en[2]),   // Templated
             .tick3_en    (`TLPATH0.tick_en[3]),   // Templated
             .exu_tlu_wsr_data_w  (`TDPPATH0.tlu_wsr_data_w[63:0]), // Templated
             .tba0_en   (`TLPATH0.tlu_tba_en_l[0]), // Templated
             .tba1_en   (`TLPATH0.tlu_tba_en_l[1]), // Templated
             .tba2_en   (`TLPATH0.tlu_tba_en_l[2]), // Templated
             .tba3_en   (`TLPATH0.tlu_tba_en_l[3]), // Templated
             .tsa_wr_vld    (`TLPATH0.tsa_wr_vld[1:0]), // Templated
             .tsa_pc_en   (`TLPATH0.tsa_pc_en),  // Templated
             .tsa_npc_en    (`TLPATH0.tsa_npc_en),   // Templated
             .tsa_tstate_en (`TLPATH0.tsa_tstate_en), // Templated
             .tsa_ttype_en  (`TLPATH0.tsa_ttype_en), // Templated
             .tsa_wr_tid    (`TLPATH0.tsa_wr_tid[1:0]), // Templated
             .tsa_wr_tpl    (`TLPATH0.tsa_wr_tpl[2:0]), // Templated
             // .temp_tlvl0    (`TS0PATH0.temp_tlvl),   // Templated
             .temp_tlvl0    (),   // Templated
             .tsa0_wdata    (`TS0PATH0.din),   // Templated
             .write_mask0   (`TS0PATH0.write_mask),  // Templated
             //.temp_tlvl1    (`TS1PATH0.temp_tlvl),   // Templated
             .temp_tlvl1    (),   // Templated
             .tsa1_wdata    (`TS1PATH0.din),   // Templated
             .write_mask1   (`TS1PATH0.write_mask),  // Templated
             .cpu_id    (10'd0),       // Templated
             .next_t0_inrr_i1 (`INTPATH0.next_t0_inrr_i1[63:0]), // Templated
             .next_t1_inrr_i1 (`INTPATH0.next_t1_inrr_i1[63:0]), // Templated
             .next_t2_inrr_i1 (`INTPATH0.next_t2_inrr_i1[63:0]), // Templated
             .next_t3_inrr_i1 (`INTPATH0.next_t3_inrr_i1[63:0]), // Templated
             .ifu_lsu_st_inst_e (`SPCPATH0.ifu_lsu_st_inst_e), // Templated
             .ifu_lsu_ld_inst_e (`SPCPATH0.ifu_lsu_ld_inst_e), // Templated
             .ifu_lsu_alt_space_e (`PCXPATH0.ifu_lsu_alt_space_e), // Templated
             .ifu_lsu_ldst_fp_e (`PCXPATH0.ifu_lsu_ldst_fp_e), // Templated
             .ifu_lsu_ldst_dbl_e  (`PCXPATH0.ifu_lsu_ldst_dbl_e), // Templated
             .lsu_ffu_blk_asi_e (`PCXPATH0.lsu_ffu_blk_asi_e), // Templated
             .ifu_tlu_inst_vld_m  (`PCXPATH0.ifu_tlu_inst_vld_m), // Templated
             .ifu_lsu_swap_e  (`SPCPATH0.ifu_lsu_swap_e), // Templated
             .ifu_tlu_thrid_e (`SPCPATH0.ifu_tlu_thrid_e[1:0]), // Templated
             .asi_wr_din    (`ASIDPPATH0.asi_wr_din), // Templated
             .asi_state_wr_thrd (`ASIDPPATH0.asi_state_wr_thrd[3:0]), // Templated
             .pil     (`TLPATH0.tlu_wsr_data_w[3:0]), // Templated
             .pil0_en   (`TLPATH0.pil0_en),  // Templated
             .pil1_en   (`TLPATH0.pil1_en),  // Templated
             .pil2_en   (`TLPATH0.pil2_en),  // Templated
             .pil3_en   (`TLPATH0.pil3_en),  // Templated
             .dp_frf_data   (`FLOATPATH0.dp_frf_data[70:0]), // Templated
             .ctl_frf_addr  (`FLOATPATH0.ctl_frf_addr[6:0]), // Templated
             .ctl_frf_wen   (`FLOATPATH0.ctl_frf_wen[1:0]), // Templated
             .regfile_index (`FLOATPATH0.frf.regfile_index[7:0]), // Templated
             .ifu_exu_rs1_s (`EXUPATH0.ifu_exu_rs1_s[4:0]), // Templated
             .ifu_exu_rs2_s (`EXUPATH0.ifu_exu_rs2_s[4:0]), // Templated
             .byp_alu_rs1_data_e  (`EXUPATH0.byp_alu_rs1_data_e[63:0]), // Templated
             .byp_alu_rs2_data_e  (`EXUPATH0.byp_alu_rs2_data_e[63:0]), // Templated
             .ifu_lsu_imm_asi_d (`SPCPATH0.ifu_lsu_imm_asi_d[7:0]), // Templated
             .ifu_lsu_imm_asi_vld_d(`SPCPATH0.ifu_lsu_imm_asi_vld_d), // Templated
             .ifu_tlu_itlb_done (`SPCPATH0.ifu_tlu_itlb_done), // Templated
             .tlu_itlb_wr_vld_g (`SPCPATH0.tlu_itlb_wr_vld_g), // Templated
             .tlu_itlb_dmp_vld_g  (`SPCPATH0.tlu_itlb_dmp_vld_g), // Templated
             .lsu_tlu_dtlb_done (`SPCPATH0.lsu_tlu_dtlb_done), // Templated
             .tlu_dtlb_wr_vld_g (`TLUPATH0.mmu_ctl.pre_dtlb_wr_vld_g), // Templated
             .tlu_dtlb_dmp_vld_g  (`SPCPATH0.tlu_dtlb_dmp_vld_g), // Templated
             .tlu_idtlb_dmp_thrid_g(`SPCPATH0.tlu_idtlb_dmp_thrid_g[1:0]), // Templated
             .inst_vld_qual_e (`INSTPATH0.inst_vld_qual_e), // Templated
             .t0_inrr_i2    (`TLUPATH0.intdp.t0_inrr_i2[63:0]), // Templated
             .t1_inrr_i2    (`TLUPATH0.intdp.t1_inrr_i2[63:0]), // Templated
             .t2_inrr_i2    (`TLUPATH0.intdp.t2_inrr_i2[63:0]), // Templated
             .t3_inrr_i2    (`TLUPATH0.intdp.t3_inrr_i2[63:0]), // Templated
             .t0_indr   (`TLUPATH0.intdp.t0_indr[10:0]), // Templated
             .t1_indr   (`TLUPATH0.intdp.t1_indr[10:0]), // Templated
             .t2_indr   (`TLUPATH0.intdp.t2_indr[10:0]), // Templated
             .t3_indr   (`TLUPATH0.intdp.t3_indr[10:0]), // Templated
             .ttype_sel_hstk_cmp_e(`INSTPATH0.ttype_sel_hstk_cmp_e), // Templated
             .ifu_tlu_ttype_vld_m (`INSTPATH0.ifu_tlu_ttype_vld_m)); // Templated
`endif // ifdef RTL_SPARC0



 `ifdef RTL_SPARC1
sas_task task1 (/*AUTOINST*/
             // Inputs
             .tlu_pich_wrap_flg_m (`TLUPATH1.tcl.tlu_pich_wrap_flg_m), // Templated
             .tlu_pic_cnt_en_m  (`TLUPATH1.tcl.tlu_pic_cnt_en_m), // Templated
             .final_ttype_sel_g (`TLUPATH1.tcl.final_ttype_sel_g), // Templated
             .rst_ttype_w2  (`TLUPATH1.tcl.rst_ttype_w2), // Templated
             .sync_trap_taken_m (`TLUPATH1.tcl.sync_trap_taken_m), // Templated
             .pib_picl_wrap (`TLUPATH1.pib_picl_wrap), // Templated
             .pib_pich_wrap_m (`TLUPATH1.tcl.pib_pich_wrap_m), // Templated
             .pib_pich_wrap (`TLUPATH1.pib_pich_wrap), // Templated
             .pic_wrap_trap_g (`TLUPATH1.tcl.pib_wrap_trap_g), // Templated
             .pib_wrap_trap_m (`TLUPATH1.tcl.pib_wrap_trap_m), // Templated
             .pcr_rw_e    (`TLUPATH1.tlu_pib.pcr_rw_e), // Templated
             .tlu_rsr_inst_e  (`TLUPATH1.tlu_pib.tlu_rsr_inst_e), // Templated
             .pcr0    (`TLUPATH1.tlu_pib.pcr0), // Templated
             .pcr1    (`TLUPATH1.tlu_pib.pcr1), // Templated
             .pcr2    (`TLUPATH1.tlu_pib.pcr2), // Templated
             .pcr3    (`TLUPATH1.tlu_pib.pcr3), // Templated
             .wsr_pcr_sel   (`TLUPATH1.tlu_pib.wsr_pcr_sel), // Templated
             .pich_cnt0   (`TLUPATH1.tlu_pib.pich_cnt0), // Templated
             .pich_cnt1   (`TLUPATH1.tlu_pib.pich_cnt1), // Templated
             .pich_cnt2   (`TLUPATH1.tlu_pib.pich_cnt2), // Templated
             .pich_cnt3   (`TLUPATH1.tlu_pib.pich_cnt3), // Templated
             .picl_cnt0   (`TLUPATH1.tlu_pib.picl_cnt0), // Templated
             .picl_cnt1   (`TLUPATH1.tlu_pib.picl_cnt1), // Templated
             .picl_cnt2   (`TLUPATH1.tlu_pib.picl_cnt2), // Templated
             .picl_cnt3   (`TLUPATH1.tlu_pib.picl_cnt3), // Templated
             .update_pich_sel (`TLUPATH1.tlu_pib.update_pich_sel), // Templated
             .update_picl_sel (`TLUPATH1.tlu_pib.update_picl_sel), // Templated
`ifndef RTL_SPU
             .const_maskid  (`PCXPATH1.ifu.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH1.ifu.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH1.ifu.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH1.ifu.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH1.ifu.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH1.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH1.ifu.ifu.errdp.formatted_tte_data), // Templated
`else
             .const_maskid  (`PCXPATH1.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH1.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH1.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH1.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH1.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH1.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH1.ifu.errdp.formatted_tte_data), // Templated
`endif
             .dformatted_tte_data (`SPARC_CORE0.`LSU_PATH.tlbdp.formatted_tte_data), // Templated
             .dtlb_cam_vld  (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_cam_vld), // Templated
             .dtlb_tte_vld_g  (`SPARC_CORE0.`LSU_PATH.excpctl.tlb_tte_vld_g), // Templated
             .tlu_hpstate_priv  (`PCXPATH1.tlu_hpstate_priv), // Templated
             .tlu_hpstate_enb (`PCXPATH1.tlu_hpstate_enb), // Templated
`ifndef RTL_SPU
             .fcl_dtu_inst_vld_d  (`PCXPATH1.ifu.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH1.ifu.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH1.ifu.ifu.fcl.xlate_en), // Templated
`else
             .fcl_dtu_inst_vld_d  (`PCXPATH1.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH1.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH1.ifu.fcl.xlate_en), // Templated
`endif
             .ifu_lsu_thrid_s (`PCXPATH1.ifu_lsu_thrid_s), // Templated
             .fcl_ifq_icmiss_s1 (`IFUPATH1.fcl.fcl_ifq_icmiss_s1), // Templated
             .tlu_exu_early_flush_pipe_w(`PCXPATH1.tlu_exu_early_flush_pipe_w), // Templated
             .rst_hwint_ttype_g (`TLUPATH1.tcl.rst_hwint_ttype_g), // Templated
             .trap_taken_g  (`TLUPATH1.tcl.trap_taken_g), // Templated
`ifndef RTL_SPU
             .spu_lsu_ldxa_illgl_va_w2(1'b0), // Templated
             .spu_lsu_ldxa_data_vld_w2(1'b0), // Templated
             .spu_lsu_ldxa_tid_w2 (2'b0), // Templated
`else
             .spu_lsu_ldxa_illgl_va_w2(`PCXPATH1.spu.spu_ctl.spu_lsu_ldxa_illgl_va_w2), // Templated
             .spu_lsu_ldxa_data_vld_w2(`PCXPATH1.spu.spu_ctl.spu_lsu_ldxa_data_vld_w2), // Templated
             .spu_lsu_ldxa_tid_w2 (`PCXPATH1.spu.spu_ctl.spu_lsu_ldxa_tid_w2), // Templated
`endif
             .mra_field1_en (`TLUPATH1.mmu_ctl.mra_field1_en), // Templated
             .mra_field2_en (`TLUPATH1.mmu_ctl.mra_field2_en), // Templated
             .mra_field3_en (`TLUPATH1.mmu_ctl.mra_field3_en), // Templated
             .mra_field4_en (`TLUPATH1.mmu_ctl.mra_field4_en), // Templated
             .pmem_unc_error_g  (`SPARC_CORE0.`LSU_PATH.dctl.pmem_unc_error_g), // Templated
`ifndef RTL_SPU
             .pc_f    (`PCXPATH1.ifu.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH1.ifu.ifu.fcl.cam_vld_f), // Templated
`else
             .pc_f    (`PCXPATH1.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH1.ifu.fcl.cam_vld_f), // Templated
`endif
             .cam_vld   (`SPARC_CORE0.`LSU_PATH.dtlb.cam_vld), // Templated
             .defr_trp_taken_m_din(`SPARC_CORE0.`LSU_PATH.excpctl.defr_trp_taken_m_din), // Templated
             .illgl_va_vld_or_drop_ldxa2masync(1'b0), // Templated
`ifndef RTL_SPU
             .ecc_wen   (`PCXPATH1.ffu.ffu.ctl.ecc_wen), // Templated
`else
             .ecc_wen   (`PCXPATH1.ffu.ctl.ecc_wen), // Templated
`endif
             .fpdis_trap_e  (`IFUPATH1.dec.fpdis_trap_e), // Templated
             .ceen    (`IFUPATH1.errctl.ceen), // Templated
             .nceen   (`IFUPATH1.errctl.nceen), // Templated
             .ifu_tlu_flush_m (`TLUPATH1.ifu_tlu_flush_m), // Templated
             .lsu_tlu_ttype_m2  (`TLUPATH1.lsu_tlu_ttype_m2), // Templated
             .lsu_tlu_ttype_vld_m2(`TLUPATH1.lsu_tlu_ttype_vld_m2), // Templated
             .tlu_final_ttype_w2  (`TLUPATH1.tlu_final_ttype_w2), // Templated
             .tlu_ifu_trappc_vld_w1(`TLUPATH1.tlu_ifu_trappc_vld_w1), // Templated
             .mra_wr_ptr    (`TLUPATH1.mra_wr_ptr),  // Templated
             .mra_wr_vld    (`TLUPATH1.mra_wr_vld),  // Templated
             .lsu_pid_state0  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state0), // Templated
             .lsu_pid_state1  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state1), // Templated
             .lsu_pid_state2  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state2), // Templated
             .lsu_pid_state3  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state3), // Templated
             .pid_state_wr_en (`SPARC_CORE0.`LSU_PATH.pid_state_wr_en), // Templated
             .lsu_t0_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t0_pctxt_state), // Templated
             .lsu_t1_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t1_pctxt_state), // Templated
             .lsu_t2_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t2_pctxt_state), // Templated
             .lsu_t3_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t3_pctxt_state), // Templated
             .pctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.pctxt_state_wr_thrd), // Templated
             .sctxt_state0  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state0), // Templated
             .sctxt_state1  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state1), // Templated
             .sctxt_state2  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state2), // Templated
             .sctxt_state3  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state3), // Templated
             .sctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state_wr_thrd), // Templated
             .va_wtchpt0_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt0_addr), // Templated
             .va_wtchpt1_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt1_addr), // Templated
             .va_wtchpt2_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt2_addr), // Templated
             .va_wtchpt3_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt3_addr), // Templated
             .lsu_va_wtchpt0_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt0_wr_en_l), // Templated
             .lsu_va_wtchpt1_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt1_wr_en_l), // Templated
             .lsu_va_wtchpt2_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt2_wr_en_l), // Templated
             .lsu_va_wtchpt3_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt3_wr_en_l), // Templated
             .ifu_rstint_m  (`TLPATH1.ifu_rstint_m), // Templated
`ifndef RTL_SPU
             .spu_tlu_rsrv_illgl_m(`PCXPATH1.tlu.tlu.spu_tlu_rsrv_illgl_m), // Templated
`else
             .spu_tlu_rsrv_illgl_m(`PCXPATH1.tlu.spu_tlu_rsrv_illgl_m), // Templated
`endif
             .cam_vld_s1    (`IFUPATH1.fcl.cam_vld_s1), // Templated
             .val_thr_s1    (`IFUPATH1.fcl.val_thr_s1), // Templated
             .pc_s    (`IFUPATH1.fdp.pc_s),  // Templated
`ifndef RTL_SPU
             .rs2_fst_ue_w3 (`PCXPATH1.ffu.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH1.ffu.ffu.ctl.rs2_fst_ce_w3), // Templated
`else
             .rs2_fst_ue_w3 (`PCXPATH1.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH1.ffu.ctl.rs2_fst_ce_w3), // Templated
`endif
             .lsu_tlu_async_ttype_vld_w2(`PCXPATH1.lsu_tlu_async_ttype_vld_w2), // Templated
             .lsu_tlu_defr_trp_taken_g(`PCXPATH1.lsu_tlu_defr_trp_taken_g), // Templated
             .lsu_tlu_async_ttype_w2(`PCXPATH1.lsu_tlu_async_ttype_w2), // Templated
             .lsu_tlu_async_tid_w2(`PCXPATH1.lsu_tlu_async_tid_w2), // Templated
`ifndef RTL_SPU
             .itlb_rw_index (`PCXPATH1.ifu.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH1.ifu.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH1.ifu.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH1.ifu.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH1.ifu.ifu.itlb.cam_hit}), // Templated
`else
             .itlb_rw_index (`PCXPATH1.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH1.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH1.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH1.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH1.ifu.itlb.cam_hit}), // Templated
`endif
             .dtlb_rw_index (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index), // Templated
             .dtlb_rw_index_vld (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index_vld), // Templated
             .dtlb_rd_tte_tag (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rd_tte_tag), // Templated
             .dtlb_rd_tte_data  (`SPARC_CORE0.`LSU_PATH.dtlb.rd_tte_data), // Templated
             .dcam_hit    ({48'b0,`SPARC_CORE0.`LSU_PATH.dtlb.cam_hit}), // Templated
             .wrt_spec_w    (`IFUPATH1.swl.wrt_spec_w), // Templated
             .spc_pcx_data_pa (124'b0), // Templated //tttttttttttttt
             .fcl_fdp_inst_sel_nop_s_l(`IFUPATH1.fdp.fcl_fdp_inst_sel_nop_s_l), // Templated
             .retract_iferr_d (`IFUPATH1.swl.retract_iferr_d), // Templated
             .inst_vld_w    (`INSTPATH1.inst_vld_w), // Templated
             .dmmu_async_illgl_va_g(`TLUPATH1.mmu_ctl.dmmu_async_illgl_va_g), // Templated
             .immu_async_illgl_va_g(`TLUPATH1.mmu_ctl.immu_async_illgl_va_g), // Templated
             .lsu_tlu_tlb_ld_inst_m(`TLUPATH1.mmu_ctl.lsu_tlu_tlb_ld_inst_m), // Templated
             .lsu_tlu_tlb_st_inst_m(`TLUPATH1.mmu_ctl.lsu_tlu_tlb_st_inst_m), // Templated
             .immu_sfsr_wr_en_l (`TLUPATH1.immu_sfsr_wr_en_l), // Templated
             .dmmu_sfsr_wr_en_l (`TLUPATH1.dmmu_sfsr_wr_en_l), // Templated
             .dmmu_sfar_wr_en_l (`TLUPATH1.dmmu_sfar_wr_en_l), // Templated
             .lsu_quad_asi_e  (`SPARC_CORE0.`LSU_PATH.lsu_quad_asi_e), // Templated
             .clk     (clk),       // Templated
             .rst_l   (rst_l),     // Templated
             .back    (`PC_CMP.back_thread[2*4-1:1*4]), // Templated
             .lsu_ifu_ldsta_internal_e(`IFUPATH1.lsu_ifu_ldsta_internal_e), // Templated
             .lsu_mmu_flush_pipe_w(`TLUPATH1.lsu_mmu_flush_pipe_w), // Templated
             .dtlb_wr_vld   (`DTLBPATH1.tlb_wr_vld), // Templated
             .dtlb_demap    (`DTLBPATH1.tlb_demap),  // Templated
             .dtlb_rd_tag_vld (`DTLBPATH1.tlb_rd_tag_vld), // Templated
             .dtlb_rd_data_vld  (`DTLBPATH1.tlb_rd_data_vld), // Templated
             .dtlb_entry_vld  ({48'd0,`DTLBPATH1.tlb_entry_vld}), // Templated
             .itlb_wr_vld   (`ITLBPATH1.tlb_wr_vld), // Templated
             .itlb_demap    (`ITLBPATH1.tlb_demap),  // Templated
             .itlb_rd_tag_vld (`ITLBPATH1.tlb_rd_tag_vld), // Templated
             .itlb_rd_data_vld  (`ITLBPATH1.tlb_rd_data_vld), // Templated
             .itlb_entry_vld  ({48'd0,`ITLBPATH1.tlb_entry_vld}), // Templated
             .tlb_access_tid_g  (`TLUPATH1.mmu_ctl.tlb_access_tid_g), // Templated
             .dsfar0_clk    (`TLUPATH1.mmu_dp.dsfar0_clk), // Templated
             .dsfar1_clk    (`TLUPATH1.mmu_dp.dsfar1_clk), // Templated
             .dsfar2_clk    (`TLUPATH1.mmu_dp.dsfar2_clk), // Templated
             .dsfar3_clk    (`TLUPATH1.mmu_dp.dsfar3_clk), // Templated
             .dsfar_din   (`TLUPATH1.mmu_dp.dsfar_din), // Templated
             .dtu_inst_d    (`IFUPATH1.dec.dtu_inst_d), // Templated
             .local_rdpr_mx1_sel  (`TLPATH1.local_rdpr_mx1_sel), // Templated
             .tlu_rdpr_mx5_sel  (`TLPATH1.tlu_rdpr_mx5_sel), // Templated
             .tlu_rdpr_mx7_sel  (`TLPATH1.tlu_rdpr_mx7_sel), // Templated
             .tlu_rst_l   (`TLPATH1.tlu_rst_l),  // Templated
             .tick_match    (`TDPPATH1.tick_match),  // Templated
             .tlu_wr_sftint_l_g (`TLUPATH1.tlu_wr_sftint_l_g), // Templated
             .dsfsr_din   (`TLUPATH1.mmu_dp.dsfsr_din), // Templated
             .dsfsr0_clk    (`TLUPATH1.mmu_dp.dsfsr0_clk), // Templated
             .dsfsr1_clk    (`TLUPATH1.mmu_dp.dsfsr1_clk), // Templated
             .dsfsr2_clk    (`TLUPATH1.mmu_dp.dsfsr2_clk), // Templated
             .dsfsr3_clk    (`TLUPATH1.mmu_dp.dsfsr3_clk), // Templated
             .isfsr_din   (`TLUPATH1.mmu_dp.isfsr_din), // Templated
             .isfsr0_clk    (`TLUPATH1.mmu_dp.isfsr0_clk), // Templated
             .isfsr1_clk    (`TLUPATH1.mmu_dp.isfsr1_clk), // Templated
             .isfsr2_clk    (`TLUPATH1.mmu_dp.isfsr2_clk), // Templated
             .isfsr3_clk    (`TLUPATH1.mmu_dp.isfsr3_clk), // Templated
             .ecl_byp_sel_ecc_w (`IFUPATH1.errctl.irf_ce_unq), // Templated
             .ifu_exu_inst_w  (`INSTPATH1.ifu_exu_inst_vld_w), // Templated
             .ctl_dp_fp_thr (`FLOATPATH1.ctl_dp_fp_thr), // Templated
             .ifu_ffu_fst_d (`FLOATPATH1.ifu_ffu_fst_d), // Templated
             .pc_e    (`DTUPATH1.pc_e),  // Templated
             .fcl_dtu_inst_vld_e  (`INSTPATH1.fcl_dtu_inst_vld_e), // Templated
             .exu_lsu_rs3_data_e  (`PCXPATH1.exu_lsu_rs3_data_e), // Templated
             .tick_ctl_din  (`TLPATH1.tick_ctl_din), // Templated
             .ifu_tlu_ttype_m (`PCXPATH1.ifu_tlu_ttype_m), // Templated
             .tlu_rerr_vld  (`PCXPATH1.tlu_rerr_vld), // Templated
             .sftint0   (`TDPPATH1.sftint0),   // Templated
             .sftint1   (`TDPPATH1.sftint1),   // Templated
             .sftint2   (`TDPPATH1.sftint2),   // Templated
             .sftint3   (`TDPPATH1.sftint3),   // Templated
             .sftint0_clk   (`TDPPATH1.sftint0_clk), // Templated
             .sftint1_clk   (`TDPPATH1.sftint1_clk), // Templated
             .sftint2_clk   (`TDPPATH1.sftint2_clk), // Templated
             .sftint3_clk   (`TDPPATH1.sftint3_clk), // Templated
             .sftint_b0_en  (`TDPPATH1.sftint_b0_en), // Templated
             .sftint_b15_en (`TDPPATH1.sftint_b15_en), // Templated
             .sftint_b16_en (`TDPPATH1.sftint_b16_en), // Templated
             .cpx_spc_data_cx2  (`PCXPATH1.cpx_spc_data_cx2), // Templated
             .ifu_exu_save_d  (`PCXPATH1.ifu_exu_save_d), // Templated
             .ifu_exu_restore_d (`PCXPATH1.ifu_exu_restore_d), // Templated
             .ifu_tlu_thrid_d (`PCXPATH1.ifu_tlu_thrid_d), // Templated
             .tlu_ifu_hwint_i3  (`TLUPATH1.tlu_ifu_hwint_i3), // Templated
             .ifu_tlu_hwint_m (`TLUPATH1.ifu_tlu_hwint_m), // Templated
             .ifu_tlu_rstint_m  (`TLUPATH1.ifu_tlu_rstint_m), // Templated
             .ifu_tlu_swint_m (`TLUPATH1.ifu_tlu_swint_m), // Templated
             .tlu_ifu_flush_pipe_w(`TLPATH1.tlu_ifu_flush_pipe_w), // Templated
             .ifu_tlu_flush_w (`PCXPATH1.ifu_tlu_flush_w), // Templated
             .ffu_ifu_fst_ce_w  (`PCXPATH1.ffu_ifu_fst_ce_w), // Templated
`ifndef RTL_SPU
             .ffu_ifu_ecc_ue_w2 (`PCXPATH1.ffu.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH1.ffu.ffu.ffu_ifu_ecc_ce_w2), // Templated
`else
             .ffu_ifu_ecc_ue_w2 (`PCXPATH1.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH1.ffu.ffu_ifu_ecc_ce_w2), // Templated
`endif
             .any_err_vld   (`IFUPATH1.errctl.any_err_vld), // Templated
             .any_ue_vld    (`IFUPATH1.errctl.any_ue_vld), // Templated
             .tsa_htstate_en  (`TLPATH1.tsa_htstate_en), // Templated
             .stickcmp_intdis_en  (`TDPPATH1.stickcmp_intdis_en), // Templated
             .tick_npt0   (`TLPATH1.tick_npt0),  // Templated
             .tick_npt1   (`TLPATH1.tick_npt1),  // Templated
             .tick_npt2   (`TLPATH1.tick_npt2),  // Templated
             .tick_npt3   (`TLPATH1.tick_npt3),  // Templated
             .true_tick   (`TDPPATH1.true_tick),   // Templated
             .htick_intdis0 (`TLU_HYPER0.htick_intdis0), // Templated
             .htick_intdis1 (`TLU_HYPER0.htick_intdis1), // Templated
             .htick_intdis2 (`TLU_HYPER0.htick_intdis2), // Templated
             .htick_intdis3 (`TLU_HYPER0.htick_intdis3), // Templated
             .true_stickcmp0  (`TDPPATH1.true_stickcmp0), // Templated
             .true_stickcmp1  (`TDPPATH1.true_stickcmp1), // Templated
             .true_stickcmp2  (`TDPPATH1.true_stickcmp2), // Templated
             .true_stickcmp3  (`TDPPATH1.true_stickcmp3), // Templated
             .tlu_hintp_en_l_g  (`TDPPATH1.tlu_hintp_en_l_g), // Templated
             .tlu_hintp   (`TDPPATH1.tlu_hintp),   // Templated
             .tlu_htba_en_l (`TDPPATH1.tlu_htba_en_l), // Templated
             .true_htba0    (`TDPPATH1.true_htba0),  // Templated
             .true_htba1    (`TDPPATH1.true_htba1),  // Templated
             .true_htba2    (`TDPPATH1.true_htba2),  // Templated
             .true_htba3    (`TDPPATH1.true_htba3),  // Templated
             .update_hpstate_l_w2 (`TDPPATH1.tlu_update_hpstate_l_w2[3:0]), // Templated
             .restore_hpstate0  (`TDPPATH1.restore_hpstate0), // Templated
             .restore_hpstate1  (`TDPPATH1.restore_hpstate1), // Templated
             .restore_hpstate2  (`TDPPATH1.restore_hpstate2), // Templated
             .restore_hpstate3  (`TDPPATH1.restore_hpstate3), // Templated
             .htickcmp_intdis_en  (`TLU_HYPER0.htickcmp_intdis_en), // Templated
             .true_htickcmp0  (`TDPPATH1.true_htickcmp0), // Templated
             .true_htickcmp1  (`TDPPATH1.true_htickcmp1), // Templated
             .true_htickcmp2  (`TDPPATH1.true_htickcmp2), // Templated
             .true_htickcmp3  (`TDPPATH1.true_htickcmp3), // Templated
             .gl0_en    (`TLU_HYPER0.gl0_en),  // Templated
             .gl1_en    (`TLU_HYPER0.gl1_en),  // Templated
             .gl2_en    (`TLU_HYPER0.gl2_en),  // Templated
             .gl3_en    (`TLU_HYPER0.gl3_en),  // Templated
             .gl_lvl0_new   (`TLU_HYPER0.gl_lvl0_new), // Templated
             .gl_lvl1_new   (`TLU_HYPER0.gl_lvl1_new), // Templated
             .gl_lvl2_new   (`TLU_HYPER0.gl_lvl2_new), // Templated
             .gl_lvl3_new   (`TLU_HYPER0.gl_lvl3_new), // Templated
             .t0_gsr_nxt    (`FFUPATH1.dp.t0_gsr_nxt), // Templated
             .t0_gsr_rnd_next (`FFUPATH1.ctl.visctl.t0_gsr_rnd_next), // Templated
             .t0_gsr_align_next (`FFUPATH1.ctl.visctl.t0_gsr_align_next), // Templated
             .t0_gsr_wsr_w  (`FFUPATH1.ctl.visctl.t0_gsr_wsr_w2), // Templated
             .t0_siam_w   (`FFUPATH1.ctl.visctl.t0_siam_w2), // Templated
             .t0_alignaddr_w  (`FFUPATH1.ctl.visctl.t0_alignaddr_w2), // Templated
             .t1_gsr_nxt    (`FFUPATH1.dp.t1_gsr_nxt), // Templated
             .t1_gsr_rnd_next (`FFUPATH1.ctl.visctl.t1_gsr_rnd_next), // Templated
             .t1_gsr_align_next (`FFUPATH1.ctl.visctl.t1_gsr_align_next), // Templated
             .t1_gsr_wsr_w  (`FFUPATH1.ctl.visctl.t1_gsr_wsr_w2), // Templated
             .t1_siam_w   (`FFUPATH1.ctl.visctl.t1_siam_w2), // Templated
             .t1_alignaddr_w  (`FFUPATH1.ctl.visctl.t1_alignaddr_w2), // Templated
             .t2_gsr_nxt    (`FFUPATH1.dp.t2_gsr_nxt), // Templated
             .t2_gsr_rnd_next (`FFUPATH1.ctl.visctl.t2_gsr_rnd_next), // Templated
             .t2_gsr_align_next (`FFUPATH1.ctl.visctl.t2_gsr_align_next), // Templated
             .t2_gsr_wsr_w  (`FFUPATH1.ctl.visctl.t2_gsr_wsr_w2), // Templated
             .t2_siam_w   (`FFUPATH1.ctl.visctl.t2_siam_w2), // Templated
             .t2_alignaddr_w  (`FFUPATH1.ctl.visctl.t2_alignaddr_w2), // Templated
             .t3_gsr_nxt    (`FFUPATH1.dp.t3_gsr_nxt), // Templated
             .t3_gsr_rnd_next (`FFUPATH1.ctl.visctl.t3_gsr_rnd_next), // Templated
             .t3_gsr_align_next (`FFUPATH1.ctl.visctl.t3_gsr_align_next), // Templated
             .t3_gsr_wsr_w  (`FFUPATH1.ctl.visctl.t3_gsr_wsr_w2), // Templated
             .t3_siam_w   (`FFUPATH1.ctl.visctl.t3_siam_w2), // Templated
             .t3_alignaddr_w  (`FFUPATH1.ctl.visctl.t3_alignaddr_w2), // Templated
             .exu_lsu_ldst_va_e (`ASIDPPATH1.exu_lsu_ldst_va_e[47:0]), // Templated
             .asi_state_e   (`ASIDPPATH1.asi_state_e[7:0]), // Templated
             .cpu_num   (cpu_num),     // Templated
             .good    (`PC_CMP.good[2*4-1:1*4]),   // Templated
             .active    (`PC_CMP.active_thread[2*4-1:1*4]), // Templated
             .finish    (`PC_CMP.finish_mask[2*4-1:1*4]), // Templated
             .lda_internal_e  (`ASIPATH1.lda_internal_e), // Templated
             .sta_internal_e  (`ASIPATH1.sta_internal_e), // Templated
             .ifu_spu_trap_ack  ({1'b0,`SPCPATH1.ifu_spu_trap_ack}), // Templated
             .ifu_exu_muls_d  (`SPCPATH1.ifu_exu_muls_d), // Templated
             .ifu_exu_tid_s2  (`EXUPATH1.ifu_exu_tid_s2[1:0]), // Templated
             .rml_irf_restore_local_m(`EXUPATH1.irf.irf.swap_local_w), // Templated
             .rml_irf_cwp_m (`EXUPATH1.irf.irf.old_lo_cwp_m[2:0]), // Templated
             .rml_irf_save_local_m(`EXUPATH1.irf.irf.swap_local_m), // Templated
             .rml_irf_thr_m (`EXUPATH1.irf.irf.cwpswap_tid_m[1:0]), // Templated
             .ifu_exu_save_e  (`EXUPATH1.rml.save_e),  // Templated
             .exu_tlu_spill_e (`EXUPATH1.rml.exu_tlu_spill_e), // Templated
             .t0_fsr_nxt    (`FLOATPATH1.dp.t0_fsr_nxt[27:0]), // Templated
             .t1_fsr_nxt    (`FLOATPATH1.dp.t1_fsr_nxt[27:0]), // Templated
             .t2_fsr_nxt    (`FLOATPATH1.dp.t2_fsr_nxt[27:0]), // Templated
             .t3_fsr_nxt    (`FLOATPATH1.dp.t3_fsr_nxt[27:0]), // Templated
             .ctl_dp_fsr_sel_old  (`FLOATPATH1.ctl_dp_fsr_sel_old[3:0]), // Templated
             .tlu_sftint_en_l_g (`TLUPATH1.tlu_sftint_en_l_g[3:0]), // Templated
             .true_tickcmp0 (`TDPPATH1.true_tickcmp0), // Templated
             .true_tickcmp1 (`TDPPATH1.true_tickcmp1), // Templated
             .true_tickcmp2 (`TDPPATH1.true_tickcmp2), // Templated
             .true_tickcmp3 (`TDPPATH1.true_tickcmp3), // Templated
             .tickcmp_intdis_en (`TDPPATH1.tickcmp_intdis_en[3:0]), // Templated
             .dtu_fdp_rdsr_sel_thr_e_l(`DTUPATH1.fcl_fdp_rdsr_sel_thr_e_l), // Templated
             .ifu_exu_rd_ifusr_e  (`EXUPATH1.ifu_exu_rd_ifusr_e), // Templated
             .ifu_exu_use_rsr_e_l (`EXUPATH1.ifu_exu_use_rsr_e_l), // Templated
             .rml_irf_global_tid  (`EXUPATH1.irf.irf.rml_irf_global_tid[1:0]), // Templated
             .ecl_irf_wen_w (`REGPATH1.ecl_irf_wen_w), // Templated
             .ecl_irf_wen_w2  (`REGPATH1.ecl_irf_wen_w2), // Templated
             .byp_irf_rd_data_w (`REGPATH1.byp_irf_rd_data_w[71:0]), // Templated
             .byp_irf_rd_data_w2  (`REGPATH1.byp_irf_rd_data_w2[71:0]), // Templated
             .thr_rd_w    (`REGPATH1.thr_rd_w[4:0]), // Templated
             .thr_rd_w2   (`REGPATH1.thr_rd_w2[4:0]), // Templated
             .ecl_irf_tid_w (`REGPATH1.ecl_irf_tid_w[1:0]), // Templated
             .ecl_irf_tid_w2  (`REGPATH1.ecl_irf_tid_w2[1:0]), // Templated
`ifndef RTL_SPU
             .ifu_tlu_thrid_w (`SPCPATH1.ifu.ifu.fcl.sas_thrid_w[1:0]), // Templated
`else
             .ifu_tlu_thrid_w (`SPCPATH1.ifu.fcl.sas_thrid_w[1:0]), // Templated
`endif
             .wen_thr0_l    (`CCRPATH1.wen_thr0_l),  // Templated
             .wen_thr1_l    (`CCRPATH1.wen_thr1_l),  // Templated
             .wen_thr2_l    (`CCRPATH1.wen_thr2_l),  // Templated
             .wen_thr3_l    (`CCRPATH1.wen_thr3_l),  // Templated
             .ccrin_thr0    (`CCRPATH1.ccrin_thr0[7:0]), // Templated
             .ccrin_thr1    (`CCRPATH1.ccrin_thr1[7:0]), // Templated
             .ccrin_thr2    (`CCRPATH1.ccrin_thr2[7:0]), // Templated
             .ccrin_thr3    (`CCRPATH1.ccrin_thr3[7:0]), // Templated
             .cwp_thr0_next (`EXUPATH1.rml.cwp.cwp_thr0_next), // Templated
             .cwp_thr1_next (`EXUPATH1.rml.cwp.cwp_thr1_next), // Templated
             .cwp_thr2_next (`EXUPATH1.rml.cwp.cwp_thr2_next), // Templated
             .cwp_thr3_next (`EXUPATH1.rml.cwp.cwp_thr3_next), // Templated
             .cwp_wen_l   (`EXUPATH1.rml.cwp.cwp_wen_l[3:0]), // Templated
             .next_cansave_w  (`EXUPATH1.rml.next_cansave_w[2:0]), // Templated
             .cansave_wen_w (`EXUPATH1.rml.cansave_wen_w), // Templated
             .next_canrestore_w (`EXUPATH1.rml.next_canrestore_w[2:0]), // Templated
             .canrestore_wen_w  (`EXUPATH1.rml.canrestore_wen_w), // Templated
             .next_otherwin_w (`EXUPATH1.rml.next_otherwin_w[2:0]), // Templated
             .otherwin_wen_w  (`EXUPATH1.rml.otherwin_wen_w), // Templated
             .tl_exu_tlu_wsr_data_w(`EXUPATH1.rml.exu_tlu_wsr_data_w[5:0]), // Templated
             .ecl_rml_wstate_wen_w(`EXUPATH1.rml.wstate_wen_w), // Templated
             .next_cleanwin_w (`EXUPATH1.rml.next_cleanwin_w[2:0]), // Templated
             .cleanwin_wen_w  (`EXUPATH1.rml.cleanwin_wen_w), // Templated
             .next_yreg_thr0  (`EXUPATH1.div.yreg.next_yreg_thr0[31:0]), // Templated
             .next_yreg_thr1  (`EXUPATH1.div.yreg.next_yreg_thr1[31:0]), // Templated
             .next_yreg_thr2  (`EXUPATH1.div.yreg.next_yreg_thr2[31:0]), // Templated
             .next_yreg_thr3  (`EXUPATH1.div.yreg.next_yreg_thr3[31:0]), // Templated
             .ecl_div_yreg_wen_l  (`EXUPATH1.ecl_div_yreg_wen_l[3:0]), // Templated
             .ifu_tlu_wsr_inst_d  (`EXUPATH1.ifu_tlu_wsr_inst_d), // Templated
             .ifu_tlu_sraddr_d  (`EXUPATH1.ifu_tlu_sraddr_d[3:0]), // Templated
             .inst_done_w_for_sas (`PC_CMP.spc1_inst_done), // Templated
`ifndef RTL_SPU
             .ifu_tlu_pc_w  (`SPCPATH1.ifu.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH1.ifu.ifu.fdp.npc_w[47:0]), // Templated
`else
             .ifu_tlu_pc_w  (`SPCPATH1.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH1.ifu.fdp.npc_w[47:0]), // Templated
`endif
             .tl0_en    (`TLPATH1.tl0_en),   // Templated
             .tl1_en    (`TLPATH1.tl1_en),   // Templated
             .tl2_en    (`TLPATH1.tl2_en),   // Templated
             .tl3_en    (`TLPATH1.tl3_en),   // Templated
             .trp_lvl0_new  (`TLPATH1.trp_lvl0_new[2:0]), // Templated
             .trp_lvl1_new  (`TLPATH1.trp_lvl1_new[2:0]), // Templated
             .trp_lvl2_new  (`TLPATH1.trp_lvl2_new[2:0]), // Templated
             .trp_lvl3_new  (`TLPATH1.trp_lvl3_new[2:0]), // Templated
             .update_pstate0_w2 (`TLPATH1.update_pstate_w2[0]), // Templated
             .update_pstate1_w2 (`TLPATH1.update_pstate_w2[1]), // Templated
             .update_pstate2_w2 (`TLPATH1.update_pstate_w2[2]), // Templated
             .update_pstate3_w2 (`TLPATH1.update_pstate_w2[3]), // Templated
             .pstate_priv_update_w2(`TDPPATH1.pstate_priv_update_w2), // Templated
             .hpstate_priv_update_w2(`TDPPATH1.hpstate_priv_update_w2), // Templated
             .restore_pstate0 (`TDPPATH1.restore_pstate0), // Templated
             .restore_pstate1 (`TDPPATH1.restore_pstate1), // Templated
             .restore_pstate2 (`TDPPATH1.restore_pstate2), // Templated
             .restore_pstate3 (`TDPPATH1.restore_pstate3), // Templated
             .tick0_en    (`TLPATH1.tick_en[0]),   // Templated
             .tick1_en    (`TLPATH1.tick_en[1]),   // Templated
             .tick2_en    (`TLPATH1.tick_en[2]),   // Templated
             .tick3_en    (`TLPATH1.tick_en[3]),   // Templated
             .exu_tlu_wsr_data_w  (`TDPPATH1.tlu_wsr_data_w[63:0]), // Templated
             .tba0_en   (`TLPATH1.tlu_tba_en_l[0]), // Templated
             .tba1_en   (`TLPATH1.tlu_tba_en_l[1]), // Templated
             .tba2_en   (`TLPATH1.tlu_tba_en_l[2]), // Templated
             .tba3_en   (`TLPATH1.tlu_tba_en_l[3]), // Templated
             .tsa_wr_vld    (`TLPATH1.tsa_wr_vld[1:0]), // Templated
             .tsa_pc_en   (`TLPATH1.tsa_pc_en),  // Templated
             .tsa_npc_en    (`TLPATH1.tsa_npc_en),   // Templated
             .tsa_tstate_en (`TLPATH1.tsa_tstate_en), // Templated
             .tsa_ttype_en  (`TLPATH1.tsa_ttype_en), // Templated
             .tsa_wr_tid    (`TLPATH1.tsa_wr_tid[1:0]), // Templated
             .tsa_wr_tpl    (`TLPATH1.tsa_wr_tpl[2:0]), // Templated
             // .temp_tlvl0    (`TS0PATH1.temp_tlvl),   // Templated
             .temp_tlvl0    (),   // Templated
             .tsa0_wdata    (`TS0PATH1.din),   // Templated
             .write_mask0   (`TS0PATH1.write_mask),  // Templated
             //.temp_tlvl1    (`TS1PATH1.temp_tlvl),   // Templated
             .temp_tlvl1    (),   // Templated
             .tsa1_wdata    (`TS1PATH1.din),   // Templated
             .write_mask1   (`TS1PATH1.write_mask),  // Templated
             .cpu_id    (10'd1),       // Templated
             .next_t0_inrr_i1 (`INTPATH1.next_t0_inrr_i1[63:0]), // Templated
             .next_t1_inrr_i1 (`INTPATH1.next_t1_inrr_i1[63:0]), // Templated
             .next_t2_inrr_i1 (`INTPATH1.next_t2_inrr_i1[63:0]), // Templated
             .next_t3_inrr_i1 (`INTPATH1.next_t3_inrr_i1[63:0]), // Templated
             .ifu_lsu_st_inst_e (`SPCPATH1.ifu_lsu_st_inst_e), // Templated
             .ifu_lsu_ld_inst_e (`SPCPATH1.ifu_lsu_ld_inst_e), // Templated
             .ifu_lsu_alt_space_e (`PCXPATH1.ifu_lsu_alt_space_e), // Templated
             .ifu_lsu_ldst_fp_e (`PCXPATH1.ifu_lsu_ldst_fp_e), // Templated
             .ifu_lsu_ldst_dbl_e  (`PCXPATH1.ifu_lsu_ldst_dbl_e), // Templated
             .lsu_ffu_blk_asi_e (`PCXPATH1.lsu_ffu_blk_asi_e), // Templated
             .ifu_tlu_inst_vld_m  (`PCXPATH1.ifu_tlu_inst_vld_m), // Templated
             .ifu_lsu_swap_e  (`SPCPATH1.ifu_lsu_swap_e), // Templated
             .ifu_tlu_thrid_e (`SPCPATH1.ifu_tlu_thrid_e[1:0]), // Templated
             .asi_wr_din    (`ASIDPPATH1.asi_wr_din), // Templated
             .asi_state_wr_thrd (`ASIDPPATH1.asi_state_wr_thrd[3:0]), // Templated
             .pil     (`TLPATH1.tlu_wsr_data_w[3:0]), // Templated
             .pil0_en   (`TLPATH1.pil0_en),  // Templated
             .pil1_en   (`TLPATH1.pil1_en),  // Templated
             .pil2_en   (`TLPATH1.pil2_en),  // Templated
             .pil3_en   (`TLPATH1.pil3_en),  // Templated
             .dp_frf_data   (`FLOATPATH1.dp_frf_data[70:0]), // Templated
             .ctl_frf_addr  (`FLOATPATH1.ctl_frf_addr[6:0]), // Templated
             .ctl_frf_wen   (`FLOATPATH1.ctl_frf_wen[1:0]), // Templated
             .regfile_index (`FLOATPATH1.frf.regfile_index[7:0]), // Templated
             .ifu_exu_rs1_s (`EXUPATH1.ifu_exu_rs1_s[4:0]), // Templated
             .ifu_exu_rs2_s (`EXUPATH1.ifu_exu_rs2_s[4:0]), // Templated
             .byp_alu_rs1_data_e  (`EXUPATH1.byp_alu_rs1_data_e[63:0]), // Templated
             .byp_alu_rs2_data_e  (`EXUPATH1.byp_alu_rs2_data_e[63:0]), // Templated
             .ifu_lsu_imm_asi_d (`SPCPATH1.ifu_lsu_imm_asi_d[7:0]), // Templated
             .ifu_lsu_imm_asi_vld_d(`SPCPATH1.ifu_lsu_imm_asi_vld_d), // Templated
             .ifu_tlu_itlb_done (`SPCPATH1.ifu_tlu_itlb_done), // Templated
             .tlu_itlb_wr_vld_g (`SPCPATH1.tlu_itlb_wr_vld_g), // Templated
             .tlu_itlb_dmp_vld_g  (`SPCPATH1.tlu_itlb_dmp_vld_g), // Templated
             .lsu_tlu_dtlb_done (`SPCPATH1.lsu_tlu_dtlb_done), // Templated
             .tlu_dtlb_wr_vld_g (`TLUPATH1.mmu_ctl.pre_dtlb_wr_vld_g), // Templated
             .tlu_dtlb_dmp_vld_g  (`SPCPATH1.tlu_dtlb_dmp_vld_g), // Templated
             .tlu_idtlb_dmp_thrid_g(`SPCPATH1.tlu_idtlb_dmp_thrid_g[1:0]), // Templated
             .inst_vld_qual_e (`INSTPATH1.inst_vld_qual_e), // Templated
             .t0_inrr_i2    (`TLUPATH1.intdp.t0_inrr_i2[63:0]), // Templated
             .t1_inrr_i2    (`TLUPATH1.intdp.t1_inrr_i2[63:0]), // Templated
             .t2_inrr_i2    (`TLUPATH1.intdp.t2_inrr_i2[63:0]), // Templated
             .t3_inrr_i2    (`TLUPATH1.intdp.t3_inrr_i2[63:0]), // Templated
             .t0_indr   (`TLUPATH1.intdp.t0_indr[10:0]), // Templated
             .t1_indr   (`TLUPATH1.intdp.t1_indr[10:0]), // Templated
             .t2_indr   (`TLUPATH1.intdp.t2_indr[10:0]), // Templated
             .t3_indr   (`TLUPATH1.intdp.t3_indr[10:0]), // Templated
             .ttype_sel_hstk_cmp_e(`INSTPATH1.ttype_sel_hstk_cmp_e), // Templated
             .ifu_tlu_ttype_vld_m (`INSTPATH1.ifu_tlu_ttype_vld_m)); // Templated
`endif // ifdef RTL_SPARC1



 `ifdef RTL_SPARC2
sas_task task2 (/*AUTOINST*/
             // Inputs
             .tlu_pich_wrap_flg_m (`TLUPATH2.tcl.tlu_pich_wrap_flg_m), // Templated
             .tlu_pic_cnt_en_m  (`TLUPATH2.tcl.tlu_pic_cnt_en_m), // Templated
             .final_ttype_sel_g (`TLUPATH2.tcl.final_ttype_sel_g), // Templated
             .rst_ttype_w2  (`TLUPATH2.tcl.rst_ttype_w2), // Templated
             .sync_trap_taken_m (`TLUPATH2.tcl.sync_trap_taken_m), // Templated
             .pib_picl_wrap (`TLUPATH2.pib_picl_wrap), // Templated
             .pib_pich_wrap_m (`TLUPATH2.tcl.pib_pich_wrap_m), // Templated
             .pib_pich_wrap (`TLUPATH2.pib_pich_wrap), // Templated
             .pic_wrap_trap_g (`TLUPATH2.tcl.pib_wrap_trap_g), // Templated
             .pib_wrap_trap_m (`TLUPATH2.tcl.pib_wrap_trap_m), // Templated
             .pcr_rw_e    (`TLUPATH2.tlu_pib.pcr_rw_e), // Templated
             .tlu_rsr_inst_e  (`TLUPATH2.tlu_pib.tlu_rsr_inst_e), // Templated
             .pcr0    (`TLUPATH2.tlu_pib.pcr0), // Templated
             .pcr1    (`TLUPATH2.tlu_pib.pcr1), // Templated
             .pcr2    (`TLUPATH2.tlu_pib.pcr2), // Templated
             .pcr3    (`TLUPATH2.tlu_pib.pcr3), // Templated
             .wsr_pcr_sel   (`TLUPATH2.tlu_pib.wsr_pcr_sel), // Templated
             .pich_cnt0   (`TLUPATH2.tlu_pib.pich_cnt0), // Templated
             .pich_cnt1   (`TLUPATH2.tlu_pib.pich_cnt1), // Templated
             .pich_cnt2   (`TLUPATH2.tlu_pib.pich_cnt2), // Templated
             .pich_cnt3   (`TLUPATH2.tlu_pib.pich_cnt3), // Templated
             .picl_cnt0   (`TLUPATH2.tlu_pib.picl_cnt0), // Templated
             .picl_cnt1   (`TLUPATH2.tlu_pib.picl_cnt1), // Templated
             .picl_cnt2   (`TLUPATH2.tlu_pib.picl_cnt2), // Templated
             .picl_cnt3   (`TLUPATH2.tlu_pib.picl_cnt3), // Templated
             .update_pich_sel (`TLUPATH2.tlu_pib.update_pich_sel), // Templated
             .update_picl_sel (`TLUPATH2.tlu_pib.update_picl_sel), // Templated
`ifndef RTL_SPU
             .const_maskid  (`PCXPATH2.ifu.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH2.ifu.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH2.ifu.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH2.ifu.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH2.ifu.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH2.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH2.ifu.ifu.errdp.formatted_tte_data), // Templated
`else
             .const_maskid  (`PCXPATH2.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH2.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH2.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH2.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH2.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH2.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH2.ifu.errdp.formatted_tte_data), // Templated
`endif
             .dformatted_tte_data (`SPARC_CORE0.`LSU_PATH.tlbdp.formatted_tte_data), // Templated
             .dtlb_cam_vld  (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_cam_vld), // Templated
             .dtlb_tte_vld_g  (`SPARC_CORE0.`LSU_PATH.excpctl.tlb_tte_vld_g), // Templated
             .tlu_hpstate_priv  (`PCXPATH2.tlu_hpstate_priv), // Templated
             .tlu_hpstate_enb (`PCXPATH2.tlu_hpstate_enb), // Templated
`ifndef RTL_SPU
             .fcl_dtu_inst_vld_d  (`PCXPATH2.ifu.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH2.ifu.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH2.ifu.ifu.fcl.xlate_en), // Templated
`else
             .fcl_dtu_inst_vld_d  (`PCXPATH2.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH2.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH2.ifu.fcl.xlate_en), // Templated
`endif
             .ifu_lsu_thrid_s (`PCXPATH2.ifu_lsu_thrid_s), // Templated
             .fcl_ifq_icmiss_s1 (`IFUPATH2.fcl.fcl_ifq_icmiss_s1), // Templated
             .tlu_exu_early_flush_pipe_w(`PCXPATH2.tlu_exu_early_flush_pipe_w), // Templated
             .rst_hwint_ttype_g (`TLUPATH2.tcl.rst_hwint_ttype_g), // Templated
             .trap_taken_g  (`TLUPATH2.tcl.trap_taken_g), // Templated
`ifndef RTL_SPU
             .spu_lsu_ldxa_illgl_va_w2(1'b0), // Templated
             .spu_lsu_ldxa_data_vld_w2(1'b0), // Templated
             .spu_lsu_ldxa_tid_w2 (2'b0), // Templated
`else
             .spu_lsu_ldxa_illgl_va_w2(`PCXPATH2.spu.spu_ctl.spu_lsu_ldxa_illgl_va_w2), // Templated
             .spu_lsu_ldxa_data_vld_w2(`PCXPATH2.spu.spu_ctl.spu_lsu_ldxa_data_vld_w2), // Templated
             .spu_lsu_ldxa_tid_w2 (`PCXPATH2.spu.spu_ctl.spu_lsu_ldxa_tid_w2), // Templated
`endif
             .mra_field1_en (`TLUPATH2.mmu_ctl.mra_field1_en), // Templated
             .mra_field2_en (`TLUPATH2.mmu_ctl.mra_field2_en), // Templated
             .mra_field3_en (`TLUPATH2.mmu_ctl.mra_field3_en), // Templated
             .mra_field4_en (`TLUPATH2.mmu_ctl.mra_field4_en), // Templated
             .pmem_unc_error_g  (`SPARC_CORE0.`LSU_PATH.dctl.pmem_unc_error_g), // Templated
`ifndef RTL_SPU
             .pc_f    (`PCXPATH2.ifu.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH2.ifu.ifu.fcl.cam_vld_f), // Templated
`else
             .pc_f    (`PCXPATH2.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH2.ifu.fcl.cam_vld_f), // Templated
`endif
             .cam_vld   (`SPARC_CORE0.`LSU_PATH.dtlb.cam_vld), // Templated
             .defr_trp_taken_m_din(`SPARC_CORE0.`LSU_PATH.excpctl.defr_trp_taken_m_din), // Templated
             .illgl_va_vld_or_drop_ldxa2masync(1'b0), // Templated
`ifndef RTL_SPU
             .ecc_wen   (`PCXPATH2.ffu.ffu.ctl.ecc_wen), // Templated
`else
             .ecc_wen   (`PCXPATH2.ffu.ctl.ecc_wen), // Templated
`endif
             .fpdis_trap_e  (`IFUPATH2.dec.fpdis_trap_e), // Templated
             .ceen    (`IFUPATH2.errctl.ceen), // Templated
             .nceen   (`IFUPATH2.errctl.nceen), // Templated
             .ifu_tlu_flush_m (`TLUPATH2.ifu_tlu_flush_m), // Templated
             .lsu_tlu_ttype_m2  (`TLUPATH2.lsu_tlu_ttype_m2), // Templated
             .lsu_tlu_ttype_vld_m2(`TLUPATH2.lsu_tlu_ttype_vld_m2), // Templated
             .tlu_final_ttype_w2  (`TLUPATH2.tlu_final_ttype_w2), // Templated
             .tlu_ifu_trappc_vld_w1(`TLUPATH2.tlu_ifu_trappc_vld_w1), // Templated
             .mra_wr_ptr    (`TLUPATH2.mra_wr_ptr),  // Templated
             .mra_wr_vld    (`TLUPATH2.mra_wr_vld),  // Templated
             .lsu_pid_state0  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state0), // Templated
             .lsu_pid_state1  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state1), // Templated
             .lsu_pid_state2  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state2), // Templated
             .lsu_pid_state3  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state3), // Templated
             .pid_state_wr_en (`SPARC_CORE0.`LSU_PATH.pid_state_wr_en), // Templated
             .lsu_t0_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t0_pctxt_state), // Templated
             .lsu_t1_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t1_pctxt_state), // Templated
             .lsu_t2_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t2_pctxt_state), // Templated
             .lsu_t3_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t3_pctxt_state), // Templated
             .pctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.pctxt_state_wr_thrd), // Templated
             .sctxt_state0  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state0), // Templated
             .sctxt_state1  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state1), // Templated
             .sctxt_state2  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state2), // Templated
             .sctxt_state3  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state3), // Templated
             .sctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state_wr_thrd), // Templated
             .va_wtchpt0_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt0_addr), // Templated
             .va_wtchpt1_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt1_addr), // Templated
             .va_wtchpt2_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt2_addr), // Templated
             .va_wtchpt3_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt3_addr), // Templated
             .lsu_va_wtchpt0_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt0_wr_en_l), // Templated
             .lsu_va_wtchpt1_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt1_wr_en_l), // Templated
             .lsu_va_wtchpt2_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt2_wr_en_l), // Templated
             .lsu_va_wtchpt3_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt3_wr_en_l), // Templated
             .ifu_rstint_m  (`TLPATH2.ifu_rstint_m), // Templated
`ifndef RTL_SPU
             .spu_tlu_rsrv_illgl_m(`PCXPATH2.tlu.tlu.spu_tlu_rsrv_illgl_m), // Templated
`else
             .spu_tlu_rsrv_illgl_m(`PCXPATH2.tlu.spu_tlu_rsrv_illgl_m), // Templated
`endif
             .cam_vld_s1    (`IFUPATH2.fcl.cam_vld_s1), // Templated
             .val_thr_s1    (`IFUPATH2.fcl.val_thr_s1), // Templated
             .pc_s    (`IFUPATH2.fdp.pc_s),  // Templated
`ifndef RTL_SPU
             .rs2_fst_ue_w3 (`PCXPATH2.ffu.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH2.ffu.ffu.ctl.rs2_fst_ce_w3), // Templated
`else
             .rs2_fst_ue_w3 (`PCXPATH2.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH2.ffu.ctl.rs2_fst_ce_w3), // Templated
`endif
             .lsu_tlu_async_ttype_vld_w2(`PCXPATH2.lsu_tlu_async_ttype_vld_w2), // Templated
             .lsu_tlu_defr_trp_taken_g(`PCXPATH2.lsu_tlu_defr_trp_taken_g), // Templated
             .lsu_tlu_async_ttype_w2(`PCXPATH2.lsu_tlu_async_ttype_w2), // Templated
             .lsu_tlu_async_tid_w2(`PCXPATH2.lsu_tlu_async_tid_w2), // Templated
`ifndef RTL_SPU
             .itlb_rw_index (`PCXPATH2.ifu.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH2.ifu.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH2.ifu.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH2.ifu.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH2.ifu.ifu.itlb.cam_hit}), // Templated
`else
             .itlb_rw_index (`PCXPATH2.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH2.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH2.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH2.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH2.ifu.itlb.cam_hit}), // Templated
`endif
             .dtlb_rw_index (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index), // Templated
             .dtlb_rw_index_vld (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index_vld), // Templated
             .dtlb_rd_tte_tag (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rd_tte_tag), // Templated
             .dtlb_rd_tte_data  (`SPARC_CORE0.`LSU_PATH.dtlb.rd_tte_data), // Templated
             .dcam_hit    ({48'b0,`SPARC_CORE0.`LSU_PATH.dtlb.cam_hit}), // Templated
             .wrt_spec_w    (`IFUPATH2.swl.wrt_spec_w), // Templated
             .spc_pcx_data_pa (124'b0), // Templated //tttttttttttttt
             .fcl_fdp_inst_sel_nop_s_l(`IFUPATH2.fdp.fcl_fdp_inst_sel_nop_s_l), // Templated
             .retract_iferr_d (`IFUPATH2.swl.retract_iferr_d), // Templated
             .inst_vld_w    (`INSTPATH2.inst_vld_w), // Templated
             .dmmu_async_illgl_va_g(`TLUPATH2.mmu_ctl.dmmu_async_illgl_va_g), // Templated
             .immu_async_illgl_va_g(`TLUPATH2.mmu_ctl.immu_async_illgl_va_g), // Templated
             .lsu_tlu_tlb_ld_inst_m(`TLUPATH2.mmu_ctl.lsu_tlu_tlb_ld_inst_m), // Templated
             .lsu_tlu_tlb_st_inst_m(`TLUPATH2.mmu_ctl.lsu_tlu_tlb_st_inst_m), // Templated
             .immu_sfsr_wr_en_l (`TLUPATH2.immu_sfsr_wr_en_l), // Templated
             .dmmu_sfsr_wr_en_l (`TLUPATH2.dmmu_sfsr_wr_en_l), // Templated
             .dmmu_sfar_wr_en_l (`TLUPATH2.dmmu_sfar_wr_en_l), // Templated
             .lsu_quad_asi_e  (`SPARC_CORE0.`LSU_PATH.lsu_quad_asi_e), // Templated
             .clk     (clk),       // Templated
             .rst_l   (rst_l),     // Templated
             .back    (`PC_CMP.back_thread[3*4-1:2*4]), // Templated
             .lsu_ifu_ldsta_internal_e(`IFUPATH2.lsu_ifu_ldsta_internal_e), // Templated
             .lsu_mmu_flush_pipe_w(`TLUPATH2.lsu_mmu_flush_pipe_w), // Templated
             .dtlb_wr_vld   (`DTLBPATH2.tlb_wr_vld), // Templated
             .dtlb_demap    (`DTLBPATH2.tlb_demap),  // Templated
             .dtlb_rd_tag_vld (`DTLBPATH2.tlb_rd_tag_vld), // Templated
             .dtlb_rd_data_vld  (`DTLBPATH2.tlb_rd_data_vld), // Templated
             .dtlb_entry_vld  ({48'd0,`DTLBPATH2.tlb_entry_vld}), // Templated
             .itlb_wr_vld   (`ITLBPATH2.tlb_wr_vld), // Templated
             .itlb_demap    (`ITLBPATH2.tlb_demap),  // Templated
             .itlb_rd_tag_vld (`ITLBPATH2.tlb_rd_tag_vld), // Templated
             .itlb_rd_data_vld  (`ITLBPATH2.tlb_rd_data_vld), // Templated
             .itlb_entry_vld  ({48'd0,`ITLBPATH2.tlb_entry_vld}), // Templated
             .tlb_access_tid_g  (`TLUPATH2.mmu_ctl.tlb_access_tid_g), // Templated
             .dsfar0_clk    (`TLUPATH2.mmu_dp.dsfar0_clk), // Templated
             .dsfar1_clk    (`TLUPATH2.mmu_dp.dsfar1_clk), // Templated
             .dsfar2_clk    (`TLUPATH2.mmu_dp.dsfar2_clk), // Templated
             .dsfar3_clk    (`TLUPATH2.mmu_dp.dsfar3_clk), // Templated
             .dsfar_din   (`TLUPATH2.mmu_dp.dsfar_din), // Templated
             .dtu_inst_d    (`IFUPATH2.dec.dtu_inst_d), // Templated
             .local_rdpr_mx1_sel  (`TLPATH2.local_rdpr_mx1_sel), // Templated
             .tlu_rdpr_mx5_sel  (`TLPATH2.tlu_rdpr_mx5_sel), // Templated
             .tlu_rdpr_mx7_sel  (`TLPATH2.tlu_rdpr_mx7_sel), // Templated
             .tlu_rst_l   (`TLPATH2.tlu_rst_l),  // Templated
             .tick_match    (`TDPPATH2.tick_match),  // Templated
             .tlu_wr_sftint_l_g (`TLUPATH2.tlu_wr_sftint_l_g), // Templated
             .dsfsr_din   (`TLUPATH2.mmu_dp.dsfsr_din), // Templated
             .dsfsr0_clk    (`TLUPATH2.mmu_dp.dsfsr0_clk), // Templated
             .dsfsr1_clk    (`TLUPATH2.mmu_dp.dsfsr1_clk), // Templated
             .dsfsr2_clk    (`TLUPATH2.mmu_dp.dsfsr2_clk), // Templated
             .dsfsr3_clk    (`TLUPATH2.mmu_dp.dsfsr3_clk), // Templated
             .isfsr_din   (`TLUPATH2.mmu_dp.isfsr_din), // Templated
             .isfsr0_clk    (`TLUPATH2.mmu_dp.isfsr0_clk), // Templated
             .isfsr1_clk    (`TLUPATH2.mmu_dp.isfsr1_clk), // Templated
             .isfsr2_clk    (`TLUPATH2.mmu_dp.isfsr2_clk), // Templated
             .isfsr3_clk    (`TLUPATH2.mmu_dp.isfsr3_clk), // Templated
             .ecl_byp_sel_ecc_w (`IFUPATH2.errctl.irf_ce_unq), // Templated
             .ifu_exu_inst_w  (`INSTPATH2.ifu_exu_inst_vld_w), // Templated
             .ctl_dp_fp_thr (`FLOATPATH2.ctl_dp_fp_thr), // Templated
             .ifu_ffu_fst_d (`FLOATPATH2.ifu_ffu_fst_d), // Templated
             .pc_e    (`DTUPATH2.pc_e),  // Templated
             .fcl_dtu_inst_vld_e  (`INSTPATH2.fcl_dtu_inst_vld_e), // Templated
             .exu_lsu_rs3_data_e  (`PCXPATH2.exu_lsu_rs3_data_e), // Templated
             .tick_ctl_din  (`TLPATH2.tick_ctl_din), // Templated
             .ifu_tlu_ttype_m (`PCXPATH2.ifu_tlu_ttype_m), // Templated
             .tlu_rerr_vld  (`PCXPATH2.tlu_rerr_vld), // Templated
             .sftint0   (`TDPPATH2.sftint0),   // Templated
             .sftint1   (`TDPPATH2.sftint1),   // Templated
             .sftint2   (`TDPPATH2.sftint2),   // Templated
             .sftint3   (`TDPPATH2.sftint3),   // Templated
             .sftint0_clk   (`TDPPATH2.sftint0_clk), // Templated
             .sftint1_clk   (`TDPPATH2.sftint1_clk), // Templated
             .sftint2_clk   (`TDPPATH2.sftint2_clk), // Templated
             .sftint3_clk   (`TDPPATH2.sftint3_clk), // Templated
             .sftint_b0_en  (`TDPPATH2.sftint_b0_en), // Templated
             .sftint_b15_en (`TDPPATH2.sftint_b15_en), // Templated
             .sftint_b16_en (`TDPPATH2.sftint_b16_en), // Templated
             .cpx_spc_data_cx2  (`PCXPATH2.cpx_spc_data_cx2), // Templated
             .ifu_exu_save_d  (`PCXPATH2.ifu_exu_save_d), // Templated
             .ifu_exu_restore_d (`PCXPATH2.ifu_exu_restore_d), // Templated
             .ifu_tlu_thrid_d (`PCXPATH2.ifu_tlu_thrid_d), // Templated
             .tlu_ifu_hwint_i3  (`TLUPATH2.tlu_ifu_hwint_i3), // Templated
             .ifu_tlu_hwint_m (`TLUPATH2.ifu_tlu_hwint_m), // Templated
             .ifu_tlu_rstint_m  (`TLUPATH2.ifu_tlu_rstint_m), // Templated
             .ifu_tlu_swint_m (`TLUPATH2.ifu_tlu_swint_m), // Templated
             .tlu_ifu_flush_pipe_w(`TLPATH2.tlu_ifu_flush_pipe_w), // Templated
             .ifu_tlu_flush_w (`PCXPATH2.ifu_tlu_flush_w), // Templated
             .ffu_ifu_fst_ce_w  (`PCXPATH2.ffu_ifu_fst_ce_w), // Templated
`ifndef RTL_SPU
             .ffu_ifu_ecc_ue_w2 (`PCXPATH2.ffu.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH2.ffu.ffu.ffu_ifu_ecc_ce_w2), // Templated
`else
             .ffu_ifu_ecc_ue_w2 (`PCXPATH2.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH2.ffu.ffu_ifu_ecc_ce_w2), // Templated
`endif
             .any_err_vld   (`IFUPATH2.errctl.any_err_vld), // Templated
             .any_ue_vld    (`IFUPATH2.errctl.any_ue_vld), // Templated
             .tsa_htstate_en  (`TLPATH2.tsa_htstate_en), // Templated
             .stickcmp_intdis_en  (`TDPPATH2.stickcmp_intdis_en), // Templated
             .tick_npt0   (`TLPATH2.tick_npt0),  // Templated
             .tick_npt1   (`TLPATH2.tick_npt1),  // Templated
             .tick_npt2   (`TLPATH2.tick_npt2),  // Templated
             .tick_npt3   (`TLPATH2.tick_npt3),  // Templated
             .true_tick   (`TDPPATH2.true_tick),   // Templated
             .htick_intdis0 (`TLU_HYPER0.htick_intdis0), // Templated
             .htick_intdis1 (`TLU_HYPER0.htick_intdis1), // Templated
             .htick_intdis2 (`TLU_HYPER0.htick_intdis2), // Templated
             .htick_intdis3 (`TLU_HYPER0.htick_intdis3), // Templated
             .true_stickcmp0  (`TDPPATH2.true_stickcmp0), // Templated
             .true_stickcmp1  (`TDPPATH2.true_stickcmp1), // Templated
             .true_stickcmp2  (`TDPPATH2.true_stickcmp2), // Templated
             .true_stickcmp3  (`TDPPATH2.true_stickcmp3), // Templated
             .tlu_hintp_en_l_g  (`TDPPATH2.tlu_hintp_en_l_g), // Templated
             .tlu_hintp   (`TDPPATH2.tlu_hintp),   // Templated
             .tlu_htba_en_l (`TDPPATH2.tlu_htba_en_l), // Templated
             .true_htba0    (`TDPPATH2.true_htba0),  // Templated
             .true_htba1    (`TDPPATH2.true_htba1),  // Templated
             .true_htba2    (`TDPPATH2.true_htba2),  // Templated
             .true_htba3    (`TDPPATH2.true_htba3),  // Templated
             .update_hpstate_l_w2 (`TDPPATH2.tlu_update_hpstate_l_w2[3:0]), // Templated
             .restore_hpstate0  (`TDPPATH2.restore_hpstate0), // Templated
             .restore_hpstate1  (`TDPPATH2.restore_hpstate1), // Templated
             .restore_hpstate2  (`TDPPATH2.restore_hpstate2), // Templated
             .restore_hpstate3  (`TDPPATH2.restore_hpstate3), // Templated
             .htickcmp_intdis_en  (`TLU_HYPER0.htickcmp_intdis_en), // Templated
             .true_htickcmp0  (`TDPPATH2.true_htickcmp0), // Templated
             .true_htickcmp1  (`TDPPATH2.true_htickcmp1), // Templated
             .true_htickcmp2  (`TDPPATH2.true_htickcmp2), // Templated
             .true_htickcmp3  (`TDPPATH2.true_htickcmp3), // Templated
             .gl0_en    (`TLU_HYPER0.gl0_en),  // Templated
             .gl1_en    (`TLU_HYPER0.gl1_en),  // Templated
             .gl2_en    (`TLU_HYPER0.gl2_en),  // Templated
             .gl3_en    (`TLU_HYPER0.gl3_en),  // Templated
             .gl_lvl0_new   (`TLU_HYPER0.gl_lvl0_new), // Templated
             .gl_lvl1_new   (`TLU_HYPER0.gl_lvl1_new), // Templated
             .gl_lvl2_new   (`TLU_HYPER0.gl_lvl2_new), // Templated
             .gl_lvl3_new   (`TLU_HYPER0.gl_lvl3_new), // Templated
             .t0_gsr_nxt    (`FFUPATH2.dp.t0_gsr_nxt), // Templated
             .t0_gsr_rnd_next (`FFUPATH2.ctl.visctl.t0_gsr_rnd_next), // Templated
             .t0_gsr_align_next (`FFUPATH2.ctl.visctl.t0_gsr_align_next), // Templated
             .t0_gsr_wsr_w  (`FFUPATH2.ctl.visctl.t0_gsr_wsr_w2), // Templated
             .t0_siam_w   (`FFUPATH2.ctl.visctl.t0_siam_w2), // Templated
             .t0_alignaddr_w  (`FFUPATH2.ctl.visctl.t0_alignaddr_w2), // Templated
             .t1_gsr_nxt    (`FFUPATH2.dp.t1_gsr_nxt), // Templated
             .t1_gsr_rnd_next (`FFUPATH2.ctl.visctl.t1_gsr_rnd_next), // Templated
             .t1_gsr_align_next (`FFUPATH2.ctl.visctl.t1_gsr_align_next), // Templated
             .t1_gsr_wsr_w  (`FFUPATH2.ctl.visctl.t1_gsr_wsr_w2), // Templated
             .t1_siam_w   (`FFUPATH2.ctl.visctl.t1_siam_w2), // Templated
             .t1_alignaddr_w  (`FFUPATH2.ctl.visctl.t1_alignaddr_w2), // Templated
             .t2_gsr_nxt    (`FFUPATH2.dp.t2_gsr_nxt), // Templated
             .t2_gsr_rnd_next (`FFUPATH2.ctl.visctl.t2_gsr_rnd_next), // Templated
             .t2_gsr_align_next (`FFUPATH2.ctl.visctl.t2_gsr_align_next), // Templated
             .t2_gsr_wsr_w  (`FFUPATH2.ctl.visctl.t2_gsr_wsr_w2), // Templated
             .t2_siam_w   (`FFUPATH2.ctl.visctl.t2_siam_w2), // Templated
             .t2_alignaddr_w  (`FFUPATH2.ctl.visctl.t2_alignaddr_w2), // Templated
             .t3_gsr_nxt    (`FFUPATH2.dp.t3_gsr_nxt), // Templated
             .t3_gsr_rnd_next (`FFUPATH2.ctl.visctl.t3_gsr_rnd_next), // Templated
             .t3_gsr_align_next (`FFUPATH2.ctl.visctl.t3_gsr_align_next), // Templated
             .t3_gsr_wsr_w  (`FFUPATH2.ctl.visctl.t3_gsr_wsr_w2), // Templated
             .t3_siam_w   (`FFUPATH2.ctl.visctl.t3_siam_w2), // Templated
             .t3_alignaddr_w  (`FFUPATH2.ctl.visctl.t3_alignaddr_w2), // Templated
             .exu_lsu_ldst_va_e (`ASIDPPATH2.exu_lsu_ldst_va_e[47:0]), // Templated
             .asi_state_e   (`ASIDPPATH2.asi_state_e[7:0]), // Templated
             .cpu_num   (cpu_num),     // Templated
             .good    (`PC_CMP.good[3*4-1:2*4]),   // Templated
             .active    (`PC_CMP.active_thread[3*4-1:2*4]), // Templated
             .finish    (`PC_CMP.finish_mask[3*4-1:2*4]), // Templated
             .lda_internal_e  (`ASIPATH2.lda_internal_e), // Templated
             .sta_internal_e  (`ASIPATH2.sta_internal_e), // Templated
             .ifu_spu_trap_ack  ({1'b0,`SPCPATH2.ifu_spu_trap_ack}), // Templated
             .ifu_exu_muls_d  (`SPCPATH2.ifu_exu_muls_d), // Templated
             .ifu_exu_tid_s2  (`EXUPATH2.ifu_exu_tid_s2[1:0]), // Templated
             .rml_irf_restore_local_m(`EXUPATH2.irf.irf.swap_local_w), // Templated
             .rml_irf_cwp_m (`EXUPATH2.irf.irf.old_lo_cwp_m[2:0]), // Templated
             .rml_irf_save_local_m(`EXUPATH2.irf.irf.swap_local_m), // Templated
             .rml_irf_thr_m (`EXUPATH2.irf.irf.cwpswap_tid_m[1:0]), // Templated
             .ifu_exu_save_e  (`EXUPATH2.rml.save_e),  // Templated
             .exu_tlu_spill_e (`EXUPATH2.rml.exu_tlu_spill_e), // Templated
             .t0_fsr_nxt    (`FLOATPATH2.dp.t0_fsr_nxt[27:0]), // Templated
             .t1_fsr_nxt    (`FLOATPATH2.dp.t1_fsr_nxt[27:0]), // Templated
             .t2_fsr_nxt    (`FLOATPATH2.dp.t2_fsr_nxt[27:0]), // Templated
             .t3_fsr_nxt    (`FLOATPATH2.dp.t3_fsr_nxt[27:0]), // Templated
             .ctl_dp_fsr_sel_old  (`FLOATPATH2.ctl_dp_fsr_sel_old[3:0]), // Templated
             .tlu_sftint_en_l_g (`TLUPATH2.tlu_sftint_en_l_g[3:0]), // Templated
             .true_tickcmp0 (`TDPPATH2.true_tickcmp0), // Templated
             .true_tickcmp1 (`TDPPATH2.true_tickcmp1), // Templated
             .true_tickcmp2 (`TDPPATH2.true_tickcmp2), // Templated
             .true_tickcmp3 (`TDPPATH2.true_tickcmp3), // Templated
             .tickcmp_intdis_en (`TDPPATH2.tickcmp_intdis_en[3:0]), // Templated
             .dtu_fdp_rdsr_sel_thr_e_l(`DTUPATH2.fcl_fdp_rdsr_sel_thr_e_l), // Templated
             .ifu_exu_rd_ifusr_e  (`EXUPATH2.ifu_exu_rd_ifusr_e), // Templated
             .ifu_exu_use_rsr_e_l (`EXUPATH2.ifu_exu_use_rsr_e_l), // Templated
             .rml_irf_global_tid  (`EXUPATH2.irf.irf.rml_irf_global_tid[1:0]), // Templated
             .ecl_irf_wen_w (`REGPATH2.ecl_irf_wen_w), // Templated
             .ecl_irf_wen_w2  (`REGPATH2.ecl_irf_wen_w2), // Templated
             .byp_irf_rd_data_w (`REGPATH2.byp_irf_rd_data_w[71:0]), // Templated
             .byp_irf_rd_data_w2  (`REGPATH2.byp_irf_rd_data_w2[71:0]), // Templated
             .thr_rd_w    (`REGPATH2.thr_rd_w[4:0]), // Templated
             .thr_rd_w2   (`REGPATH2.thr_rd_w2[4:0]), // Templated
             .ecl_irf_tid_w (`REGPATH2.ecl_irf_tid_w[1:0]), // Templated
             .ecl_irf_tid_w2  (`REGPATH2.ecl_irf_tid_w2[1:0]), // Templated
`ifndef RTL_SPU
             .ifu_tlu_thrid_w (`SPCPATH2.ifu.ifu.fcl.sas_thrid_w[1:0]), // Templated
`else
             .ifu_tlu_thrid_w (`SPCPATH2.ifu.fcl.sas_thrid_w[1:0]), // Templated
`endif
             .wen_thr0_l    (`CCRPATH2.wen_thr0_l),  // Templated
             .wen_thr1_l    (`CCRPATH2.wen_thr1_l),  // Templated
             .wen_thr2_l    (`CCRPATH2.wen_thr2_l),  // Templated
             .wen_thr3_l    (`CCRPATH2.wen_thr3_l),  // Templated
             .ccrin_thr0    (`CCRPATH2.ccrin_thr0[7:0]), // Templated
             .ccrin_thr1    (`CCRPATH2.ccrin_thr1[7:0]), // Templated
             .ccrin_thr2    (`CCRPATH2.ccrin_thr2[7:0]), // Templated
             .ccrin_thr3    (`CCRPATH2.ccrin_thr3[7:0]), // Templated
             .cwp_thr0_next (`EXUPATH2.rml.cwp.cwp_thr0_next), // Templated
             .cwp_thr1_next (`EXUPATH2.rml.cwp.cwp_thr1_next), // Templated
             .cwp_thr2_next (`EXUPATH2.rml.cwp.cwp_thr2_next), // Templated
             .cwp_thr3_next (`EXUPATH2.rml.cwp.cwp_thr3_next), // Templated
             .cwp_wen_l   (`EXUPATH2.rml.cwp.cwp_wen_l[3:0]), // Templated
             .next_cansave_w  (`EXUPATH2.rml.next_cansave_w[2:0]), // Templated
             .cansave_wen_w (`EXUPATH2.rml.cansave_wen_w), // Templated
             .next_canrestore_w (`EXUPATH2.rml.next_canrestore_w[2:0]), // Templated
             .canrestore_wen_w  (`EXUPATH2.rml.canrestore_wen_w), // Templated
             .next_otherwin_w (`EXUPATH2.rml.next_otherwin_w[2:0]), // Templated
             .otherwin_wen_w  (`EXUPATH2.rml.otherwin_wen_w), // Templated
             .tl_exu_tlu_wsr_data_w(`EXUPATH2.rml.exu_tlu_wsr_data_w[5:0]), // Templated
             .ecl_rml_wstate_wen_w(`EXUPATH2.rml.wstate_wen_w), // Templated
             .next_cleanwin_w (`EXUPATH2.rml.next_cleanwin_w[2:0]), // Templated
             .cleanwin_wen_w  (`EXUPATH2.rml.cleanwin_wen_w), // Templated
             .next_yreg_thr0  (`EXUPATH2.div.yreg.next_yreg_thr0[31:0]), // Templated
             .next_yreg_thr1  (`EXUPATH2.div.yreg.next_yreg_thr1[31:0]), // Templated
             .next_yreg_thr2  (`EXUPATH2.div.yreg.next_yreg_thr2[31:0]), // Templated
             .next_yreg_thr3  (`EXUPATH2.div.yreg.next_yreg_thr3[31:0]), // Templated
             .ecl_div_yreg_wen_l  (`EXUPATH2.ecl_div_yreg_wen_l[3:0]), // Templated
             .ifu_tlu_wsr_inst_d  (`EXUPATH2.ifu_tlu_wsr_inst_d), // Templated
             .ifu_tlu_sraddr_d  (`EXUPATH2.ifu_tlu_sraddr_d[3:0]), // Templated
             .inst_done_w_for_sas (`PC_CMP.spc2_inst_done), // Templated
`ifndef RTL_SPU
             .ifu_tlu_pc_w  (`SPCPATH2.ifu.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH2.ifu.ifu.fdp.npc_w[47:0]), // Templated
`else
             .ifu_tlu_pc_w  (`SPCPATH2.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH2.ifu.fdp.npc_w[47:0]), // Templated
`endif
             .tl0_en    (`TLPATH2.tl0_en),   // Templated
             .tl1_en    (`TLPATH2.tl1_en),   // Templated
             .tl2_en    (`TLPATH2.tl2_en),   // Templated
             .tl3_en    (`TLPATH2.tl3_en),   // Templated
             .trp_lvl0_new  (`TLPATH2.trp_lvl0_new[2:0]), // Templated
             .trp_lvl1_new  (`TLPATH2.trp_lvl1_new[2:0]), // Templated
             .trp_lvl2_new  (`TLPATH2.trp_lvl2_new[2:0]), // Templated
             .trp_lvl3_new  (`TLPATH2.trp_lvl3_new[2:0]), // Templated
             .update_pstate0_w2 (`TLPATH2.update_pstate_w2[0]), // Templated
             .update_pstate1_w2 (`TLPATH2.update_pstate_w2[1]), // Templated
             .update_pstate2_w2 (`TLPATH2.update_pstate_w2[2]), // Templated
             .update_pstate3_w2 (`TLPATH2.update_pstate_w2[3]), // Templated
             .pstate_priv_update_w2(`TDPPATH2.pstate_priv_update_w2), // Templated
             .hpstate_priv_update_w2(`TDPPATH2.hpstate_priv_update_w2), // Templated
             .restore_pstate0 (`TDPPATH2.restore_pstate0), // Templated
             .restore_pstate1 (`TDPPATH2.restore_pstate1), // Templated
             .restore_pstate2 (`TDPPATH2.restore_pstate2), // Templated
             .restore_pstate3 (`TDPPATH2.restore_pstate3), // Templated
             .tick0_en    (`TLPATH2.tick_en[0]),   // Templated
             .tick1_en    (`TLPATH2.tick_en[1]),   // Templated
             .tick2_en    (`TLPATH2.tick_en[2]),   // Templated
             .tick3_en    (`TLPATH2.tick_en[3]),   // Templated
             .exu_tlu_wsr_data_w  (`TDPPATH2.tlu_wsr_data_w[63:0]), // Templated
             .tba0_en   (`TLPATH2.tlu_tba_en_l[0]), // Templated
             .tba1_en   (`TLPATH2.tlu_tba_en_l[1]), // Templated
             .tba2_en   (`TLPATH2.tlu_tba_en_l[2]), // Templated
             .tba3_en   (`TLPATH2.tlu_tba_en_l[3]), // Templated
             .tsa_wr_vld    (`TLPATH2.tsa_wr_vld[1:0]), // Templated
             .tsa_pc_en   (`TLPATH2.tsa_pc_en),  // Templated
             .tsa_npc_en    (`TLPATH2.tsa_npc_en),   // Templated
             .tsa_tstate_en (`TLPATH2.tsa_tstate_en), // Templated
             .tsa_ttype_en  (`TLPATH2.tsa_ttype_en), // Templated
             .tsa_wr_tid    (`TLPATH2.tsa_wr_tid[1:0]), // Templated
             .tsa_wr_tpl    (`TLPATH2.tsa_wr_tpl[2:0]), // Templated
             // .temp_tlvl0    (`TS0PATH2.temp_tlvl),   // Templated
             .temp_tlvl0    (),   // Templated
             .tsa0_wdata    (`TS0PATH2.din),   // Templated
             .write_mask0   (`TS0PATH2.write_mask),  // Templated
             //.temp_tlvl1    (`TS1PATH2.temp_tlvl),   // Templated
             .temp_tlvl1    (),   // Templated
             .tsa1_wdata    (`TS1PATH2.din),   // Templated
             .write_mask1   (`TS1PATH2.write_mask),  // Templated
             .cpu_id    (10'd2),       // Templated
             .next_t0_inrr_i1 (`INTPATH2.next_t0_inrr_i1[63:0]), // Templated
             .next_t1_inrr_i1 (`INTPATH2.next_t1_inrr_i1[63:0]), // Templated
             .next_t2_inrr_i1 (`INTPATH2.next_t2_inrr_i1[63:0]), // Templated
             .next_t3_inrr_i1 (`INTPATH2.next_t3_inrr_i1[63:0]), // Templated
             .ifu_lsu_st_inst_e (`SPCPATH2.ifu_lsu_st_inst_e), // Templated
             .ifu_lsu_ld_inst_e (`SPCPATH2.ifu_lsu_ld_inst_e), // Templated
             .ifu_lsu_alt_space_e (`PCXPATH2.ifu_lsu_alt_space_e), // Templated
             .ifu_lsu_ldst_fp_e (`PCXPATH2.ifu_lsu_ldst_fp_e), // Templated
             .ifu_lsu_ldst_dbl_e  (`PCXPATH2.ifu_lsu_ldst_dbl_e), // Templated
             .lsu_ffu_blk_asi_e (`PCXPATH2.lsu_ffu_blk_asi_e), // Templated
             .ifu_tlu_inst_vld_m  (`PCXPATH2.ifu_tlu_inst_vld_m), // Templated
             .ifu_lsu_swap_e  (`SPCPATH2.ifu_lsu_swap_e), // Templated
             .ifu_tlu_thrid_e (`SPCPATH2.ifu_tlu_thrid_e[1:0]), // Templated
             .asi_wr_din    (`ASIDPPATH2.asi_wr_din), // Templated
             .asi_state_wr_thrd (`ASIDPPATH2.asi_state_wr_thrd[3:0]), // Templated
             .pil     (`TLPATH2.tlu_wsr_data_w[3:0]), // Templated
             .pil0_en   (`TLPATH2.pil0_en),  // Templated
             .pil1_en   (`TLPATH2.pil1_en),  // Templated
             .pil2_en   (`TLPATH2.pil2_en),  // Templated
             .pil3_en   (`TLPATH2.pil3_en),  // Templated
             .dp_frf_data   (`FLOATPATH2.dp_frf_data[70:0]), // Templated
             .ctl_frf_addr  (`FLOATPATH2.ctl_frf_addr[6:0]), // Templated
             .ctl_frf_wen   (`FLOATPATH2.ctl_frf_wen[1:0]), // Templated
             .regfile_index (`FLOATPATH2.frf.regfile_index[7:0]), // Templated
             .ifu_exu_rs1_s (`EXUPATH2.ifu_exu_rs1_s[4:0]), // Templated
             .ifu_exu_rs2_s (`EXUPATH2.ifu_exu_rs2_s[4:0]), // Templated
             .byp_alu_rs1_data_e  (`EXUPATH2.byp_alu_rs1_data_e[63:0]), // Templated
             .byp_alu_rs2_data_e  (`EXUPATH2.byp_alu_rs2_data_e[63:0]), // Templated
             .ifu_lsu_imm_asi_d (`SPCPATH2.ifu_lsu_imm_asi_d[7:0]), // Templated
             .ifu_lsu_imm_asi_vld_d(`SPCPATH2.ifu_lsu_imm_asi_vld_d), // Templated
             .ifu_tlu_itlb_done (`SPCPATH2.ifu_tlu_itlb_done), // Templated
             .tlu_itlb_wr_vld_g (`SPCPATH2.tlu_itlb_wr_vld_g), // Templated
             .tlu_itlb_dmp_vld_g  (`SPCPATH2.tlu_itlb_dmp_vld_g), // Templated
             .lsu_tlu_dtlb_done (`SPCPATH2.lsu_tlu_dtlb_done), // Templated
             .tlu_dtlb_wr_vld_g (`TLUPATH2.mmu_ctl.pre_dtlb_wr_vld_g), // Templated
             .tlu_dtlb_dmp_vld_g  (`SPCPATH2.tlu_dtlb_dmp_vld_g), // Templated
             .tlu_idtlb_dmp_thrid_g(`SPCPATH2.tlu_idtlb_dmp_thrid_g[1:0]), // Templated
             .inst_vld_qual_e (`INSTPATH2.inst_vld_qual_e), // Templated
             .t0_inrr_i2    (`TLUPATH2.intdp.t0_inrr_i2[63:0]), // Templated
             .t1_inrr_i2    (`TLUPATH2.intdp.t1_inrr_i2[63:0]), // Templated
             .t2_inrr_i2    (`TLUPATH2.intdp.t2_inrr_i2[63:0]), // Templated
             .t3_inrr_i2    (`TLUPATH2.intdp.t3_inrr_i2[63:0]), // Templated
             .t0_indr   (`TLUPATH2.intdp.t0_indr[10:0]), // Templated
             .t1_indr   (`TLUPATH2.intdp.t1_indr[10:0]), // Templated
             .t2_indr   (`TLUPATH2.intdp.t2_indr[10:0]), // Templated
             .t3_indr   (`TLUPATH2.intdp.t3_indr[10:0]), // Templated
             .ttype_sel_hstk_cmp_e(`INSTPATH2.ttype_sel_hstk_cmp_e), // Templated
             .ifu_tlu_ttype_vld_m (`INSTPATH2.ifu_tlu_ttype_vld_m)); // Templated
`endif // ifdef RTL_SPARC2



 `ifdef RTL_SPARC3
sas_task task3 (/*AUTOINST*/
             // Inputs
             .tlu_pich_wrap_flg_m (`TLUPATH3.tcl.tlu_pich_wrap_flg_m), // Templated
             .tlu_pic_cnt_en_m  (`TLUPATH3.tcl.tlu_pic_cnt_en_m), // Templated
             .final_ttype_sel_g (`TLUPATH3.tcl.final_ttype_sel_g), // Templated
             .rst_ttype_w2  (`TLUPATH3.tcl.rst_ttype_w2), // Templated
             .sync_trap_taken_m (`TLUPATH3.tcl.sync_trap_taken_m), // Templated
             .pib_picl_wrap (`TLUPATH3.pib_picl_wrap), // Templated
             .pib_pich_wrap_m (`TLUPATH3.tcl.pib_pich_wrap_m), // Templated
             .pib_pich_wrap (`TLUPATH3.pib_pich_wrap), // Templated
             .pic_wrap_trap_g (`TLUPATH3.tcl.pib_wrap_trap_g), // Templated
             .pib_wrap_trap_m (`TLUPATH3.tcl.pib_wrap_trap_m), // Templated
             .pcr_rw_e    (`TLUPATH3.tlu_pib.pcr_rw_e), // Templated
             .tlu_rsr_inst_e  (`TLUPATH3.tlu_pib.tlu_rsr_inst_e), // Templated
             .pcr0    (`TLUPATH3.tlu_pib.pcr0), // Templated
             .pcr1    (`TLUPATH3.tlu_pib.pcr1), // Templated
             .pcr2    (`TLUPATH3.tlu_pib.pcr2), // Templated
             .pcr3    (`TLUPATH3.tlu_pib.pcr3), // Templated
             .wsr_pcr_sel   (`TLUPATH3.tlu_pib.wsr_pcr_sel), // Templated
             .pich_cnt0   (`TLUPATH3.tlu_pib.pich_cnt0), // Templated
             .pich_cnt1   (`TLUPATH3.tlu_pib.pich_cnt1), // Templated
             .pich_cnt2   (`TLUPATH3.tlu_pib.pich_cnt2), // Templated
             .pich_cnt3   (`TLUPATH3.tlu_pib.pich_cnt3), // Templated
             .picl_cnt0   (`TLUPATH3.tlu_pib.picl_cnt0), // Templated
             .picl_cnt1   (`TLUPATH3.tlu_pib.picl_cnt1), // Templated
             .picl_cnt2   (`TLUPATH3.tlu_pib.picl_cnt2), // Templated
             .picl_cnt3   (`TLUPATH3.tlu_pib.picl_cnt3), // Templated
             .update_pich_sel (`TLUPATH3.tlu_pib.update_pich_sel), // Templated
             .update_picl_sel (`TLUPATH3.tlu_pib.update_picl_sel), // Templated
`ifndef RTL_SPU
             .const_maskid  (`PCXPATH3.ifu.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH3.ifu.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH3.ifu.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH3.ifu.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH3.ifu.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH3.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH3.ifu.ifu.errdp.formatted_tte_data), // Templated
`else
             .const_maskid  (`PCXPATH3.ifu.fdp.const_maskid), // Templated
             .fprs_sel_wrt  (`PCXPATH3.ifu.swl.fprs_sel_wrt), // Templated
             .fprs_sel_set  (`PCXPATH3.ifu.swl.fprs_sel_set), // Templated
             .fprs_wrt_data (`PCXPATH3.ifu.swl.fprs_wrt_data), // Templated
             .new_fprs    (`PCXPATH3.ifu.swl.new_fprs), // Templated
             .ifu_lsu_pref_inst_e (`PCXPATH3.ifu_lsu_pref_inst_e), // Templated
             .formatted_tte_data  (`PCXPATH3.ifu.errdp.formatted_tte_data), // Templated
`endif
             .dformatted_tte_data (`SPARC_CORE0.`LSU_PATH.tlbdp.formatted_tte_data), // Templated
             .dtlb_cam_vld  (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_cam_vld), // Templated
             .dtlb_tte_vld_g  (`SPARC_CORE0.`LSU_PATH.excpctl.tlb_tte_vld_g), // Templated
             .tlu_hpstate_priv  (`PCXPATH3.tlu_hpstate_priv), // Templated
             .tlu_hpstate_enb (`PCXPATH3.tlu_hpstate_enb), // Templated
`ifndef RTL_SPU
             .fcl_dtu_inst_vld_d  (`PCXPATH3.ifu.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH3.ifu.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH3.ifu.ifu.fcl.xlate_en), // Templated
`else
             .fcl_dtu_inst_vld_d  (`PCXPATH3.ifu.fcl_dtu_inst_vld_d), // Templated
             .icache_hit    (`PCXPATH3.ifu.itlb.cache_hit), // Templated
             .xlate_en    (`PCXPATH3.ifu.fcl.xlate_en), // Templated
`endif
             .ifu_lsu_thrid_s (`PCXPATH3.ifu_lsu_thrid_s), // Templated
             .fcl_ifq_icmiss_s1 (`IFUPATH3.fcl.fcl_ifq_icmiss_s1), // Templated
             .tlu_exu_early_flush_pipe_w(`PCXPATH3.tlu_exu_early_flush_pipe_w), // Templated
             .rst_hwint_ttype_g (`TLUPATH3.tcl.rst_hwint_ttype_g), // Templated
             .trap_taken_g  (`TLUPATH3.tcl.trap_taken_g), // Templated
`ifndef RTL_SPU
             .spu_lsu_ldxa_illgl_va_w2(1'b0), // Templated
             .spu_lsu_ldxa_data_vld_w2(1'b0), // Templated
             .spu_lsu_ldxa_tid_w2 (2'b0), // Templated
`else
             .spu_lsu_ldxa_illgl_va_w2(`PCXPATH3.spu.spu_ctl.spu_lsu_ldxa_illgl_va_w2), // Templated
             .spu_lsu_ldxa_data_vld_w2(`PCXPATH3.spu.spu_ctl.spu_lsu_ldxa_data_vld_w2), // Templated
             .spu_lsu_ldxa_tid_w2 (`PCXPATH3.spu.spu_ctl.spu_lsu_ldxa_tid_w2), // Templated
`endif
             .mra_field1_en (`TLUPATH3.mmu_ctl.mra_field1_en), // Templated
             .mra_field2_en (`TLUPATH3.mmu_ctl.mra_field2_en), // Templated
             .mra_field3_en (`TLUPATH3.mmu_ctl.mra_field3_en), // Templated
             .mra_field4_en (`TLUPATH3.mmu_ctl.mra_field4_en), // Templated
             .pmem_unc_error_g  (`SPARC_CORE0.`LSU_PATH.dctl.pmem_unc_error_g), // Templated
`ifndef RTL_SPU
             .pc_f    (`PCXPATH3.ifu.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH3.ifu.ifu.fcl.cam_vld_f), // Templated
`else
             .pc_f    (`PCXPATH3.ifu.fdp.pc_f), // Templated
             .cam_vld_f   (`PCXPATH3.ifu.fcl.cam_vld_f), // Templated
`endif
             .cam_vld   (`SPARC_CORE0.`LSU_PATH.dtlb.cam_vld), // Templated
             .defr_trp_taken_m_din(`SPARC_CORE0.`LSU_PATH.excpctl.defr_trp_taken_m_din), // Templated
             .illgl_va_vld_or_drop_ldxa2masync(1'b0), // Templated
`ifndef RTL_SPU
             .ecc_wen   (`PCXPATH3.ffu.ffu.ctl.ecc_wen), // Templated
`else
             .ecc_wen   (`PCXPATH3.ffu.ctl.ecc_wen), // Templated
`endif
             .fpdis_trap_e  (`IFUPATH3.dec.fpdis_trap_e), // Templated
             .ceen    (`IFUPATH3.errctl.ceen), // Templated
             .nceen   (`IFUPATH3.errctl.nceen), // Templated
             .ifu_tlu_flush_m (`TLUPATH3.ifu_tlu_flush_m), // Templated
             .lsu_tlu_ttype_m2  (`TLUPATH3.lsu_tlu_ttype_m2), // Templated
             .lsu_tlu_ttype_vld_m2(`TLUPATH3.lsu_tlu_ttype_vld_m2), // Templated
             .tlu_final_ttype_w2  (`TLUPATH3.tlu_final_ttype_w2), // Templated
             .tlu_ifu_trappc_vld_w1(`TLUPATH3.tlu_ifu_trappc_vld_w1), // Templated
             .mra_wr_ptr    (`TLUPATH3.mra_wr_ptr),  // Templated
             .mra_wr_vld    (`TLUPATH3.mra_wr_vld),  // Templated
             .lsu_pid_state0  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state0), // Templated
             .lsu_pid_state1  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state1), // Templated
             .lsu_pid_state2  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state2), // Templated
             .lsu_pid_state3  (`SPARC_CORE0.`LSU_PATH.lsu_pid_state3), // Templated
             .pid_state_wr_en (`SPARC_CORE0.`LSU_PATH.pid_state_wr_en), // Templated
             .lsu_t0_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t0_pctxt_state), // Templated
             .lsu_t1_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t1_pctxt_state), // Templated
             .lsu_t2_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t2_pctxt_state), // Templated
             .lsu_t3_pctxt_state  (`SPARC_CORE0.`LSU_PATH.lsu_t3_pctxt_state), // Templated
             .pctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.pctxt_state_wr_thrd), // Templated
             .sctxt_state0  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state0), // Templated
             .sctxt_state1  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state1), // Templated
             .sctxt_state2  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state2), // Templated
             .sctxt_state3  (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state3), // Templated
             .sctxt_state_wr_thrd (`SPARC_CORE0.`LSU_PATH.dctldp.sctxt_state_wr_thrd), // Templated
             .va_wtchpt0_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt0_addr), // Templated
             .va_wtchpt1_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt1_addr), // Templated
             .va_wtchpt2_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt2_addr), // Templated
             .va_wtchpt3_addr (`SPARC_CORE0.`LSU_PATH.qdp1.va_wtchpt3_addr), // Templated
             .lsu_va_wtchpt0_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt0_wr_en_l), // Templated
             .lsu_va_wtchpt1_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt1_wr_en_l), // Templated
             .lsu_va_wtchpt2_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt2_wr_en_l), // Templated
             .lsu_va_wtchpt3_wr_en_l(`SPARC_CORE0.`LSU_PATH.lsu_va_wtchpt3_wr_en_l), // Templated
             .ifu_rstint_m  (`TLPATH3.ifu_rstint_m), // Templated
`ifndef RTL_SPU
             .spu_tlu_rsrv_illgl_m(`PCXPATH3.tlu.tlu.spu_tlu_rsrv_illgl_m), // Templated
`else
             .spu_tlu_rsrv_illgl_m(`PCXPATH3.tlu.spu_tlu_rsrv_illgl_m), // Templated
`endif
             .cam_vld_s1    (`IFUPATH3.fcl.cam_vld_s1), // Templated
             .val_thr_s1    (`IFUPATH3.fcl.val_thr_s1), // Templated
             .pc_s    (`IFUPATH3.fdp.pc_s),  // Templated
`ifndef RTL_SPU
             .rs2_fst_ue_w3 (`PCXPATH3.ffu.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH3.ffu.ffu.ctl.rs2_fst_ce_w3), // Templated
`else
             .rs2_fst_ue_w3 (`PCXPATH3.ffu.ctl.rs2_fst_ue_w3), // Templated
             .rs2_fst_ce_w3 (`PCXPATH3.ffu.ctl.rs2_fst_ce_w3), // Templated
`endif
             .lsu_tlu_async_ttype_vld_w2(`PCXPATH3.lsu_tlu_async_ttype_vld_w2), // Templated
             .lsu_tlu_defr_trp_taken_g(`PCXPATH3.lsu_tlu_defr_trp_taken_g), // Templated
             .lsu_tlu_async_ttype_w2(`PCXPATH3.lsu_tlu_async_ttype_w2), // Templated
             .lsu_tlu_async_tid_w2(`PCXPATH3.lsu_tlu_async_tid_w2), // Templated
`ifndef RTL_SPU
             .itlb_rw_index (`PCXPATH3.ifu.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH3.ifu.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH3.ifu.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH3.ifu.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH3.ifu.ifu.itlb.cam_hit}), // Templated
`else
             .itlb_rw_index (`PCXPATH3.ifu.itlb.tlb_rw_index), // Templated
             .itlb_rw_index_vld (`PCXPATH3.ifu.itlb.tlb_rw_index_vld), // Templated
             .itlb_rd_tte_tag (`PCXPATH3.ifu.itlb.tlb_rd_tte_tag), // Templated
             .itlb_rd_tte_data  (`PCXPATH3.ifu.itlb.rd_tte_data), // Templated
             .icam_hit    ({48'b0,`PCXPATH3.ifu.itlb.cam_hit}), // Templated
`endif
             .dtlb_rw_index (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index), // Templated
             .dtlb_rw_index_vld (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rw_index_vld), // Templated
             .dtlb_rd_tte_tag (`SPARC_CORE0.`LSU_PATH.dtlb.tlb_rd_tte_tag), // Templated
             .dtlb_rd_tte_data  (`SPARC_CORE0.`LSU_PATH.dtlb.rd_tte_data), // Templated
             .dcam_hit    ({48'b0,`SPARC_CORE0.`LSU_PATH.dtlb.cam_hit}), // Templated
             .wrt_spec_w    (`IFUPATH3.swl.wrt_spec_w), // Templated
             .spc_pcx_data_pa (124'b0), // Templated //tttttttttttttt
             .fcl_fdp_inst_sel_nop_s_l(`IFUPATH3.fdp.fcl_fdp_inst_sel_nop_s_l), // Templated
             .retract_iferr_d (`IFUPATH3.swl.retract_iferr_d), // Templated
             .inst_vld_w    (`INSTPATH3.inst_vld_w), // Templated
             .dmmu_async_illgl_va_g(`TLUPATH3.mmu_ctl.dmmu_async_illgl_va_g), // Templated
             .immu_async_illgl_va_g(`TLUPATH3.mmu_ctl.immu_async_illgl_va_g), // Templated
             .lsu_tlu_tlb_ld_inst_m(`TLUPATH3.mmu_ctl.lsu_tlu_tlb_ld_inst_m), // Templated
             .lsu_tlu_tlb_st_inst_m(`TLUPATH3.mmu_ctl.lsu_tlu_tlb_st_inst_m), // Templated
             .immu_sfsr_wr_en_l (`TLUPATH3.immu_sfsr_wr_en_l), // Templated
             .dmmu_sfsr_wr_en_l (`TLUPATH3.dmmu_sfsr_wr_en_l), // Templated
             .dmmu_sfar_wr_en_l (`TLUPATH3.dmmu_sfar_wr_en_l), // Templated
             .lsu_quad_asi_e  (`SPARC_CORE0.`LSU_PATH.lsu_quad_asi_e), // Templated
             .clk     (clk),       // Templated
             .rst_l   (rst_l),     // Templated
             .back    (`PC_CMP.back_thread[4*4-1:3*4]), // Templated
             .lsu_ifu_ldsta_internal_e(`IFUPATH3.lsu_ifu_ldsta_internal_e), // Templated
             .lsu_mmu_flush_pipe_w(`TLUPATH3.lsu_mmu_flush_pipe_w), // Templated
             .dtlb_wr_vld   (`DTLBPATH3.tlb_wr_vld), // Templated
             .dtlb_demap    (`DTLBPATH3.tlb_demap),  // Templated
             .dtlb_rd_tag_vld (`DTLBPATH3.tlb_rd_tag_vld), // Templated
             .dtlb_rd_data_vld  (`DTLBPATH3.tlb_rd_data_vld), // Templated
             .dtlb_entry_vld  ({48'd0,`DTLBPATH3.tlb_entry_vld}), // Templated
             .itlb_wr_vld   (`ITLBPATH3.tlb_wr_vld), // Templated
             .itlb_demap    (`ITLBPATH3.tlb_demap),  // Templated
             .itlb_rd_tag_vld (`ITLBPATH3.tlb_rd_tag_vld), // Templated
             .itlb_rd_data_vld  (`ITLBPATH3.tlb_rd_data_vld), // Templated
             .itlb_entry_vld  ({48'd0,`ITLBPATH3.tlb_entry_vld}), // Templated
             .tlb_access_tid_g  (`TLUPATH3.mmu_ctl.tlb_access_tid_g), // Templated
             .dsfar0_clk    (`TLUPATH3.mmu_dp.dsfar0_clk), // Templated
             .dsfar1_clk    (`TLUPATH3.mmu_dp.dsfar1_clk), // Templated
             .dsfar2_clk    (`TLUPATH3.mmu_dp.dsfar2_clk), // Templated
             .dsfar3_clk    (`TLUPATH3.mmu_dp.dsfar3_clk), // Templated
             .dsfar_din   (`TLUPATH3.mmu_dp.dsfar_din), // Templated
             .dtu_inst_d    (`IFUPATH3.dec.dtu_inst_d), // Templated
             .local_rdpr_mx1_sel  (`TLPATH3.local_rdpr_mx1_sel), // Templated
             .tlu_rdpr_mx5_sel  (`TLPATH3.tlu_rdpr_mx5_sel), // Templated
             .tlu_rdpr_mx7_sel  (`TLPATH3.tlu_rdpr_mx7_sel), // Templated
             .tlu_rst_l   (`TLPATH3.tlu_rst_l),  // Templated
             .tick_match    (`TDPPATH3.tick_match),  // Templated
             .tlu_wr_sftint_l_g (`TLUPATH3.tlu_wr_sftint_l_g), // Templated
             .dsfsr_din   (`TLUPATH3.mmu_dp.dsfsr_din), // Templated
             .dsfsr0_clk    (`TLUPATH3.mmu_dp.dsfsr0_clk), // Templated
             .dsfsr1_clk    (`TLUPATH3.mmu_dp.dsfsr1_clk), // Templated
             .dsfsr2_clk    (`TLUPATH3.mmu_dp.dsfsr2_clk), // Templated
             .dsfsr3_clk    (`TLUPATH3.mmu_dp.dsfsr3_clk), // Templated
             .isfsr_din   (`TLUPATH3.mmu_dp.isfsr_din), // Templated
             .isfsr0_clk    (`TLUPATH3.mmu_dp.isfsr0_clk), // Templated
             .isfsr1_clk    (`TLUPATH3.mmu_dp.isfsr1_clk), // Templated
             .isfsr2_clk    (`TLUPATH3.mmu_dp.isfsr2_clk), // Templated
             .isfsr3_clk    (`TLUPATH3.mmu_dp.isfsr3_clk), // Templated
             .ecl_byp_sel_ecc_w (`IFUPATH3.errctl.irf_ce_unq), // Templated
             .ifu_exu_inst_w  (`INSTPATH3.ifu_exu_inst_vld_w), // Templated
             .ctl_dp_fp_thr (`FLOATPATH3.ctl_dp_fp_thr), // Templated
             .ifu_ffu_fst_d (`FLOATPATH3.ifu_ffu_fst_d), // Templated
             .pc_e    (`DTUPATH3.pc_e),  // Templated
             .fcl_dtu_inst_vld_e  (`INSTPATH3.fcl_dtu_inst_vld_e), // Templated
             .exu_lsu_rs3_data_e  (`PCXPATH3.exu_lsu_rs3_data_e), // Templated
             .tick_ctl_din  (`TLPATH3.tick_ctl_din), // Templated
             .ifu_tlu_ttype_m (`PCXPATH3.ifu_tlu_ttype_m), // Templated
             .tlu_rerr_vld  (`PCXPATH3.tlu_rerr_vld), // Templated
             .sftint0   (`TDPPATH3.sftint0),   // Templated
             .sftint1   (`TDPPATH3.sftint1),   // Templated
             .sftint2   (`TDPPATH3.sftint2),   // Templated
             .sftint3   (`TDPPATH3.sftint3),   // Templated
             .sftint0_clk   (`TDPPATH3.sftint0_clk), // Templated
             .sftint1_clk   (`TDPPATH3.sftint1_clk), // Templated
             .sftint2_clk   (`TDPPATH3.sftint2_clk), // Templated
             .sftint3_clk   (`TDPPATH3.sftint3_clk), // Templated
             .sftint_b0_en  (`TDPPATH3.sftint_b0_en), // Templated
             .sftint_b15_en (`TDPPATH3.sftint_b15_en), // Templated
             .sftint_b16_en (`TDPPATH3.sftint_b16_en), // Templated
             .cpx_spc_data_cx2  (`PCXPATH3.cpx_spc_data_cx2), // Templated
             .ifu_exu_save_d  (`PCXPATH3.ifu_exu_save_d), // Templated
             .ifu_exu_restore_d (`PCXPATH3.ifu_exu_restore_d), // Templated
             .ifu_tlu_thrid_d (`PCXPATH3.ifu_tlu_thrid_d), // Templated
             .tlu_ifu_hwint_i3  (`TLUPATH3.tlu_ifu_hwint_i3), // Templated
             .ifu_tlu_hwint_m (`TLUPATH3.ifu_tlu_hwint_m), // Templated
             .ifu_tlu_rstint_m  (`TLUPATH3.ifu_tlu_rstint_m), // Templated
             .ifu_tlu_swint_m (`TLUPATH3.ifu_tlu_swint_m), // Templated
             .tlu_ifu_flush_pipe_w(`TLPATH3.tlu_ifu_flush_pipe_w), // Templated
             .ifu_tlu_flush_w (`PCXPATH3.ifu_tlu_flush_w), // Templated
             .ffu_ifu_fst_ce_w  (`PCXPATH3.ffu_ifu_fst_ce_w), // Templated
`ifndef RTL_SPU
             .ffu_ifu_ecc_ue_w2 (`PCXPATH3.ffu.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH3.ffu.ffu.ffu_ifu_ecc_ce_w2), // Templated
`else
             .ffu_ifu_ecc_ue_w2 (`PCXPATH3.ffu.ffu_ifu_ecc_ue_w2), // Templated
             .ffu_ifu_ecc_ce_w2 (`PCXPATH3.ffu.ffu_ifu_ecc_ce_w2), // Templated
`endif
             .any_err_vld   (`IFUPATH3.errctl.any_err_vld), // Templated
             .any_ue_vld    (`IFUPATH3.errctl.any_ue_vld), // Templated
             .tsa_htstate_en  (`TLPATH3.tsa_htstate_en), // Templated
             .stickcmp_intdis_en  (`TDPPATH3.stickcmp_intdis_en), // Templated
             .tick_npt0   (`TLPATH3.tick_npt0),  // Templated
             .tick_npt1   (`TLPATH3.tick_npt1),  // Templated
             .tick_npt2   (`TLPATH3.tick_npt2),  // Templated
             .tick_npt3   (`TLPATH3.tick_npt3),  // Templated
             .true_tick   (`TDPPATH3.true_tick),   // Templated
             .htick_intdis0 (`TLU_HYPER0.htick_intdis0), // Templated
             .htick_intdis1 (`TLU_HYPER0.htick_intdis1), // Templated
             .htick_intdis2 (`TLU_HYPER0.htick_intdis2), // Templated
             .htick_intdis3 (`TLU_HYPER0.htick_intdis3), // Templated
             .true_stickcmp0  (`TDPPATH3.true_stickcmp0), // Templated
             .true_stickcmp1  (`TDPPATH3.true_stickcmp1), // Templated
             .true_stickcmp2  (`TDPPATH3.true_stickcmp2), // Templated
             .true_stickcmp3  (`TDPPATH3.true_stickcmp3), // Templated
             .tlu_hintp_en_l_g  (`TDPPATH3.tlu_hintp_en_l_g), // Templated
             .tlu_hintp   (`TDPPATH3.tlu_hintp),   // Templated
             .tlu_htba_en_l (`TDPPATH3.tlu_htba_en_l), // Templated
             .true_htba0    (`TDPPATH3.true_htba0),  // Templated
             .true_htba1    (`TDPPATH3.true_htba1),  // Templated
             .true_htba2    (`TDPPATH3.true_htba2),  // Templated
             .true_htba3    (`TDPPATH3.true_htba3),  // Templated
             .update_hpstate_l_w2 (`TDPPATH3.tlu_update_hpstate_l_w2[3:0]), // Templated
             .restore_hpstate0  (`TDPPATH3.restore_hpstate0), // Templated
             .restore_hpstate1  (`TDPPATH3.restore_hpstate1), // Templated
             .restore_hpstate2  (`TDPPATH3.restore_hpstate2), // Templated
             .restore_hpstate3  (`TDPPATH3.restore_hpstate3), // Templated
             .htickcmp_intdis_en  (`TLU_HYPER0.htickcmp_intdis_en), // Templated
             .true_htickcmp0  (`TDPPATH3.true_htickcmp0), // Templated
             .true_htickcmp1  (`TDPPATH3.true_htickcmp1), // Templated
             .true_htickcmp2  (`TDPPATH3.true_htickcmp2), // Templated
             .true_htickcmp3  (`TDPPATH3.true_htickcmp3), // Templated
             .gl0_en    (`TLU_HYPER0.gl0_en),  // Templated
             .gl1_en    (`TLU_HYPER0.gl1_en),  // Templated
             .gl2_en    (`TLU_HYPER0.gl2_en),  // Templated
             .gl3_en    (`TLU_HYPER0.gl3_en),  // Templated
             .gl_lvl0_new   (`TLU_HYPER0.gl_lvl0_new), // Templated
             .gl_lvl1_new   (`TLU_HYPER0.gl_lvl1_new), // Templated
             .gl_lvl2_new   (`TLU_HYPER0.gl_lvl2_new), // Templated
             .gl_lvl3_new   (`TLU_HYPER0.gl_lvl3_new), // Templated
             .t0_gsr_nxt    (`FFUPATH3.dp.t0_gsr_nxt), // Templated
             .t0_gsr_rnd_next (`FFUPATH3.ctl.visctl.t0_gsr_rnd_next), // Templated
             .t0_gsr_align_next (`FFUPATH3.ctl.visctl.t0_gsr_align_next), // Templated
             .t0_gsr_wsr_w  (`FFUPATH3.ctl.visctl.t0_gsr_wsr_w2), // Templated
             .t0_siam_w   (`FFUPATH3.ctl.visctl.t0_siam_w2), // Templated
             .t0_alignaddr_w  (`FFUPATH3.ctl.visctl.t0_alignaddr_w2), // Templated
             .t1_gsr_nxt    (`FFUPATH3.dp.t1_gsr_nxt), // Templated
             .t1_gsr_rnd_next (`FFUPATH3.ctl.visctl.t1_gsr_rnd_next), // Templated
             .t1_gsr_align_next (`FFUPATH3.ctl.visctl.t1_gsr_align_next), // Templated
             .t1_gsr_wsr_w  (`FFUPATH3.ctl.visctl.t1_gsr_wsr_w2), // Templated
             .t1_siam_w   (`FFUPATH3.ctl.visctl.t1_siam_w2), // Templated
             .t1_alignaddr_w  (`FFUPATH3.ctl.visctl.t1_alignaddr_w2), // Templated
             .t2_gsr_nxt    (`FFUPATH3.dp.t2_gsr_nxt), // Templated
             .t2_gsr_rnd_next (`FFUPATH3.ctl.visctl.t2_gsr_rnd_next), // Templated
             .t2_gsr_align_next (`FFUPATH3.ctl.visctl.t2_gsr_align_next), // Templated
             .t2_gsr_wsr_w  (`FFUPATH3.ctl.visctl.t2_gsr_wsr_w2), // Templated
             .t2_siam_w   (`FFUPATH3.ctl.visctl.t2_siam_w2), // Templated
             .t2_alignaddr_w  (`FFUPATH3.ctl.visctl.t2_alignaddr_w2), // Templated
             .t3_gsr_nxt    (`FFUPATH3.dp.t3_gsr_nxt), // Templated
             .t3_gsr_rnd_next (`FFUPATH3.ctl.visctl.t3_gsr_rnd_next), // Templated
             .t3_gsr_align_next (`FFUPATH3.ctl.visctl.t3_gsr_align_next), // Templated
             .t3_gsr_wsr_w  (`FFUPATH3.ctl.visctl.t3_gsr_wsr_w2), // Templated
             .t3_siam_w   (`FFUPATH3.ctl.visctl.t3_siam_w2), // Templated
             .t3_alignaddr_w  (`FFUPATH3.ctl.visctl.t3_alignaddr_w2), // Templated
             .exu_lsu_ldst_va_e (`ASIDPPATH3.exu_lsu_ldst_va_e[47:0]), // Templated
             .asi_state_e   (`ASIDPPATH3.asi_state_e[7:0]), // Templated
             .cpu_num   (cpu_num),     // Templated
             .good    (`PC_CMP.good[4*4-1:3*4]),   // Templated
             .active    (`PC_CMP.active_thread[4*4-1:3*4]), // Templated
             .finish    (`PC_CMP.finish_mask[4*4-1:3*4]), // Templated
             .lda_internal_e  (`ASIPATH3.lda_internal_e), // Templated
             .sta_internal_e  (`ASIPATH3.sta_internal_e), // Templated
             .ifu_spu_trap_ack  ({1'b0,`SPCPATH3.ifu_spu_trap_ack}), // Templated
             .ifu_exu_muls_d  (`SPCPATH3.ifu_exu_muls_d), // Templated
             .ifu_exu_tid_s2  (`EXUPATH3.ifu_exu_tid_s2[1:0]), // Templated
             .rml_irf_restore_local_m(`EXUPATH3.irf.irf.swap_local_w), // Templated
             .rml_irf_cwp_m (`EXUPATH3.irf.irf.old_lo_cwp_m[2:0]), // Templated
             .rml_irf_save_local_m(`EXUPATH3.irf.irf.swap_local_m), // Templated
             .rml_irf_thr_m (`EXUPATH3.irf.irf.cwpswap_tid_m[1:0]), // Templated
             .ifu_exu_save_e  (`EXUPATH3.rml.save_e),  // Templated
             .exu_tlu_spill_e (`EXUPATH3.rml.exu_tlu_spill_e), // Templated
             .t0_fsr_nxt    (`FLOATPATH3.dp.t0_fsr_nxt[27:0]), // Templated
             .t1_fsr_nxt    (`FLOATPATH3.dp.t1_fsr_nxt[27:0]), // Templated
             .t2_fsr_nxt    (`FLOATPATH3.dp.t2_fsr_nxt[27:0]), // Templated
             .t3_fsr_nxt    (`FLOATPATH3.dp.t3_fsr_nxt[27:0]), // Templated
             .ctl_dp_fsr_sel_old  (`FLOATPATH3.ctl_dp_fsr_sel_old[3:0]), // Templated
             .tlu_sftint_en_l_g (`TLUPATH3.tlu_sftint_en_l_g[3:0]), // Templated
             .true_tickcmp0 (`TDPPATH3.true_tickcmp0), // Templated
             .true_tickcmp1 (`TDPPATH3.true_tickcmp1), // Templated
             .true_tickcmp2 (`TDPPATH3.true_tickcmp2), // Templated
             .true_tickcmp3 (`TDPPATH3.true_tickcmp3), // Templated
             .tickcmp_intdis_en (`TDPPATH3.tickcmp_intdis_en[3:0]), // Templated
             .dtu_fdp_rdsr_sel_thr_e_l(`DTUPATH3.fcl_fdp_rdsr_sel_thr_e_l), // Templated
             .ifu_exu_rd_ifusr_e  (`EXUPATH3.ifu_exu_rd_ifusr_e), // Templated
             .ifu_exu_use_rsr_e_l (`EXUPATH3.ifu_exu_use_rsr_e_l), // Templated
             .rml_irf_global_tid  (`EXUPATH3.irf.irf.rml_irf_global_tid[1:0]), // Templated
             .ecl_irf_wen_w (`REGPATH3.ecl_irf_wen_w), // Templated
             .ecl_irf_wen_w2  (`REGPATH3.ecl_irf_wen_w2), // Templated
             .byp_irf_rd_data_w (`REGPATH3.byp_irf_rd_data_w[71:0]), // Templated
             .byp_irf_rd_data_w2  (`REGPATH3.byp_irf_rd_data_w2[71:0]), // Templated
             .thr_rd_w    (`REGPATH3.thr_rd_w[4:0]), // Templated
             .thr_rd_w2   (`REGPATH3.thr_rd_w2[4:0]), // Templated
             .ecl_irf_tid_w (`REGPATH3.ecl_irf_tid_w[1:0]), // Templated
             .ecl_irf_tid_w2  (`REGPATH3.ecl_irf_tid_w2[1:0]), // Templated
`ifndef RTL_SPU
             .ifu_tlu_thrid_w (`SPCPATH3.ifu.ifu.fcl.sas_thrid_w[1:0]), // Templated
`else
             .ifu_tlu_thrid_w (`SPCPATH3.ifu.fcl.sas_thrid_w[1:0]), // Templated
`endif
             .wen_thr0_l    (`CCRPATH3.wen_thr0_l),  // Templated
             .wen_thr1_l    (`CCRPATH3.wen_thr1_l),  // Templated
             .wen_thr2_l    (`CCRPATH3.wen_thr2_l),  // Templated
             .wen_thr3_l    (`CCRPATH3.wen_thr3_l),  // Templated
             .ccrin_thr0    (`CCRPATH3.ccrin_thr0[7:0]), // Templated
             .ccrin_thr1    (`CCRPATH3.ccrin_thr1[7:0]), // Templated
             .ccrin_thr2    (`CCRPATH3.ccrin_thr2[7:0]), // Templated
             .ccrin_thr3    (`CCRPATH3.ccrin_thr3[7:0]), // Templated
             .cwp_thr0_next (`EXUPATH3.rml.cwp.cwp_thr0_next), // Templated
             .cwp_thr1_next (`EXUPATH3.rml.cwp.cwp_thr1_next), // Templated
             .cwp_thr2_next (`EXUPATH3.rml.cwp.cwp_thr2_next), // Templated
             .cwp_thr3_next (`EXUPATH3.rml.cwp.cwp_thr3_next), // Templated
             .cwp_wen_l   (`EXUPATH3.rml.cwp.cwp_wen_l[3:0]), // Templated
             .next_cansave_w  (`EXUPATH3.rml.next_cansave_w[2:0]), // Templated
             .cansave_wen_w (`EXUPATH3.rml.cansave_wen_w), // Templated
             .next_canrestore_w (`EXUPATH3.rml.next_canrestore_w[2:0]), // Templated
             .canrestore_wen_w  (`EXUPATH3.rml.canrestore_wen_w), // Templated
             .next_otherwin_w (`EXUPATH3.rml.next_otherwin_w[2:0]), // Templated
             .otherwin_wen_w  (`EXUPATH3.rml.otherwin_wen_w), // Templated
             .tl_exu_tlu_wsr_data_w(`EXUPATH3.rml.exu_tlu_wsr_data_w[5:0]), // Templated
             .ecl_rml_wstate_wen_w(`EXUPATH3.rml.wstate_wen_w), // Templated
             .next_cleanwin_w (`EXUPATH3.rml.next_cleanwin_w[2:0]), // Templated
             .cleanwin_wen_w  (`EXUPATH3.rml.cleanwin_wen_w), // Templated
             .next_yreg_thr0  (`EXUPATH3.div.yreg.next_yreg_thr0[31:0]), // Templated
             .next_yreg_thr1  (`EXUPATH3.div.yreg.next_yreg_thr1[31:0]), // Templated
             .next_yreg_thr2  (`EXUPATH3.div.yreg.next_yreg_thr2[31:0]), // Templated
             .next_yreg_thr3  (`EXUPATH3.div.yreg.next_yreg_thr3[31:0]), // Templated
             .ecl_div_yreg_wen_l  (`EXUPATH3.ecl_div_yreg_wen_l[3:0]), // Templated
             .ifu_tlu_wsr_inst_d  (`EXUPATH3.ifu_tlu_wsr_inst_d), // Templated
             .ifu_tlu_sraddr_d  (`EXUPATH3.ifu_tlu_sraddr_d[3:0]), // Templated
             .inst_done_w_for_sas (`PC_CMP.spc3_inst_done), // Templated
`ifndef RTL_SPU
             .ifu_tlu_pc_w  (`SPCPATH3.ifu.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH3.ifu.ifu.fdp.npc_w[47:0]), // Templated
`else
             .ifu_tlu_pc_w  (`SPCPATH3.ifu.fdp.pc_w[47:0]), // Templated
             .ifu_tlu_npc_w (`SPCPATH3.ifu.fdp.npc_w[47:0]), // Templated
`endif
             .tl0_en    (`TLPATH3.tl0_en),   // Templated
             .tl1_en    (`TLPATH3.tl1_en),   // Templated
             .tl2_en    (`TLPATH3.tl2_en),   // Templated
             .tl3_en    (`TLPATH3.tl3_en),   // Templated
             .trp_lvl0_new  (`TLPATH3.trp_lvl0_new[2:0]), // Templated
             .trp_lvl1_new  (`TLPATH3.trp_lvl1_new[2:0]), // Templated
             .trp_lvl2_new  (`TLPATH3.trp_lvl2_new[2:0]), // Templated
             .trp_lvl3_new  (`TLPATH3.trp_lvl3_new[2:0]), // Templated
             .update_pstate0_w2 (`TLPATH3.update_pstate_w2[0]), // Templated
             .update_pstate1_w2 (`TLPATH3.update_pstate_w2[1]), // Templated
             .update_pstate2_w2 (`TLPATH3.update_pstate_w2[2]), // Templated
             .update_pstate3_w2 (`TLPATH3.update_pstate_w2[3]), // Templated
             .pstate_priv_update_w2(`TDPPATH3.pstate_priv_update_w2), // Templated
             .hpstate_priv_update_w2(`TDPPATH3.hpstate_priv_update_w2), // Templated
             .restore_pstate0 (`TDPPATH3.restore_pstate0), // Templated
             .restore_pstate1 (`TDPPATH3.restore_pstate1), // Templated
             .restore_pstate2 (`TDPPATH3.restore_pstate2), // Templated
             .restore_pstate3 (`TDPPATH3.restore_pstate3), // Templated
             .tick0_en    (`TLPATH3.tick_en[0]),   // Templated
             .tick1_en    (`TLPATH3.tick_en[1]),   // Templated
             .tick2_en    (`TLPATH3.tick_en[2]),   // Templated
             .tick3_en    (`TLPATH3.tick_en[3]),   // Templated
             .exu_tlu_wsr_data_w  (`TDPPATH3.tlu_wsr_data_w[63:0]), // Templated
             .tba0_en   (`TLPATH3.tlu_tba_en_l[0]), // Templated
             .tba1_en   (`TLPATH3.tlu_tba_en_l[1]), // Templated
             .tba2_en   (`TLPATH3.tlu_tba_en_l[2]), // Templated
             .tba3_en   (`TLPATH3.tlu_tba_en_l[3]), // Templated
             .tsa_wr_vld    (`TLPATH3.tsa_wr_vld[1:0]), // Templated
             .tsa_pc_en   (`TLPATH3.tsa_pc_en),  // Templated
             .tsa_npc_en    (`TLPATH3.tsa_npc_en),   // Templated
             .tsa_tstate_en (`TLPATH3.tsa_tstate_en), // Templated
             .tsa_ttype_en  (`TLPATH3.tsa_ttype_en), // Templated
             .tsa_wr_tid    (`TLPATH3.tsa_wr_tid[1:0]), // Templated
             .tsa_wr_tpl    (`TLPATH3.tsa_wr_tpl[2:0]), // Templated
             // .temp_tlvl0    (`TS0PATH3.temp_tlvl),   // Templated
             .temp_tlvl0    (),   // Templated
             .tsa0_wdata    (`TS0PATH3.din),   // Templated
             .write_mask0   (`TS0PATH3.write_mask),  // Templated
             //.temp_tlvl1    (`TS1PATH3.temp_tlvl),   // Templated
             .temp_tlvl1    (),   // Templated
             .tsa1_wdata    (`TS1PATH3.din),   // Templated
             .write_mask1   (`TS1PATH3.write_mask),  // Templated
             .cpu_id    (10'd3),       // Templated
             .next_t0_inrr_i1 (`INTPATH3.next_t0_inrr_i1[63:0]), // Templated
             .next_t1_inrr_i1 (`INTPATH3.next_t1_inrr_i1[63:0]), // Templated
             .next_t2_inrr_i1 (`INTPATH3.next_t2_inrr_i1[63:0]), // Templated
             .next_t3_inrr_i1 (`INTPATH3.next_t3_inrr_i1[63:0]), // Templated
             .ifu_lsu_st_inst_e (`SPCPATH3.ifu_lsu_st_inst_e), // Templated
             .ifu_lsu_ld_inst_e (`SPCPATH3.ifu_lsu_ld_inst_e), // Templated
             .ifu_lsu_alt_space_e (`PCXPATH3.ifu_lsu_alt_space_e), // Templated
             .ifu_lsu_ldst_fp_e (`PCXPATH3.ifu_lsu_ldst_fp_e), // Templated
             .ifu_lsu_ldst_dbl_e  (`PCXPATH3.ifu_lsu_ldst_dbl_e), // Templated
             .lsu_ffu_blk_asi_e (`PCXPATH3.lsu_ffu_blk_asi_e), // Templated
             .ifu_tlu_inst_vld_m  (`PCXPATH3.ifu_tlu_inst_vld_m), // Templated
             .ifu_lsu_swap_e  (`SPCPATH3.ifu_lsu_swap_e), // Templated
             .ifu_tlu_thrid_e (`SPCPATH3.ifu_tlu_thrid_e[1:0]), // Templated
             .asi_wr_din    (`ASIDPPATH3.asi_wr_din), // Templated
             .asi_state_wr_thrd (`ASIDPPATH3.asi_state_wr_thrd[3:0]), // Templated
             .pil     (`TLPATH3.tlu_wsr_data_w[3:0]), // Templated
             .pil0_en   (`TLPATH3.pil0_en),  // Templated
             .pil1_en   (`TLPATH3.pil1_en),  // Templated
             .pil2_en   (`TLPATH3.pil2_en),  // Templated
             .pil3_en   (`TLPATH3.pil3_en),  // Templated
             .dp_frf_data   (`FLOATPATH3.dp_frf_data[70:0]), // Templated
             .ctl_frf_addr  (`FLOATPATH3.ctl_frf_addr[6:0]), // Templated
             .ctl_frf_wen   (`FLOATPATH3.ctl_frf_wen[1:0]), // Templated
             .regfile_index (`FLOATPATH3.frf.regfile_index[7:0]), // Templated
             .ifu_exu_rs1_s (`EXUPATH3.ifu_exu_rs1_s[4:0]), // Templated
             .ifu_exu_rs2_s (`EXUPATH3.ifu_exu_rs2_s[4:0]), // Templated
             .byp_alu_rs1_data_e  (`EXUPATH3.byp_alu_rs1_data_e[63:0]), // Templated
             .byp_alu_rs2_data_e  (`EXUPATH3.byp_alu_rs2_data_e[63:0]), // Templated
             .ifu_lsu_imm_asi_d (`SPCPATH3.ifu_lsu_imm_asi_d[7:0]), // Templated
             .ifu_lsu_imm_asi_vld_d(`SPCPATH3.ifu_lsu_imm_asi_vld_d), // Templated
             .ifu_tlu_itlb_done (`SPCPATH3.ifu_tlu_itlb_done), // Templated
             .tlu_itlb_wr_vld_g (`SPCPATH3.tlu_itlb_wr_vld_g), // Templated
             .tlu_itlb_dmp_vld_g  (`SPCPATH3.tlu_itlb_dmp_vld_g), // Templated
             .lsu_tlu_dtlb_done (`SPCPATH3.lsu_tlu_dtlb_done), // Templated
             .tlu_dtlb_wr_vld_g (`TLUPATH3.mmu_ctl.pre_dtlb_wr_vld_g), // Templated
             .tlu_dtlb_dmp_vld_g  (`SPCPATH3.tlu_dtlb_dmp_vld_g), // Templated
             .tlu_idtlb_dmp_thrid_g(`SPCPATH3.tlu_idtlb_dmp_thrid_g[1:0]), // Templated
             .inst_vld_qual_e (`INSTPATH3.inst_vld_qual_e), // Templated
             .t0_inrr_i2    (`TLUPATH3.intdp.t0_inrr_i2[63:0]), // Templated
             .t1_inrr_i2    (`TLUPATH3.intdp.t1_inrr_i2[63:0]), // Templated
             .t2_inrr_i2    (`TLUPATH3.intdp.t2_inrr_i2[63:0]), // Templated
             .t3_inrr_i2    (`TLUPATH3.intdp.t3_inrr_i2[63:0]), // Templated
             .t0_indr   (`TLUPATH3.intdp.t0_indr[10:0]), // Templated
             .t1_indr   (`TLUPATH3.intdp.t1_indr[10:0]), // Templated
             .t2_indr   (`TLUPATH3.intdp.t2_indr[10:0]), // Templated
             .t3_indr   (`TLUPATH3.intdp.t3_indr[10:0]), // Templated
             .ttype_sel_hstk_cmp_e(`INSTPATH3.ttype_sel_hstk_cmp_e), // Templated
             .ifu_tlu_ttype_vld_m (`INSTPATH3.ifu_tlu_ttype_vld_m)); // Templated
`endif // ifdef RTL_SPARC3




`endif // SAS_DISABLE
// asdf;
reg [71:0] active_window [127:0];
reg [71:0] locals        [255:0];
reg [71:0] evens         [255:0];
reg [71:0] odds          [255:0];
reg [71:0] globals       [255:0];
reg [38:0] regfile       [255:0];
//signals for fifo
time    sas_time;
reg [63:0] sas_timer;

reg [9:0]  sas_spc; // seems to be unused
reg [1:0]  sas_thread;
reg [2:0]  sas_win;
reg [5:0]  sas_addr;
reg [4:0]  sas_cond;
reg [63:0] sas_reg;
reg [63:0] sas_val;
reg        dummy;
reg        sas_int;

integer    i, max;
reg         reset_status, expected_warm, swap;
initial begin
    reset_status = 0;
    expected_warm= 0;
    swap         = 0;
end // initial begin

`ifndef NO_MRA_VAL
//mra memory contets
task mra_val;
    input [9:0] cpu;
    input [3:0] idx;
    output [159:0] mra_wdata;
    reg [159:0] mra_wdata;

`ifdef FPGA_SYN_16x160
    reg [7:0] tmp;
`endif
    begin
        case(cpu)
            
    `ifdef RTL_SPARC0
               10'd0 : begin
    `ifndef PITON_PROTO
    `ifdef FPGA_SYN_16x160
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr0.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr0.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr0.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr0.inq_ary3, tmp[7:6]);
                    mra_wdata[7:0] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr1.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr1.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr1.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr1.inq_ary3, tmp[7:6]);
                    mra_wdata[15:8] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr2.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr2.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr2.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr2.inq_ary3, tmp[7:6]);
                    mra_wdata[23:16] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr3.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr3.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr3.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr3.inq_ary3, tmp[7:6]);
                    mra_wdata[31:24] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr4.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr4.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr4.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr4.inq_ary3, tmp[7:6]);
                    mra_wdata[39:32] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr5.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr5.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr5.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr5.inq_ary3, tmp[7:6]);
                    mra_wdata[47:40] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr6.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr6.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr6.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr6.inq_ary3, tmp[7:6]);
                    mra_wdata[55:48] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr7.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr7.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr7.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr7.inq_ary3, tmp[7:6]);
                    mra_wdata[63:56] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr8.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr8.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr8.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr8.inq_ary3, tmp[7:6]);
                    mra_wdata[71:64] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr9.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr9.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr9.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr9.inq_ary3, tmp[7:6]);
                    mra_wdata[79:72] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr10.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr10.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr10.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr10.inq_ary3, tmp[7:6]);
                    mra_wdata[87:80] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr11.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr11.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr11.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr11.inq_ary3, tmp[7:6]);
                    mra_wdata[95:88] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr12.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr12.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr12.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr12.inq_ary3, tmp[7:6]);
                    mra_wdata[103:96] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr13.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr13.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr13.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr13.inq_ary3, tmp[7:6]);
                    mra_wdata[111:104] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr14.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr14.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr14.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr14.inq_ary3, tmp[7:6]);
                    mra_wdata[119:112] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr15.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr15.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr15.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr15.inq_ary3, tmp[7:6]);
                    mra_wdata[127:120] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr16.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr16.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr16.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr16.inq_ary3, tmp[7:6]);
                    mra_wdata[135:128] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr17.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr17.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr17.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr17.inq_ary3, tmp[7:6]);
                    mra_wdata[143:136] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr18.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr18.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr18.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr18.inq_ary3, tmp[7:6]);
                    mra_wdata[151:144] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr19.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr19.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr19.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH0.mra.arr19.inq_ary3, tmp[7:6]);
                    mra_wdata[159:152] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
        `else
            $bw_force_by_name(2, idx, `TLUPATH0.mra.inq_ary, mra_wdata);
        `endif
    `else
    $bw_force_by_name(2, idx, `TLUPATH0.mra.inq_ary, mra_wdata);
    `endif // PITON_PROTO
                end
    `endif


    `ifdef RTL_SPARC1
               10'd1 : begin
    `ifndef PITON_PROTO
    `ifdef FPGA_SYN_16x160
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr0.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr0.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr0.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr0.inq_ary3, tmp[7:6]);
                    mra_wdata[7:0] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr1.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr1.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr1.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr1.inq_ary3, tmp[7:6]);
                    mra_wdata[15:8] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr2.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr2.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr2.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr2.inq_ary3, tmp[7:6]);
                    mra_wdata[23:16] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr3.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr3.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr3.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr3.inq_ary3, tmp[7:6]);
                    mra_wdata[31:24] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr4.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr4.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr4.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr4.inq_ary3, tmp[7:6]);
                    mra_wdata[39:32] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr5.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr5.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr5.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr5.inq_ary3, tmp[7:6]);
                    mra_wdata[47:40] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr6.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr6.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr6.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr6.inq_ary3, tmp[7:6]);
                    mra_wdata[55:48] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr7.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr7.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr7.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr7.inq_ary3, tmp[7:6]);
                    mra_wdata[63:56] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr8.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr8.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr8.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr8.inq_ary3, tmp[7:6]);
                    mra_wdata[71:64] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr9.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr9.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr9.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr9.inq_ary3, tmp[7:6]);
                    mra_wdata[79:72] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr10.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr10.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr10.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr10.inq_ary3, tmp[7:6]);
                    mra_wdata[87:80] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr11.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr11.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr11.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr11.inq_ary3, tmp[7:6]);
                    mra_wdata[95:88] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr12.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr12.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr12.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr12.inq_ary3, tmp[7:6]);
                    mra_wdata[103:96] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr13.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr13.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr13.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr13.inq_ary3, tmp[7:6]);
                    mra_wdata[111:104] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr14.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr14.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr14.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr14.inq_ary3, tmp[7:6]);
                    mra_wdata[119:112] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr15.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr15.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr15.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr15.inq_ary3, tmp[7:6]);
                    mra_wdata[127:120] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr16.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr16.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr16.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr16.inq_ary3, tmp[7:6]);
                    mra_wdata[135:128] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr17.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr17.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr17.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr17.inq_ary3, tmp[7:6]);
                    mra_wdata[143:136] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr18.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr18.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr18.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr18.inq_ary3, tmp[7:6]);
                    mra_wdata[151:144] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr19.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr19.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr19.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH1.mra.arr19.inq_ary3, tmp[7:6]);
                    mra_wdata[159:152] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
        `else
            $bw_force_by_name(2, idx, `TLUPATH1.mra.inq_ary, mra_wdata);
        `endif
    `else
    $bw_force_by_name(2, idx, `TLUPATH1.mra.inq_ary, mra_wdata);
    `endif // PITON_PROTO
                end
    `endif


    `ifdef RTL_SPARC2
               10'd2 : begin
    `ifndef PITON_PROTO
    `ifdef FPGA_SYN_16x160
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr0.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr0.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr0.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr0.inq_ary3, tmp[7:6]);
                    mra_wdata[7:0] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr1.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr1.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr1.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr1.inq_ary3, tmp[7:6]);
                    mra_wdata[15:8] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr2.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr2.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr2.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr2.inq_ary3, tmp[7:6]);
                    mra_wdata[23:16] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr3.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr3.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr3.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr3.inq_ary3, tmp[7:6]);
                    mra_wdata[31:24] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr4.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr4.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr4.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr4.inq_ary3, tmp[7:6]);
                    mra_wdata[39:32] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr5.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr5.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr5.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr5.inq_ary3, tmp[7:6]);
                    mra_wdata[47:40] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr6.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr6.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr6.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr6.inq_ary3, tmp[7:6]);
                    mra_wdata[55:48] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr7.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr7.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr7.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr7.inq_ary3, tmp[7:6]);
                    mra_wdata[63:56] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr8.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr8.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr8.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr8.inq_ary3, tmp[7:6]);
                    mra_wdata[71:64] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr9.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr9.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr9.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr9.inq_ary3, tmp[7:6]);
                    mra_wdata[79:72] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr10.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr10.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr10.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr10.inq_ary3, tmp[7:6]);
                    mra_wdata[87:80] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr11.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr11.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr11.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr11.inq_ary3, tmp[7:6]);
                    mra_wdata[95:88] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr12.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr12.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr12.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr12.inq_ary3, tmp[7:6]);
                    mra_wdata[103:96] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr13.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr13.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr13.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr13.inq_ary3, tmp[7:6]);
                    mra_wdata[111:104] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr14.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr14.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr14.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr14.inq_ary3, tmp[7:6]);
                    mra_wdata[119:112] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr15.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr15.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr15.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr15.inq_ary3, tmp[7:6]);
                    mra_wdata[127:120] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr16.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr16.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr16.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr16.inq_ary3, tmp[7:6]);
                    mra_wdata[135:128] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr17.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr17.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr17.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr17.inq_ary3, tmp[7:6]);
                    mra_wdata[143:136] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr18.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr18.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr18.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr18.inq_ary3, tmp[7:6]);
                    mra_wdata[151:144] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr19.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr19.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr19.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH2.mra.arr19.inq_ary3, tmp[7:6]);
                    mra_wdata[159:152] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
        `else
            $bw_force_by_name(2, idx, `TLUPATH2.mra.inq_ary, mra_wdata);
        `endif
    `else
    $bw_force_by_name(2, idx, `TLUPATH2.mra.inq_ary, mra_wdata);
    `endif // PITON_PROTO
                end
    `endif


    `ifdef RTL_SPARC3
               10'd3 : begin
    `ifndef PITON_PROTO
    `ifdef FPGA_SYN_16x160
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr0.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr0.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr0.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr0.inq_ary3, tmp[7:6]);
                    mra_wdata[7:0] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr1.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr1.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr1.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr1.inq_ary3, tmp[7:6]);
                    mra_wdata[15:8] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr2.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr2.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr2.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr2.inq_ary3, tmp[7:6]);
                    mra_wdata[23:16] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr3.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr3.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr3.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr3.inq_ary3, tmp[7:6]);
                    mra_wdata[31:24] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr4.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr4.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr4.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr4.inq_ary3, tmp[7:6]);
                    mra_wdata[39:32] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr5.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr5.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr5.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr5.inq_ary3, tmp[7:6]);
                    mra_wdata[47:40] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr6.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr6.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr6.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr6.inq_ary3, tmp[7:6]);
                    mra_wdata[55:48] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr7.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr7.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr7.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr7.inq_ary3, tmp[7:6]);
                    mra_wdata[63:56] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr8.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr8.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr8.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr8.inq_ary3, tmp[7:6]);
                    mra_wdata[71:64] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr9.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr9.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr9.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr9.inq_ary3, tmp[7:6]);
                    mra_wdata[79:72] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr10.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr10.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr10.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr10.inq_ary3, tmp[7:6]);
                    mra_wdata[87:80] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr11.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr11.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr11.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr11.inq_ary3, tmp[7:6]);
                    mra_wdata[95:88] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr12.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr12.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr12.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr12.inq_ary3, tmp[7:6]);
                    mra_wdata[103:96] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr13.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr13.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr13.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr13.inq_ary3, tmp[7:6]);
                    mra_wdata[111:104] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr14.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr14.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr14.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr14.inq_ary3, tmp[7:6]);
                    mra_wdata[119:112] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr15.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr15.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr15.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr15.inq_ary3, tmp[7:6]);
                    mra_wdata[127:120] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr16.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr16.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr16.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr16.inq_ary3, tmp[7:6]);
                    mra_wdata[135:128] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr17.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr17.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr17.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr17.inq_ary3, tmp[7:6]);
                    mra_wdata[143:136] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr18.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr18.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr18.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr18.inq_ary3, tmp[7:6]);
                    mra_wdata[151:144] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr19.inq_ary0, tmp[1:0]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr19.inq_ary1, tmp[3:2]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr19.inq_ary2, tmp[5:4]);
                    $bw_force_by_name(2, idx, `TLUPATH3.mra.arr19.inq_ary3, tmp[7:6]);
                    mra_wdata[159:152] = {tmp[7],tmp[5],tmp[3],tmp[1],tmp[6],tmp[4],tmp[2],tmp[0]};
        `else
            $bw_force_by_name(2, idx, `TLUPATH3.mra.inq_ary, mra_wdata);
        `endif
    `else
    $bw_force_by_name(2, idx, `TLUPATH3.mra.inq_ary, mra_wdata);
    `endif // PITON_PROTO
                end
    `endif



            default: begin
            end
        endcase // case(cpu)
    end
endtask // mra_val
`endif // endif NO_MRA_VAL
reg timestamp, timest;
reg [63:0] time_stamp;
reg         pli_flag;

integer    rtl_counter;
initial begin
    timestamp = 1;
    timest = 1;
end
//send rtl cycle
always @(posedge clk)begin
    if(rst_l)begin
        sas_int      = 0;
        reset_status = 1;
        sas_int      = 1;

        `ifdef SAS_DISABLE
        `else
        
     `ifdef RTL_SPARC0
    `SAS_TASKS.task0.process;
      `endif


     `ifdef RTL_SPARC1
    `SAS_TASKS.task1.process;
      `endif


     `ifdef RTL_SPARC2
    `SAS_TASKS.task2.process;
      `endif


     `ifdef RTL_SPARC3
    `SAS_TASKS.task3.process;
      `endif



        `endif // SAS_DISABLE

    end // if (rst_l)
    else if(reset_status)expected_warm = 1;
    if(swap &&
            // `DCTLPATH0.dramctl0.dram_dctl.dram_que.que_bank_idle_cnt == 5'h1c &&
            // `DCTLPATH0.dramctl1.dram_dctl.dram_que.que_bank_idle_cnt == 5'h1c &&
            // `DCTLPATH1.dramctl0.dram_dctl.dram_que.que_bank_idle_cnt == 5'h1c &&
            // `DCTLPATH1.dramctl1.dram_dctl.dram_que.que_bank_idle_cnt == 5'h1c)begin
            1'b1) begin // tttttttttttt
        `TOP_MOD.monitor.pc_cmp.max = max;
        swap  = 0;
    end

end // always @ (posedge clk)

integer   sent;
/*-----------------------------------------------------------------
assign symbolic name.
----------------------------------------------------------------*/
//regs symbol.
reg [7:0] sym_tab[3:0];
reg [7:0] sym;
reg [240:0] str[`FLOAT_X:`PC];

initial begin

    sym_tab[0]                       = "g";
    sym_tab[1]                       = "o";
    sym_tab[2]                       = "l";
    sym_tab[3]                       = "i";
    sent                             = 0;
    str[`PC]                         = "PC";
    str[`NPC]                        = "NPC";
    str[`Y]                          = "Y";
    str[`CCR]                        = "CCR";
    str[`FPRS]                       = "FPRS";
    str[`FSR]                        = "FSR";
    str[`ASI]                        = "ASI";
    str[`TICK_SAS]                   = "TICK";
    str[`GSR]                        = "GSR";
    str[`TICK_CMPR]                  = "TICK_CMPR";
    str[`STICK]                      = "STICK";
    str[`STICK_CMPR]                 = "STICK_CMPR";
    str[`PSTATE_SAS]                 = "PSTATE";
    str[`TL_SAS]                     = "TL";
    str[`PIL_SAS]                    = "PIL";
    str[`TPC1]                       = "TPC1";
    str[`TPC2]                       = "TPC2";
    str[`TPC3]                       = "TPC3";
    str[`TPC4]                       = "TPC4";
    str[`TPC5]                       = "TPC5";
    str[`TPC6]                       = "TPC6";
    str[`TNPC1]                      = "TNPC1";
    str[`TNPC2]                      = "TNPC2";
    str[`TNPC3]                      = "TNPC3";
    str[`TNPC4]                      = "TNPC4";
    str[`TNPC5]                      = "TNPC5";
    str[`TNPC6]                      = "TNPC6";
    str[`TSTATE1]                    = "TSTATE1";
    str[`TSTATE2]                    = "TSTATE2";
    str[`TSTATE3]                    = "TSTATE3";
    str[`TSTATE4]                    = "TSTATE4";
    str[`TSTATE5]                    = "TSTATE5";
    str[`TSTATE6]                    = "TSTATE6";
    str[`TT1]                        = "TT1";
    str[`TT2]                        = "TT2";
    str[`TT3]                        = "TT3";
    str[`TT4]                        = "TT4";
    str[`TT5]                        = "TT5";
    str[`TT6]                        = "TT6";
    str[`TBA_SAS]                    = "TBA";
    str[`VER]                        = "VER";
    str[`CWP]                        = "CWP";
    str[`CANSAVE]                    = "CANSAVE";
    str[`CANRESTORE]                 = "CANRESTORE";
    str[`OTHERWIN]                   = "OTHERWIN";
    str[`WSTATE]                     = "WSTATE";
    str[`CLEANWIN]                   = "CLEANWIN";
    str[`SOFTINT]                    = "SOFTINT";
    str[`ECACHE_ERROR_ENABLE]        = "ECACHE_ERROR_ENABLE";
    str[`ASYNCHRONOUS_FAULT_STATUS]  = "ASYNCHRONOUS_FAULT_STATUS";
    str[`ASYNCHRONOUS_FAULT_ADDRESS] = "ASYNCHRONOUS_FAULT_ADDRESS";
    str[`OUT_INTR_DATA0]             = "OUT_INTR_DATA0";
    str[`OUT_INTR_DATA1]             = "OUT_INTR_DATA1";
    str[`OUT_INTR_DATA2]             = "OUT_INTR_DATA2";
    str[`INTR_DISPATCH_STATUS]       = "INTR_DISPATCH_STATUS";
    str[`IN_INTR_DATA0]              = "IN_INTR_DATA0";
    str[`IN_INTR_DATA1]              = "IN_INTR_DATA1";
    str[`IN_INTR_DATA2]              = "IN_INTR_DATA2";
    str[`INTR_RECEIVE]               = "INTR_RECEIVE";
    str[`GL]                         = "GL";
    str[`HPSTATE_SAS]                = "HPSTATE";
    str[`HTSTATE1]                   = "HTSTATE1";
    str[`HTSTATE2]                   = "HTSTATE2";
    str[`HTSTATE3]                   = "HTSTATE3";
    str[`HTSTATE4]                   = "HTSTATE4";
    str[`HTSTATE5]                   = "HTSTATE5";
    str[`HTSTATE6]                   = "HTSTATE6";
    str[`HTSTATE7]                   = "HTSTATE7";
    str[`HTSTATE8]                   = "HTSTATE8";
    str[`HTSTATE9]                   = "HTSTATE9";
    str[`HTSTATE10]                  = "HTSTATE10";
    str[`HTBA_SAS]                   = "HTBA";
    str[`HINTP_SAS]                  = "HINTP";
    str[`HSTICK_CMPR]                = "HSTICK_CMPR";
    str[`MID]                        = "MID";
    str[`ISFSR]                      = "ISFSR";
    str[`DSFSR]                      = "DSFSR";
    str[`SFAR]                       = "SFAR";
    str[`I_TAG_ACCESS]               = "I_TAG_ACCESS";
    str[`D_TAG_ACCESS]               = "D_TAG_ACCESS";
    str[`CTXT_PRIM]                  = "CTXT_PRIM";
    str[`CTXT_SEC]                   = "CTXT_SEC";
    str[`SFP_REG]                    = "SFP_REG";
    str[`I_CTXT_ZERO_PS0]            = "I_CTXT_ZERO_PS0";
    str[`D_CTXT_ZERO_PS0]            = "D_CTXT_ZERO_PS0";
    str[`I_CTXT_ZERO_PS1]            = "I_CTXT_ZERO_PS1";
    str[`D_CTXT_ZERO_PS1]            = "D_CTXT_ZERO_PS1";
    str[`I_CTXT_ZERO_CONFIG]         = "I_CTXT_ZERO_CONFIG";
    str[`D_CTXT_ZERO_CONFIG]         = "D_CTXT_ZERO_CONFIG";
    str[`I_CTXT_NONZERO_PS0]         = "I_CTXT_NONZERO_PS0";
    str[`D_CTXT_NONZERO_PS0]         = "D_CTXT_NONZERO_PS0";
    str[`I_CTXT_NONZERO_PS1]         = "I_CTXT_NONZERO_PS1";
    str[`D_CTXT_NONZERO_PS1]         = "D_CTXT_NONZERO_PS1";
    str[`I_CTXT_NONZERO_CONFIG]      = "I_CTXT_NONZERO_CONFIG";
    str[`D_CTXT_NONZERO_CONFIG]      = "D_CTXT_NONZERO_CONFIG";
    str[`I_TAG_TARGET]               = "I_TAG_TARGET";
    str[`D_TAG_TARGET]               = "D_TAG_TARGET";
    str[`I_TSB_PTR_PS0]              = "I_TSB_PTR_PS0";
    str[`D_TSB_PTR_PS0]              = "D_TSB_PTR_PS0";
    str[`I_TSB_PTR_PS1]              = "I_TSB_PTR_PS1";
    str[`D_TSB_PTR_PS1]              = "D_TSB_PTR_PS1";
    str[`D_TSB_DIR_PTR]              = "D_TSB_DIR_PTR";
    str[`VA_WP_ADDR]                 = "VA_WP_ADDR";
    str[`PID]                        = "PID";
    str[`REG_WRITE_BACK]             = "general register";
    str[`FLOAT_I]                    = "floating point";
    str[`FLOAT_X]                    = "floating point";
end // initial begin

/*-----------------------------------------------------------------
read data from socket and do comparsion.
----------------------------------------------------------------*/
reg [4:0]   next_thread;
reg [3:0]   recv_status;
reg [3:0]   ready;
reg [240:0] t_str;
reg [63:0]  rtl_val;
integer     good_timeout;
//keep the drop invr data
reg [31:0]  drop_vld;
reg [63:0]  drop_val[31:0];
reg [2:0]   drop_win[31:0];
reg [3:0]   drop_cond[31:0];

reg [31:0]  mul_vld;
reg [63:0]  mul_val[31:0];
reg [4:0]   mul_reg[31:0];
reg [4:0]   mul_win[31:0];

reg [31:0]  smul_vld;
reg [63:0]  smul_val[31:0];
reg [4:0]   smul_reg[31:0];
reg [4:0]   smul_win[31:0];

reg [3:0]   tmp_val;
reg [63:0]  mulv;
reg [4:0]   mulr;
reg          mul, inst_cond;
reg [4:0]   mulw;
//use for instruction checker.
reg [4:0]   inst_thread;
reg          wasthere, once_try;
reg [7:0]   ccr_req;

integer          idx;
reg            less;

initial begin
    good_timeout = 0;
    drop_vld     = 0;
    mul_vld      = 0;
    wasthere     = 1;
    once_try     = 1;
    smul_vld     = 0;
end

always @(posedge clk)begin
    if(`TOP_MOD.diag_done)good_timeout = good_timeout + 1;
    if(good_timeout > 3200000)begin
        // Tri: original time out is 2000 but will timeout before the interrupt gets to the farther tile
        less = 1;
        for(idx = 0; idx < `NUM_TILES;idx = idx + 1)begin
            if(`PC_CMP.finish_mask[idx])begin
                if(`PC_CMP.active_thread[idx] == 0)begin
                    less = 0;
                    $display("%0t:sas_tasks info->you turn on less thread than finish_mask. finish_mask(%x) active_thread(%x)",
                             $time, `PC_CMP.finish_mask, `PC_CMP.active_thread);
                    `MONITOR_PATH.fail("you turn on less thread than finish_mask");
                    idx = `NUM_TILES;
                end
            end
        end
    end // if (good_timeout > 2000)
end

// reg timestamp;
// reg [63:0] time_stamp;

reg [31:0] max_32;

initial
begin
    timestamp   = 1;
    rtl_counter = 0;
    pli_flag    = 0;
    if($test$plusargs("debug_cycle"))pli_flag = 1;
end

task register_cmp;
    input [7:0]  type_i;
    input [9:0]  spc;
    input [1:0]  thread;
    input [2:0]  window;
    input [5:0]  rtl_reg_addr;
    input [63:0] rtl_reg_val;
    input [63:0] sas_reg_val;
    input [63:0] sas_sps_val;
    input [4:0]  rs1;
    input [63:0] val1;
    input [4:0]  rs2;
    input [63:0] val2;
    input [3:0]  cond;
    reg   [63:0] sas_temp;

    begin
        case(type_i)
            `REG_WRITE_BACK : begin
                sym = sym_tab[rtl_reg_addr[5:3]];
                $display("%0t:reg_updated -> spc(%1d) thread(%d) window(%d) rs1(%x)->%x rs2(%x)->%x reg#(%s%0x) val = %x",
                         $time, spc,  thread, window, rs1, val1, rs2, val2, sym, rtl_reg_addr[2:0], rtl_reg_val);
            end
            `PC         : begin
                $display("%0t:pc-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end
            `NPC         : begin
                $display("%0t:npc-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end
            `Y          : begin
                $display("%0t:y_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[31:0]);
            end
            `CCR        : begin
                $display("%0t:ccr_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[7:0]);
            end
            `FPRS        : begin
                $display("%0t:fprs_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, cond ? rtl_reg_val[2:0] : rtl_reg_val[1:0] );
            end // case: `FPRS
            `FSR        : begin
                rtl_reg_val[22] = 0;//mask ns
                sas_sps_val[22] = 0;
                rtl_reg_val[13] = 0;//mask gne
                sas_sps_val[13] = 0;
                $display("%0t:fsr_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[37:0]);
            end
            `ASI        : begin
                $display("%0t:asi_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[7:0]);
            end // case: `CCR
            `TICK_SAS       : begin
                sas_temp = sas_sps_val - 1;

                $display("%0t:tick_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[63:0]);
            end
            `TICK_CMPR       : begin
                $display("%0t:tick_cmpr_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[63:0]);
            end
            `STICK_CMPR       : begin
                $display("%0t:stick_cmpr_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[63:0]);
            end
            `GSR        : begin
                $display("%0t:gsr_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[63:0]);
            end // case: `TICK_CMPR
            `PSTATE_SAS            : begin
                $display("%0t:pstate_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[11:0]);
            end
            `TL_SAS            : begin
                $display("%0t:tl_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end
            `PIL_SAS            : begin
                $display("%0t:pil_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[3:0]);
            end
            `TPC1, `TPC2, `TPC3, `TPC4, `TPC5, `TPC6 : begin
                $display("%0t:tpc%0d_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, type_i - `PIL_SAS, spc, thread, window, rtl_reg_val[47:0]);
            end
            `TNPC1, `TNPC2, `TNPC3, `TNPC4, `TNPC5, `TNPC6 : begin
                $display("%0t:tnpc%0d_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, type_i - 56, spc, thread, window, rtl_reg_val[47:0]);
            end
            `TSTATE1, `TSTATE2, `TSTATE3, `TSTATE4, `TSTATE5, `TSTATE6 : begin
                $display("%0t:tstate%0d_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, type_i - 66, spc, thread, window, rtl_reg_val[39:0]);
            end
            `TT1, `TT2, `TT3, `TT4, `TT5, `TT6 : begin
                $display("%0t:ttype%0d_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, type_i - 76, spc, thread, window, rtl_reg_val[8:0]);
            end // case: `TT1, `TT2, `TT3, `TT4, `TT5, `TT6

            `TBA_SAS            : begin
                $display("%0t:tba_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `TBA
            `VER            : begin
                $display("%0t:ver_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[32:0]);
            end // case: `TBA
            `CWP            : begin
                $display("%0t:cwp_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end
            `CANSAVE            : begin
                $display("%0t:cansave_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end
            `CANRESTORE           : begin
                $display("%0t:canrestore_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end
            `OTHERWIN           : begin
                $display("%0t:otherwin_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end
            `WSTATE           : begin
                $display("%0t:wstate_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[5:0]);
            end
            `CLEANWIN           : begin
                $display("%0t:cleanwin_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end // case: `CLEANWIN
            `SOFTINT           : begin
                $display("%0t:softint_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, 1'b1);
            end
            `ECACHE_ERROR_ENABLE           : begin
                $display("%0t:ecache_error_enable_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end // case: `UPAD_CONFIG
            `ASYNCHRONOUS_FAULT_STATUS           : begin
                $display("%0t:asynchronous_fault_status_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end // case: `UPAD_CONFIG
            `ASYNCHRONOUS_FAULT_ADDRESS           : begin
                $display("%0t:asynchronous_fault_address_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end
            `INTR_DISPATCH_STATUS           : begin
                $display("%0t:intr_dispatch_status_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[10:0]);
            end
            `INTR_RECEIVE          : begin
                $display("%0t:intr_receive_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end // case: `IN_INTR_DATA2
            `FLOAT_I           : begin
                if((rtl_reg_addr > 31) && rtl_reg_addr[1])sas_reg_val[31:0] = sas_reg_val[63:32];
                $display("%0t:float_reg-updated -> spc(%1d) thread(%d) reg#(%0d) val = %x",
                         $time, spc, thread, rtl_reg_addr, rtl_reg_val[31:0]);
            end // case: `FLOAT_I
            `FLOAT_X           : begin
                $display("%0t:float_reg-updated -> spc(%1d) thread(%d) reg#(f%0d) val = %x",
                         $time, spc, thread, rtl_reg_addr, rtl_reg_val[63:0]);
            end // case: `FLOAT_I
            `HTBA_SAS            : begin
                $display("%0t:htba_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[33:0]);
            end // case: `TBA
            `HINTP_SAS            : begin
                $display("%0t:hintp_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[3:0]);
            end // case: `HINTP
            `HSTICK_CMPR            : begin
                $display("%0t:hstick_cmpr_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[63:0]);
            end // case: `HINTP
            `HPSTATE_SAS            : begin
                sas_sps_val[4:0] = {sas_sps_val[10], sas_sps_val[11], sas_sps_val[5], sas_sps_val[2], sas_sps_val[0]};

                $display("%0t:hpstate_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[3:0]);
            end // case: `HPSTATE
            `GL            : begin
                $display("%0t:gl_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[1:0]);
            end // case: `HPSTATE
            `HTSTATE1, `HTSTATE2, `HTSTATE3, `HTSTATE4, `HTSTATE5, `HTSTATE6 : begin
                $display("%0t:htstate%0d_reg-updated -> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, type_i - 108, spc, thread, window, rtl_reg_val[2:0]);
            end // case: `HTSTATE1, `HTSTATE2, `HTSTATE3, `HTSTATE4, `HTSTATE5, `HTSTATE6
            `ISFSR            : begin
                $display("%0t:isfsr_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[23:0]);
            end // case: `HPSTATE
            `DSFSR            : begin
                $display("%0t:dsfsr_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[23:0]);
            end // case: `HPSTATE
            `SFAR           : begin
                $display("%0t:sfar_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `HPSTATE
            `I_TAG_ACCESS          : begin
                $display("%0t:itag_access_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `I_TAG_ACCESS
            `D_TAG_ACCESS          : begin
                $display("%0t:dtag_access_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `D_TAG_ACCESS
            `CTXT_PRIM   : begin
                $display("%0t:ctxt_prim_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[12:0]);
            end // case: `CTXT_PRIM
            `CTXT_SEC   : begin
                $display("%0t:ctxt_sec_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[12:0]);
            end // case: `CTXT_SEC
            `I_CTXT_ZERO_PS0   : begin
                $display("%0t:i_ctxt_zero_ps0_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `I_CTXT_ZERO_PS0
            `D_CTXT_ZERO_PS0   : begin
                $display("%0t:d_ctxt_zero_ps0_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `D_CTXT_ZERO_PS0
            `I_CTXT_ZERO_PS1   : begin
                $display("%0t:i_ctxt_zero_ps1_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `I_CTXT_ZERO_PS1
            `D_CTXT_ZERO_PS1   : begin
                $display("%0t:d_ctxt_zero_ps1_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `D_CTXT_ZERO_PS0
            `I_CTXT_ZERO_CONFIG   : begin
                $display("%0t:i_ctxt_zero_config_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[5:0]);
            end // case: `I_CTXT_ZERO_CONFIG
            `D_CTXT_ZERO_CONFIG   : begin
                $display("%0t:d_ctxt_zero_config_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[5:0]);
            end // case: `D_CTXT_ZERO_CONFIG
            `I_CTXT_NONZERO_PS0   : begin
                $display("%0t:i_ctxt_nonzero_ps0_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `I_CTXT_ZERO_PS0
            `D_CTXT_NONZERO_PS0   : begin
                $display("%0t:d_ctxt_nonzero_ps0_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `D_CTXT_ZERO_PS0
            `I_CTXT_NONZERO_PS1   : begin
                $display("%0t:i_ctxt_nonzero_ps1_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `I_CTXT_ZERO_PS1
            `D_CTXT_NONZERO_PS1   : begin
                $display("%0t:d_ctxt_nonzero_ps1_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[47:0]);
            end // case: `D_CTXT_ZERO_PS0
            `I_CTXT_NONZERO_CONFIG   : begin
                $display("%0t:i_ctxt_nonzero_config_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[5:0]);
            end // case: `I_CTXT_ZERO_CONFIG
            `D_CTXT_NONZERO_CONFIG   : begin
                $display("%0t:d_ctxt_nonzero_config_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[5:0]);
            end // case: `D_CTXT_NONZERO_CONFIG
            `VA_WP_ADDR  : begin
                $display("%0t:va_wp_addr_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[44:0]);
            end // case: `VA_WP_ADDR
            `PID  : begin
                $display("%0t:pid_reg-updated-> spc(%1d) thread(%d) window(%d) val = %x",
                         $time, spc, thread, window, rtl_reg_val[2:0]);
            end // case: `VA_WP_ADDR
        endcase
    end
endtask
`endif // SAS_DISABLE

endmodule // sas_tasks
          // Local Variables:
          // verilog-library-directories:("." "../../../design/rtl")
          // verilog-library-extensions:(".v" ".h")
          // End:

