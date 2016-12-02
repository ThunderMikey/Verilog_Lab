module ex_14top(SW, CLOCK_50, DAC_CS, DAC_SDI, DAC_LD, DAC_SCK, PWM_OUT, HEX0, HEX1, HEX2, HEX3, HEX4);
	
	input [9:0] SW;
	input CLOCK_50;
	
	output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK, PWM_OUT;
	output [3:0] HEX0, HEX1, HEX2, HEX3, HEX4;
	
	
	
	//wire [9:0] addr;
	wire [9:0] addr_loop;
	wire [9:0] addr_result;
	wire [9:0] data_out;
	wire [23:0] out_mult; // 24 bit output
	wire [3:0] bcd_seg0;
	wire [3:0] bcd_seg1;
	wire [3:0] bcd_seg2;
	wire [3:0] bcd_seg3;
	wire [3:0] bcd_seg4;
	
	wire divclk;
	
	divide5k divide5(CLOCK_50, divclk);
	
	// outputting to the board
	addprev_addr_w_sw adder(SW, addr_loop);
	addr_reg address_reg(divclk, addr_result, addr_loop);
	ROM datarom(addr_loop, divclk, data_out);
	spi2dac spi(CLOCK_50, data_out, divclk, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	pwm pulsewidth(CLOCK_50, divclk, data_out);
	
	// outputting the decimal value to the 7-seg displays
	const_mult mult(SW, out_mult);
	bin2bcd_16 mult_to_bcd(out_mult[23:14], bcd_seg0, bcd_seg1, bcd_seg2, bcd_seg3, bcd_seg4);
	hex_to_7seg hex0(bcd_seg0, HEX0);
	hex_to_7seg hex1(bcd_seg1, HEX1);
	hex_to_7seg hex2(bcd_seg2, HEX2);
	hex_to_7seg hex3(bcd_seg3, HEX3);
	hex_to_7seg hex4(bcd_seg4, HEX4);
	
	
	
endmodule
