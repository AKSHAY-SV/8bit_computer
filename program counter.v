`timescale 1ns / 1ps

module program_counter(input clk,rst,pc_inc,pc_load,pc_oe,
                       input [7:0]data_in,
                       output [7:0] bus_out,pc_out);

reg [7:0] count;
                       
always @(posedge clk) begin
    if(rst)
        count <= 8'b0;
    else if(pc_load)
        count <= data_in;
    else if(pc_inc)
        count <= count + 1;
end

assign pc_out  = count;
assign bus_out = pc_oe ? count : 8'bz;

endmodule
