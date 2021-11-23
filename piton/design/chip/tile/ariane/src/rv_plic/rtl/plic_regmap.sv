// Do not edit - auto-generated
module plic_regs (
  input logic [2:0][2:0] prio_i,
  output logic [2:0][2:0] prio_o,
  output logic [2:0] prio_we_o,
  output logic [2:0] prio_re_o,
  input logic [0:0][2:0] ip_i,
  output logic [0:0] ip_re_o,
  input logic [17:0][2:0] ie_i,
  output logic [17:0][2:0] ie_o,
  output logic [17:0] ie_we_o,
  output logic [17:0] ie_re_o,
  input logic [17:0][2:0] threshold_i,
  output logic [17:0][2:0] threshold_o,
  output logic [17:0] threshold_we_o,
  output logic [17:0] threshold_re_o,
  input logic [17:0][1:0] cc_i,
  output logic [17:0][1:0] cc_o,
  output logic [17:0] cc_we_o,
  output logic [17:0] cc_re_o,
  // Bus Interface
  input  reg_intf::reg_intf_req_a32_d32 req_i,
  output reg_intf::reg_intf_resp_d32    resp_o
);
always_comb begin
  resp_o.ready = 1'b1;
  resp_o.rdata = '0;
  resp_o.error = '0;
  prio_o = '0;
  prio_we_o = '0;
  prio_re_o = '0;
  ie_o = '0;
  ie_we_o = '0;
  ie_re_o = '0;
  threshold_o = '0;
  threshold_we_o = '0;
  threshold_re_o = '0;
  cc_o = '0;
  cc_we_o = '0;
  cc_re_o = '0;
  if (req_i.valid) begin
    if (req_i.write) begin
      unique case(req_i.addr)
        32'hc000000: begin
          prio_o[0][2:0] = req_i.wdata[2:0];
          prio_we_o[0] = 1'b1;
        end
        32'hc000004: begin
          prio_o[1][2:0] = req_i.wdata[2:0];
          prio_we_o[1] = 1'b1;
        end
        32'hc000008: begin
          prio_o[2][2:0] = req_i.wdata[2:0];
          prio_we_o[2] = 1'b1;
        end
        32'hc002000: begin
          ie_o[0][2:0] = req_i.wdata[2:0];
          ie_we_o[0] = 1'b1;
        end
        32'hc002080: begin
          ie_o[1][2:0] = req_i.wdata[2:0];
          ie_we_o[1] = 1'b1;
        end
        32'hc002100: begin
          ie_o[2][2:0] = req_i.wdata[2:0];
          ie_we_o[2] = 1'b1;
        end
        32'hc002180: begin
          ie_o[3][2:0] = req_i.wdata[2:0];
          ie_we_o[3] = 1'b1;
        end
        32'hc002200: begin
          ie_o[4][2:0] = req_i.wdata[2:0];
          ie_we_o[4] = 1'b1;
        end
        32'hc002280: begin
          ie_o[5][2:0] = req_i.wdata[2:0];
          ie_we_o[5] = 1'b1;
        end
        32'hc002300: begin
          ie_o[6][2:0] = req_i.wdata[2:0];
          ie_we_o[6] = 1'b1;
        end
        32'hc002380: begin
          ie_o[7][2:0] = req_i.wdata[2:0];
          ie_we_o[7] = 1'b1;
        end
        32'hc002400: begin
          ie_o[8][2:0] = req_i.wdata[2:0];
          ie_we_o[8] = 1'b1;
        end
        32'hc002480: begin
          ie_o[9][2:0] = req_i.wdata[2:0];
          ie_we_o[9] = 1'b1;
        end
        32'hc002500: begin
          ie_o[10][2:0] = req_i.wdata[2:0];
          ie_we_o[10] = 1'b1;
        end
        32'hc002580: begin
          ie_o[11][2:0] = req_i.wdata[2:0];
          ie_we_o[11] = 1'b1;
        end
        32'hc002600: begin
          ie_o[12][2:0] = req_i.wdata[2:0];
          ie_we_o[12] = 1'b1;
        end
        32'hc002680: begin
          ie_o[13][2:0] = req_i.wdata[2:0];
          ie_we_o[13] = 1'b1;
        end
        32'hc002700: begin
          ie_o[14][2:0] = req_i.wdata[2:0];
          ie_we_o[14] = 1'b1;
        end
        32'hc002780: begin
          ie_o[15][2:0] = req_i.wdata[2:0];
          ie_we_o[15] = 1'b1;
        end
        32'hc002800: begin
          ie_o[16][2:0] = req_i.wdata[2:0];
          ie_we_o[16] = 1'b1;
        end
        32'hc002880: begin
          ie_o[17][2:0] = req_i.wdata[2:0];
          ie_we_o[17] = 1'b1;
        end
        32'hc200000: begin
          threshold_o[0][2:0] = req_i.wdata[2:0];
          threshold_we_o[0] = 1'b1;
        end
        32'hc201000: begin
          threshold_o[1][2:0] = req_i.wdata[2:0];
          threshold_we_o[1] = 1'b1;
        end
        32'hc202000: begin
          threshold_o[2][2:0] = req_i.wdata[2:0];
          threshold_we_o[2] = 1'b1;
        end
        32'hc203000: begin
          threshold_o[3][2:0] = req_i.wdata[2:0];
          threshold_we_o[3] = 1'b1;
        end
        32'hc204000: begin
          threshold_o[4][2:0] = req_i.wdata[2:0];
          threshold_we_o[4] = 1'b1;
        end
        32'hc205000: begin
          threshold_o[5][2:0] = req_i.wdata[2:0];
          threshold_we_o[5] = 1'b1;
        end
        32'hc206000: begin
          threshold_o[6][2:0] = req_i.wdata[2:0];
          threshold_we_o[6] = 1'b1;
        end
        32'hc207000: begin
          threshold_o[7][2:0] = req_i.wdata[2:0];
          threshold_we_o[7] = 1'b1;
        end
        32'hc208000: begin
          threshold_o[8][2:0] = req_i.wdata[2:0];
          threshold_we_o[8] = 1'b1;
        end
        32'hc209000: begin
          threshold_o[9][2:0] = req_i.wdata[2:0];
          threshold_we_o[9] = 1'b1;
        end
        32'hc20a000: begin
          threshold_o[10][2:0] = req_i.wdata[2:0];
          threshold_we_o[10] = 1'b1;
        end
        32'hc20b000: begin
          threshold_o[11][2:0] = req_i.wdata[2:0];
          threshold_we_o[11] = 1'b1;
        end
        32'hc20c000: begin
          threshold_o[12][2:0] = req_i.wdata[2:0];
          threshold_we_o[12] = 1'b1;
        end
        32'hc20d000: begin
          threshold_o[13][2:0] = req_i.wdata[2:0];
          threshold_we_o[13] = 1'b1;
        end
        32'hc20e000: begin
          threshold_o[14][2:0] = req_i.wdata[2:0];
          threshold_we_o[14] = 1'b1;
        end
        32'hc20f000: begin
          threshold_o[15][2:0] = req_i.wdata[2:0];
          threshold_we_o[15] = 1'b1;
        end
        32'hc210000: begin
          threshold_o[16][2:0] = req_i.wdata[2:0];
          threshold_we_o[16] = 1'b1;
        end
        32'hc211000: begin
          threshold_o[17][2:0] = req_i.wdata[2:0];
          threshold_we_o[17] = 1'b1;
        end
        32'hc200004: begin
          cc_o[0][1:0] = req_i.wdata[1:0];
          cc_we_o[0] = 1'b1;
        end
        32'hc201004: begin
          cc_o[1][1:0] = req_i.wdata[1:0];
          cc_we_o[1] = 1'b1;
        end
        32'hc202004: begin
          cc_o[2][1:0] = req_i.wdata[1:0];
          cc_we_o[2] = 1'b1;
        end
        32'hc203004: begin
          cc_o[3][1:0] = req_i.wdata[1:0];
          cc_we_o[3] = 1'b1;
        end
        32'hc204004: begin
          cc_o[4][1:0] = req_i.wdata[1:0];
          cc_we_o[4] = 1'b1;
        end
        32'hc205004: begin
          cc_o[5][1:0] = req_i.wdata[1:0];
          cc_we_o[5] = 1'b1;
        end
        32'hc206004: begin
          cc_o[6][1:0] = req_i.wdata[1:0];
          cc_we_o[6] = 1'b1;
        end
        32'hc207004: begin
          cc_o[7][1:0] = req_i.wdata[1:0];
          cc_we_o[7] = 1'b1;
        end
        32'hc208004: begin
          cc_o[8][1:0] = req_i.wdata[1:0];
          cc_we_o[8] = 1'b1;
        end
        32'hc209004: begin
          cc_o[9][1:0] = req_i.wdata[1:0];
          cc_we_o[9] = 1'b1;
        end
        32'hc20a004: begin
          cc_o[10][1:0] = req_i.wdata[1:0];
          cc_we_o[10] = 1'b1;
        end
        32'hc20b004: begin
          cc_o[11][1:0] = req_i.wdata[1:0];
          cc_we_o[11] = 1'b1;
        end
        32'hc20c004: begin
          cc_o[12][1:0] = req_i.wdata[1:0];
          cc_we_o[12] = 1'b1;
        end
        32'hc20d004: begin
          cc_o[13][1:0] = req_i.wdata[1:0];
          cc_we_o[13] = 1'b1;
        end
        32'hc20e004: begin
          cc_o[14][1:0] = req_i.wdata[1:0];
          cc_we_o[14] = 1'b1;
        end
        32'hc20f004: begin
          cc_o[15][1:0] = req_i.wdata[1:0];
          cc_we_o[15] = 1'b1;
        end
        32'hc210004: begin
          cc_o[16][1:0] = req_i.wdata[1:0];
          cc_we_o[16] = 1'b1;
        end
        32'hc211004: begin
          cc_o[17][1:0] = req_i.wdata[1:0];
          cc_we_o[17] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end else begin
      unique case(req_i.addr)
        32'hc000000: begin
          resp_o.rdata[2:0] = prio_i[0][2:0];
          prio_re_o[0] = 1'b1;
        end
        32'hc000004: begin
          resp_o.rdata[2:0] = prio_i[1][2:0];
          prio_re_o[1] = 1'b1;
        end
        32'hc000008: begin
          resp_o.rdata[2:0] = prio_i[2][2:0];
          prio_re_o[2] = 1'b1;
        end
        32'hc001000: begin
          resp_o.rdata[2:0] = ip_i[0][2:0];
          ip_re_o[0] = 1'b1;
        end
        32'hc002000: begin
          resp_o.rdata[2:0] = ie_i[0][2:0];
          ie_re_o[0] = 1'b1;
        end
        32'hc002080: begin
          resp_o.rdata[2:0] = ie_i[1][2:0];
          ie_re_o[1] = 1'b1;
        end
        32'hc002100: begin
          resp_o.rdata[2:0] = ie_i[2][2:0];
          ie_re_o[2] = 1'b1;
        end
        32'hc002180: begin
          resp_o.rdata[2:0] = ie_i[3][2:0];
          ie_re_o[3] = 1'b1;
        end
        32'hc002200: begin
          resp_o.rdata[2:0] = ie_i[4][2:0];
          ie_re_o[4] = 1'b1;
        end
        32'hc002280: begin
          resp_o.rdata[2:0] = ie_i[5][2:0];
          ie_re_o[5] = 1'b1;
        end
        32'hc002300: begin
          resp_o.rdata[2:0] = ie_i[6][2:0];
          ie_re_o[6] = 1'b1;
        end
        32'hc002380: begin
          resp_o.rdata[2:0] = ie_i[7][2:0];
          ie_re_o[7] = 1'b1;
        end
        32'hc002400: begin
          resp_o.rdata[2:0] = ie_i[8][2:0];
          ie_re_o[8] = 1'b1;
        end
        32'hc002480: begin
          resp_o.rdata[2:0] = ie_i[9][2:0];
          ie_re_o[9] = 1'b1;
        end
        32'hc002500: begin
          resp_o.rdata[2:0] = ie_i[10][2:0];
          ie_re_o[10] = 1'b1;
        end
        32'hc002580: begin
          resp_o.rdata[2:0] = ie_i[11][2:0];
          ie_re_o[11] = 1'b1;
        end
        32'hc002600: begin
          resp_o.rdata[2:0] = ie_i[12][2:0];
          ie_re_o[12] = 1'b1;
        end
        32'hc002680: begin
          resp_o.rdata[2:0] = ie_i[13][2:0];
          ie_re_o[13] = 1'b1;
        end
        32'hc002700: begin
          resp_o.rdata[2:0] = ie_i[14][2:0];
          ie_re_o[14] = 1'b1;
        end
        32'hc002780: begin
          resp_o.rdata[2:0] = ie_i[15][2:0];
          ie_re_o[15] = 1'b1;
        end
        32'hc002800: begin
          resp_o.rdata[2:0] = ie_i[16][2:0];
          ie_re_o[16] = 1'b1;
        end
        32'hc002880: begin
          resp_o.rdata[2:0] = ie_i[17][2:0];
          ie_re_o[17] = 1'b1;
        end
        32'hc200000: begin
          resp_o.rdata[2:0] = threshold_i[0][2:0];
          threshold_re_o[0] = 1'b1;
        end
        32'hc201000: begin
          resp_o.rdata[2:0] = threshold_i[1][2:0];
          threshold_re_o[1] = 1'b1;
        end
        32'hc202000: begin
          resp_o.rdata[2:0] = threshold_i[2][2:0];
          threshold_re_o[2] = 1'b1;
        end
        32'hc203000: begin
          resp_o.rdata[2:0] = threshold_i[3][2:0];
          threshold_re_o[3] = 1'b1;
        end
        32'hc204000: begin
          resp_o.rdata[2:0] = threshold_i[4][2:0];
          threshold_re_o[4] = 1'b1;
        end
        32'hc205000: begin
          resp_o.rdata[2:0] = threshold_i[5][2:0];
          threshold_re_o[5] = 1'b1;
        end
        32'hc206000: begin
          resp_o.rdata[2:0] = threshold_i[6][2:0];
          threshold_re_o[6] = 1'b1;
        end
        32'hc207000: begin
          resp_o.rdata[2:0] = threshold_i[7][2:0];
          threshold_re_o[7] = 1'b1;
        end
        32'hc208000: begin
          resp_o.rdata[2:0] = threshold_i[8][2:0];
          threshold_re_o[8] = 1'b1;
        end
        32'hc209000: begin
          resp_o.rdata[2:0] = threshold_i[9][2:0];
          threshold_re_o[9] = 1'b1;
        end
        32'hc20a000: begin
          resp_o.rdata[2:0] = threshold_i[10][2:0];
          threshold_re_o[10] = 1'b1;
        end
        32'hc20b000: begin
          resp_o.rdata[2:0] = threshold_i[11][2:0];
          threshold_re_o[11] = 1'b1;
        end
        32'hc20c000: begin
          resp_o.rdata[2:0] = threshold_i[12][2:0];
          threshold_re_o[12] = 1'b1;
        end
        32'hc20d000: begin
          resp_o.rdata[2:0] = threshold_i[13][2:0];
          threshold_re_o[13] = 1'b1;
        end
        32'hc20e000: begin
          resp_o.rdata[2:0] = threshold_i[14][2:0];
          threshold_re_o[14] = 1'b1;
        end
        32'hc20f000: begin
          resp_o.rdata[2:0] = threshold_i[15][2:0];
          threshold_re_o[15] = 1'b1;
        end
        32'hc210000: begin
          resp_o.rdata[2:0] = threshold_i[16][2:0];
          threshold_re_o[16] = 1'b1;
        end
        32'hc211000: begin
          resp_o.rdata[2:0] = threshold_i[17][2:0];
          threshold_re_o[17] = 1'b1;
        end
        32'hc200004: begin
          resp_o.rdata[1:0] = cc_i[0][1:0];
          cc_re_o[0] = 1'b1;
        end
        32'hc201004: begin
          resp_o.rdata[1:0] = cc_i[1][1:0];
          cc_re_o[1] = 1'b1;
        end
        32'hc202004: begin
          resp_o.rdata[1:0] = cc_i[2][1:0];
          cc_re_o[2] = 1'b1;
        end
        32'hc203004: begin
          resp_o.rdata[1:0] = cc_i[3][1:0];
          cc_re_o[3] = 1'b1;
        end
        32'hc204004: begin
          resp_o.rdata[1:0] = cc_i[4][1:0];
          cc_re_o[4] = 1'b1;
        end
        32'hc205004: begin
          resp_o.rdata[1:0] = cc_i[5][1:0];
          cc_re_o[5] = 1'b1;
        end
        32'hc206004: begin
          resp_o.rdata[1:0] = cc_i[6][1:0];
          cc_re_o[6] = 1'b1;
        end
        32'hc207004: begin
          resp_o.rdata[1:0] = cc_i[7][1:0];
          cc_re_o[7] = 1'b1;
        end
        32'hc208004: begin
          resp_o.rdata[1:0] = cc_i[8][1:0];
          cc_re_o[8] = 1'b1;
        end
        32'hc209004: begin
          resp_o.rdata[1:0] = cc_i[9][1:0];
          cc_re_o[9] = 1'b1;
        end
        32'hc20a004: begin
          resp_o.rdata[1:0] = cc_i[10][1:0];
          cc_re_o[10] = 1'b1;
        end
        32'hc20b004: begin
          resp_o.rdata[1:0] = cc_i[11][1:0];
          cc_re_o[11] = 1'b1;
        end
        32'hc20c004: begin
          resp_o.rdata[1:0] = cc_i[12][1:0];
          cc_re_o[12] = 1'b1;
        end
        32'hc20d004: begin
          resp_o.rdata[1:0] = cc_i[13][1:0];
          cc_re_o[13] = 1'b1;
        end
        32'hc20e004: begin
          resp_o.rdata[1:0] = cc_i[14][1:0];
          cc_re_o[14] = 1'b1;
        end
        32'hc20f004: begin
          resp_o.rdata[1:0] = cc_i[15][1:0];
          cc_re_o[15] = 1'b1;
        end
        32'hc210004: begin
          resp_o.rdata[1:0] = cc_i[16][1:0];
          cc_re_o[16] = 1'b1;
        end
        32'hc211004: begin
          resp_o.rdata[1:0] = cc_i[17][1:0];
          cc_re_o[17] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end
  end
end
endmodule

