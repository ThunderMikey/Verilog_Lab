module add3_ge5 (in_num, out_num);
	input [3:0] in_num;
	output [3:0] out_num;
	
	reg [3:0] out_num;
	
	always @ (in_num)
	begin
		case (in_num)
			4'b0101: out_num = 4'b1000;
			4'b0110: out_num = 4'b1001;
			4'b0111: out_num = 4'b1010;
			4'b1000: out_num = 4'b1011;
			4'b1001: out_num = 4'b1100;
			4'b1010: out_num = 4'b1101; //case(10): out_num=13 should be enough of cases
			//----------------------------
			4'b0000: out_num = in_num;
			4'b0001: out_num = in_num;
			4'b0010: out_num = in_num;
			4'b0011: out_num = in_num;
			4'b0100: out_num = in_num;
			
			default: out_num = 4'b0000;
		endcase
	end
endmodule