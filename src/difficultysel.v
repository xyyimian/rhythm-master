`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:54:10 11/28/2016 
// Design Name: 
// Module Name:    difficultysel 
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
module difficultysel(
    input clk,
	 input start,//记得最好给所有模块上一个复位信号
    input [2:0] difficulty,
    output reg [9:0] timeunit
    );
	always@(posedge clk or posedge start)
	if(start)
		timeunit=300;
	else
		case(difficulty)//由于数码管的限制，我无法改变键位的密度，只能通过曲子节奏的快慢来改变难度
			3'b001:timeunit=700;
			3'b010:timeunit=500;
			3'b100:timeunit=300;
		default: timeunit=50;//!!!需要更改！
		endcase
		
endmodule