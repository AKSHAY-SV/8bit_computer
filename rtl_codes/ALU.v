`timescale 1ns / 1ps

module ALU(input [7:0]a,b,
           input [2:0]opcode,
           input oe,
           output [7:0]bus_out,
           output reg carry_out,overflow_flag,
           output wire negative_flag,zero_flag);

localparam ALU_ADD = 3'b000;
localparam ALU_SUB = 3'b001;
localparam ALU_AND = 3'b010;
localparam ALU_OR  = 3'b011;
localparam ALU_XOR  = 3'b100;
localparam ALU_NOT  = 3'b101;
localparam ALU_SHL  = 3'b110;
localparam ALU_SHR  = 3'b111;

reg [7:0]result;
          
always@(*) begin
carry_out=0;

case(opcode)
    ALU_ADD: 
    begin
        {carry_out, result} = {1'b0, a} + {1'b0, b};
        assign overflow_flag = (~a[7] & ~b[7] & result[7])|( a[7] &  b[7] & ~result[7]);
    end
    
    ALU_SUB: 
    begin
        {carry_out, result} = {1'b0, a} - {1'b0, b};
        assign overflow_flag = (~a[7] &  b[7] & result[7])|( a[7] & ~b[7] & ~result[7]);
    end
    
    ALU_AND: result = a & b;
    
    ALU_OR:  result = a | b;
    
    ALU_XOR: result = a ^ b;
    
    ALU_NOT: result = !a;
    
    ALU_SHL: 
    begin
         result    = a << 1;
         carry_out = a[7];  // bit shifted out of MSB
    end
    
    ALU_SHR: 
    begin
         result    = a >> 1;
         carry_out = a[0];  // bit shifted out of LSB
    end
    
    default:result=8'b00000000;
    
    endcase
end

assign negative_flag = result[7];
assign zero_flag = (result==8'b00000000);
assign bus_out = oe ? result : 8'bz;

endmodule