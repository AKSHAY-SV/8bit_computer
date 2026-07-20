`timescale 1ns / 1ps

module flags_register (
    input      clk, rst,
    input      flags_load,
    input      zero_in, carry_in,
    input      neg_in, overflow_in,
    output reg zero_flag, carry_flag,
    output reg neg_flag,  overflow_flag
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            zero_flag     <= 0;
            carry_flag    <= 0;
            neg_flag      <= 0;
            overflow_flag <= 0;
        end else if (flags_load) begin
            zero_flag     <= zero_in;
            carry_flag    <= carry_in;
            neg_flag      <= neg_in;
            overflow_flag <= overflow_in;
        end
    end
endmodule