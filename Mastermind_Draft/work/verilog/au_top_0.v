/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module au_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input usb_rx,
    output reg usb_tx,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [1:0] inbutton,
    output reg [15:0] outled,
    output reg [7:0] outseg,
    output reg [3:0] outsel
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  wire [(2'h2+0)-1:0] M_buttoncond_out;
  reg [(2'h2+0)-1:0] M_buttoncond_in;
  
  genvar GEN_buttoncond0;
  generate
  for (GEN_buttoncond0=0;GEN_buttoncond0<2'h2;GEN_buttoncond0=GEN_buttoncond0+1) begin: buttoncond_gen_0
    button_conditioner_2 buttoncond (
      .clk(clk),
      .in(M_buttoncond_in[GEN_buttoncond0*(1)+(1)-1-:(1)]),
      .out(M_buttoncond_out[GEN_buttoncond0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  wire [(2'h2+0)-1:0] M_buttondetector_out;
  reg [(2'h2+0)-1:0] M_buttondetector_in;
  
  genvar GEN_buttondetector0;
  generate
  for (GEN_buttondetector0=0;GEN_buttondetector0<2'h2;GEN_buttondetector0=GEN_buttondetector0+1) begin: buttondetector_gen_0
    edge_detector_3 buttondetector (
      .clk(clk),
      .in(M_buttondetector_in[GEN_buttondetector0*(1)+(1)-1-:(1)]),
      .out(M_buttondetector_out[GEN_buttondetector0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  wire [16-1:0] M_man_out;
  wire [20-1:0] M_man_seg_out;
  wire [16-1:0] M_man_outled;
  reg [1-1:0] M_man_colour_button;
  reg [1-1:0] M_man_confirm_button;
  control_fsm_4 man (
    .clk(clk),
    .rst(rst),
    .colour_button(M_man_colour_button),
    .confirm_button(M_man_confirm_button),
    .out(M_man_out),
    .seg_out(M_man_seg_out),
    .outled(M_man_outled)
  );
  wire [7-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [20-1:0] M_seg_values;
  multi_seven_seg_5 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  
  always @* begin
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    usb_tx = usb_rx;
    led = 8'h00;
    io_seg = 8'hff;
    io_sel = 4'hf;
    M_buttoncond_in = inbutton;
    M_buttondetector_in = M_buttoncond_out;
    outseg = M_seg_seg;
    outsel = M_seg_sel;
    M_man_confirm_button = 1'h0;
    M_man_colour_button = 1'h0;
    M_man_confirm_button = M_buttondetector_out[0+0-:1];
    M_man_colour_button = M_buttondetector_out[1+0-:1];
    outled = M_man_outled;
    M_seg_values = M_man_seg_out;
    io_seg = ~M_seg_seg;
    io_sel = ~M_seg_sel;
  end
endmodule
