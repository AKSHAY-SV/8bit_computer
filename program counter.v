`timescale 1ns / 1ps

module program_counter(input clk,rst,pc_inc,pc_load, input [7:0]data_in, output reg [7:0] pc_out);
always @(posedge clk) begin
    if(rst)
        pc_out <= 8'b0;
    else if(pc_load)
        pc_out <= data_in;
    else if(pc_inc)
        pc_out <= pc_out + 1;
end
endmodule
