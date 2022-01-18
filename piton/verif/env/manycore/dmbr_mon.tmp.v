// Copyright (c) 2015 Princeton University
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Princeton University nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

/******************************************************************************
* Filename		: 	dmbr_mon.v
* Author		:	Alexey Lavrov
* Created		:	08/11/2014
* Company		:	Princeton University
* Email			: 	alavrov@pirnceton.edu
* Description	:	provides a set of simple monitors and checkers for dmbr
*******************************************************************************/
`include "dmbr_define.v"
`include "cross_module.tmp.h"

module dmbr_mon (
	input	clk
);

localparam TOTAL_CREDIT_WIDTH = `CREDIT_WIDTH + 4;	// 10 bins > 2^4 increasing in width

// /home/ruaro/nooman-openpiton/piton/verif/env/manycore/devices_ariane.xml


    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num0;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits0;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt0;
	   wire									rst_credits0;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num1;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits1;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt1;
	   wire									rst_credits1;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num2;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits2;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt2;
	   wire									rst_credits2;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num3;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits3;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt3;
	   wire									rst_credits3;
    assign total_credit_num0 =  `DMBR0.creditIn_0  +  `DMBR0.creditIn_1  +  `DMBR0.creditIn_2  +  `DMBR0.creditIn_3  +  `DMBR0.creditIn_4  +  `DMBR0.creditIn_5  +  `DMBR0.creditIn_6  +  `DMBR0.creditIn_7  +  `DMBR0.creditIn_8  +  `DMBR0.creditIn_9 ;
assign rst_credits0 = rep_cnt0 == `DMBR0.replenishCyclesIn;
    assign total_credit_num1 =  `DMBR1.creditIn_0  +  `DMBR1.creditIn_1  +  `DMBR1.creditIn_2  +  `DMBR1.creditIn_3  +  `DMBR1.creditIn_4  +  `DMBR1.creditIn_5  +  `DMBR1.creditIn_6  +  `DMBR1.creditIn_7  +  `DMBR1.creditIn_8  +  `DMBR1.creditIn_9 ;
assign rst_credits1 = rep_cnt1 == `DMBR1.replenishCyclesIn;
    assign total_credit_num2 =  `DMBR2.creditIn_0  +  `DMBR2.creditIn_1  +  `DMBR2.creditIn_2  +  `DMBR2.creditIn_3  +  `DMBR2.creditIn_4  +  `DMBR2.creditIn_5  +  `DMBR2.creditIn_6  +  `DMBR2.creditIn_7  +  `DMBR2.creditIn_8  +  `DMBR2.creditIn_9 ;
assign rst_credits2 = rep_cnt2 == `DMBR2.replenishCyclesIn;
    assign total_credit_num3 =  `DMBR3.creditIn_0  +  `DMBR3.creditIn_1  +  `DMBR3.creditIn_2  +  `DMBR3.creditIn_3  +  `DMBR3.creditIn_4  +  `DMBR3.creditIn_5  +  `DMBR3.creditIn_6  +  `DMBR3.creditIn_7  +  `DMBR3.creditIn_8  +  `DMBR3.creditIn_9 ;
assign rst_credits3 = rep_cnt3 == `DMBR3.replenishCyclesIn;



	
	always @(posedge `DMBR0.clk)
	begin
	if (`DMBR0.rst)
		used_credits0 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits0 <= `DMBR0.l1missIn													? used_credits0 + 1 :
						  `DMBR0.l2responseIn & ~`DMBR0.l2missIn & (used_credits0 > 0)	? used_credits0 - 1 :
						  rst_credits0														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits0 	;

if(`DMBR0.rst)
	    rep_cnt0 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt0 <= rst_credits0	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt0 + 1'b1;
end

	always @(posedge `DMBR1.clk)
	begin
	if (`DMBR1.rst)
		used_credits1 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits1 <= `DMBR1.l1missIn													? used_credits1 + 1 :
						  `DMBR1.l2responseIn & ~`DMBR1.l2missIn & (used_credits1 > 0)	? used_credits1 - 1 :
						  rst_credits1														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits1 	;

if(`DMBR1.rst)
	    rep_cnt1 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt1 <= rst_credits1	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt1 + 1'b1;
end

	always @(posedge `DMBR2.clk)
	begin
	if (`DMBR2.rst)
		used_credits2 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits2 <= `DMBR2.l1missIn													? used_credits2 + 1 :
						  `DMBR2.l2responseIn & ~`DMBR2.l2missIn & (used_credits2 > 0)	? used_credits2 - 1 :
						  rst_credits2														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits2 	;

if(`DMBR2.rst)
	    rep_cnt2 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt2 <= rst_credits2	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt2 + 1'b1;
end

	always @(posedge `DMBR3.clk)
	begin
	if (`DMBR3.rst)
		used_credits3 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits3 <= `DMBR3.l1missIn													? used_credits3 + 1 :
						  `DMBR3.l2responseIn & ~`DMBR3.l2missIn & (used_credits3 > 0)	? used_credits3 - 1 :
						  rst_credits3														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits3 	;

if(`DMBR3.rst)
	    rep_cnt3 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt3 <= rst_credits3	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt3 + 1'b1;
end



// Checker #1: check that the total number of credits in all
// bins isn't exceeded
`ifdef DMBR_CHECKER

	always @*
	begin
		if ((used_credits0 > (total_credit_num0 + 1) ) & `DMBR0.l1missIn)
		//if (used_credits0 > total_credit_num0)
		begin
			$display("\n***********************************************************");
			$display("DMBR0: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits1 > (total_credit_num1 + 1) ) & `DMBR1.l1missIn)
		//if (used_credits1 > total_credit_num1)
		begin
			$display("\n***********************************************************");
			$display("DMBR1: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits2 > (total_credit_num2 + 1) ) & `DMBR2.l1missIn)
		//if (used_credits2 > total_credit_num2)
		begin
			$display("\n***********************************************************");
			$display("DMBR2: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits3 > (total_credit_num3 + 1) ) & `DMBR3.l1missIn)
		//if (used_credits3 > total_credit_num3)
		begin
			$display("\n***********************************************************");
			$display("DMBR3: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

`endif

endmodule
