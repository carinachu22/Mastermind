/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module boolean_18 (
    input rst,
    input [15:0] a,
    input [15:0] b,
    input [5:0] alufn_op,
    output reg [15:0] out
  );
  
  
  
  always @* begin
    
    case (alufn_op[0+3-:4])
      4'h8: begin
        out = a & b;
      end
      4'he: begin
        out = a | b;
      end
      4'h6: begin
        out = a ^ b;
      end
      4'ha: begin
        out = a;
      end
      default: begin
        out = 16'h0000;
      end
    endcase
  end
endmodule
