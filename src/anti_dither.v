`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:11:49 11/26/2016 
// Design Name: 
// Module Name:    anti_dither 
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
module anti_dither(
    input btnu,
    input btnl,
    input btnr,
    input btnd,
    output reg btnd_int,
    output reg btnu_int,
    output reg btnl_int,
    output reg btnr_int,
    input clk
    );
	 
 reg [19:0] cnt;
	 reg oi;
initial
begin
	op=0;
	 cnt=0;
	 oi=0;
end

always@(posedge clk)
begin
if(op==1)
	op=0;
if(btn!=oi)
begin
	if(cnt==20'd1000_000)
	cnt=0;
	else
	begin
		cnt=cnt+1;
		if(cnt==20'd999_999)
		begin
		oi=btn;
		if(btn==1)
			op=1;
		end
	end
end
else
	cnt=0;
end


endmodule
