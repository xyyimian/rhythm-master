`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:38:58 11/26/2016 
// Design Name: 
// Module Name:    judge 
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
module judge(
    input btnu,
	 input stop,
    input btnd,
    input btnl,
    input btnr,
    input start,
    input clk,
    input [7:0] Y,
	 input OE,
	 input [9:0] timeunit,
	 output reg [2:0] level,
    output reg [4:0] rank
    );
	reg [12:0] score;
	reg [16:0] counter;//(10^5)
	reg [18:0] cntms;//
	reg playing;
	reg [2:0] state [3:0];
		
	reg [0:0] turn1 [1:0];//�жϳ����ź��Ƿ�Ϊ�����źţ�0��ʾ��,������1λ
	reg [18:0] queue1  [5:0];//�洢��������ʱ��ͳ���
	reg [18:0] queue2 [5:0];		//����for�����ƣ������ѽ�queue�ӳ�
	reg [18:0] queue3 [5:0];
	reg [0:0] turn4 [1:0];//��ά������λ����λ�
	reg [18:0] queue4 [5:0];//��

	integer k;

	reg [18:0] tdist [4:0];//��¼���׼ʱ��Ĳ�ֵ
	reg [18:0] sttime1;
	reg [18:0] sttime4;
	
	
	wire btnu_pos_p;
	wire btnd_pos_p;
	wire btnl_pos_p;
	wire btnr_pos_p;
	wire btnu_neg_p;
	wire btnd_neg_p;
	wire btnl_neg_p;
	wire btnr_neg_p;
	
	reg btnu_pos_r;
	reg btnu_neg_r;
	reg btnd_pos_r;
	reg btnd_neg_r;
	reg btnl_pos_r;
	reg btnl_neg_r;
	reg btnr_pos_r;
	reg btnr_neg_r;


signal_generate		u_signal_generate(
.reset(start),
.signal_in(btnu),
.clk(clk),
.signal_out_pos(btnu_pos_p),
.signal_out_neg(btnu_neg_p)
);

signal_generate		d_signal_generate(
.reset(start),
.signal_in(btnd),
.clk(clk),
.signal_out_pos(btnd_pos_p),
.signal_out_neg(btnd_neg_p)
);

signal_generate		l_signal_generate(
.reset(start),
.signal_in(btnl),
.clk(clk),
.signal_out_pos(btnl_pos_p),
.signal_out_neg(btnl_neg_p)
);

signal_generate		r_signal_generate(
.reset(start),
.signal_in(btnr),
.clk(clk),
.signal_out_pos(btnr_pos_p),
.signal_out_neg(btnr_neg_p)
);



always@(posedge clk)
begin
btnu_pos_r=btnu_pos_p;
btnu_neg_r=btnu_neg_p;
btnd_pos_r=btnd_pos_p;
btnd_neg_r=btnd_neg_p;
btnl_pos_r=btnl_pos_p;
btnl_neg_r=btnl_neg_p;
btnr_pos_r=btnr_pos_p;
btnr_neg_r=btnr_neg_p;
end

	
always@(posedge clk or posedge start)//ϵͳʱ��
if(start)
begin
	counter=0;
	playing=1;
	cntms=0;
end
else if(~stop)
begin
	if(playing)
		if(counter==17'd99999)
		begin
			counter=0;
			cntms=cntms+1;
		end
		else
			counter=counter+1;
end


	
always@(posedge clk or posedge start)
begin
if(start)
begin
	level<=3'b0;
	
	for(k=0;k<5;k=k+1)//ע���ά�������������ʼ��
	begin	
	queue1[k]<=0;
	queue2[k]<=0;
	queue3[k]<=0;
	queue4[k]<=0;
	tdist[k]<=0;
	end
	
	
	for(k=0;k<2;k=k+1)
	begin
	turn1[k]<=0;
	turn4[k]<=0;
	end
	
	score<=0;
	sttime1<=0;		//�����İ���ȥ��ʱ��
	sttime4<=0;
end
else if(~stop)//***
begin
	
//*********�󳤼�*********	
	if(btnl_pos_r)
	begin
		state[0]<=3'd1;
		sttime1<=cntms;
	end
	else if(btnl_neg_r)
	begin
		state[0]<=3'd2;
	end
		
		
	case(state[0])
	3'd0:
	begin
	end
	3'd1://��¼��ʼ����ʱ��
		begin
			state[0]<=3'd0;
		end
	3'd2:
		begin
			if(sttime1>queue1[0])//miss
				state[0]<=3'd3;
			else
			begin
				if(cntms<queue1[0]+queue1[1]*timeunit)//��ǰ��������
					if(cntms>queue1[0])
					begin
						tdist[0]<=cntms-queue1[0];
						state[0]<=3'd4;//ȥ����
					end
					else
						state[0]<=3'd6;
				else
				begin
					tdist[0]<=queue1[1]*timeunit;
					state[0]<=3'd4;//ȥ����
				end
			end
		end
	3'd3://miss
		begin
		level<=3'b001;
		state[0]<=3'd5;
		end
	3'd4://��������
		begin
		score<=score+(tdist[0]*50)/timeunit;
		state[0]<=3'd5;
		level<=3'b111;//perfect
		end
	3'd5://���б仯
		begin
		queue1[0]<=queue1[2];
		queue1[1]<=queue1[3];
		queue1[2]<=0;
		queue1[3]<=0;
		queue1[4]<=0;
		state[0]<=3'd6;
		end
	3'd6:
		begin
		tdist[0]<=0;
		sttime1<=0;
		state[0]<=3'd0;
		end
		endcase

//************�ҳ���************		
	if(btnu_pos_r)
	begin
		state[3]<=3'd1;
		sttime4<=cntms;
	end
	else if(btnu_neg_r)
	begin
		state[3]<=3'd2;
	end
		
		
	case(state[3])
	3'd0:
	begin
	end
	3'd1://��¼��ʼ����ʱ���miss
		begin
			
			state[3]<=0;
		end
	3'd2:
		begin
			if(sttime4>queue4[0])//miss
				state[3]<=3'd3;
			else
			begin
				if(cntms<queue4[0]+queue4[1]*timeunit)//��ǰ��������
					if(cntms>queue4[0])
					begin
						tdist[3]<=cntms-queue4[0];//ע�⣡����������뱣֤��Ϊ��������һ�������ֱ�ӱ���
						state[3]<=3'd4;//ȥ����
					end
					else
						state[3]<=3'd6;
				else
				begin
					tdist[3]<=queue4[1]*timeunit;
					state[3]<=3'd4;//ȥ����
				end
			end
		end
	3'd3://miss
		begin
		level<=3'b001;
		state[3]<=3'd5;
		end
	3'd4://��������
		begin
		score<=score+(tdist[3]*50)/timeunit;
		state[3]<=3'd5;
		level<=3'b111;//perfect
		end
	3'd5://���б仯
		begin
		queue4[0]<=queue4[2];
		queue4[1]<=queue4[3];
		queue4[2]<=0;
		queue4[3]<=0;
		queue4[4]<=0;
		state[3]<=3'd6;
		end
	3'd6:
		begin
		tdist[3]<=0;
		sttime4<=0;
		state[3]<=0;
		end
	endcase
		
//**********�Ҷ̼�***********		
	

if(btnr_pos_r)
begin
	if(btnu && turn4[0])
		state[2]<=3'd1;
	else
		state[2]<=3'd2;
end

	
	case(state[2])
	3'd0:
	begin//��һ�䲻�ӻᱨ��
	end
	3'd1://���������
	begin
		score<=score+50;
		turn4[0]<=turn4[1];
		turn4[1]<=0;
		state[2]<=3'd0;//ֱ�ӽ���
	end
	3'd2://�������
	begin
		if(cntms>queue3[0])
			state[2]<=3'd3;//miss
		else
		begin
			tdist[2]<=(queue3[0]-cntms);
			state[2]<=3'd4;
		end
	end
	3'd3://miss
	begin
		level<=3'b001;
		state[2]<=3'd5; //�����
	end
	
	3'd4://�жϲ������÷�
	begin
		if(tdist[2]<100)
		begin
			score<=score+13'd50;//perfect
			level<=3'b111;
			state[2]<=3'd5;
		end
		else if(tdist[2]<3*timeunit)
		begin
			score<=score+13'd25;//great
			level<=3'b011;
			state[2]<=3'd5;
		end
	end
	3'd5://�����
	begin
		queue3[0]<=queue3[1];
		queue3[1]<=queue3[2];
		queue3[2]<=queue3[3];
		queue3[3]<=0;
		state[2]<=3'd6;
	end
	3'd6:
	begin
		tdist[2]<=0;
		state[2]<=3'd0;
	end
	endcase		

//***********��̼�************


if(btnd_pos_r)
begin
	if(btnl && turn1[0])
		state[1]<=3'd1;
	else
		state[1]<=3'd2;
end
		
	case(state[1])
	3'd0:
	begin
	end
	3'd1:
	begin
		score<=score+50;
		turn1[0]<=turn1[1];
		turn1[1]<=0;
		state[1]<=3'd0;//ֱ�ӽ���
	end
	3'd2://�������
	begin
		if(cntms>queue2[0])
			state[1]<=3'd3;
		else
		begin
			tdist[1]<=(queue2[0]-cntms);
			state[1]<=3'd4;
		end
	end
	3'd3://miss
	begin
		level<=3'b001;
		state[1]<=3'd5; //�����
	end
	
	3'd4://�жϲ������÷�
	begin
		if(tdist[1]<100)
		begin
			score<=score+13'd50;//perfect
			level<=3'b111;
			state[1]<=3'd5;
		end
		else if(tdist[1]<3*timeunit)
		begin
			score<=score+13'd25;//great
			level<=3'b011;
			state[1]<=3'd5;
		end
	end
	3'd5://�����
	begin
		queue2[0]<=queue2[1];
		queue2[1]<=queue2[2];
		queue2[2]<=queue2[3];
		queue2[3]<=0;
		state[1]<=3'd6;
	end
	3'd6:
	begin
		tdist[1]<=0;
		state[1]<=3'd0;
	end
	endcase
		
if(OE)//�������
begin

	
	if(~Y[5])//��̼�
	begin
		for(k=0;k!=4 && queue2[k]!=0;k=k+1)
		begin
		end
		queue2[k]<=cntms+3*timeunit;
	end
	
	if(~Y[3])//�����
		begin
			if(turn1[0])
				turn1[1]<=1;
			else
				turn1[0]<=1;
		end
	
	if(~Y[4])//�󳤼�
	begin
		if(queue1[4]==0)
		begin
			if(queue1[0]==0)
			begin
				queue1[0]<=cntms+3*timeunit;
			end
			queue1[1]<=queue1[1]+1;
		end
		else
		begin
			if(queue1[2]==0)
			begin
				queue1[2]<=cntms+3*timeunit;
			end
			queue1[3]<=queue1[3]+1;
		end
	end
	else
	begin
		if(queue1[4]==0 && queue1[0]!=0)
				queue1[4]<=1;
	end
	
	
	if(~Y[1])//�����
		begin
			if(turn4[0])
				turn4[1]<=1;
			else
				turn4[0]<=1;
		end
		
	if(~Y[7])//�ҳ���
	begin
		if(queue4[4]==0)
		begin
			if(queue4[0]==0)
			begin
				queue4[0]<=cntms+3*timeunit;
			end
			queue4[1]<=queue4[1]+1;
		end
		else
		begin
			if(queue4[2]==0)
			begin
				queue4[2]<=cntms+3*timeunit;
			end
			queue4[3]<=queue4[3]+1;
		end
	end
	else
	begin
		if(queue4[4]==0 && queue4[0]!=0)
				queue4[4]<=1;
	end
	
	
	if(~Y[6])//�Ҷ̼�
	begin
		for(k=0;k!=4 && queue3[k]!=0;k=k+1)
		begin
		end
		queue3[k]<=cntms+3*timeunit;
	end	
	
end//OE end

end//else end		
end//always end

always@(score)
if(start)
	rank=0;
else
begin
	if(score>13'd0)
	begin
	if(score<13'd100)
		rank=5'b00001;
	else if(score<13'd300)
		rank=5'b00011;
	else if(score<13'd1000)
		rank=5'b00111;
	else if(score<13'd2000)
		rank=5'b01111;
	else// if(score<13'd5000)
		rank=5'b11111;
	end
	else
		rank=5'b00000;
end

endmodule
