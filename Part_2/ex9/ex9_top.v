module ex9_top(CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, LEDR);
	input CLOCK_50;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
	output [9:0] LEDR;

	wire tick_ms, tick_hs, en_lfsr, start_delay, time_out;
	wire [13:0] prbs;
	wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	wire [15:0] bin;
	wire [15:0] timer_value;

	divide50k divide50k_block (CLOCK_50, tick_ms);
	divide2k5 divide2k5_block (tick_ms, CLOCK_50, tick_hs);

	fsm_F1 fsm_F1_block (tick_ms, tick_hs, ~KEY[3], time_out, en_lfsr, start_delay, LEDR);

	lfsr_14 lfsr_14_block (tick_ms, en_lfsr, prbs);
	delay_14 delay_14_block (prbs, tick_ms, start_delay, time_out);

	
	//switchdisplay(switch, reset, HEX_in1, HEX_in2, HEX_out)
	switchdisplay switchdisplay_block_0 (LEDR[9], {2'b0, prbs}, timer_value, bin);
	
	bin2bcd_16 bin2bcd_16_block (bin, BCD0, BCD1, BCD2, BCD3, BCD4);

	hex_to_7seg sseg0 (HEX0, BCD0);
	hex_to_7seg sseg1 (HEX1, BCD1);
	hex_to_7seg sseg2 (HEX2, BCD2);
	hex_to_7seg sseg3 (HEX3, BCD3);
	hex_to_7seg sseg4 (HEX4, BCD4);
	
	//timer (clk, start, stop, reset, time_passed)
	timer_16 timer_block (tick_ms, time_out, ~KEY[0], en_lfsr, timer_value);

	
	
	
endmodule