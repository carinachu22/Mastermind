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
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  reg switch_state;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  wire [(3'h4+0)-1:0] M_buttoncond_out;
  reg [(3'h4+0)-1:0] M_buttoncond_in;
  
  genvar GEN_buttoncond0;
  generate
  for (GEN_buttoncond0=0;GEN_buttoncond0<3'h4;GEN_buttoncond0=GEN_buttoncond0+1) begin: buttoncond_gen_0
    button_conditioner_2 buttoncond (
      .clk(clk),
      .in(M_buttoncond_in[GEN_buttoncond0*(1)+(1)-1-:(1)]),
      .out(M_buttoncond_out[GEN_buttoncond0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  wire [(3'h4+0)-1:0] M_buttondetector_out;
  reg [(3'h4+0)-1:0] M_buttondetector_in;
  
  genvar GEN_buttondetector0;
  generate
  for (GEN_buttondetector0=0;GEN_buttondetector0<3'h4;GEN_buttondetector0=GEN_buttondetector0+1) begin: buttondetector_gen_0
    edge_detector_3 buttondetector (
      .clk(clk),
      .in(M_buttondetector_in[GEN_buttondetector0*(1)+(1)-1-:(1)]),
      .out(M_buttondetector_out[GEN_buttondetector0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  wire [16-1:0] M_man_out;
  wire [20-1:0] M_man_seg_out;
  reg [16-1:0] M_man_dips;
  reg [1-1:0] M_man_trigger_start;
  fsm_draft_4 man (
    .clk(clk),
    .rst(rst),
    .dips(M_man_dips),
    .trigger_start(M_man_trigger_start),
    .out(M_man_out),
    .seg_out(M_man_seg_out)
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
  localparam IDLE_test_mode = 1'd0;
  localparam MANUAL_test_mode = 1'd1;
  
  reg M_test_mode_d, M_test_mode_q = IDLE_test_mode;
  
  always @* begin
    M_test_mode_d = M_test_mode_q;
    
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    usb_tx = usb_rx;
    led = 8'h00;
    io_led = 24'h000000;
    io_seg = 8'hff;
    io_sel = 4'hf;
    M_buttoncond_in = io_button[0+3-:4];
    M_buttondetector_in = M_buttoncond_out;
    switch_state = M_buttondetector_out[0+0-:1];
    M_man_trigger_start = 1'h0;
    M_man_dips = 16'h0000;
    M_seg_values = 20'h001c1;
    
    case (M_test_mode_q)
      IDLE_test_mode: begin
        if (switch_state) begin
          M_test_mode_d = MANUAL_test_mode;
        end
      end
      MANUAL_test_mode: begin
        M_man_dips[0+7-:8] = io_dip[0+7-:8];
        M_man_dips[8+7-:8] = io_dip[8+7-:8];
        M_man_trigger_start = M_buttondetector_out[1+0-:1];
        M_seg_values = M_man_seg_out;
        io_led[8+7-:8] = M_man_out[8+7-:8];
        io_led[0+7-:8] = M_man_out[0+7-:8];
        if (switch_state) begin
          M_test_mode_d = IDLE_test_mode;
        end
      end
    endcase
    io_seg = ~M_seg_seg;
    io_sel = ~M_seg_sel;
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_test_mode_q <= 1'h0;
    end else begin
      M_test_mode_q <= M_test_mode_d;
    end
  end
  
endmodule
