module add3_ge5(in_num, out_num);
	input [3:0] in_num;
	output reg [3:0] out_num;
	
	always @ (in_num)
	begin
		case(in_num)
			4b'0101: out_num = 4b'1000
			4b'0110: out_num = 4b'1001
			4b'0111: out_num = 4b'1010
			4b'0110: out_num = 4b'1011
			4b'0111: out_num = 4b'1100
			4b'1000: out_num = 4b'1101
			4b'1001: out_num = 4b'1110
			4b'1010: out_num = 4b'1111
			//----------------------------
			4b'0000: out_num = in_num;
			4b'0001: out_num = in_num;
			4b'0010: out_num = in_num;
			4b'0011: out_num = in_num;
			4b'0100: out_num = in_num;
		
			default out_num = 4b'0000;
		endcase
	end



module bin_to_bcd10 (bin, out_BCD1, out_BCD2, out_BCD3); 
	
	input [10:0] bin; // input from switches
	output [3:0] out_BCD1, out_BCD2, out_BCD3;
	
	wire [3:0] w1, w2, w3, w4, w5, w6, w7 
	wire [3:0] a1, a2, a3, a4, a5, a6, a7
	
	add3_ge5 ADD1 (w1, a1);
	add3_ge5 ADD2 (w2, a2);
	add3_ge5 ADD3 (w3, a3);
	add3_ge5 ADD4 (w4, a4);
	add3_ge5 ADD5 (w5, a5);
	add3_ge5 ADD6 (w6, a6);
	add3_ge5 ADD7 (w7, a7);
	
	assign w1 = {2b'00, bin[9:8]}; // corresponds to wiring levels in the diagram
	assign w2 = {a1[2:0], bin[4]};
	assign w3 = {a2[2:0], bin[3]};
	assign w4 = {bin[9], a1[3], a2[3], a3[3]};
	assign w5 = {a3[2:0], bin[2]};
	assign w6 = {a4[2:0], a5[3]};
	assign w7 = {a5[2:0], bin[1]};
	
	// route to the BCD outputs
	assign out_BCD1 = {a7[2:0], bin[0]};
	assign out_BCD2 = {a6[2:0], a7[3]};
	assign out_BCD3 = {2b'00, a4[3], a6[3]};
	
endmodule
	 
// now wire to 7-segment decoder
	
	
	
	