`timescale 1ns / 1ps

module instruction_register (input clk, rst, ir_load,input[7:0] data_in,output reg [7:0] ir_out,output [3:0] opcode,operand);
always @(posedge clk) begin
    if (rst)           
        ir_out <= 8'b0;
    else if (ir_load)  
        ir_out <= data_in;
end
assign opcode  = ir_out[7:4];
assign operand = ir_out[3:0];
endmodule