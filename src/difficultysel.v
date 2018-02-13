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
	 input start,//�ǵ���ø�����ģ����һ����λ�ź�
    input [2:0] difficulty,
    output reg [9:0] timeunit
    );
	always@(posedge clk or posedge start)
	if(start)
		timeunit=300;
	else
		case(difficulty)//��������ܵ����ƣ����޷��ı��λ���ܶȣ�ֻ��ͨ�����ӽ���Ŀ������ı��Ѷ�
			3'b001:timeunit=700;
			3'b010:timeunit=500;
			3'b100:timeunit=300;
		default: timeunit=50;//!!!��Ҫ���ģ�
		endcase
		
endmodule