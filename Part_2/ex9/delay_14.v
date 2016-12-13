module delay_14(N, clk, trigger, time_out);
	input [13:0] N;
	input clk, trigger;
	output time_out;

	reg [13:0] count;
	reg time_out;
	initial time_out=1'b0;
	always @ (posedge clk) begin
		if(trigger==1'b1) begin
			if(count==14'b0) begin
				time_out=1'b1;
			end
			else begin
				count<=count-1'b1;
				time_out<=1'b0;
			end
		end
		else begin
			count<=N;
			time_out<=1'b0;
		end
		
	end
endmodule