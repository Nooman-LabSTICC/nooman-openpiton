// Modified by Princeton University on June 9th, 2015
/*
* ========== Copyright Header Begin ==========================================
*
* OpenSPARC T1 Processor File: cross_module.h
* Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
* DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
*
* The above named program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License version 2 as published by the Free Software Foundation.
*
* The above named program is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this work; if not, write to the Free Software
* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
*
* ========== Copyright Header End ============================================
*/

`ifndef CROSS_MODULE_H
`define CROSS_MODULE_H



`define MONITOR_SIGNAL                 155
`define FLOAT_X                        154
`define FLOAT_I                        153
`define REG_WRITE_BACK                 152
`define PLI_QUIT                1    /* None */
`define PLI_SSTEP               2    /* %1 th id */
`define PLI_READ_TH_REG         3    /* %1 th id, %2 win num, %3 reg num */
`define PLI_READ_TH_CTL_REG     4    /* %1 th id, %2 reg num */
`define PLI_READ_TH_FP_REG_I    5    /* %1 th id, %2 reg num */
`define PLI_READ_TH_FP_REG_X    6    /* %1 th id, %2 reg num */
`define PLI_RTL_DATA            7
`define PLI_RTL_CYCLE           8
`define PLI_WRITE_TH_XCC_REG    9
`define PLI_FORCE_TRAP_TYPE            15
`define PLI_RESET_TLB_ENTRY     16
`define PLI_RETRY               30
`define PLI_WRITE_TH_REG_HI     10
`define PLI_WRITE_TH_REG        11
`define PLI_WRITE_TH_CTL_REG    12    /* %1 th id, %2 reg num, %3-%10 value */
`define CMD_BUFSIZE 10240

//define all cross module

// trin: defines for jtag test bench

`ifdef JTAG_TB_XMODULE
    `define TOP_MOD     jtag_testbench_top.helper
    `define SIM_TOP     jtag_testbench_top.helper
    `define TOP_MOD_INST `TOP_MOD
`else
    `define TOP_MOD     cmp_top
    `define SIM_TOP     cmp_top
    `define TOP_MOD_INST `TOP_MOD.system
// TODO: Alexey: use PITON_PROTO define ?
//`define TOP_MOD      fpga_top.cmp_top
`endif

//`define SIM_TOP fpga_top.cmp_top

    // `define TOP_SHELL    cmp_top_shell
`define CHIP         `TOP_MOD_INST.chip
`define CHIP_INT_CLK `CHIP.clk_muxed
`define TOP_DESIGN   `TOP_MOD.chip
`define FAKE_IOB     `TOP_MOD.system.chipset.chipset_impl.ciop_fake_iob
// `define TOP_MEMORY   `TOP_MOD.cmp

`define JTAG_CTAP    `CHIP.jtag_port.ctap
`define MONITOR_PATH `TOP_MOD.monitor
`define PC_CMP       `TOP_MOD.monitor.pc_cmp
`define SAS_SEND     `TOP_MOD.sas_tasks.send_cmd
`define SAS_DEF      `TOP_MOD.sas_tasks.sas_def
`define SAS_TASKS    `TOP_MOD.sas_tasks
`define CPX_INVALID_TIME 1000

// Note that the belows were generated through the template file and pyhp


    `define TILE0            `CHIP.tile0
    `define ARIANE_CORE0     `TILE0.g_ariane_core.core.ariane
    `define SPARC_CORE0      `TILE0.g_sparc_core.core
    `define PICO_CORE0       `TILE0.g_picorv32_core.core
    `ifdef RTL_SPARC0
    `define CORE_REF0        `SPARC_CORE0
    `endif // ifdef RTL_SPARC0
    `ifdef RTL_ARIANE0
    `define CORE_REF0        `TILE0.g_ariane_core.core
    `endif // ifdef RTL_ARIANE0
    `ifdef RTL_PICO0
    `define CORE_REF0        `PICO_CORE0
    `endif // ifdef RTL_PICO0
    `define CCX_TRANSDUCER0  `TILE0.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER0 `TILE0.g_picorv32_core.pico_l15_transducer
    `define L15_TOP0         `TILE0.l15.l15
    `define L15_PIPE0        `TILE0.l15.l15.pipeline
    `define DMBR0            `TILE0.dmbr_ins
    `define L2_TOP0          `TILE0.l2
    `define SPARC_REG0       `SPARC_CORE0.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH0       `SPARC_CORE0.sparc0.ffu.ffu
`else
    `define FLOATPATH0       `SPARC_CORE0.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH0         `SPARC_CORE0.sparc0.tlu.tlu
    `define DTLBPATH0        `SPARC_CORE0.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH0         `SPARC_CORE0.sparc0.tlu
    `define DTLBPATH0        `SPARC_CORE0.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH0         `SPARC_CORE0.sparc0
`ifndef RTL_SPU
    `define ICVPATH0         `SPARC_CORE0.sparc0.ifu.ifu.icv
    `define IFUPATH0         `SPARC_CORE0.sparc0.ifu.ifu
    `define TNUM0S           `SPARC_CORE0.sparc0.ifu.ifu.swl
    `define TPC0S            `SPARC_CORE0.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH0         `SPARC_CORE0.sparc0.ifu.icv
    `define IFUPATH0         `SPARC_CORE0.sparc0.ifu
    `define TNUM0S           `SPARC_CORE0.sparc0.ifu.swl
    `define TPC0S            `SPARC_CORE0.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH0         `SPARC_CORE0.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH0         `SPARC_CORE0.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH0         `SPARC_CORE0.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH0         `SPARC_CORE0.sparc0.ifu.fdp
`endif
    `define ALUPATH0         `SPARC_CORE0.sparc0.exu.exu.alu
    `define SPCPATH0         `SPARC_CORE0.sparc0
    `define REGPATH0         `SPARC_CORE0.sparc0.exu.exu.irf.irf
    `define CCRPATH0         `SPARC_CORE0.sparc0.exu.exu.ecl.ccr
    `define EXUPATH0         `SPARC_CORE0.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH0          `SPARC_CORE0.sparc0.tlu.tlu.tcl
    `define TS0PATH0         `SPARC_CORE0.sparc0.tlu.tlu.tsa0
    `define TS1PATH0         `SPARC_CORE0.sparc0.tlu.tlu.tsa1
    `define INTPATH0         `SPARC_CORE0.sparc0.tlu.tlu.intdp
    `define ASIPATH0         `SPARC_CORE0.sparc0.lsu.lsu.dctl
    `define ASIDPPATH0       `SPARC_CORE0.sparc0.lsu.lsu.dctldp
    `define ICTPATH0         `SPARC_CORE0.sparc0.ifu.ifu.ict
    `define DCACHE0          `SPARC_CORE0.sparc0.lsu.lsu.dcache
    `define INSTPATH0        `SPARC_CORE0.sparc0.ifu.ifu.fcl
    `define PCPATH0          `SPARC_CORE0.sparc0.ifu.ifu
    `define DVLD0            `SPARC_CORE0.sparc0.lsu.lsu.dva
    `define DTAG0            `SPARC_CORE0.sparc0.lsu.lsu.dtag
    `define SDTAG0           `SPARC_CORE0.sparc0.lsu.lsu.dtag
    `define SDVLD0           `SPARC_CORE0.sparc0.lsu.lsu.dva
    `define FFUPATH0         `SPARC_CORE0.sparc0.ffu.ffu
    `define TLU_HYPER0       `SPARC_CORE0.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP0           `SPARC_CORE0.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH0        `SPARC_CORE0.sparc0.ifu.ifu.itlb
`else
    `define TLPATH0          `SPARC_CORE0.sparc0.tlu.tcl
    `define TS0PATH0         `SPARC_CORE0.sparc0.tlu.tsa0
    `define TS1PATH0         `SPARC_CORE0.sparc0.tlu.tsa1
    `define INTPATH0         `SPARC_CORE0.sparc0.tlu.intdp
    `define ASIPATH0         `SPARC_CORE0.sparc0.lsu.dctl
    `define ASIDPPATH0       `SPARC_CORE0.sparc0.lsu.dctldp
    `define ICTPATH0         `SPARC_CORE0.sparc0.ifu.ict
    `define DCACHE0          `SPARC_CORE0.sparc0.lsu.dcache
    `define INSTPATH0        `SPARC_CORE0.sparc0.ifu.fcl
    `define PCPATH0          `SPARC_CORE0.sparc0.ifu
    `define DVLD0            `SPARC_CORE0.sparc0.lsu.dva
    `define DTAG0            `SPARC_CORE0.sparc0.lsu.dtag
    `define SDTAG0           `SPARC_CORE0.sparc0.lsu.dtag
    `define SDVLD0           `SPARC_CORE0.sparc0.lsu.dva
    `define FFUPATH0         `SPARC_CORE0.sparc0.ffu
    `define TLU_HYPER0       `SPARC_CORE0.sparc0.tlu.tlu_hyperv
    `define IFQDP0           `SPARC_CORE0.sparc0.ifu.ifqdp
    `define ITLBPATH0        `SPARC_CORE0.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH0    `SPARC_CORE0.sparc0.cfg_asi
    

    `define TILE1            `CHIP.tile1
    `define ARIANE_CORE1     `TILE1.g_ariane_core.core.ariane
    `define SPARC_CORE1      `TILE1.g_sparc_core.core
    `define PICO_CORE1       `TILE1.g_picorv32_core.core
    `ifdef RTL_SPARC1
    `define CORE_REF1        `SPARC_CORE1
    `endif // ifdef RTL_SPARC1
    `ifdef RTL_ARIANE1
    `define CORE_REF1        `TILE1.g_ariane_core.core
    `endif // ifdef RTL_ARIANE1
    `ifdef RTL_PICO1
    `define CORE_REF1        `PICO_CORE1
    `endif // ifdef RTL_PICO1
    `define CCX_TRANSDUCER1  `TILE1.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER1 `TILE1.g_picorv32_core.pico_l15_transducer
    `define L15_TOP1         `TILE1.l15.l15
    `define L15_PIPE1        `TILE1.l15.l15.pipeline
    `define DMBR1            `TILE1.dmbr_ins
    `define L2_TOP1          `TILE1.l2
    `define SPARC_REG1       `SPARC_CORE1.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH1       `SPARC_CORE1.sparc0.ffu.ffu
`else
    `define FLOATPATH1       `SPARC_CORE1.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH1         `SPARC_CORE1.sparc0.tlu.tlu
    `define DTLBPATH1        `SPARC_CORE1.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH1         `SPARC_CORE1.sparc0.tlu
    `define DTLBPATH1        `SPARC_CORE1.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH1         `SPARC_CORE1.sparc0
`ifndef RTL_SPU
    `define ICVPATH1         `SPARC_CORE1.sparc0.ifu.ifu.icv
    `define IFUPATH1         `SPARC_CORE1.sparc0.ifu.ifu
    `define TNUM1S           `SPARC_CORE1.sparc0.ifu.ifu.swl
    `define TPC1S            `SPARC_CORE1.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH1         `SPARC_CORE1.sparc0.ifu.icv
    `define IFUPATH1         `SPARC_CORE1.sparc0.ifu
    `define TNUM1S           `SPARC_CORE1.sparc0.ifu.swl
    `define TPC1S            `SPARC_CORE1.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH1         `SPARC_CORE1.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH1         `SPARC_CORE1.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH1         `SPARC_CORE1.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH1         `SPARC_CORE1.sparc0.ifu.fdp
`endif
    `define ALUPATH1         `SPARC_CORE1.sparc0.exu.exu.alu
    `define SPCPATH1         `SPARC_CORE1.sparc0
    `define REGPATH1         `SPARC_CORE1.sparc0.exu.exu.irf.irf
    `define CCRPATH1         `SPARC_CORE1.sparc0.exu.exu.ecl.ccr
    `define EXUPATH1         `SPARC_CORE1.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH1          `SPARC_CORE1.sparc0.tlu.tlu.tcl
    `define TS0PATH1         `SPARC_CORE1.sparc0.tlu.tlu.tsa0
    `define TS1PATH1         `SPARC_CORE1.sparc0.tlu.tlu.tsa1
    `define INTPATH1         `SPARC_CORE1.sparc0.tlu.tlu.intdp
    `define ASIPATH1         `SPARC_CORE1.sparc0.lsu.lsu.dctl
    `define ASIDPPATH1       `SPARC_CORE1.sparc0.lsu.lsu.dctldp
    `define ICTPATH1         `SPARC_CORE1.sparc0.ifu.ifu.ict
    `define DCACHE1          `SPARC_CORE1.sparc0.lsu.lsu.dcache
    `define INSTPATH1        `SPARC_CORE1.sparc0.ifu.ifu.fcl
    `define PCPATH1          `SPARC_CORE1.sparc0.ifu.ifu
    `define DVLD1            `SPARC_CORE1.sparc0.lsu.lsu.dva
    `define DTAG1            `SPARC_CORE1.sparc0.lsu.lsu.dtag
    `define SDTAG1           `SPARC_CORE1.sparc0.lsu.lsu.dtag
    `define SDVLD1           `SPARC_CORE1.sparc0.lsu.lsu.dva
    `define FFUPATH1         `SPARC_CORE1.sparc0.ffu.ffu
    `define TLU_HYPER1       `SPARC_CORE1.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP1           `SPARC_CORE1.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH1        `SPARC_CORE1.sparc0.ifu.ifu.itlb
`else
    `define TLPATH1          `SPARC_CORE1.sparc0.tlu.tcl
    `define TS0PATH1         `SPARC_CORE1.sparc0.tlu.tsa0
    `define TS1PATH1         `SPARC_CORE1.sparc0.tlu.tsa1
    `define INTPATH1         `SPARC_CORE1.sparc0.tlu.intdp
    `define ASIPATH1         `SPARC_CORE1.sparc0.lsu.dctl
    `define ASIDPPATH1       `SPARC_CORE1.sparc0.lsu.dctldp
    `define ICTPATH1         `SPARC_CORE1.sparc0.ifu.ict
    `define DCACHE1          `SPARC_CORE1.sparc0.lsu.dcache
    `define INSTPATH1        `SPARC_CORE1.sparc0.ifu.fcl
    `define PCPATH1          `SPARC_CORE1.sparc0.ifu
    `define DVLD1            `SPARC_CORE1.sparc0.lsu.dva
    `define DTAG1            `SPARC_CORE1.sparc0.lsu.dtag
    `define SDTAG1           `SPARC_CORE1.sparc0.lsu.dtag
    `define SDVLD1           `SPARC_CORE1.sparc0.lsu.dva
    `define FFUPATH1         `SPARC_CORE1.sparc0.ffu
    `define TLU_HYPER1       `SPARC_CORE1.sparc0.tlu.tlu_hyperv
    `define IFQDP1           `SPARC_CORE1.sparc0.ifu.ifqdp
    `define ITLBPATH1        `SPARC_CORE1.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH1    `SPARC_CORE1.sparc0.cfg_asi
    

    `define TILE2            `CHIP.tile2
    `define ARIANE_CORE2     `TILE2.g_ariane_core.core.ariane
    `define SPARC_CORE2      `TILE2.g_sparc_core.core
    `define PICO_CORE2       `TILE2.g_picorv32_core.core
    `ifdef RTL_SPARC2
    `define CORE_REF2        `SPARC_CORE2
    `endif // ifdef RTL_SPARC2
    `ifdef RTL_ARIANE2
    `define CORE_REF2        `TILE2.g_ariane_core.core
    `endif // ifdef RTL_ARIANE2
    `ifdef RTL_PICO2
    `define CORE_REF2        `PICO_CORE2
    `endif // ifdef RTL_PICO2
    `define CCX_TRANSDUCER2  `TILE2.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER2 `TILE2.g_picorv32_core.pico_l15_transducer
    `define L15_TOP2         `TILE2.l15.l15
    `define L15_PIPE2        `TILE2.l15.l15.pipeline
    `define DMBR2            `TILE2.dmbr_ins
    `define L2_TOP2          `TILE2.l2
    `define SPARC_REG2       `SPARC_CORE2.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH2       `SPARC_CORE2.sparc0.ffu.ffu
`else
    `define FLOATPATH2       `SPARC_CORE2.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH2         `SPARC_CORE2.sparc0.tlu.tlu
    `define DTLBPATH2        `SPARC_CORE2.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH2         `SPARC_CORE2.sparc0.tlu
    `define DTLBPATH2        `SPARC_CORE2.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH2         `SPARC_CORE2.sparc0
`ifndef RTL_SPU
    `define ICVPATH2         `SPARC_CORE2.sparc0.ifu.ifu.icv
    `define IFUPATH2         `SPARC_CORE2.sparc0.ifu.ifu
    `define TNUM2S           `SPARC_CORE2.sparc0.ifu.ifu.swl
    `define TPC2S            `SPARC_CORE2.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH2         `SPARC_CORE2.sparc0.ifu.icv
    `define IFUPATH2         `SPARC_CORE2.sparc0.ifu
    `define TNUM2S           `SPARC_CORE2.sparc0.ifu.swl
    `define TPC2S            `SPARC_CORE2.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH2         `SPARC_CORE2.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH2         `SPARC_CORE2.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH2         `SPARC_CORE2.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH2         `SPARC_CORE2.sparc0.ifu.fdp
`endif
    `define ALUPATH2         `SPARC_CORE2.sparc0.exu.exu.alu
    `define SPCPATH2         `SPARC_CORE2.sparc0
    `define REGPATH2         `SPARC_CORE2.sparc0.exu.exu.irf.irf
    `define CCRPATH2         `SPARC_CORE2.sparc0.exu.exu.ecl.ccr
    `define EXUPATH2         `SPARC_CORE2.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH2          `SPARC_CORE2.sparc0.tlu.tlu.tcl
    `define TS0PATH2         `SPARC_CORE2.sparc0.tlu.tlu.tsa0
    `define TS1PATH2         `SPARC_CORE2.sparc0.tlu.tlu.tsa1
    `define INTPATH2         `SPARC_CORE2.sparc0.tlu.tlu.intdp
    `define ASIPATH2         `SPARC_CORE2.sparc0.lsu.lsu.dctl
    `define ASIDPPATH2       `SPARC_CORE2.sparc0.lsu.lsu.dctldp
    `define ICTPATH2         `SPARC_CORE2.sparc0.ifu.ifu.ict
    `define DCACHE2          `SPARC_CORE2.sparc0.lsu.lsu.dcache
    `define INSTPATH2        `SPARC_CORE2.sparc0.ifu.ifu.fcl
    `define PCPATH2          `SPARC_CORE2.sparc0.ifu.ifu
    `define DVLD2            `SPARC_CORE2.sparc0.lsu.lsu.dva
    `define DTAG2            `SPARC_CORE2.sparc0.lsu.lsu.dtag
    `define SDTAG2           `SPARC_CORE2.sparc0.lsu.lsu.dtag
    `define SDVLD2           `SPARC_CORE2.sparc0.lsu.lsu.dva
    `define FFUPATH2         `SPARC_CORE2.sparc0.ffu.ffu
    `define TLU_HYPER2       `SPARC_CORE2.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP2           `SPARC_CORE2.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH2        `SPARC_CORE2.sparc0.ifu.ifu.itlb
`else
    `define TLPATH2          `SPARC_CORE2.sparc0.tlu.tcl
    `define TS0PATH2         `SPARC_CORE2.sparc0.tlu.tsa0
    `define TS1PATH2         `SPARC_CORE2.sparc0.tlu.tsa1
    `define INTPATH2         `SPARC_CORE2.sparc0.tlu.intdp
    `define ASIPATH2         `SPARC_CORE2.sparc0.lsu.dctl
    `define ASIDPPATH2       `SPARC_CORE2.sparc0.lsu.dctldp
    `define ICTPATH2         `SPARC_CORE2.sparc0.ifu.ict
    `define DCACHE2          `SPARC_CORE2.sparc0.lsu.dcache
    `define INSTPATH2        `SPARC_CORE2.sparc0.ifu.fcl
    `define PCPATH2          `SPARC_CORE2.sparc0.ifu
    `define DVLD2            `SPARC_CORE2.sparc0.lsu.dva
    `define DTAG2            `SPARC_CORE2.sparc0.lsu.dtag
    `define SDTAG2           `SPARC_CORE2.sparc0.lsu.dtag
    `define SDVLD2           `SPARC_CORE2.sparc0.lsu.dva
    `define FFUPATH2         `SPARC_CORE2.sparc0.ffu
    `define TLU_HYPER2       `SPARC_CORE2.sparc0.tlu.tlu_hyperv
    `define IFQDP2           `SPARC_CORE2.sparc0.ifu.ifqdp
    `define ITLBPATH2        `SPARC_CORE2.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH2    `SPARC_CORE2.sparc0.cfg_asi
    

    `define TILE3            `CHIP.tile3
    `define ARIANE_CORE3     `TILE3.g_ariane_core.core.ariane
    `define SPARC_CORE3      `TILE3.g_sparc_core.core
    `define PICO_CORE3       `TILE3.g_picorv32_core.core
    `ifdef RTL_SPARC3
    `define CORE_REF3        `SPARC_CORE3
    `endif // ifdef RTL_SPARC3
    `ifdef RTL_ARIANE3
    `define CORE_REF3        `TILE3.g_ariane_core.core
    `endif // ifdef RTL_ARIANE3
    `ifdef RTL_PICO3
    `define CORE_REF3        `PICO_CORE3
    `endif // ifdef RTL_PICO3
    `define CCX_TRANSDUCER3  `TILE3.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER3 `TILE3.g_picorv32_core.pico_l15_transducer
    `define L15_TOP3         `TILE3.l15.l15
    `define L15_PIPE3        `TILE3.l15.l15.pipeline
    `define DMBR3            `TILE3.dmbr_ins
    `define L2_TOP3          `TILE3.l2
    `define SPARC_REG3       `SPARC_CORE3.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH3       `SPARC_CORE3.sparc0.ffu.ffu
`else
    `define FLOATPATH3       `SPARC_CORE3.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH3         `SPARC_CORE3.sparc0.tlu.tlu
    `define DTLBPATH3        `SPARC_CORE3.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH3         `SPARC_CORE3.sparc0.tlu
    `define DTLBPATH3        `SPARC_CORE3.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH3         `SPARC_CORE3.sparc0
`ifndef RTL_SPU
    `define ICVPATH3         `SPARC_CORE3.sparc0.ifu.ifu.icv
    `define IFUPATH3         `SPARC_CORE3.sparc0.ifu.ifu
    `define TNUM3S           `SPARC_CORE3.sparc0.ifu.ifu.swl
    `define TPC3S            `SPARC_CORE3.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH3         `SPARC_CORE3.sparc0.ifu.icv
    `define IFUPATH3         `SPARC_CORE3.sparc0.ifu
    `define TNUM3S           `SPARC_CORE3.sparc0.ifu.swl
    `define TPC3S            `SPARC_CORE3.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH3         `SPARC_CORE3.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH3         `SPARC_CORE3.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH3         `SPARC_CORE3.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH3         `SPARC_CORE3.sparc0.ifu.fdp
`endif
    `define ALUPATH3         `SPARC_CORE3.sparc0.exu.exu.alu
    `define SPCPATH3         `SPARC_CORE3.sparc0
    `define REGPATH3         `SPARC_CORE3.sparc0.exu.exu.irf.irf
    `define CCRPATH3         `SPARC_CORE3.sparc0.exu.exu.ecl.ccr
    `define EXUPATH3         `SPARC_CORE3.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH3          `SPARC_CORE3.sparc0.tlu.tlu.tcl
    `define TS0PATH3         `SPARC_CORE3.sparc0.tlu.tlu.tsa0
    `define TS1PATH3         `SPARC_CORE3.sparc0.tlu.tlu.tsa1
    `define INTPATH3         `SPARC_CORE3.sparc0.tlu.tlu.intdp
    `define ASIPATH3         `SPARC_CORE3.sparc0.lsu.lsu.dctl
    `define ASIDPPATH3       `SPARC_CORE3.sparc0.lsu.lsu.dctldp
    `define ICTPATH3         `SPARC_CORE3.sparc0.ifu.ifu.ict
    `define DCACHE3          `SPARC_CORE3.sparc0.lsu.lsu.dcache
    `define INSTPATH3        `SPARC_CORE3.sparc0.ifu.ifu.fcl
    `define PCPATH3          `SPARC_CORE3.sparc0.ifu.ifu
    `define DVLD3            `SPARC_CORE3.sparc0.lsu.lsu.dva
    `define DTAG3            `SPARC_CORE3.sparc0.lsu.lsu.dtag
    `define SDTAG3           `SPARC_CORE3.sparc0.lsu.lsu.dtag
    `define SDVLD3           `SPARC_CORE3.sparc0.lsu.lsu.dva
    `define FFUPATH3         `SPARC_CORE3.sparc0.ffu.ffu
    `define TLU_HYPER3       `SPARC_CORE3.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP3           `SPARC_CORE3.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH3        `SPARC_CORE3.sparc0.ifu.ifu.itlb
`else
    `define TLPATH3          `SPARC_CORE3.sparc0.tlu.tcl
    `define TS0PATH3         `SPARC_CORE3.sparc0.tlu.tsa0
    `define TS1PATH3         `SPARC_CORE3.sparc0.tlu.tsa1
    `define INTPATH3         `SPARC_CORE3.sparc0.tlu.intdp
    `define ASIPATH3         `SPARC_CORE3.sparc0.lsu.dctl
    `define ASIDPPATH3       `SPARC_CORE3.sparc0.lsu.dctldp
    `define ICTPATH3         `SPARC_CORE3.sparc0.ifu.ict
    `define DCACHE3          `SPARC_CORE3.sparc0.lsu.dcache
    `define INSTPATH3        `SPARC_CORE3.sparc0.ifu.fcl
    `define PCPATH3          `SPARC_CORE3.sparc0.ifu
    `define DVLD3            `SPARC_CORE3.sparc0.lsu.dva
    `define DTAG3            `SPARC_CORE3.sparc0.lsu.dtag
    `define SDTAG3           `SPARC_CORE3.sparc0.lsu.dtag
    `define SDVLD3           `SPARC_CORE3.sparc0.lsu.dva
    `define FFUPATH3         `SPARC_CORE3.sparc0.ffu
    `define TLU_HYPER3       `SPARC_CORE3.sparc0.tlu.tlu_hyperv
    `define IFQDP3           `SPARC_CORE3.sparc0.ifu.ifqdp
    `define ITLBPATH3        `SPARC_CORE3.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH3    `SPARC_CORE3.sparc0.cfg_asi
    

    `define TILE4            `CHIP.tile4
    `define ARIANE_CORE4     `TILE4.g_ariane_core.core.ariane
    `define SPARC_CORE4      `TILE4.g_sparc_core.core
    `define PICO_CORE4       `TILE4.g_picorv32_core.core
    `ifdef RTL_SPARC4
    `define CORE_REF4        `SPARC_CORE4
    `endif // ifdef RTL_SPARC4
    `ifdef RTL_ARIANE4
    `define CORE_REF4        `TILE4.g_ariane_core.core
    `endif // ifdef RTL_ARIANE4
    `ifdef RTL_PICO4
    `define CORE_REF4        `PICO_CORE4
    `endif // ifdef RTL_PICO4
    `define CCX_TRANSDUCER4  `TILE4.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER4 `TILE4.g_picorv32_core.pico_l15_transducer
    `define L15_TOP4         `TILE4.l15.l15
    `define L15_PIPE4        `TILE4.l15.l15.pipeline
    `define DMBR4            `TILE4.dmbr_ins
    `define L2_TOP4          `TILE4.l2
    `define SPARC_REG4       `SPARC_CORE4.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH4       `SPARC_CORE4.sparc0.ffu.ffu
`else
    `define FLOATPATH4       `SPARC_CORE4.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH4         `SPARC_CORE4.sparc0.tlu.tlu
    `define DTLBPATH4        `SPARC_CORE4.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH4         `SPARC_CORE4.sparc0.tlu
    `define DTLBPATH4        `SPARC_CORE4.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH4         `SPARC_CORE4.sparc0
`ifndef RTL_SPU
    `define ICVPATH4         `SPARC_CORE4.sparc0.ifu.ifu.icv
    `define IFUPATH4         `SPARC_CORE4.sparc0.ifu.ifu
    `define TNUM4S           `SPARC_CORE4.sparc0.ifu.ifu.swl
    `define TPC4S            `SPARC_CORE4.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH4         `SPARC_CORE4.sparc0.ifu.icv
    `define IFUPATH4         `SPARC_CORE4.sparc0.ifu
    `define TNUM4S           `SPARC_CORE4.sparc0.ifu.swl
    `define TPC4S            `SPARC_CORE4.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH4         `SPARC_CORE4.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH4         `SPARC_CORE4.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH4         `SPARC_CORE4.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH4         `SPARC_CORE4.sparc0.ifu.fdp
`endif
    `define ALUPATH4         `SPARC_CORE4.sparc0.exu.exu.alu
    `define SPCPATH4         `SPARC_CORE4.sparc0
    `define REGPATH4         `SPARC_CORE4.sparc0.exu.exu.irf.irf
    `define CCRPATH4         `SPARC_CORE4.sparc0.exu.exu.ecl.ccr
    `define EXUPATH4         `SPARC_CORE4.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH4          `SPARC_CORE4.sparc0.tlu.tlu.tcl
    `define TS0PATH4         `SPARC_CORE4.sparc0.tlu.tlu.tsa0
    `define TS1PATH4         `SPARC_CORE4.sparc0.tlu.tlu.tsa1
    `define INTPATH4         `SPARC_CORE4.sparc0.tlu.tlu.intdp
    `define ASIPATH4         `SPARC_CORE4.sparc0.lsu.lsu.dctl
    `define ASIDPPATH4       `SPARC_CORE4.sparc0.lsu.lsu.dctldp
    `define ICTPATH4         `SPARC_CORE4.sparc0.ifu.ifu.ict
    `define DCACHE4          `SPARC_CORE4.sparc0.lsu.lsu.dcache
    `define INSTPATH4        `SPARC_CORE4.sparc0.ifu.ifu.fcl
    `define PCPATH4          `SPARC_CORE4.sparc0.ifu.ifu
    `define DVLD4            `SPARC_CORE4.sparc0.lsu.lsu.dva
    `define DTAG4            `SPARC_CORE4.sparc0.lsu.lsu.dtag
    `define SDTAG4           `SPARC_CORE4.sparc0.lsu.lsu.dtag
    `define SDVLD4           `SPARC_CORE4.sparc0.lsu.lsu.dva
    `define FFUPATH4         `SPARC_CORE4.sparc0.ffu.ffu
    `define TLU_HYPER4       `SPARC_CORE4.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP4           `SPARC_CORE4.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH4        `SPARC_CORE4.sparc0.ifu.ifu.itlb
`else
    `define TLPATH4          `SPARC_CORE4.sparc0.tlu.tcl
    `define TS0PATH4         `SPARC_CORE4.sparc0.tlu.tsa0
    `define TS1PATH4         `SPARC_CORE4.sparc0.tlu.tsa1
    `define INTPATH4         `SPARC_CORE4.sparc0.tlu.intdp
    `define ASIPATH4         `SPARC_CORE4.sparc0.lsu.dctl
    `define ASIDPPATH4       `SPARC_CORE4.sparc0.lsu.dctldp
    `define ICTPATH4         `SPARC_CORE4.sparc0.ifu.ict
    `define DCACHE4          `SPARC_CORE4.sparc0.lsu.dcache
    `define INSTPATH4        `SPARC_CORE4.sparc0.ifu.fcl
    `define PCPATH4          `SPARC_CORE4.sparc0.ifu
    `define DVLD4            `SPARC_CORE4.sparc0.lsu.dva
    `define DTAG4            `SPARC_CORE4.sparc0.lsu.dtag
    `define SDTAG4           `SPARC_CORE4.sparc0.lsu.dtag
    `define SDVLD4           `SPARC_CORE4.sparc0.lsu.dva
    `define FFUPATH4         `SPARC_CORE4.sparc0.ffu
    `define TLU_HYPER4       `SPARC_CORE4.sparc0.tlu.tlu_hyperv
    `define IFQDP4           `SPARC_CORE4.sparc0.ifu.ifqdp
    `define ITLBPATH4        `SPARC_CORE4.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH4    `SPARC_CORE4.sparc0.cfg_asi
    

    `define TILE5            `CHIP.tile5
    `define ARIANE_CORE5     `TILE5.g_ariane_core.core.ariane
    `define SPARC_CORE5      `TILE5.g_sparc_core.core
    `define PICO_CORE5       `TILE5.g_picorv32_core.core
    `ifdef RTL_SPARC5
    `define CORE_REF5        `SPARC_CORE5
    `endif // ifdef RTL_SPARC5
    `ifdef RTL_ARIANE5
    `define CORE_REF5        `TILE5.g_ariane_core.core
    `endif // ifdef RTL_ARIANE5
    `ifdef RTL_PICO5
    `define CORE_REF5        `PICO_CORE5
    `endif // ifdef RTL_PICO5
    `define CCX_TRANSDUCER5  `TILE5.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER5 `TILE5.g_picorv32_core.pico_l15_transducer
    `define L15_TOP5         `TILE5.l15.l15
    `define L15_PIPE5        `TILE5.l15.l15.pipeline
    `define DMBR5            `TILE5.dmbr_ins
    `define L2_TOP5          `TILE5.l2
    `define SPARC_REG5       `SPARC_CORE5.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH5       `SPARC_CORE5.sparc0.ffu.ffu
`else
    `define FLOATPATH5       `SPARC_CORE5.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH5         `SPARC_CORE5.sparc0.tlu.tlu
    `define DTLBPATH5        `SPARC_CORE5.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH5         `SPARC_CORE5.sparc0.tlu
    `define DTLBPATH5        `SPARC_CORE5.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH5         `SPARC_CORE5.sparc0
`ifndef RTL_SPU
    `define ICVPATH5         `SPARC_CORE5.sparc0.ifu.ifu.icv
    `define IFUPATH5         `SPARC_CORE5.sparc0.ifu.ifu
    `define TNUM5S           `SPARC_CORE5.sparc0.ifu.ifu.swl
    `define TPC5S            `SPARC_CORE5.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH5         `SPARC_CORE5.sparc0.ifu.icv
    `define IFUPATH5         `SPARC_CORE5.sparc0.ifu
    `define TNUM5S           `SPARC_CORE5.sparc0.ifu.swl
    `define TPC5S            `SPARC_CORE5.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH5         `SPARC_CORE5.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH5         `SPARC_CORE5.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH5         `SPARC_CORE5.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH5         `SPARC_CORE5.sparc0.ifu.fdp
`endif
    `define ALUPATH5         `SPARC_CORE5.sparc0.exu.exu.alu
    `define SPCPATH5         `SPARC_CORE5.sparc0
    `define REGPATH5         `SPARC_CORE5.sparc0.exu.exu.irf.irf
    `define CCRPATH5         `SPARC_CORE5.sparc0.exu.exu.ecl.ccr
    `define EXUPATH5         `SPARC_CORE5.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH5          `SPARC_CORE5.sparc0.tlu.tlu.tcl
    `define TS0PATH5         `SPARC_CORE5.sparc0.tlu.tlu.tsa0
    `define TS1PATH5         `SPARC_CORE5.sparc0.tlu.tlu.tsa1
    `define INTPATH5         `SPARC_CORE5.sparc0.tlu.tlu.intdp
    `define ASIPATH5         `SPARC_CORE5.sparc0.lsu.lsu.dctl
    `define ASIDPPATH5       `SPARC_CORE5.sparc0.lsu.lsu.dctldp
    `define ICTPATH5         `SPARC_CORE5.sparc0.ifu.ifu.ict
    `define DCACHE5          `SPARC_CORE5.sparc0.lsu.lsu.dcache
    `define INSTPATH5        `SPARC_CORE5.sparc0.ifu.ifu.fcl
    `define PCPATH5          `SPARC_CORE5.sparc0.ifu.ifu
    `define DVLD5            `SPARC_CORE5.sparc0.lsu.lsu.dva
    `define DTAG5            `SPARC_CORE5.sparc0.lsu.lsu.dtag
    `define SDTAG5           `SPARC_CORE5.sparc0.lsu.lsu.dtag
    `define SDVLD5           `SPARC_CORE5.sparc0.lsu.lsu.dva
    `define FFUPATH5         `SPARC_CORE5.sparc0.ffu.ffu
    `define TLU_HYPER5       `SPARC_CORE5.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP5           `SPARC_CORE5.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH5        `SPARC_CORE5.sparc0.ifu.ifu.itlb
`else
    `define TLPATH5          `SPARC_CORE5.sparc0.tlu.tcl
    `define TS0PATH5         `SPARC_CORE5.sparc0.tlu.tsa0
    `define TS1PATH5         `SPARC_CORE5.sparc0.tlu.tsa1
    `define INTPATH5         `SPARC_CORE5.sparc0.tlu.intdp
    `define ASIPATH5         `SPARC_CORE5.sparc0.lsu.dctl
    `define ASIDPPATH5       `SPARC_CORE5.sparc0.lsu.dctldp
    `define ICTPATH5         `SPARC_CORE5.sparc0.ifu.ict
    `define DCACHE5          `SPARC_CORE5.sparc0.lsu.dcache
    `define INSTPATH5        `SPARC_CORE5.sparc0.ifu.fcl
    `define PCPATH5          `SPARC_CORE5.sparc0.ifu
    `define DVLD5            `SPARC_CORE5.sparc0.lsu.dva
    `define DTAG5            `SPARC_CORE5.sparc0.lsu.dtag
    `define SDTAG5           `SPARC_CORE5.sparc0.lsu.dtag
    `define SDVLD5           `SPARC_CORE5.sparc0.lsu.dva
    `define FFUPATH5         `SPARC_CORE5.sparc0.ffu
    `define TLU_HYPER5       `SPARC_CORE5.sparc0.tlu.tlu_hyperv
    `define IFQDP5           `SPARC_CORE5.sparc0.ifu.ifqdp
    `define ITLBPATH5        `SPARC_CORE5.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH5    `SPARC_CORE5.sparc0.cfg_asi
    

    `define TILE6            `CHIP.tile6
    `define ARIANE_CORE6     `TILE6.g_ariane_core.core.ariane
    `define SPARC_CORE6      `TILE6.g_sparc_core.core
    `define PICO_CORE6       `TILE6.g_picorv32_core.core
    `ifdef RTL_SPARC6
    `define CORE_REF6        `SPARC_CORE6
    `endif // ifdef RTL_SPARC6
    `ifdef RTL_ARIANE6
    `define CORE_REF6        `TILE6.g_ariane_core.core
    `endif // ifdef RTL_ARIANE6
    `ifdef RTL_PICO6
    `define CORE_REF6        `PICO_CORE6
    `endif // ifdef RTL_PICO6
    `define CCX_TRANSDUCER6  `TILE6.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER6 `TILE6.g_picorv32_core.pico_l15_transducer
    `define L15_TOP6         `TILE6.l15.l15
    `define L15_PIPE6        `TILE6.l15.l15.pipeline
    `define DMBR6            `TILE6.dmbr_ins
    `define L2_TOP6          `TILE6.l2
    `define SPARC_REG6       `SPARC_CORE6.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH6       `SPARC_CORE6.sparc0.ffu.ffu
`else
    `define FLOATPATH6       `SPARC_CORE6.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH6         `SPARC_CORE6.sparc0.tlu.tlu
    `define DTLBPATH6        `SPARC_CORE6.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH6         `SPARC_CORE6.sparc0.tlu
    `define DTLBPATH6        `SPARC_CORE6.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH6         `SPARC_CORE6.sparc0
`ifndef RTL_SPU
    `define ICVPATH6         `SPARC_CORE6.sparc0.ifu.ifu.icv
    `define IFUPATH6         `SPARC_CORE6.sparc0.ifu.ifu
    `define TNUM6S           `SPARC_CORE6.sparc0.ifu.ifu.swl
    `define TPC6S            `SPARC_CORE6.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH6         `SPARC_CORE6.sparc0.ifu.icv
    `define IFUPATH6         `SPARC_CORE6.sparc0.ifu
    `define TNUM6S           `SPARC_CORE6.sparc0.ifu.swl
    `define TPC6S            `SPARC_CORE6.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH6         `SPARC_CORE6.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH6         `SPARC_CORE6.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH6         `SPARC_CORE6.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH6         `SPARC_CORE6.sparc0.ifu.fdp
`endif
    `define ALUPATH6         `SPARC_CORE6.sparc0.exu.exu.alu
    `define SPCPATH6         `SPARC_CORE6.sparc0
    `define REGPATH6         `SPARC_CORE6.sparc0.exu.exu.irf.irf
    `define CCRPATH6         `SPARC_CORE6.sparc0.exu.exu.ecl.ccr
    `define EXUPATH6         `SPARC_CORE6.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH6          `SPARC_CORE6.sparc0.tlu.tlu.tcl
    `define TS0PATH6         `SPARC_CORE6.sparc0.tlu.tlu.tsa0
    `define TS1PATH6         `SPARC_CORE6.sparc0.tlu.tlu.tsa1
    `define INTPATH6         `SPARC_CORE6.sparc0.tlu.tlu.intdp
    `define ASIPATH6         `SPARC_CORE6.sparc0.lsu.lsu.dctl
    `define ASIDPPATH6       `SPARC_CORE6.sparc0.lsu.lsu.dctldp
    `define ICTPATH6         `SPARC_CORE6.sparc0.ifu.ifu.ict
    `define DCACHE6          `SPARC_CORE6.sparc0.lsu.lsu.dcache
    `define INSTPATH6        `SPARC_CORE6.sparc0.ifu.ifu.fcl
    `define PCPATH6          `SPARC_CORE6.sparc0.ifu.ifu
    `define DVLD6            `SPARC_CORE6.sparc0.lsu.lsu.dva
    `define DTAG6            `SPARC_CORE6.sparc0.lsu.lsu.dtag
    `define SDTAG6           `SPARC_CORE6.sparc0.lsu.lsu.dtag
    `define SDVLD6           `SPARC_CORE6.sparc0.lsu.lsu.dva
    `define FFUPATH6         `SPARC_CORE6.sparc0.ffu.ffu
    `define TLU_HYPER6       `SPARC_CORE6.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP6           `SPARC_CORE6.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH6        `SPARC_CORE6.sparc0.ifu.ifu.itlb
`else
    `define TLPATH6          `SPARC_CORE6.sparc0.tlu.tcl
    `define TS0PATH6         `SPARC_CORE6.sparc0.tlu.tsa0
    `define TS1PATH6         `SPARC_CORE6.sparc0.tlu.tsa1
    `define INTPATH6         `SPARC_CORE6.sparc0.tlu.intdp
    `define ASIPATH6         `SPARC_CORE6.sparc0.lsu.dctl
    `define ASIDPPATH6       `SPARC_CORE6.sparc0.lsu.dctldp
    `define ICTPATH6         `SPARC_CORE6.sparc0.ifu.ict
    `define DCACHE6          `SPARC_CORE6.sparc0.lsu.dcache
    `define INSTPATH6        `SPARC_CORE6.sparc0.ifu.fcl
    `define PCPATH6          `SPARC_CORE6.sparc0.ifu
    `define DVLD6            `SPARC_CORE6.sparc0.lsu.dva
    `define DTAG6            `SPARC_CORE6.sparc0.lsu.dtag
    `define SDTAG6           `SPARC_CORE6.sparc0.lsu.dtag
    `define SDVLD6           `SPARC_CORE6.sparc0.lsu.dva
    `define FFUPATH6         `SPARC_CORE6.sparc0.ffu
    `define TLU_HYPER6       `SPARC_CORE6.sparc0.tlu.tlu_hyperv
    `define IFQDP6           `SPARC_CORE6.sparc0.ifu.ifqdp
    `define ITLBPATH6        `SPARC_CORE6.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH6    `SPARC_CORE6.sparc0.cfg_asi
    

    `define TILE7            `CHIP.tile7
    `define ARIANE_CORE7     `TILE7.g_ariane_core.core.ariane
    `define SPARC_CORE7      `TILE7.g_sparc_core.core
    `define PICO_CORE7       `TILE7.g_picorv32_core.core
    `ifdef RTL_SPARC7
    `define CORE_REF7        `SPARC_CORE7
    `endif // ifdef RTL_SPARC7
    `ifdef RTL_ARIANE7
    `define CORE_REF7        `TILE7.g_ariane_core.core
    `endif // ifdef RTL_ARIANE7
    `ifdef RTL_PICO7
    `define CORE_REF7        `PICO_CORE7
    `endif // ifdef RTL_PICO7
    `define CCX_TRANSDUCER7  `TILE7.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER7 `TILE7.g_picorv32_core.pico_l15_transducer
    `define L15_TOP7         `TILE7.l15.l15
    `define L15_PIPE7        `TILE7.l15.l15.pipeline
    `define DMBR7            `TILE7.dmbr_ins
    `define L2_TOP7          `TILE7.l2
    `define SPARC_REG7       `SPARC_CORE7.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH7       `SPARC_CORE7.sparc0.ffu.ffu
`else
    `define FLOATPATH7       `SPARC_CORE7.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH7         `SPARC_CORE7.sparc0.tlu.tlu
    `define DTLBPATH7        `SPARC_CORE7.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH7         `SPARC_CORE7.sparc0.tlu
    `define DTLBPATH7        `SPARC_CORE7.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH7         `SPARC_CORE7.sparc0
`ifndef RTL_SPU
    `define ICVPATH7         `SPARC_CORE7.sparc0.ifu.ifu.icv
    `define IFUPATH7         `SPARC_CORE7.sparc0.ifu.ifu
    `define TNUM7S           `SPARC_CORE7.sparc0.ifu.ifu.swl
    `define TPC7S            `SPARC_CORE7.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH7         `SPARC_CORE7.sparc0.ifu.icv
    `define IFUPATH7         `SPARC_CORE7.sparc0.ifu
    `define TNUM7S           `SPARC_CORE7.sparc0.ifu.swl
    `define TPC7S            `SPARC_CORE7.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH7         `SPARC_CORE7.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH7         `SPARC_CORE7.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH7         `SPARC_CORE7.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH7         `SPARC_CORE7.sparc0.ifu.fdp
`endif
    `define ALUPATH7         `SPARC_CORE7.sparc0.exu.exu.alu
    `define SPCPATH7         `SPARC_CORE7.sparc0
    `define REGPATH7         `SPARC_CORE7.sparc0.exu.exu.irf.irf
    `define CCRPATH7         `SPARC_CORE7.sparc0.exu.exu.ecl.ccr
    `define EXUPATH7         `SPARC_CORE7.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH7          `SPARC_CORE7.sparc0.tlu.tlu.tcl
    `define TS0PATH7         `SPARC_CORE7.sparc0.tlu.tlu.tsa0
    `define TS1PATH7         `SPARC_CORE7.sparc0.tlu.tlu.tsa1
    `define INTPATH7         `SPARC_CORE7.sparc0.tlu.tlu.intdp
    `define ASIPATH7         `SPARC_CORE7.sparc0.lsu.lsu.dctl
    `define ASIDPPATH7       `SPARC_CORE7.sparc0.lsu.lsu.dctldp
    `define ICTPATH7         `SPARC_CORE7.sparc0.ifu.ifu.ict
    `define DCACHE7          `SPARC_CORE7.sparc0.lsu.lsu.dcache
    `define INSTPATH7        `SPARC_CORE7.sparc0.ifu.ifu.fcl
    `define PCPATH7          `SPARC_CORE7.sparc0.ifu.ifu
    `define DVLD7            `SPARC_CORE7.sparc0.lsu.lsu.dva
    `define DTAG7            `SPARC_CORE7.sparc0.lsu.lsu.dtag
    `define SDTAG7           `SPARC_CORE7.sparc0.lsu.lsu.dtag
    `define SDVLD7           `SPARC_CORE7.sparc0.lsu.lsu.dva
    `define FFUPATH7         `SPARC_CORE7.sparc0.ffu.ffu
    `define TLU_HYPER7       `SPARC_CORE7.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP7           `SPARC_CORE7.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH7        `SPARC_CORE7.sparc0.ifu.ifu.itlb
`else
    `define TLPATH7          `SPARC_CORE7.sparc0.tlu.tcl
    `define TS0PATH7         `SPARC_CORE7.sparc0.tlu.tsa0
    `define TS1PATH7         `SPARC_CORE7.sparc0.tlu.tsa1
    `define INTPATH7         `SPARC_CORE7.sparc0.tlu.intdp
    `define ASIPATH7         `SPARC_CORE7.sparc0.lsu.dctl
    `define ASIDPPATH7       `SPARC_CORE7.sparc0.lsu.dctldp
    `define ICTPATH7         `SPARC_CORE7.sparc0.ifu.ict
    `define DCACHE7          `SPARC_CORE7.sparc0.lsu.dcache
    `define INSTPATH7        `SPARC_CORE7.sparc0.ifu.fcl
    `define PCPATH7          `SPARC_CORE7.sparc0.ifu
    `define DVLD7            `SPARC_CORE7.sparc0.lsu.dva
    `define DTAG7            `SPARC_CORE7.sparc0.lsu.dtag
    `define SDTAG7           `SPARC_CORE7.sparc0.lsu.dtag
    `define SDVLD7           `SPARC_CORE7.sparc0.lsu.dva
    `define FFUPATH7         `SPARC_CORE7.sparc0.ffu
    `define TLU_HYPER7       `SPARC_CORE7.sparc0.tlu.tlu_hyperv
    `define IFQDP7           `SPARC_CORE7.sparc0.ifu.ifqdp
    `define ITLBPATH7        `SPARC_CORE7.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH7    `SPARC_CORE7.sparc0.cfg_asi
    

    `define TILE8            `CHIP.tile8
    `define ARIANE_CORE8     `TILE8.g_ariane_core.core.ariane
    `define SPARC_CORE8      `TILE8.g_sparc_core.core
    `define PICO_CORE8       `TILE8.g_picorv32_core.core
    `ifdef RTL_SPARC8
    `define CORE_REF8        `SPARC_CORE8
    `endif // ifdef RTL_SPARC8
    `ifdef RTL_ARIANE8
    `define CORE_REF8        `TILE8.g_ariane_core.core
    `endif // ifdef RTL_ARIANE8
    `ifdef RTL_PICO8
    `define CORE_REF8        `PICO_CORE8
    `endif // ifdef RTL_PICO8
    `define CCX_TRANSDUCER8  `TILE8.g_sparc_core.ccx_l15_transducer
    `define PICO_TRANSDUCER8 `TILE8.g_picorv32_core.pico_l15_transducer
    `define L15_TOP8         `TILE8.l15.l15
    `define L15_PIPE8        `TILE8.l15.l15.pipeline
    `define DMBR8            `TILE8.dmbr_ins
    `define L2_TOP8          `TILE8.l2
    `define SPARC_REG8       `SPARC_CORE8.sparc0.exu.exu.irf.irf
`ifndef RTL_SPU
    `define FLOATPATH8       `SPARC_CORE8.sparc0.ffu.ffu
`else
    `define FLOATPATH8       `SPARC_CORE8.sparc0.ffu
`endif
`ifndef RTL_SPU
    `define TLUPATH8         `SPARC_CORE8.sparc0.tlu.tlu
    `define DTLBPATH8        `SPARC_CORE8.sparc0.lsu.lsu.dtlb
`else
    `define TLUPATH8         `SPARC_CORE8.sparc0.tlu
    `define DTLBPATH8        `SPARC_CORE8.sparc0.lsu.dtlb
`endif
`ifndef RTL_SPU
    `define LSU_PATH sparc0.lsu.lsu
`else
    `define LSU_PATH sparc0.lsu
`endif
    `define PCXPATH8         `SPARC_CORE8.sparc0
`ifndef RTL_SPU
    `define ICVPATH8         `SPARC_CORE8.sparc0.ifu.ifu.icv
    `define IFUPATH8         `SPARC_CORE8.sparc0.ifu.ifu
    `define TNUM8S           `SPARC_CORE8.sparc0.ifu.ifu.swl
    `define TPC8S            `SPARC_CORE8.sparc0.ifu.ifu.fdp
`else
    `define ICVPATH8         `SPARC_CORE8.sparc0.ifu.icv
    `define IFUPATH8         `SPARC_CORE8.sparc0.ifu
    `define TNUM8S           `SPARC_CORE8.sparc0.ifu.swl
    `define TPC8S            `SPARC_CORE8.sparc0.ifu.fdp
`endif
`ifndef RTL_SPU
    `define TDPPATH8         `SPARC_CORE8.sparc0.tlu.tlu.tdp
`else
    `define TDPPATH8         `SPARC_CORE8.sparc0.tlu.tdp
`endif
`ifndef RTL_SPU
    `define DTUPATH8         `SPARC_CORE8.sparc0.ifu.ifu.fdp
`else
    `define DTUPATH8         `SPARC_CORE8.sparc0.ifu.fdp
`endif
    `define ALUPATH8         `SPARC_CORE8.sparc0.exu.exu.alu
    `define SPCPATH8         `SPARC_CORE8.sparc0
    `define REGPATH8         `SPARC_CORE8.sparc0.exu.exu.irf.irf
    `define CCRPATH8         `SPARC_CORE8.sparc0.exu.exu.ecl.ccr
    `define EXUPATH8         `SPARC_CORE8.sparc0.exu.exu
`ifndef RTL_SPU
    `define TLPATH8          `SPARC_CORE8.sparc0.tlu.tlu.tcl
    `define TS0PATH8         `SPARC_CORE8.sparc0.tlu.tlu.tsa0
    `define TS1PATH8         `SPARC_CORE8.sparc0.tlu.tlu.tsa1
    `define INTPATH8         `SPARC_CORE8.sparc0.tlu.tlu.intdp
    `define ASIPATH8         `SPARC_CORE8.sparc0.lsu.lsu.dctl
    `define ASIDPPATH8       `SPARC_CORE8.sparc0.lsu.lsu.dctldp
    `define ICTPATH8         `SPARC_CORE8.sparc0.ifu.ifu.ict
    `define DCACHE8          `SPARC_CORE8.sparc0.lsu.lsu.dcache
    `define INSTPATH8        `SPARC_CORE8.sparc0.ifu.ifu.fcl
    `define PCPATH8          `SPARC_CORE8.sparc0.ifu.ifu
    `define DVLD8            `SPARC_CORE8.sparc0.lsu.lsu.dva
    `define DTAG8            `SPARC_CORE8.sparc0.lsu.lsu.dtag
    `define SDTAG8           `SPARC_CORE8.sparc0.lsu.lsu.dtag
    `define SDVLD8           `SPARC_CORE8.sparc0.lsu.lsu.dva
    `define FFUPATH8         `SPARC_CORE8.sparc0.ffu.ffu
    `define TLU_HYPER8       `SPARC_CORE8.sparc0.tlu.tlu.tlu_hyperv
    `define IFQDP8           `SPARC_CORE8.sparc0.ifu.ifu.ifqdp
    `define ITLBPATH8        `SPARC_CORE8.sparc0.ifu.ifu.itlb
`else
    `define TLPATH8          `SPARC_CORE8.sparc0.tlu.tcl
    `define TS0PATH8         `SPARC_CORE8.sparc0.tlu.tsa0
    `define TS1PATH8         `SPARC_CORE8.sparc0.tlu.tsa1
    `define INTPATH8         `SPARC_CORE8.sparc0.tlu.intdp
    `define ASIPATH8         `SPARC_CORE8.sparc0.lsu.dctl
    `define ASIDPPATH8       `SPARC_CORE8.sparc0.lsu.dctldp
    `define ICTPATH8         `SPARC_CORE8.sparc0.ifu.ict
    `define DCACHE8          `SPARC_CORE8.sparc0.lsu.dcache
    `define INSTPATH8        `SPARC_CORE8.sparc0.ifu.fcl
    `define PCPATH8          `SPARC_CORE8.sparc0.ifu
    `define DVLD8            `SPARC_CORE8.sparc0.lsu.dva
    `define DTAG8            `SPARC_CORE8.sparc0.lsu.dtag
    `define SDTAG8           `SPARC_CORE8.sparc0.lsu.dtag
    `define SDVLD8           `SPARC_CORE8.sparc0.lsu.dva
    `define FFUPATH8         `SPARC_CORE8.sparc0.ffu
    `define TLU_HYPER8       `SPARC_CORE8.sparc0.tlu.tlu_hyperv
    `define IFQDP8           `SPARC_CORE8.sparc0.ifu.ifqdp
    `define ITLBPATH8        `SPARC_CORE8.sparc0.ifu.itlb
`endif
    `define CFG_ASI_PATH8    `SPARC_CORE8.sparc0.cfg_asi
    


`define ITAG0           `TOP_MOD.monitor.l_cache_mon0
`define IVLD0           `TOP_MOD.monitor.l_cache_mon0
`define SAS_INTER `TOP_MOD.sas_intf
`ifndef RTL_SPU
`define STNUM `SPARC_CORE0.sparc0.ifu.ifu.dtu.swl
`define STPC  `SPARC_CORE0.sparc0.ifu.ifu.fdp
`else
`define STNUM `SPARC_CORE0.sparc0.ifu.dtu.swl
`define STPC  `SPARC_CORE0.sparc0.ifu.fdp
`endif
`define MONITOR `TOP_MOD.monitor

`endif
