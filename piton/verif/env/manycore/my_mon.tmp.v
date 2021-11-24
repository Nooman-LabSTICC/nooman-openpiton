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

// /home/ruaro/nooman-openpiton/piton/verif/env/manycore/devices_ariane.xml
`define NUM_TILES 9


/*

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

    */

module my_mon(
    input wire clk
);

parameter TILE_NUM=1;
localparam NR_COMMIT_PORTS = 2;

integer counter = 0;

//Output file
integer fd;  


integer i;
initial begin
    fd = $fopen("debug/mem_cpu_log.txt", "w");  
    $fclose(fd); 
end

//Note: access to L1.5 are not token in account becuase in: "Power and Energy Characterization of an Open Source 25-Core Manycore Processor" HPCA'18.
//The Authors of OpenPiton claim that
/* 
The L1.5 cache is basically a replica of the L1 cache, 
but is write-back. Thus, a miss in the L1 will also miss 
in the L1.5. However, it is important to note that the 
energy to access the L1.5 is included in all results in 
Table VII except for L1 hit.
*/
//In case of L1 hit there is no access to L1.5

//*************************************** MEMORY STATISTICS *************************************************

always @ (posedge clk)
begin
    counter <= counter + 1;
    
    //L1-I cache miss. This value is provided by the performance counter implemented by Ariane: perf_counters.sv
    
    //L1-D cache miss. This value is provided by the performance counter implemented by Ariane: perf_counters.sv
    
    //Cache L1-I access
    //The strategy is observe when the signal from core to icache is valid. This signal will be only stay active to every new instruction.

    //LD I and D access
    //Store and Load L1-D access. To account only store, observe only interface 2, to account only Loads, oberve only interface 1
    //The strategy of this observation consists in monitor the frequency data cache issue a data granted signal to core, informing 
    //that memory operation (load or store) was sucessifully concluded.

    //LD-D amo access
    //The strategy is similar. Observe the ack signal sent from the memory to the core, informing that the last AMO was concluded.

    //L2 access, miss, and RAM access
    //The signals of miss and access were estracted from the dedicated registers used by L2 to implement performance counters.
    //To account the generation of a new LOAD_MEM it is being tested the signal inside the pipe1, which generate packets o LOAD_MEM
    //Observe that LOAD_MEM not necessarely means a DRAM_ACCESS. They represent any access to an external peripheric, included DRAM, IOB, boot, UART.

    //DRAM access - signals comes from fake_mem_ctrl.v

   //Core 0x0 Index: 0
    if(`ARIANE_CORE0.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:0",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE0.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:0",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE0.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:0",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE0.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:0",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE0.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:0",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE0.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:0",counter);
        $fclose(fd);
    end
    if(`L2_TOP0.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:0",counter);
        $fclose(fd);
    end
    if(`L2_TOP0.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:0",counter);
        $fclose(fd);
    end
    if(`L2_TOP0.pipe1.msg_send_valid && `L2_TOP0.pipe1.msg_send_ready && (`L2_TOP0.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:0",counter);
        $fclose(fd);
    end

   //Core 1x0 Index: 1
    if(`ARIANE_CORE1.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:256",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE1.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:256",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE1.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:256",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE1.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:256",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE1.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:256",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE1.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:256",counter);
        $fclose(fd);
    end
    if(`L2_TOP1.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:256",counter);
        $fclose(fd);
    end
    if(`L2_TOP1.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:256",counter);
        $fclose(fd);
    end
    if(`L2_TOP1.pipe1.msg_send_valid && `L2_TOP1.pipe1.msg_send_ready && (`L2_TOP1.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:256",counter);
        $fclose(fd);
    end

   //Core 2x0 Index: 2
    if(`ARIANE_CORE2.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:512",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE2.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:512",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE2.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:512",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE2.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:512",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE2.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:512",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE2.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:512",counter);
        $fclose(fd);
    end
    if(`L2_TOP2.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:512",counter);
        $fclose(fd);
    end
    if(`L2_TOP2.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:512",counter);
        $fclose(fd);
    end
    if(`L2_TOP2.pipe1.msg_send_valid && `L2_TOP2.pipe1.msg_send_ready && (`L2_TOP2.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:512",counter);
        $fclose(fd);
    end

   //Core 0x1 Index: 3
    if(`ARIANE_CORE3.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:1",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE3.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:1",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE3.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:1",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE3.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:1",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE3.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:1",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE3.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:1",counter);
        $fclose(fd);
    end
    if(`L2_TOP3.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:1",counter);
        $fclose(fd);
    end
    if(`L2_TOP3.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:1",counter);
        $fclose(fd);
    end
    if(`L2_TOP3.pipe1.msg_send_valid && `L2_TOP3.pipe1.msg_send_ready && (`L2_TOP3.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:1",counter);
        $fclose(fd);
    end

   //Core 1x1 Index: 4
    if(`ARIANE_CORE4.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:257",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE4.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:257",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE4.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:257",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE4.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:257",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE4.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:257",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE4.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:257",counter);
        $fclose(fd);
    end
    if(`L2_TOP4.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:257",counter);
        $fclose(fd);
    end
    if(`L2_TOP4.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:257",counter);
        $fclose(fd);
    end
    if(`L2_TOP4.pipe1.msg_send_valid && `L2_TOP4.pipe1.msg_send_ready && (`L2_TOP4.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:257",counter);
        $fclose(fd);
    end

   //Core 2x1 Index: 5
    if(`ARIANE_CORE5.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:513",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE5.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:513",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE5.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:513",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE5.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:513",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE5.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:513",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE5.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:513",counter);
        $fclose(fd);
    end
    if(`L2_TOP5.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:513",counter);
        $fclose(fd);
    end
    if(`L2_TOP5.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:513",counter);
        $fclose(fd);
    end
    if(`L2_TOP5.pipe1.msg_send_valid && `L2_TOP5.pipe1.msg_send_ready && (`L2_TOP5.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:513",counter);
        $fclose(fd);
    end

   //Core 0x2 Index: 6
    if(`ARIANE_CORE6.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:2",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE6.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:2",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE6.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:2",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE6.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:2",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE6.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:2",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE6.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:2",counter);
        $fclose(fd);
    end
    if(`L2_TOP6.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:2",counter);
        $fclose(fd);
    end
    if(`L2_TOP6.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:2",counter);
        $fclose(fd);
    end
    if(`L2_TOP6.pipe1.msg_send_valid && `L2_TOP6.pipe1.msg_send_ready && (`L2_TOP6.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:2",counter);
        $fclose(fd);
    end

   //Core 1x2 Index: 7
    if(`ARIANE_CORE7.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:258",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE7.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:258",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE7.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:258",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE7.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:258",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE7.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:258",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE7.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:258",counter);
        $fclose(fd);
    end
    if(`L2_TOP7.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:258",counter);
        $fclose(fd);
    end
    if(`L2_TOP7.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:258",counter);
        $fclose(fd);
    end
    if(`L2_TOP7.pipe1.msg_send_valid && `L2_TOP7.pipe1.msg_send_ready && (`L2_TOP7.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:258",counter);
        $fclose(fd);
    end

   //Core 2x2 Index: 8
    if(`ARIANE_CORE8.icache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Imiss:%0d:514",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE8.dcache_miss_cache_perf) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Dmiss:%0d:514",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE8.i_cache_subsystem.dcache_req_ports_o[1].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:514",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE8.i_cache_subsystem.dcache_req_ports_o[2].data_gnt) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Daccess:%0d:514",counter);
        $fclose(fd);
    end
    //Includes AMO access
    if(`ARIANE_CORE8.i_cache_subsystem.dcache_amo_resp_o.ack) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Damo access:%0d:514",counter);
        $fclose(fd);
    end
    if(`ARIANE_CORE8.i_frontend.icache_valid_q) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L1-Iaccess:%0d:514",counter);
        $fclose(fd);
    end
    if(`L2_TOP8.l2_miss_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2miss:%0d:514",counter);
        $fclose(fd);
    end
    if(`L2_TOP8.l2_access_valid) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2access:%0d:514",counter);
        $fclose(fd);
    end
    if(`L2_TOP8.pipe1.msg_send_valid && `L2_TOP8.pipe1.msg_send_ready && (`L2_TOP8.pipe1.msg_send_mode == 3'h4)) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"L2LOAD_MEM:%0d:514",counter);
        $fclose(fd);
    end

    if (`TOP_MOD_INST.chipset.chipset_impl.fake_mem_ctrl.mem_valid_in && `TOP_MOD_INST.chipset.chipset_impl.fake_mem_ctrl.mem_ready_in) begin
        fd = $fopen("debug/mem_cpu_log.txt", "a");
        $fdisplay(fd,"DRAMaccess:%0d-all", counter);
        $fclose(fd);
    end

    //*************************************** END MEMORY STATISTICS *************************************************


    //*************************************** INSTRUCTION STATISTICS ************************************************
    //Implemented inside piton/design/chip/tile/ariane/src/perf_counters.sv
 //if (`ARIANE_CORE0.commit_instr_id_commit
 //if (`ARIANE_CORE0.commit_ack)
 /*
    for tile in range (NUM_TILES):
        tile_str = str(tile)
        print "    for ( i = 0; i < NR_COMMIT_PORTS-1; i = i + 1) begin"
        print "        if (`ARIANE_CORE0.commit_ack[i]) begin"
        print "            if (`ARIANE_CORE0.commit_instr_id_commit[i].fu == LOAD) begin"
        print "                $fdisplay(fd,\"LOAD tile"+tile_str+"\");"
        print "            end"  
        print "        end"
        print "    end"
    */

end

endmodule

