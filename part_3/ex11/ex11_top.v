module ex11_top(SW, CLOCK_50, PWM_OUT, DAC_CS, DAC_SDI, DAC_LD, DAC_SCK);
	input [9:0] SW;
	input CLOCK_50;
	output PWM_OUT;
	output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK;
	
	wire load;
	
	divide5k div(CLOCK_50, load);
	
	spi2dac spi(CLOCK_50, SW, load, DAC_SDI, DAC_CS , DAC_SCK, DAC_LD);
	pwm our_pwm(CLOCK_50, SW, load, PWM_OUT);
	
endmodule
