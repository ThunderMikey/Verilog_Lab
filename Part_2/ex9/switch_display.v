module switchdisplay(reset, bin_in1, bin_in2, bin_out);
	input reset;
	input [15:0] bin_in1, bin_in2;
	output reg [15:0] bin_out;
	
	always @ (*) begin
		if(reset==0)
			bin_out<=bin_in2;
		else
			bin_out<=bin_in1;
	end
	
endmodule
