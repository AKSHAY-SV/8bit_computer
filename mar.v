`timescale 1ns / 1ps

module mar(input clk,rst,mar_load,
           input[7:0] data_in,
           output reg [7:0] mar_out);
           
always @(posedge clk) begin
    if(rst)
        mar_out <= 8'b0;
    else if(mar_load)
        mar_out <= data_in;
end

endmodule
