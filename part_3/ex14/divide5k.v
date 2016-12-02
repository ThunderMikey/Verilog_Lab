module divide5k(CLK, tick);
	input CLK;
	output tick;
	parameter N = 5000;
	
	
	initial tick = 0;
	
	reg [15:0] count;
	reg tick;
	always @ (posedge CLK)
		if(count==1'b0)
		begin
			tick<=1'b1;
			count<=N;
		end
		else
		begin
			count<=count-1'b1;
			tick<=1'b0;
		end
		
endmodule