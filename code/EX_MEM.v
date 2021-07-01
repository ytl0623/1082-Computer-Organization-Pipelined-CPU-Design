module EX_MEM( clk, zero, Branch, MemWrite, MemRead, MemtoReg, RegWrite, jump, ALU_out, WD, WN, b_tgt,
				EX_MEM_reg_zero, EX_MEM_reg_Branch, EX_MEM_reg_MemWrite, EX_MEM_reg_MemRead, EX_MEM_reg_MemtoReg,
				EX_MEM_reg_RegWrite, EX_MEM_reg_ALU_out, EX_MEM_reg_WD, EX_MEM_reg_WN, EX_MEM_reg_b_tgt, EX_MEM_reg_jump );
				
	input clk, zero, Branch, MemRead, MemWrite, MemtoReg, RegWrite, jump;
	input [31:0] ALU_out;
	input [31:0] WD;
	input [4:0] WN;
	input [31:0] b_tgt;
	
	output EX_MEM_reg_zero, EX_MEM_reg_Branch, EX_MEM_reg_MemRead, EX_MEM_reg_MemWrite, EX_MEM_reg_MemtoReg, EX_MEM_reg_RegWrite, EX_MEM_reg_jump;
	output [31:0] EX_MEM_reg_ALU_out;
	output [31:0] EX_MEM_reg_WD;
	output [4:0] EX_MEM_reg_WN;
	output [31:0] EX_MEM_reg_b_tgt;
	
	reg EX_MEM_reg_zero, EX_MEM_reg_Branch, EX_MEM_reg_MemRead, EX_MEM_reg_MemWrite, EX_MEM_reg_MemtoReg, EX_MEM_reg_RegWrite, EX_MEM_reg_jump;
	reg [31:0] EX_MEM_reg_ALU_out;
	reg [31:0] EX_MEM_reg_WD;	
	reg [4:0] EX_MEM_reg_WN;
	reg [31:0] EX_MEM_reg_b_tgt;
	
	always @( posedge clk ) begin

		EX_MEM_reg_jump <= jump;
		EX_MEM_reg_ALU_out <= ALU_out;
		EX_MEM_reg_Branch <= Branch;
		EX_MEM_reg_MemRead <= MemRead;
		EX_MEM_reg_MemWrite <= MemWrite;
		EX_MEM_reg_MemtoReg <= MemtoReg;
		EX_MEM_reg_RegWrite <= RegWrite;
		EX_MEM_reg_WD <= WD;
		EX_MEM_reg_WN <= WN;
		EX_MEM_reg_zero <= zero;

	end
	
endmodule