`timescale 1ns / 1ps

module upper (
    input        clk,
    input        rst,

    input        pc_inc,
    input        pc_load,
    input        pc_oe,

    input        mar_load,
    input        mar_src,

    input        ram_oe,
    input        ram_we,

    input        ir_load,

    inout  [7:0] bus,

    output [3:0] opcode,
    output [3:0] operand
);

    wire [7:0] mar_out;
    wire [7:0] pc_out;

    wire [7:0] mar_data_in = mar_src ? {4'b0, operand} : bus;
    wire [7:0] pc_data_in  = {4'b0, operand};

    program_counter PC (
        .clk     (clk),
        .rst     (rst),
        .pc_inc  (pc_inc),
        .pc_load (pc_load),
        .pc_oe   (pc_oe),
        .data_in (pc_data_in),
        .bus_out (bus),
        .pc_out  (pc_out)
    );

    mar MAR (
        .clk      (clk),
        .rst      (rst),
        .mar_load (mar_load),
        .data_in  (mar_data_in),
        .mar_out  (mar_out)
    );

    ram_256 RAM (
        .clk     (clk),
        .we      (ram_we),
        .oe      (ram_oe),
        .addr    (mar_out),
        .data_in (bus),
        .bus_out (bus)
    );

    instruction_register IR (
        .clk     (clk),
        .rst     (rst),
        .ir_load (ir_load),
        .data_in (bus),
        .ir_out  (),
        .opcode  (opcode),
        .operand (operand)
    );

endmodule