module IF_ID( clk, pc_incr, RD, IF_ID_Reg_pc_incr, IF_ID_Reg_RD );
	input	clk;
	input	[31:0]	pc_incr, RD;
	output	[31:0]	IF_ID_Reg_pc_incr, IF_ID_Reg_RD;
	reg		[31:0]	IF_ID_Reg_pc_incr, IF_ID_Reg_RD;
	
	always @( posedge clk ) begin

		IF_ID_Reg_pc_incr <= pc_incr;
		IF_ID_Reg_RD <= RD;

	end

endmodule