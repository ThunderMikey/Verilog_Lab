//------------------------------
// Module name: pitch change
// Function: Simply to pass input to output
// Creator:  Peter Cheung
// Version:  1.0
// Date:     18 Feb 2014
//------------------------------

module processor (sysclk, data_in, data_out, data_valid, mode);

	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	output [9:0] 	data_out;	// 10-bit output data
	input				data_valid;	// goes high when ADC got a new data
	input [3:0]		mode;			// 0 - no voice corruption; 1 to 7 corrupt

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire [9:0]		x,y;

	// convert input/output from offset binary to 2's complement
	parameter 		ADC_OFFSET = 10'h188;
	parameter 		DAC_OFFSET = 10'h200;

	assign x = data_in - ADC_OFFSET;		// x is input in 2's complement

	//  Now clock y output with system clock
	always @(posedge sysclk)
		if (mode == 4'b0)
			data_out <=  x + DAC_OFFSET;
		else
			data_out <=  y + DAC_OFFSET;
	
	// Peform the processing to corrupt the voice

	wire			load;					// load pulse
	wire [8:0]	QA, QB;				// delayed channels
	reg [8:0]	KA, KB;				// channel delay value
	reg [7:0]	GA, GB;				// channel gains (0, 7-bit)
	wire [16:0]	PA, PB;				// product
	wire [16:0]	sum;
	
	pulse_gen  PULSE2 (load, data_valid, sysclk);

	delay DELAY_A (sysclk, x[9:1], load, KA, QA);
	delay DELAY_B (sysclk, x[9:1], load, KB, QB);
	mult  GAIN_A  (sysclk, QA, GA, PA);
	mult  GAIN_B  (sysclk, QB, GB, PB);
	
	assign	sum = PA + PB;
	assign	y = sum[16:7];
	
	// determine rate of sweep in delay
	reg			sweep_clk;
	reg [2:0] 	mclk_out;

	initial sweep_clk = 1'b0;
	initial mclk_out = 3'b0;
	
	always @ (posedge data_valid) 
		if (mclk_out==3'b0) begin
			mclk_out <= ~mode[3:1] + 1'b1;    
			sweep_clk <= 1'b1;
			end
		else begin
			mclk_out <= mclk_out - 1'b1;
			sweep_clk <= 1'b0;
			end

	// FSM controller
	reg [8:0]	ctr;					// 13 bit address counter
	initial	ctr = 9'b0;	
	always @ (posedge sweep_clk) 
		ctr <= ctr - 1'b1;			// increment address counter
	
	always @ (posedge sysclk) begin
		KA <= ctr - 9'd128;
		KB <= ctr + 9'd128;	
		case (ctr[8:7])
			2'b11: begin					// region BA
						GA <= {1'b0,~ctr[6:0]};
						GB <= {1'b0,ctr[6:0]};
					end
			2'b10: begin
						GA <= 8'b01111111;
						GB <= 8'b0;
					end
			2'b01: begin
						GA <= {1'b0,ctr[6:0]};
						GB <= {1'b0,~ctr[6:0]};
					end
			2'b00: begin
						GA <= 8'b0;
						GB <= 8'b01111111;
					end
			default:	;
		endcase
	end
							
endmodule