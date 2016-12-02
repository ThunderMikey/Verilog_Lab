module ex13_top(CLOCK_50, DAC_CS, DAC_SDI, DAC_LD, DAC_SCK, PWM_OUT);
	input CLOCK_50;
	output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK, PWM_OUT;
	
	wire samp_pulse;
	wire [9:0] addr, data;
	divide5k divide5k_block (CLOCK_50, samp_pulse);
	//counter_10 (clock, enable, reset, count);
	counter_10 counter_10_block (CLOCK_50, samp_pulse, 1'b0, addr);
	//ROM (address,clock,q);
	ROM ROM_block (addr, samp_pulse, data);
	
	//spi2dac (sysclk, data_in, load, dac_sdi, dac_cs, dac_sck, dac_ld);
	spi2dac spi2dac_block (CLOCK_50, data, samp_pulse, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	
	//pwm(clk, data_in, load, pwm_out);
	pwm pwm_block (CLOCK_50, data, samp_pulse, PWM_OUT);
endmodule
