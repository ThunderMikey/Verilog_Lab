module vc_main(sysclk, data_valid, data_in, data_out);
	input sysclk, data_valid;
	input signed [9:0] data_in;
	output reg [9:0] data_out;
	wire ram_enable;
	wire signed [9:0] to_add_1, to_add_2;
	reg [16:0] interm_mult1, interm_mult2;
	wire unsigned [12:0] read_addr;
	wire unsigned [8:0] KA, KB;
	wire unsigned [6:0] GA, GB;
	wire signed [9:0] data_in_nooffset;
	reg signed [9:0] data_out_nooffset;
	wire signed [9:0] to_atten_ram1, to_atten_ram2;
	
	
	parameter ADC_OFFSET = 10'h181;
	parameter DAC_OFFSET = 10'h200;
	
	assign data_in_nooffset=data_in-ADC_OFFSET;
	
	always @ (posedge sysclk) begin
		data_out_nooffset<=to_add_1+to_add_2;
	end
	always @ (posedge sysclk) begin
		data_out<=data_out_nooffset+DAC_OFFSET;
	end
	
	pulse_gen pulse_gen_block (
	.pulse(ram_enable), 
	.in(data_valid), 
	.clk(sysclk));
	
	//-------------ram blocks
	reg unsigned [12:0] write_addr_ram1, write_addr_ram2;
	always @ (posedge sysclk) begin
		write_addr_ram1<=read_addr+{4'b0, KA};
		write_addr_ram2<=read_addr+{4'b0, KB};
	end
	
	ram_2ports_wr_undefined ram1(
	.clock(sysclk),
	.data(data_in_nooffset),
	.rdaddress(read_addr),
	.rden(ram_enable),
	.wraddress(write_addr_ram1),
	.wren(ram_enable),
	.q(to_atten_ram1));
	
	ram_2ports_wr_undefined ram2(
	.clock(sysclk),
	.data(data_in_nooffset),
	.rdaddress(read_addr),
	.rden(ram_enable),
	.wraddress(write_addr_ram2),
	.wren(ram_enable),
	.q(to_atten_ram2));
	//------------end ram blocks
	
	counter_13 addr_counter(
	.clock(data_valid), 
	.enable(1'b1), 
	.reset(1'b0), 
	.count(read_addr));
	
	vc_ccu vc_ccu_block (.data_valid(data_valid), .KA(KA), .KB(KB), .GA(GA), .GB(GB));
	
	//attenuate block
	//module mult_pos_neg(clk, multiplicand, gain, result);
	mult_pos_neg mult_ram1(sysclk, to_atten_ram1, GA, to_add_1);
	mult_pos_neg mult_ram2(sysclk, to_atten_ram2, GB, to_add_2);
	/*
	reg [9:0] twos_to_atten_ram1, twos_to_atten_ram2;
	always @ (posedge sysclk) begin
		if(to_atten_ram1<0) begin 
			twos_to_atten_ram1=(~to_atten_ram1)+1;
			interm_mult1=twos_to_atten_ram1*GA;
			to_add_1=((~interm_mult1[16:7])+1);
		end
		else begin
			interm_mult1=to_atten_ram1*GA;
			to_add_1=interm_mult1[16:7];
		end
	end
	always @ (posedge sysclk) begin
		if(to_atten_ram2<0) begin 
			twos_to_atten_ram2=(~to_atten_ram2)+1;
			interm_mult2=twos_to_atten_ram2*GB;
			to_add_2=((~interm_mult2[16:7])+1);
		end
		else begin
			interm_mult2=to_atten_ram2*GB;
			to_add_2=interm_mult2[16:7];
		end
	end
	*/
	//end of attenuate
	
endmodule
