`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:58 12/02/2016 
// Design Name: 
// Module Name:    music 
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
module music(
    input clk,
	 input stop,
    input [9:0] timeunit,
    output reg speaker,
    input start
    );

//分频计数器
parameter wide=15;
reg[7:0] cnt;  //音名数
reg[4:0] cnt1; //10MHz基频
reg[27:0] cnt2;//节拍频率5Hz
reg[wide-1:0] origin;//预置数寄存器     
reg[wide-1:0] drive;
reg[1:0] count;
reg carrier;
reg [27:0] freq;

always@(posedge clk)
	freq<=100000*timeunit;

//分频产生5MHz和5Hz的频率
always @(posedge clk or posedge start)
  begin
    if(start)
     begin
      cnt1<=5'd0;
      cnt2<=27'd0;
     end
    else if(~stop)
      begin
        cnt1<=cnt1+1'b1;
        cnt2<=cnt2+1'b1;
      if(cnt1==5'd19)
         cnt1<=5'd0;
      if(cnt2==freq)//10^7
        cnt2<=27'd0;
     end
   end
 
 always @(posedge clk or posedge start)
    begin
     if(start)
       drive<=15'h0; 
     else if(~stop)
	  begin
			if(cnt1==5'd19)
           begin
            if(drive==15'd32767)//7FFF即32767*10
             begin
              drive<=origin; 
              carrier<=1'b1;
             end
            else
			   begin
					drive<=drive+1'b1; //32767*10
					carrier<=1'b0; 
				end
           end
		end
 end    
            
//carrier的频率是每个音阶的频率

 always @(posedge carrier)
     begin
       count<=count+1'b1;
       if(count==4'd0)//16
        speaker<=1'b1;
       else speaker<=1'b0; 
    end
	
 always @(posedge clk or posedge start)
   begin
     if(start)
      begin
       origin<=15'h0;
        cnt<=8'd0;
      end
     else if(~stop && cnt2==freq) 
      begin
      if(cnt==8'd70)
        cnt<=8'd0;
     else
         cnt<=cnt+1'b1;//每0.2s增加一次
   case (cnt)
		8'd0:origin<=15'd32767;
		8'd1:origin<=15'd32767;
     8'd2:origin<=15'd27085;  //中音3，4个节拍
     8'd3:origin<=15'd27085;   
     8'd4:origin<=15'd27085;  
     8'd5:origin<=15'd26389; 
     8'd6:origin<=15'd25191; //中音5,3个节拍 
     8'd7:origin<=15'd25191;   
     8'd8:origin<=15'd26389;  
     8'd9:origin<=15'd26389;//中音6                            
     8'd10:origin<=15'd27987; //高音1，3个节拍
     8'd11:origin<=15'd27987;
     8'd12:origin<=15'd27085; 
                        
     8'd13:origin<=15'd26389; //高音2   
     8'd14:origin<=15'd27085; //中音6
     8'd15:origin<=15'd27085; //高音1
     8'd16:origin<=15'd27085;  //中音5
     8'd17:origin<=15'd27085; 
	  
     8'd18:origin<=15'd25191; //高音5 
     8'd19:origin<=15'd25191; 
     8'd20:origin<=15'd26389; 
     8'd21:origin<=15'd27085; //倍高音1  
     8'd22:origin<=15'd26389; //高音6

     8'd23:origin<=15'd26389;//高音5
     8'd24:origin<=15'd25191;//高音3
     8'd25:origin<=15'd25191;//高音5
	  
     8'd26:origin<=15'd23225; //高音2
     8'd27:origin<=15'd21403;
     8'd28:origin<=15'd26389; 
     8'd29:origin<=15'd25191;
     8'd30:origin<=15'd24264;
     8'd31:origin<=15'd24264;
     8'd32:origin<=15'd24264; 
     8'd33:origin<=15'd24264;
     8'd34:origin<=15'd24264;
     8'd35:origin<=15'd24264;
     8'd36:origin<=15'd24264;
     8'd37:origin<=15'd25191;//高音3
     8'd38:origin<=15'd26389; //中音7
     8'd39:origin<=15'd26389;
     8'd40:origin<=15'd26389;//中音6
     8'd41:origin<=15'd27402;
     8'd42:origin<=15'd25191; //中音5
     8'd43:origin<=15'd25191; 
     8'd44:origin<=15'd24264;   
     8'd45:origin<=15'd24264;//中音6
     8'd46:origin<=15'd23225;//高音1 
     8'd47:origin<=15'd23225;
     8'd48:origin<=15'd23225;//高音2  
     8'd49:origin<=15'd23225; 
     8'd50:origin<=15'd26389;//中音3
     8'd51:origin<=15'd26389;
     8'd52:origin<=15'd26389; //高音1
     8'd53:origin<=15'd25191;
     
     8'd54:origin<=15'd24264;//中音6 
     8'd55:origin<=15'd23225;//中音5
     8'd56:origin<=15'd21403; //中音6
     8'd57:origin<=15'd23225;//高音1 
     8'd58:origin<=15'd20012;//中音5
     8'd59:origin<=15'd20012; 
     8'd60:origin<=15'd20012;
     8'd61:origin<=15'd20012;
     8'd62:origin<=15'd20012; 
     8'd63:origin<=15'd20012;
     8'd64:origin<=15'd20012;
     8'd65:origin<=15'd20012;
     
default:origin<=15'd32767;
     endcase 
  end
end
endmodule


