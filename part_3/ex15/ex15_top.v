module ex15_top (CLOCK_50, SW, HEX0, HEX1, HEX2, 
					DAC_SDI, DAC_SCK, DAC_CS, DAC_LD,
					ADC_SDI, ADC_SCK, ADC_CS, ADC_SDO, PWM_OUT);

	input			CLOCK_50;		// DE0 50MHz system clock
	input [9:0]	SW;				// 10 slide switches to specify address to ROM
	output [6:0] HEX0, HEX1, HEX2;
	output 		DAC_SDI;			//Serial data out to SDI of the DAC
	output 		DAC_SCK;				//Serial clock signal to both DAC and ADC
	output		DAC_CS;			//Chip select to the DAC, low active
	output 		DAC_LD;			//Load new data to DAC, low active	
	output 		ADC_SDI;			//Serial data out to SDI of the ADC
	output 		ADC_SCK;		// ADC Clock signal
	output		ADC_CS;			//Chip select to the ADC, low active
	input 		ADC_SDO;			//Converted serial data from ADC	
	output		PWM_OUT;			// PWM output to R channel
	
	
	
	//wire [9:0] addr;
	wire [9:0] addr_loop;
	wire [9:0] addr_result;
	wire [23:0] out_mult; // 24 bit output
	wire [3:0] bcd_seg0;
	wire [3:0] bcd_seg1;
	wire [3:0] bcd_seg2;
	wire [3:0] bcd_seg3;
	wire [3:0] bcd_seg4;
	
	wire [9:0] 	data_in;		// converted data from ADC
	wire [9:0] 	data_out;	// processed data to DAC
	
	wire data_valid;
	wire divclk;
	
	divide5k divide5(CLOCK_50, divclk);
	
	// outputting to the board
	
	addprev_addr_w_sw adder(data_in, addr_loop, addr_result);
	addr_reg address_reg(divclk, addr_result, addr_loop);
	ROM datarom(addr_loop, divclk, data_out);
	
	spi2adc poten_spi_adc(
	.sysclk(CLOCK_50), 
	.start(divclk), 
	.channel(1'b0), 			// channel 0 to use the potentiometer as input
	.data_from_adc(data_in), 
	.data_valid(data_valid), 
	.sdata_to_adc(ADC_SDI), 
	.adc_cs(ADC_CS), 
	.adc_sck(ADC_SCK), 
	.sdata_from_adc(ADC_SDO));
	
	spi2dac spi(CLOCK_50, data_out, divclk, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	pwm pulsewidth(CLOCK_50, data_out, divclk, PWM_OUT);
	
	// outputting the decimal value to the 7-seg displays
	const_mult mult(data_in, out_mult);
	bin2bcd_16 mult_to_bcd(out_mult[23:10], bcd_seg0, bcd_seg1, bcd_seg2, bcd_seg3, bcd_seg4);
	hex_to_7seg hex0(bcd_seg0, HEX0);
	hex_to_7seg hex1(bcd_seg1, HEX1);
	hex_to_7seg hex2(bcd_seg2, HEX2);
	hex_to_7seg hex3(bcd_seg3, HEX3);
	hex_to_7seg hex4(bcd_seg4, HEX4);
	
endmodule
