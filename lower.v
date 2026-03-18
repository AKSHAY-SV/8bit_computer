`timescale 1ns / 1ps

module lower (
    input        clk,
    input        rst,

    input        rega_load,
    input        rega_oe,
    input        regb_load,

    input        alu_oe,
    input  [2:0] alu_op,

    input        flags_load,

    input        out_load,

    inout  [7:0] bus,

    output       zero_flag,
    output       carry_flag,
    output       neg_flag,
    output       overflow_flag,

    output [7:0] out_val
);

    wire [7:0] rega_out, regb_out;
    wire       alu_carry, alu_overflow, alu_negative, alu_zero;

    register_file REGFILE (
        .clk       (clk),
        .rst       (rst),
        .rega_load (rega_load),
        .rega_oe   (rega_oe),
        .regb_load (regb_load),
        .bus_in    (bus),
        .bus_out   (bus),
        .rega_out  (rega_out),
        .regb_out  (regb_out)
    );

    ALU ALU_inst (
        .a            (rega_out),
        .b            (regb_out),
        .opcode       (alu_op),
        .oe           (alu_oe),
        .bus_out      (bus),
        .carry_out    (alu_carry),
        .overflow_flag(alu_overflow),
        .negative_flag(alu_negative),
        .zero_flag    (alu_zero)
    );

    flags_register FLAGS (
        .clk          (clk),
        .rst          (rst),
        .flags_load   (flags_load),
        .zero_in      (alu_zero),
        .carry_in     (alu_carry),
        .neg_in       (alu_negative),
        .overflow_in  (alu_overflow),
        .zero_flag    (zero_flag),
        .carry_flag   (carry_flag),
        .neg_flag     (neg_flag),
        .overflow_flag(overflow_flag)
    );

    output_register OUTREG (
        .clk      (clk),
        .rst      (rst),
        .out_load (out_load),
        .bus_in   (bus),
        .out_val  (out_val)
    );

endmodule