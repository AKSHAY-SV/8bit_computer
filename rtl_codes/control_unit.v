`timescale 1ns / 1ps

module control_unit (
    input        clk,
    input        rst,

    input  [3:0] opcode,
    input  [3:0] operand,

    input        zero_flag,
    input        carry_flag,
    input        neg_flag,
    input        overflow_flag,   

    output reg   pc_inc,
    output reg   pc_load,
    output reg   pc_oe,

    output reg   mar_load,
    output reg   mar_src,

    output reg   ram_oe,
    output reg   ram_we,

    output reg   ir_load,

    output reg   rega_load,
    output reg   rega_oe,
    output reg   regb_load,

    output reg        alu_oe,
    output reg [2:0]  alu_op,

    output reg   flags_load,

    output reg   out_load,

    output reg   halt
);

localparam LDA = 4'b0000;
localparam STA = 4'b0001;
localparam ADD = 4'b0010;
localparam SUB = 4'b0011;
localparam AND = 4'b0100;
localparam OR  = 4'b0101;
localparam XOR = 4'b0110;
localparam SHL = 4'b0111;
localparam SHR = 4'b1000;
localparam NOT = 4'b1001;
localparam JMP = 4'b1010;
localparam JZ  = 4'b1011;
localparam JC  = 4'b1100;
localparam JN  = 4'b1101;
localparam OUT = 4'b1110;
localparam HLT = 4'b1111;

localparam ALU_ADD = 3'b000;
localparam ALU_SUB = 3'b001;
localparam ALU_AND = 3'b010;
localparam ALU_OR  = 3'b011;
localparam ALU_XOR  = 3'b100;
localparam ALU_NOT  = 3'b101;
localparam ALU_SHL  = 3'b110;
localparam ALU_SHR  = 3'b111;

reg [2:0] step;

function [2:0] last_step;
input [3:0] op;
case (op)
    LDA, STA:                    last_step = 3'd3;
    ADD, SUB, AND, OR, XOR:      last_step = 3'd4;
    SHL, SHR, NOT,
    JMP, JZ, JC, JN,
    OUT, HLT:                    last_step = 3'd2;
    default:                     last_step = 3'd1;
endcase
endfunction

always @(posedge clk or posedge rst) begin
    if (rst)
        step <= 3'd0;
    else if (halt)
        step <= step;
    else if (step == last_step(opcode))
        step <= 3'd0;
    else
        step <= step + 1;
end

always @(*) begin
    pc_inc      = 0;
    pc_load     = 0;
    pc_oe       = 0;
    mar_load    = 0;
    mar_src     = 0;
    ram_oe      = 0;
    ram_we      = 0;
    ir_load     = 0;
    rega_load   = 0;
    rega_oe     = 0;
    regb_load   = 0;
    alu_oe      = 0;
    alu_op      = ALU_ADD;
    flags_load  = 0;
    out_load    = 0;
    halt        = 0;

    case (step)
        3'd0: 
        begin
            pc_oe    = 1;
            mar_load = 1;
            mar_src  = 0;
        end

        3'd1: begin
            ram_oe  = 1;
            ir_load = 1;
            pc_inc  = 1;
        end

        3'd2: 
        begin
            case (opcode)
                STA: 
                begin 
                    mar_load = 1; 
                    mar_src = 1; 
                end
                
                ADD: 
                begin 
                    mar_load = 1; 
                    mar_src = 1; 
                end
                
                SUB: 
                begin 
                    mar_load = 1; 
                    mar_src = 1; 
                end
                
                AND:
                begin 
                    mar_load = 1; 
                    mar_src = 1; 
                end
                
                OR:  
                begin 
                    mar_load = 1; 
                    mar_src = 1; 
                end
                
                XOR: 
                begin 
                    mar_load = 1; 
                    mar_src = 1; 
                end

                SHL: 
                begin
                    alu_oe     = 1;
                    alu_op     = ALU_SHL;
                    rega_load  = 1;
                    flags_load = 1;
                end
                
                SHR: 
                begin
                    alu_oe     = 1;
                    alu_op     = ALU_SHR;
                    rega_load  = 1;
                    flags_load = 1;
                end
                
                NOT: 
                begin
                    alu_oe     = 1;
                    alu_op     = ALU_NOT;
                    rega_load  = 1;
                    flags_load = 1;
                end

                JMP: 
                begin 
                    pc_load = 1; 
                end

                JZ:  
                begin 
                    if (zero_flag)  
                        pc_load = 1; 
                end
                JC:  
                begin 
                    if (carry_flag) 
                        pc_load = 1; 
                end
                
                JN:  
                begin 
                    if (neg_flag)   
                        pc_load = 1; 
                end

                OUT: 
                begin 
                    rega_oe = 1; 
                    out_load = 1; 
                end

                HLT: 
                begin 
                    halt = 1; 
                end
            endcase
        end

        3'd3: 
        begin
            case (opcode)
                LDA: begin ram_oe = 1; rega_load = 1; end
                STA: begin rega_oe = 1; ram_we = 1; end

                ADD: begin ram_oe = 1; regb_load = 1; end
                SUB: begin ram_oe = 1; regb_load = 1; end
                AND: begin ram_oe = 1; regb_load = 1; end
                OR:  begin ram_oe = 1; regb_load = 1; end
                XOR: begin ram_oe = 1; regb_load = 1; end
            endcase
        end

        3'd4: begin
            case (opcode)
                ADD: begin
                    alu_oe     = 1;
                    alu_op     = ALU_ADD;
                    rega_load  = 1;
                    flags_load = 1;
                end
                SUB: begin
                    alu_oe     = 1;
                    alu_op     = ALU_SUB;
                    rega_load  = 1;
                    flags_load = 1;
                end
                AND: begin
                    alu_oe     = 1;
                    alu_op     = ALU_AND;
                    rega_load  = 1;
                    flags_load = 1;
                end
                OR: begin
                    alu_oe     = 1;
                    alu_op     = ALU_OR;
                    rega_load  = 1;
                    flags_load = 1;
                end
                XOR: begin
                    alu_oe     = 1;
                    alu_op     = ALU_XOR;
                    rega_load  = 1;
                    flags_load = 1;
                end
            endcase
        end

    endcase
end

endmodule