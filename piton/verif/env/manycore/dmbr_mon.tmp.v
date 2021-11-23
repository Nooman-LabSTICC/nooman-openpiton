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

// /home/ruaro/openpiton/piton/verif/env/manycore/devices_ariane.xml


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
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num4;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits4;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt4;
	   wire									rst_credits4;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num5;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits5;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt5;
	   wire									rst_credits5;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num6;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits6;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt6;
	   wire									rst_credits6;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num7;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits7;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt7;
	   wire									rst_credits7;
    wire [TOTAL_CREDIT_WIDTH - 1 : 0]	total_credit_num8;
	   reg	[TOTAL_CREDIT_WIDTH - 1 : 0]	used_credits8;
    reg 	[`REPLENISH_WIDTH - 1 : 0]		rep_cnt8;
	   wire									rst_credits8;
    assign total_credit_num0 =  `DMBR0.creditIn_0  +  `DMBR0.creditIn_1  +  `DMBR0.creditIn_2  +  `DMBR0.creditIn_3  +  `DMBR0.creditIn_4  +  `DMBR0.creditIn_5  +  `DMBR0.creditIn_6  +  `DMBR0.creditIn_7  +  `DMBR0.creditIn_8  +  `DMBR0.creditIn_9 ;
assign rst_credits0 = rep_cnt0 == `DMBR0.replenishCyclesIn;
    assign total_credit_num1 =  `DMBR1.creditIn_0  +  `DMBR1.creditIn_1  +  `DMBR1.creditIn_2  +  `DMBR1.creditIn_3  +  `DMBR1.creditIn_4  +  `DMBR1.creditIn_5  +  `DMBR1.creditIn_6  +  `DMBR1.creditIn_7  +  `DMBR1.creditIn_8  +  `DMBR1.creditIn_9 ;
assign rst_credits1 = rep_cnt1 == `DMBR1.replenishCyclesIn;
    assign total_credit_num2 =  `DMBR2.creditIn_0  +  `DMBR2.creditIn_1  +  `DMBR2.creditIn_2  +  `DMBR2.creditIn_3  +  `DMBR2.creditIn_4  +  `DMBR2.creditIn_5  +  `DMBR2.creditIn_6  +  `DMBR2.creditIn_7  +  `DMBR2.creditIn_8  +  `DMBR2.creditIn_9 ;
assign rst_credits2 = rep_cnt2 == `DMBR2.replenishCyclesIn;
    assign total_credit_num3 =  `DMBR3.creditIn_0  +  `DMBR3.creditIn_1  +  `DMBR3.creditIn_2  +  `DMBR3.creditIn_3  +  `DMBR3.creditIn_4  +  `DMBR3.creditIn_5  +  `DMBR3.creditIn_6  +  `DMBR3.creditIn_7  +  `DMBR3.creditIn_8  +  `DMBR3.creditIn_9 ;
assign rst_credits3 = rep_cnt3 == `DMBR3.replenishCyclesIn;
    assign total_credit_num4 =  `DMBR4.creditIn_0  +  `DMBR4.creditIn_1  +  `DMBR4.creditIn_2  +  `DMBR4.creditIn_3  +  `DMBR4.creditIn_4  +  `DMBR4.creditIn_5  +  `DMBR4.creditIn_6  +  `DMBR4.creditIn_7  +  `DMBR4.creditIn_8  +  `DMBR4.creditIn_9 ;
assign rst_credits4 = rep_cnt4 == `DMBR4.replenishCyclesIn;
    assign total_credit_num5 =  `DMBR5.creditIn_0  +  `DMBR5.creditIn_1  +  `DMBR5.creditIn_2  +  `DMBR5.creditIn_3  +  `DMBR5.creditIn_4  +  `DMBR5.creditIn_5  +  `DMBR5.creditIn_6  +  `DMBR5.creditIn_7  +  `DMBR5.creditIn_8  +  `DMBR5.creditIn_9 ;
assign rst_credits5 = rep_cnt5 == `DMBR5.replenishCyclesIn;
    assign total_credit_num6 =  `DMBR6.creditIn_0  +  `DMBR6.creditIn_1  +  `DMBR6.creditIn_2  +  `DMBR6.creditIn_3  +  `DMBR6.creditIn_4  +  `DMBR6.creditIn_5  +  `DMBR6.creditIn_6  +  `DMBR6.creditIn_7  +  `DMBR6.creditIn_8  +  `DMBR6.creditIn_9 ;
assign rst_credits6 = rep_cnt6 == `DMBR6.replenishCyclesIn;
    assign total_credit_num7 =  `DMBR7.creditIn_0  +  `DMBR7.creditIn_1  +  `DMBR7.creditIn_2  +  `DMBR7.creditIn_3  +  `DMBR7.creditIn_4  +  `DMBR7.creditIn_5  +  `DMBR7.creditIn_6  +  `DMBR7.creditIn_7  +  `DMBR7.creditIn_8  +  `DMBR7.creditIn_9 ;
assign rst_credits7 = rep_cnt7 == `DMBR7.replenishCyclesIn;
    assign total_credit_num8 =  `DMBR8.creditIn_0  +  `DMBR8.creditIn_1  +  `DMBR8.creditIn_2  +  `DMBR8.creditIn_3  +  `DMBR8.creditIn_4  +  `DMBR8.creditIn_5  +  `DMBR8.creditIn_6  +  `DMBR8.creditIn_7  +  `DMBR8.creditIn_8  +  `DMBR8.creditIn_9 ;
assign rst_credits8 = rep_cnt8 == `DMBR8.replenishCyclesIn;



	
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

	always @(posedge `DMBR4.clk)
	begin
	if (`DMBR4.rst)
		used_credits4 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits4 <= `DMBR4.l1missIn													? used_credits4 + 1 :
						  `DMBR4.l2responseIn & ~`DMBR4.l2missIn & (used_credits4 > 0)	? used_credits4 - 1 :
						  rst_credits4														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits4 	;

if(`DMBR4.rst)
	    rep_cnt4 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt4 <= rst_credits4	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt4 + 1'b1;
end

	always @(posedge `DMBR5.clk)
	begin
	if (`DMBR5.rst)
		used_credits5 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits5 <= `DMBR5.l1missIn													? used_credits5 + 1 :
						  `DMBR5.l2responseIn & ~`DMBR5.l2missIn & (used_credits5 > 0)	? used_credits5 - 1 :
						  rst_credits5														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits5 	;

if(`DMBR5.rst)
	    rep_cnt5 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt5 <= rst_credits5	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt5 + 1'b1;
end

	always @(posedge `DMBR6.clk)
	begin
	if (`DMBR6.rst)
		used_credits6 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits6 <= `DMBR6.l1missIn													? used_credits6 + 1 :
						  `DMBR6.l2responseIn & ~`DMBR6.l2missIn & (used_credits6 > 0)	? used_credits6 - 1 :
						  rst_credits6														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits6 	;

if(`DMBR6.rst)
	    rep_cnt6 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt6 <= rst_credits6	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt6 + 1'b1;
end

	always @(posedge `DMBR7.clk)
	begin
	if (`DMBR7.rst)
		used_credits7 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits7 <= `DMBR7.l1missIn													? used_credits7 + 1 :
						  `DMBR7.l2responseIn & ~`DMBR7.l2missIn & (used_credits7 > 0)	? used_credits7 - 1 :
						  rst_credits7														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits7 	;

if(`DMBR7.rst)
	    rep_cnt7 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt7 <= rst_credits7	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt7 + 1'b1;
end

	always @(posedge `DMBR8.clk)
	begin
	if (`DMBR8.rst)
		used_credits8 <= {TOTAL_CREDIT_WIDTH{1'b0}};
	else
		used_credits8 <= `DMBR8.l1missIn													? used_credits8 + 1 :
						  `DMBR8.l2responseIn & ~`DMBR8.l2missIn & (used_credits8 > 0)	? used_credits8 - 1 :
						  rst_credits8														? {TOTAL_CREDIT_WIDTH{1'b0}} :
						  																	  used_credits8 	;

if(`DMBR8.rst)
	    rep_cnt8 <= {`REPLENISH_WIDTH{1'b0}};
	else
		rep_cnt8 <= rst_credits8	? {`REPLENISH_WIDTH{1'b0}} : rep_cnt8 + 1'b1;
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

	always @*
	begin
		if ((used_credits4 > (total_credit_num4 + 1) ) & `DMBR4.l1missIn)
		//if (used_credits4 > total_credit_num4)
		begin
			$display("\n***********************************************************");
			$display("DMBR4: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits5 > (total_credit_num5 + 1) ) & `DMBR5.l1missIn)
		//if (used_credits5 > total_credit_num5)
		begin
			$display("\n***********************************************************");
			$display("DMBR5: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits6 > (total_credit_num6 + 1) ) & `DMBR6.l1missIn)
		//if (used_credits6 > total_credit_num6)
		begin
			$display("\n***********************************************************");
			$display("DMBR6: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits7 > (total_credit_num7 + 1) ) & `DMBR7.l1missIn)
		//if (used_credits7 > total_credit_num7)
		begin
			$display("\n***********************************************************");
			$display("DMBR7: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

	always @*
	begin
		if ((used_credits8 > (total_credit_num8 + 1) ) & `DMBR8.l1missIn)
		//if (used_credits8 > total_credit_num8)
		begin
			$display("\n***********************************************************");
			$display("DMBR8: checker error! Must present a stall signal!");
			$display("***********************************************************\n");
			$stop;
		end
	end

`endif

endmodule
