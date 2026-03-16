`timescale 1ns / 1ps
module datapath(
    input clk,
    input write_enable,
    input [2:0] write_reg,
    input [2:0] read_reg1,
    input [2:0] read_reg2,
    input [2:0] ALU_CONTROL,

    output [7:0] result,
    output carry,
    output zero,
    output negative
);

wire [7:0] read_data1;
wire [7:0] read_data2;
wire [7:0] alu_result;

regfile RF(
    .clk(clk),
    .write_enable(write_enable),
    .write_reg(write_reg),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_data(alu_result),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

alu ALU(
    .A(read_data1),
    .B(read_data2),
    .ALU_CONTROL(ALU_CONTROL),
    .result(alu_result),
    .carry(carry),
    .zero(zero),
    .negative(negative)
);

assign result = alu_result;

endmodule
