`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:55 11/30/2016 
// Design Name: 
// Module Name:    signal_generate 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module signal_generate(
    input signal_in,
    input clk,
	 input reset,
    output signal_out_pos,
    output signal_out_neg
    );

reg signal_in1,signal_in2,signal_in3;
 
always @(posedge clk or posedge reset)
if(reset)
begin
	signal_in1 <= 0;
	signal_in2 <= 0;
	signal_in3 <= 0;
end
else
    begin
       signal_in1 <= signal_in;
       signal_in2 <= signal_in1;
       signal_in3 <= signal_in2;
    end

 
assign signal_out_neg = signal_in3 & ~signal_in2;
assign signal_out_pos = signal_in2 & ~signal_in3;

endmodule
