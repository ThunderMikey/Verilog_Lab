module ex10_top(SW, CLOCK_50, DAC_CS, DAC_SDI, DAC_LD, DAC_SCK);
	input [9:0] SW;
	input CLOCK_50;
	output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK;
	
	wire tick_out;

	divide5k clktick_16(CLOCK_50, tick_out);
	spi2dac spi(CLOCK_50, SW, tick_out, DAC_SDI, DAC_CS , DAC_SCK, DAC_LD);
	
endmodule