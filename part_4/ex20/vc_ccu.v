module vc_ccu (data_valid, KA, KB, GA, GB);
	input data_valid;
	output reg unsigned [8:0] KA, KB;
	output reg unsigned [6:0] GA, GB;
	
	//down_counter module
	parameter exp_ramp_grad=3'd2;
	reg [8:0] down_counter;
	reg [2:0] ramp_grad;
	initial down_counter=9'd511;
	initial ramp_grad=3'd0;
	always @ (posedge data_valid) begin
		if(ramp_grad==3'd0) begin 
			down_counter<=down_counter-9'd1;
			ramp_grad<=exp_ramp_grad-3'd1;
		end
		else begin
			ramp_grad<=ramp_grad-3'd1;
		end
	end
	//end down_counter module
	
	//4 state FSM
	reg [1:0] state;
	initial state=2'b11;
	always @ (down_counter) begin //@ down_counter
		if(down_counter<=9'd511 && down_counter>=9'd384) begin
			state<=2'd3;
		end
		else begin
			if(down_counter<=9'd383 && down_counter>=9'd256) begin
				state<=2'd0;
			end
			else begin
				if(down_counter<=9'd255 && down_counter>=9'd128) begin
					state<=2'd1;
				end
				else begin	//0-127
					state<=2'd2;
				end
			end
		end
	end
	
	always @ (*) begin
		case (state)
		0:	begin
			GA<=7'b1111111;
			GB<=7'b0;
			KA<=down_counter-9'd128;
			KB<=0;
		end
		1:	begin
			if(down_counter[6:0]==0);
			else begin
			GA<=down_counter[6:0];
			GB<=(~down_counter[6:0])+7'd1;
			KA<=down_counter-9'd128;
			KB<=down_counter+9'd128;
			end
		end
		2:	begin
			GA<=7'b0;
			GB<=7'b1111111;
			KA<=0;
			KB<=down_counter+9'd128;
		end
		3:	begin
			if(down_counter[6:0]==0);
			else begin
			GA<=(~down_counter[6:0])+7'd1;
			GB<=down_counter[6:0];
			KA<=down_counter-9'd128;
			KB<=down_counter-9'd384;
			end
		end
		default:	;
		endcase
	end
	
	
	
endmodule
