module bin2bcd_10 (B, out_BCD0, out_BCD1, out_BCD2, out_BCD3);
	input [9:0] B;
	output [3:0] out_BCD0, out_BCD1, out_BCD2, out_BCD3;
	
	wire [3:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11;
	wire [3:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11;
	
	add3_ge5 A0 (w0,a0);
	add3_ge5 A1 (w1,a1);
	add3_ge5 A2 (w2,a2);
	add3_ge5 A3 (w3,a3);
	add3_ge5 A4 (w4,a4);
	add3_ge5 A5 (w5,a5);
	add3_ge5 A6 (w6,a6);
	add3_ge5 A7 (w7,a7);
	add3_ge5 A8 (w8,a8);
	add3_ge5 A9 (w9,a9);
	add3_ge5 A10 (w10,a10);
	add3_ge5 A11 (w11,a11);
	
	assign w0 = {1'b0, B[9:7]};
	assign w1 = {a0[2:0], B[6]};
	assign w2 = {a1[2:0], B[5]};
	assign w3 = {1'b0, a0[3], a1[3], a2[3]};
	assign w4 = {a2[2:0], B[4]};
	assign w5 = {a3[2:0], a4[3]};
	assign w6 = {a4[2:0], B[3]};
	assign w7 = {a5[2:0], a6[3]};
	assign w8 = {a6[2:0], B[2]};
	assign w9 = {1'b0, a3[3], a5[3], a7[3]};
	assign w10 = {a7[2:0], a8[3]};
	assign w11 = {a8[2:0], B[1]};
	
	//connect four BCD outputs
	assign out_BCD0 = {a11[2:0], B[0]};
	assign out_BCD1 = {a10[2:0], a11[3]};
	assign out_BCD2 = {a9[2:0], a10[3]};
	assign out_BCD3 = {3'b0, a9[3]};
endmodule