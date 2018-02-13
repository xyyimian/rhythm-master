`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:04:03 11/27/2016 
// Design Name: 
// Module Name:    mom 
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
module mom(
    input clk,
	 input stop,
	 input start,
    output reg [7:0] Y,
    output reg OE,
    input [9:0] timeunit
    );
	 
	 reg [16:0] counter;
	 reg [18:0] cntms;
	 reg playing;//如果将它定义成1，就会变成锁存器
	 reg [6:0] beat;
	 reg OElast;
	 
		
always@(posedge clk or posedge start)
begin
	if(start)
		begin
			OE<=0;
			OElast<=0;
			counter<=17'd0;
			cntms<=16'd0;
			playing<=1;
			beat<=0;
			Y=8'b1111_1111;
				//经查阅，必须在各个状态下都要给所有寄存器赋值，否则就会出现什么latch的错误
		end
else if(~stop)
begin	
	if(playing && beat<7'd100)
	begin
		if(counter==17'd99_999)
		begin
			OE<=OElast;
			counter<=17'd0;
			if(cntms==timeunit)
			begin
				cntms<=0;
				beat<=beat+1;
				OElast<=1;
			end
			else
			begin
				if(cntms<19'd256_000)//cntms的上限足够大，不清零
					cntms<=cntms+1;
			end
		end
		else
			begin
				counter<=counter+1;
				OElast<=0;
				OE<=OElast;
			end
	end	
	
	if(playing && OElast)
		case(beat)
		7'd0:Y=8'b01111111;
		7'd1:Y=8'b01111111;
		7'd2:Y=8'b01111111;
		7'd3:Y=8'b10111111;
		7'd4:Y=8'b11011111;
		7'd5:Y=8'b1111_1111;
		7'd6:Y=8'b10111111;
		7'd7:Y=8'b1111_1111;
		7'd8:Y=8'b01111111;
		7'd9:Y=8'b0111_1111;
		7'd10:Y=8'b10111111;
		7'd11:Y=8'b11011111;
		7'd12:Y=8'b01111111;
		7'd13:Y=8'b01111111;
		7'd14:Y=8'b01111111;
		7'd15:Y=8'b01111111;
		7'd16:Y=8'b1110_1111;
		7'd17:Y=8'b11101111;
		7'd18:Y=8'b11011111;
		7'd19:Y=8'b10111111;
		7'd20:Y=8'b1011_1111;
		7'd21:Y=8'b11111111;
		7'd22:Y=8'b1101_1111;
		7'd23:Y=8'b11111111;
		7'd24:Y=8'b1011_1111;
		7'd25:Y=8'b1011_1111;
		7'd26:Y=8'b1011_1111;
		7'd27:Y=8'b1101_1111;
		7'd28:Y=8'b1110_1111;
		7'd29:Y=8'b1110_1111;
		7'd30:Y=8'b1110_1111;
		7'd31:Y=8'b1111_1111;
		7'd32:Y=8'b1110_1111;
		7'd33:Y=8'b1110_1111;
		7'd34:Y=8'b1110_1111;
		7'd35:Y=8'b1101_1111;
		7'd36:Y=8'b1101_1111;
		7'd37:Y=8'b1111_1111;
		7'd38:Y=8'b1011_1111;
		7'd39:Y=8'b1011_1111;
		7'd40:Y=8'b1011_1111;
		7'd41:Y=8'b1111_1111;
		7'd42:Y=8'b1101_1111;
		7'd43:Y=8'b1111_1111;
		
		7'd44:Y=8'b1110_1111;
		7'd45:Y=8'b1110_1111;
		7'd46:Y=8'b1110_1111;
		7'd47:Y=8'b1110_1111;
		7'd48:Y=8'b0111_1111;
		7'd49:Y=8'b0111_1111;
		7'd50:Y=8'b0111_1011;
		7'd51:Y=8'b1011_1111;
		7'd52:Y=8'b1011_1111;
		7'd53:Y=8'b1101_1111;
		7'd54:Y=8'b1101_1111;
		7'd55:Y=8'b1011_1111;
		7'd56:Y=8'b1110_1111;
		7'd57:Y=8'b1110_1111;
		7'd58:Y=8'b1110_1111;
		7'd59:Y=8'b1110_0111;
		default:Y=8'b1111_1111;
		endcase
	end
end	
	
endmodule
