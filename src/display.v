`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:32 11/27/2016 
// Design Name: 
// Module Name:    display 
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


module display(
    input clk,
    input scan_sgn,
	 input start,
    output reg [3:0] an,
    output reg [7:0] seg,
    input [7:0] Y,
	 input OE
    );


	
	integer i;
	reg [1:0] a;
	reg [7:0] display_num [3:0] ;

	always@(posedge clk or posedge start)
	begin
		if(start)
		begin
			a<=2'b00;
		end
		else if(scan_sgn)
		begin//这个begin真的要加。。不然真的会出错。。。
				if(a==2'b11)
					a<=2'b00;
				else
					a<=a+2'b1;
		end
	end

always@(posedge clk or posedge start)
begin
	if(start)
		seg<=8'b1111_1111;		
	else
		case(a)
			2'b00:
			begin
				an<=4'b0111;
				seg<=display_num[3];
			end
			2'b01:
			begin
				an<=4'b1011;
				seg<=display_num[2];
			end
			2'b10:
			begin
				an<=4'b1101;
				seg<=display_num[1];
			end
		default:
			begin
				an<=4'b1110;
				seg<=display_num[0];
			end
		endcase
end

		
	always@(posedge clk or posedge start)
		if(start)
			for(i=0;i<4;i=i+1)
				display_num[i]<=8'b1111_1111;
		else if(OE)
		begin
			display_num[0]<=display_num[1];
			display_num[1]<=display_num[2];
			display_num[2]<=display_num[3];
			display_num[3]<=Y;//最高位为最新一位
		end

endmodule
