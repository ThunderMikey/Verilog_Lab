module addprev_addr_w_sw(SW, addr, result);
	input [9:0] SW, addr;
	output [9:0] result;
	
	reg result;
	
	always @ (SW or addr)
		result <= SW + addr;
		
		
endmodule
