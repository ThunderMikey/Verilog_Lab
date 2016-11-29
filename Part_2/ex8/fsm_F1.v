//11 states, need 4 bit state
module fsm_F1(clk, tick, trigger, time_out, en_lfsr, start_delay, ledr);
	input clk, tick, trigger, time_out;
	output en_lfsr, start_delay;
	output [9:0] ledr;

	reg [3:0] state;
	initial state=0;
	always @ (posedge clk) begin
		case(state)
			0:	if(trigger==1'b1)
					state<=1;
			1:	if(tick==1'b1)
					state<=2;
			2:	if(tick==1'b1)
					state<=3;
			3:	if(tick==1'b1)
					state<=4;
			4:	if(tick==1'b1)
					state<=5;
			5:	if(tick==1'b1)
					state<=6;
			6:	if(tick==1'b1)
					state<=7;
			7:	if(tick==1'b1)
					state<=8;
			8:	if(tick==1'b1)
					state<=9;
			9:	if(tick==1'b1)
					state<=10;
			10:	if(time_out==1'b1)
					state<=0;
			default:	;
		endcase
	end
	
	reg en_lfsr, start_delay;
	reg [9:0] ledr;
	always @(posedge clk) begin
		case(state)
			0:	begin
				en_lfsr<=1'b0;	start_delay<=1'b0; ledr<=10'b0;
			end
			1:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1000000000;
			end
			2:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1100000000;
			end
			3:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1110000000;
			end
			4:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1111000000;
			end
			5:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1111100000;
			end
			6:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1111110000;
			end
			7:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1111111000;
			end
			8:	begin
				en_lfsr<=1'b1;	start_delay<=1'b0; ledr<=10'b1111111100;
			end
			9:	begin
				en_lfsr<=1'b0;	start_delay<=1'b0; ledr<=10'b1111111110;
			end
			10:	begin
				en_lfsr<=1'b0;	start_delay<=1'b1; ledr<=10'b1111111111;
			end	
			default:	;
		endcase
	end
endmodule