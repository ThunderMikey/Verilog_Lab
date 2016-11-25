module ex6_top (KEY, CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4);
	input [1:0] KEY;
	input CLOCK_50;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
	
	wire [15:0] counterout;
	wire [3:0] binh0;
	wire [3:0] binh1;
	wire [3:0] binh2;
	wire [3:0] binh3;
	wire [3:0] binh4;
	wire tick;
	
	divide50k divide50k_main (CLOCK_50, tick);
	counter_16 mainblock (CLOCK_50, (~KEY[0]&tick), ~KEY[1], counterout);
	bin2bcd_16 bindecode (counterout, binh0, binh1, binh2, binh3, binh4);
	hex_to_7seg hexout0 (HEX0, binh0);
	hex_to_7seg hexout1 (HEX1, binh1);
	hex_to_7seg hexout2 (HEX2, binh2);
	hex_to_7seg hexout3 (HEX3, binh3);
	hex_to_7seg hexout4 (HEX4, binh4);
	
endmodule