module echo (sysclk, data_valid, data_in, data_out);
	input sysclk, data_valid;
	input [9:0] data_in;
	output reg [9:0] data_out;
	
	wire wrreq, rdreq, full;
	wire [9:0] to_mult;
	reg [9:0] to_add;
	// reg [9:0] to_add;
	wire [9:0] result;
	wire [9:0] x;
	reg [9:0] y;
	
	parameter ADC_OFFSET = 10'h181;
	parameter DAC_OFFSET = 10'h200;
	
	assign x=data_in - ADC_OFFSET;
	
	pulse_gen pulse_gen_block (.pulse(wrreq), .in(data_valid), .clk(sysclk));
	
	fifo_10bit fifo_10bit_block(
	.clock(sysclk),
	.data(x),
	.rdreq(full&wrreq),
	.wrreq(wrreq),
	.full(full),
	.q(to_mult));
	
	always @ (posedge sysclk) begin
		to_add <= $signed(to_mult)>>>1;
	end
	
	always @ (posedge sysclk) begin
		y <= x + to_add;
	end
	
	always @ (posedge sysclk) begin
		data_out<= y + DAC_OFFSET;
	end
	
/*	always @ (full) begin
		data_out<=result;
	end
*/
endmodule
