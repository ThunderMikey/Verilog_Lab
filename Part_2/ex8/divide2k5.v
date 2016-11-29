module divide2k5(en, clk, tick);
	input en, clk;
	output tick;
	parameter N2k5 = 500;
	initial tick = 0;
	reg [11:0] count;
	reg tick;
	always @ (posedge clk)
		if(en==1) begin
			if(count==1'b0) begin
				tick<=1'b1;
				count<=N2k5;
			end
			else begin
				count<=count-1'b1;
				tick<=1'b0;
			end
		end
endmodule