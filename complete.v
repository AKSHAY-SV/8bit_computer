`timescale 1ns / 1ps

module computer (
    input        clk,
    input        rst,
    output [7:0] out_val
);

    wire [7:0] bus;

    wire        pc_inc, pc_load, pc_oe;
    wire        mar_load, mar_src;
    wire        ram_oe, ram_we;
    wire        ir_load;
    wire        rega_load, rega_oe, regb_load;
    wire        alu_oe;
    wire [2:0]  alu_op;
    wire        flags_load;
    wire        out_load;
    wire        halt;

    wire [3:0]  opcode, operand;
    wire        zero_flag, carry_flag, neg_flag, overflow_flag;

    upper UPPER (
        .clk      (clk),
        .rst      (rst),
        .pc_inc   (pc_inc),
        .pc_load  (pc_load),
        .pc_oe    (pc_oe),
        .mar_load (mar_load),
        .mar_src  (mar_src),
        .ram_oe   (ram_oe),
        .ram_we   (ram_we),
        .ir_load  (ir_load),
        .bus      (bus),
        .opcode   (opcode),
        .operand  (operand)
    );

    lower LOWER (
        .clk          (clk),
        .rst          (rst),
        .rega_load    (rega_load),
        .rega_oe      (rega_oe),
        .regb_load    (regb_load),
        .alu_oe       (alu_oe),
        .alu_op       (alu_op),
        .flags_load   (flags_load),
        .out_load     (out_load),
        .bus          (bus),
        .zero_flag    (zero_flag),
        .carry_flag   (carry_flag),
        .neg_flag     (neg_flag),
        .overflow_flag(overflow_flag),
        .out_val      (out_val)
    );

    control_unit CU (
        .clk          (clk),
        .rst          (rst),
        .opcode       (opcode),
        .operand      (operand),
        .zero_flag    (zero_flag),
        .carry_flag   (carry_flag),
        .neg_flag     (neg_flag),
        .overflow_flag(overflow_flag),
        .pc_inc       (pc_inc),
        .pc_load      (pc_load),
        .pc_oe        (pc_oe),
        .mar_load     (mar_load),
        .mar_src      (mar_src),
        .ram_oe       (ram_oe),
        .ram_we       (ram_we),
        .ir_load      (ir_load),
        .rega_load    (rega_load),
        .rega_oe      (rega_oe),
        .regb_load    (regb_load),
        .alu_oe       (alu_oe),
        .alu_op       (alu_op),
        .flags_load   (flags_load),
        .out_load     (out_load),
        .halt         (halt)
    );

endmodule