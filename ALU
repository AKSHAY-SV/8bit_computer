`timescale 1ns / 1ps
module alu(
input [7:0]A,
input [7:0]B,
input [2:0]ALU_CONTROL,
 output reg [7:0]result,
 output reg carry,
 output zero,
 output negative
  );
 always@(*)
 begin
  carry=0;
  case(ALU_CONTROL)
  3'b000:begin
  {carry,result}=A+B;
  end
  3'b001:begin
  {carry,result}=A-B;
  end
  3'b010:begin
  result=A&B;
  end
  3'b011:begin
  result=A|B;
  end
  3'b100:begin
  result=A^B;
  end
  3'b101:begin
  result=A<<1;
  end
  3'b110:begin
  result=A>>1;
  end
   
   default:result=8'b00000000;
   endcase
  end
   assign zero=(result==8'b00000000);
   assign negative=result[7];   
endmodule
