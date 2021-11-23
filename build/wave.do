onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cmp_top/system/chipset/chipset_clk
add wave -noupdate -radix decimal -radixshowbase 0 /cmp_top/network_mon/counter
add wave -noupdate /cmp_top/sys_rst_n
add wave -noupdate -group ChipInput -group NoC1_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc1_valid
add wave -noupdate -group ChipInput -group NoC1_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc1_data
add wave -noupdate -group ChipInput -group NoC1_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc1_yummy
add wave -noupdate -group ChipInput -group NoC2_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc2_valid
add wave -noupdate -group ChipInput -group NoC2_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc2_data
add wave -noupdate -group ChipInput -group NoC2_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc2_yummy
add wave -noupdate -group ChipInput -group NoC3_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc3_valid
add wave -noupdate -group ChipInput -group NoC3_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc3_data
add wave -noupdate -group ChipInput -group NoC3_In -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/offchip_processor_noc3_yummy
add wave -noupdate -group ChipOutput -group NoC1_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc1_valid
add wave -noupdate -group ChipOutput -group NoC1_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc1_data
add wave -noupdate -group ChipOutput -group NoC1_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc1_yummy
add wave -noupdate -group ChipOutput -group NoC2_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc2_valid
add wave -noupdate -group ChipOutput -group NoC2_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc2_data
add wave -noupdate -group ChipOutput -group NoC2_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc2_yummy
add wave -noupdate -group ChipOutput -group NoC3_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc3_valid
add wave -noupdate -group ChipOutput -group NoC3_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc3_data
add wave -noupdate -group ChipOutput -group NoC3_Out -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/processor_offchip_noc3_yummy
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].address_index}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].address_tag}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_wdata}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_req}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_we}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_be}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_size}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].kill_req}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Store-In(2)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].tag_valid}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].address_index}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].address_tag}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_wdata}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_req}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_we}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_be}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_size}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].kill_req}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-In(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].tag_valid}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-Out(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_o[1].data_gnt}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-Out(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_o[1].data_rvalid}
add wave -noupdate -group PE0x0 -group L1_0x0 -group Load-Out(1)-0x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_o[1].data_rdata}
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Store_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_store_unit/valid_i
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Store_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_store_unit/vaddr_o
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Store_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/lsu_ctrl.data
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Store_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_store_unit/valid_o
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Store_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/lsu_ctrl.be
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Load_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/valid_i
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Load_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/vaddr_o
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Load_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/valid_o
add wave -noupdate -group PE0x0 -group CPU_0x0 -group Load_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/result_o
add wave -noupdate -group PE0x0 -group CPU_0x0 -group ICacheInstru_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_frontend/icache_valid_q
add wave -noupdate -group PE0x0 -group CPU_0x0 -group ICacheInstru_0x0 -radix hexadecimal -radixshowbase 0 -label addr /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_frontend/icache_vaddr_q
add wave -noupdate -group PE0x0 -group CPU_0x0 -group ICacheInstru_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_frontend/i_bht/index
add wave -noupdate -group PE0x0 -group CPU_0x0 -group ICacheInstru_0x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/g_ariane_core/core/ariane/i_frontend/icache_data
add wave -noupdate -group PE0x0 -group Local_In -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_data_val_noc1
add wave -noupdate -group PE0x0 -group Local_In -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_data_noc1
add wave -noupdate -group PE0x0 -group Local_In -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_yummy_noc1
add wave -noupdate -group PE0x0 -group Local_In -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_data_val_noc2
add wave -noupdate -group PE0x0 -group Local_In -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_data_noc2
add wave -noupdate -group PE0x0 -group Local_In -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_yummy_noc2
add wave -noupdate -group PE0x0 -group Local_In -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_data_val_noc3
add wave -noupdate -group PE0x0 -group Local_In -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_data_noc3
add wave -noupdate -group PE0x0 -group Local_In -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_yummy_noc3
add wave -noupdate -group PE0x0 -group Local_Out -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_valid_noc1
add wave -noupdate -group PE0x0 -group Local_Out -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_data_noc1
add wave -noupdate -group PE0x0 -group Local_Out -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_consumed_noc1
add wave -noupdate -group PE0x0 -group Local_Out -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_valid_noc2
add wave -noupdate -group PE0x0 -group Local_Out -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_data_noc2
add wave -noupdate -group PE0x0 -group Local_Out -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_consumed_noc2
add wave -noupdate -group PE0x0 -group Local_Out -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_valid_noc3
add wave -noupdate -group PE0x0 -group Local_Out -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/buffer_router_data_noc3
add wave -noupdate -group PE0x0 -group Local_Out -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/router_buffer_consumed_noc3
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn0_validIn_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn0_dataIn_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn0_yummyOut_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn1_validIn_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn1_dataIn_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn1_yummyOut_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn2_validIn_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn2_dataIn_E
add wave -noupdate -group PE0x0 -group Routers -group Input-EAST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn2_yummyOut_E
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn0_dEo_valid
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn0_dEo
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn0_dEo_yummy
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn1_dEo_valid
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn1_dEo
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn1_dEo_yummy
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn2_dEo_valid
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn2_dEo
add wave -noupdate -group PE0x0 -group Routers -group Output-EAST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile0/dyn2_dEo_yummy
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].address_index}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].address_tag}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_wdata}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_req}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_we}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_be}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].data_size}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].kill_req}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Store-In(2)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[2].tag_valid}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].address_index}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].address_tag}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_wdata}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_req}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_we}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_be}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].data_size}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].kill_req}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-In(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_i[1].tag_valid}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-Out(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_o[1].data_gnt}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-Out(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_o[1].data_rvalid}
add wave -noupdate -group PE1x0 -group L1_1x0 -group Load-Out(1)-1x0 -radix hexadecimal -radixshowbase 0  {/cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_cache_subsystem/dcache_req_ports_o[1].data_rdata}
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Store_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_store_unit/valid_i
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Store_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_store_unit/vaddr_o
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Store_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/lsu_ctrl.data
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Store_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_store_unit/valid_o
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Store_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/lsu_ctrl.be
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Load_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/valid_i
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Load_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/vaddr_o
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Load_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/valid_o
add wave -noupdate -group PE1x0 -group CPU_1x0 -group Load_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/ex_stage_i/lsu_i/i_load_unit/result_o
add wave -noupdate -group PE1x0 -group CPU_1x0 -group ICacheInstru_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_frontend/icache_valid_q
add wave -noupdate -group PE1x0 -group CPU_1x0 -group ICacheInstru_1x0 -radix hexadecimal -radixshowbase 0 -label addr /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_frontend/icache_vaddr_q
add wave -noupdate -group PE1x0 -group CPU_1x0 -group ICacheInstru_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_frontend/i_bht/index
add wave -noupdate -group PE1x0 -group CPU_1x0 -group ICacheInstru_1x0 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/g_ariane_core/core/ariane/i_frontend/icache_data
add wave -noupdate -group PE1x0 -group Local_In -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_data_val_noc1
add wave -noupdate -group PE1x0 -group Local_In -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_data_noc1
add wave -noupdate -group PE1x0 -group Local_In -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_yummy_noc1
add wave -noupdate -group PE1x0 -group Local_In -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_data_val_noc2
add wave -noupdate -group PE1x0 -group Local_In -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_data_noc2
add wave -noupdate -group PE1x0 -group Local_In -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_yummy_noc2
add wave -noupdate -group PE1x0 -group Local_In -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_data_val_noc3
add wave -noupdate -group PE1x0 -group Local_In -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_data_noc3
add wave -noupdate -group PE1x0 -group Local_In -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_yummy_noc3
add wave -noupdate -group PE1x0 -group Local_Out -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_valid_noc1
add wave -noupdate -group PE1x0 -group Local_Out -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_data_noc1
add wave -noupdate -group PE1x0 -group Local_Out -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_consumed_noc1
add wave -noupdate -group PE1x0 -group Local_Out -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_valid_noc2
add wave -noupdate -group PE1x0 -group Local_Out -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_data_noc2
add wave -noupdate -group PE1x0 -group Local_Out -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_consumed_noc2
add wave -noupdate -group PE1x0 -group Local_Out -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_valid_noc3
add wave -noupdate -group PE1x0 -group Local_Out -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/buffer_router_data_noc3
add wave -noupdate -group PE1x0 -group Local_Out -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/router_buffer_consumed_noc3
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn0_validIn_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn0_dataIn_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn0_yummyOut_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn1_validIn_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn1_dataIn_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn1_yummyOut_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn2_validIn_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn2_dataIn_W
add wave -noupdate -group PE1x0 -group Routers -group Input-WEST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn2_yummyOut_W
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn0_dWo_valid
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn0_dWo
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC1 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn0_dWo_yummy
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn1_dWo_valid
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn1_dWo
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC2 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn1_dWo_yummy
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn2_dWo_valid
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn2_dWo
add wave -noupdate -group PE1x0 -group Routers -group Output-WEST -group NoC3 -radix hexadecimal -radixshowbase 0 /cmp_top/system/chip/tile1/dyn2_dWo_yummy

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {263 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 172
configure wave -valuecolwidth 132
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {33209400 ns}
