`timescale 1ns / 1ps

module output_register (
    input      clk, rst,
    input      out_load,
    input  [7:0] bus_in,
    output reg [7:0] out_val
);
    always @(posedge clk or posedge rst) begin
        if (rst)           
            out_val <= 8'b0;
        else if (out_load) 
            out_val <= bus_in;
    end
endmodule
