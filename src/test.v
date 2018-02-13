`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:25:40 11/30/2016
// Design Name:   top
// Module Name:   E:/digital_program/rhythm_master/test.v
// Project Name:  rhythm_master
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg [2:0] sw;
	reg btnr;
	reg btnd;
	reg btnl;
	reg btnu;
	reg btns;
	reg stop;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.seg(seg), 
		.an(an), 
		.sw(sw), 
		.btnr(btnr), 
		.btnd(btnd), 
		.btnl(btnl), 
		.btnu(btnu), 
		.btns(btns),
		.stop(stop)
	);

	initial begin
		// Initialize Inputs
		stop=0;
		sw = 3'b101;
		btnr = 0;
		btnd = 0;
		btnl = 0;
		btnu = 0;
	end
	
	initial
	begin
	clk=0;
	forever #1 clk=~clk;
	end
	
	initial
	begin
	btns=0;
	#10;
	btns=1;
	#100;
	btns=0;
	#40090000
	btnu=1;
	#30000000;
	btnu=0;
   end 
	
endmodule

