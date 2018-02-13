`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:46:25 11/28/2016 
// Design Name: 
// Module Name:    top 
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
module top(
    input clk,
    output [7:0] seg,//注，这个必须写成wire类型！
    output [3:0] an,
    input [2:0] sw,
    output [2:0] level,
	 output [4:0] rank,
	 output speaker,
    input btnr,
    input btnd,
    input btnl,
    input btnu,
    input btns,
	 input stop
    );
	 
	wire scan_sgn;
	wire OE;
	wire [7:0] Y;
	wire [9:0] timeunit;
	
music			u_music(
.stop			(stop			),
.clk			(clk			),
.start		(btns			),
.speaker		(speaker		),
.timeunit	(timeunit	)
);
	
scan			u_scan(
.start		(btns			),
.clk			(clk			),
.scan_sgn	(scan_sgn	)
);

difficultysel	u_difficultysel(
.start			(btns			),
.clk				(clk			),
.difficulty		(sw			),
.timeunit		(timeunit	)
);

display			u_display(
.start			(btns			),
.clk				(clk			),
.scan_sgn		(scan_sgn	),
.an				(an			),
.seg				(seg			),
.Y					(Y				),
.OE				(OE			)
);

mom				u_mom(
.stop				(stop			),
.clk				(clk			),
.Y					(Y				),
.start			(btns			),
.OE				(OE			),
.timeunit		(timeunit	)
);

judge				u_judge(
.stop				(stop			),
.clk				(clk			),
.btnu				(btnu			),
.btnd				(btnd			),
.btnr				(btnr			),
.btnl				(btnl			),
.start			(btns			),
.Y					(Y				),
.OE				(OE			),
.level			(level		),
.rank				(rank			),
.timeunit		(timeunit	)
);


endmodule
