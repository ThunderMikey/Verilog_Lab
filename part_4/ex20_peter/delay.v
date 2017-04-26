//------------------------------
// Module name: variable delay element
// Function: delay by 1 to 512 samples
// Creator:  Peter Cheung
// Version:  1.0
// Date:     18 Feb 2014
//------------------------------

module delay (sysclk, d, load, k, q);

	input				sysclk;		// system clock
	input [8:0]		d;				// 9-bit input data
	output [8:0] 	q;				// 10-bit output data
	input				load;			// goes high when ADC got a new data
	input	[8:0]		k;				// no of samples to delay

	wire				sysclk;
	wire [8:0]		d;
	wire	[8:0]  	q;
	
	// specify address counter to generate read/write addresses
	wire [8:0] 		rdaddr, wraddr;
	wire				enable;
	
	reg [8:0]	ctr;					// 13 bit address counter
	initial	ctr = 9'b0;
	
	always @ (negedge load)
		ctr <= ctr + 1'b1;			// increment address counter
	
	assign rdaddr = ctr;
	assign wraddr = ctr + k;	// add delay to define wr address

	pulse_gen  PULSE2 (enable, load, sysclk);
	RAM  DELAY (sysclk, d, rdaddr, enable, wraddr, enable, q);
		
endmodule