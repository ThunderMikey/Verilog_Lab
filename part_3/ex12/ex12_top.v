module ex12_top(SW, CLOCK_50, HEX0, HEX1, HEX2);
	input CLOCK_50;
	input [9:0] SW;
	output [6:0] HEX0, HEX1, HEX2;
	
	wire [9:0] ram_out;
	
	ROM ROM_block (SW, CLOCK_50, ram_out);
	
	hex_to_7seg SEG7_0(HEX0,ram_out[3:0]);
	hex_to_7seg SEG7_1(HEX1,ram_out[7:4]);
	hex_to_7seg SEG7_2(HEX2,{2'b0, ram_out[9:8]});
	
endmodule
