module echo_back (switches, sysclk, data_valid, data_in, data_out);
	input sysclk, data_valid;
	input [9:0] data_in;
	input [8:0] switches;
	output reg [9:0] data_out;
	
	wire enable;
	wire [8:0] to_mult;
	
	wire [9:0] result;
	wire [9:0] x;
	
	wire [12:0] addrs_count_val;
	reg [12:0] added_addrs;
	
	reg [8:0] to_add;
	
	reg [9:0] y;
	reg ff_full;
	
	parameter ADC_OFFSET = 10'h181;
	parameter DAC_OFFSET = 10'h200;
	
	// ADC offset correction
	assign x = data_in - ADC_OFFSET;
	
	pulse_gen pulse_gen_block (.pulse(enable), .in(data_valid), .clk(sysclk));
	
	// multiply by 0.5
	always @ (posedge sysclk) begin
		to_add <= $signed(to_mult)>>>1;
	end
	
	// subtract result from input - this may prove an issue if
	// the result does have to explictly sign extended
	always @ (posedge sysclk) begin
		y <= x - to_add;
	end
	
	
	// DAC offset correction
	always @ (posedge sysclk) begin
		data_out <= y + DAC_OFFSET;
	end
	
	always @ (posedge sysclk) begin
		added_addrs <= switches + addrs_count_val;
	end
	
	// 13 bit counter
	counter_13 addr_counter(
	.clock(~wrreq), 
	.enable(1'b1), 
	.reset(1'b0), 
	.count(addrs_count_val));
	
	// RAM block for the feedback
	ram_block delay_ram(
	.clock(sysclk),
	.data(y[9:1]),
	.rdaddress(addrs_count_val),
	.rden(enable),
	.wraddress(added_addrs),
	.wren(enable),
	.q(to_mult));
	
	

endmodule