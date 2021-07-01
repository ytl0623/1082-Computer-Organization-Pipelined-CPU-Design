module ID_EX( clk, pc_incr, RD1, RD2, extend_immed, rt, rd, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, ALUOp,
				ID_EX_pc_incr, ID_EX_reg_RD1, ID_EX_reg_RD2, ID_EX_reg_extend_immed, ID_EX_reg_rt, ID_EX_reg_rd, ID_EX_reg_RegDst, 
				ID_EX_reg_ALUSrc, ID_EX_reg_MemtoReg, ID_EX_reg_RegWrite, ID_EX_reg_MemRead, ID_EX_reg_MemWrite, 
				ID_EX_reg_Branch, ID_EX_reg_Jump, ID_EX_reg_ALUOp	);

	input clk, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump;
    input[31:0] RD1, RD2;
	input[4:0] rt, rd;
	input[31:0] extend_immed;
	input[1:0] ALUOp;
	input[31:0]	pc_incr;
	
	output[4:0] ID_EX_reg_rt, ID_EX_reg_rd;
	output[31:0] ID_EX_reg_RD1, ID_EX_reg_RD2;
	output[31:0] ID_EX_reg_extend_immed;
	output ID_EX_reg_RegDst, ID_EX_reg_ALUSrc, ID_EX_reg_MemtoReg, ID_EX_reg_RegWrite, ID_EX_reg_MemRead, ID_EX_reg_MemWrite, ID_EX_reg_Branch, ID_EX_reg_Jump;
    output[1:0] ID_EX_reg_ALUOp;	
	output[31:0] ID_EX_pc_incr;
	
	reg[4:0] ID_EX_reg_rt, ID_EX_reg_rd;
	reg[31:0] ID_EX_reg_RD1, ID_EX_reg_RD2;
	reg[31:0] ID_EX_reg_extend_immed;
	reg ID_EX_reg_RegDst, ID_EX_reg_ALUSrc, ID_EX_reg_MemtoReg, ID_EX_reg_RegWrite, ID_EX_reg_MemRead, ID_EX_reg_MemWrite, ID_EX_reg_Branch, ID_EX_reg_Jump;
    reg[1:0] ID_EX_reg_ALUOp;
	reg[31:0] ID_EX_pc_incr;	
	
	always @( posedge clk ) begin

		ID_EX_reg_ALUOp <= ALUOp;
		ID_EX_reg_ALUSrc <= ALUSrc;
		ID_EX_reg_Branch <= Branch;
		ID_EX_reg_Jump <= Jump;
		ID_EX_reg_MemRead <= MemRead;
		ID_EX_reg_MemWrite <= MemWrite;
		ID_EX_reg_MemtoReg <= MemtoReg;
		ID_EX_reg_RD1 <= RD1;
		ID_EX_reg_RD2 <= RD2;
		ID_EX_reg_RegDst <= RegDst;
		ID_EX_reg_RegWrite <= RegWrite;
		ID_EX_reg_extend_immed <= extend_immed;
		ID_EX_reg_rd <= rd;
		ID_EX_reg_rt <= rt;
		ID_EX_pc_incr <= pc_incr;

	end
endmodule