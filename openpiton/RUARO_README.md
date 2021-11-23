current frequency settings:
Chip:
Interconnect: 1000Mhz
FPGA: 200Mhz

TODO: clean variable names


# GENERATION WITH TRACE
sims -sys=manycore -vlt_build -vlt_build_args=--trace -vlt_build_args=-CFLAGS -vlt_build_args=-DVERILATOR_VCD -x_tiles=2 -y_tiles=1 -ariane -config_rtl=PITON_NO_JTAG -config_rtl=PITON_NO_CHIP_BRIDGE -config_rtl=PITON_CLKS_CHIPSET

GENERATION NO TRACE --FAST
sims -sys=manycore -vlt_build -x_tiles=2 -y_tiles=1 -ariane -config_rtl=PITON_NO_JTAG -config_rtl=PITON_NO_CHIP_BRIDGE -config_rtl=PITON_CLKS_CHIPSET

SIMULATION
sims -sys=manycore -vlt_run -x_tiles=2 -y_tiles=1 -ariane prod_cons_book.c -rtl_timeout=100000000 -max_cycle=50000000


---Others

# GENERATION
sims -sys=manycore -vlt_build -vlt_build_args=--trace -vlt_build_args=-CFLAGS -vlt_build_args=-DVERILATOR_VCD -x_tiles=2 -y_tiles=1 -ariane -config_rtl=DISABLE_ALL_MONITORS -config_rtl=PITON_NO_JTAG

# SEM BRIGE:
sims -sys=manycore -vlt_build -vlt_build_args=--trace -vlt_build_args=-CFLAGS -vlt_build_args=-DVERILATOR_VCD -x_tiles=2 -y_tiles=1 -ariane -config_rtl=DISABLE_ALL_MONITORS -config_rtl=PITON_NO_JTAG -config_rtl=PITON_NO_CHIP_BRIDGE -config_rtl=PITON_CLKS_CHIPSET





# ############ ESSA GERACAO EH QUE ESTA DE ACORDO COM O PDF DA VISAO GERAL ###############: 
sims -sys=manycore -vlt_build -x_tiles=2 -y_tiles=2 -ariane -config_rtl=PITON_NO_JTAG -config_rtl=PITON_NO_CHIP_BRIDGE -config_rtl=PITON_CLKS_CHIPSET


# ESSA GERACAO EH QUE ESTA DE ACORDO COM O PDF DA VISAO GERAL (waveform):
sims -sys=manycore -vlt_build -vlt_build_args=--trace -vlt_build_args=-CFLAGS -vlt_build_args=-DVERILATOR_VCD -x_tiles=2 -y_tiles=2 -ariane -config_rtl=PITON_NO_JTAG -config_rtl=PITON_NO_CHIP_BRIDGE -config_rtl=PITON_CLKS_CHIPSET


# OPEN GTK WAVE
gtkwave -o my_top.vcd teste.gtkw &

Perifheral connected to crossbar:

chip
mem
iob
uart
ariane_debug
ariane_bootrom
ariane_clint
ariane_plic

# MODULES TO REMOVE CHIP
* clock_mux
* io_clock_rst_sync
* jtag_port (e derivados)
* jtag_rst_sync
* oci_inst
* pll_top (e derivados)
* passthrouh

ifdef NEXYSVIDEO_BOARD
Tudo que estiver aqui dentro

`ifdef VC707_BOARD
Tudo que estiver aqui dentro

ifdef PITON_FPGA_ETHERNETLITE
Tudo que estiver aqui dentro


--Placas especificas de FPGA ver se está funcionando
ifdef GENESYS2_BOARD
ifdef NEXYSVIDEO_BOARD
ifdef VCU118_BOARD
ifdef VC707_BOARD
ifdef NEXYSVIDEO_BOARD
ifdef PITONSYS_INC_PASSTHRU
Tudo que estiver aqui dentro




# MODULES TO SHRINK 
* IOB (ciop_iob) - Simply generate a initial packet

