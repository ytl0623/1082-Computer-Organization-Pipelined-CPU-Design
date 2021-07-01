//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_test( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr, sht_out, hi_out, lo_out, aluOut;
	wire [63:0] div_out;

	// control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump;
    wire [1:0] ALUOp;
    wire [5:0] Operation, SHToperation, DIVoperation, MUXoperation;
	
//    assign opcode = instr[31:26];
//    assign rs = instr[25:21];
//    assign rt = instr[20:16];
//    assign rd = instr[15:11];
//    assign shamt = instr[10:6];
//    assign funct = instr[5:0];
//    assign immed = instr[15:0];
//    assign jumpoffset = instr[25:0];

	wire		[31:0]	IF_ID_Reg_pc_incr, IF_ID_Reg_RD;
	
	wire[4:0] ID_EX_reg_rt, ID_EX_reg_rd;
	wire[31:0] ID_EX_reg_RD1, ID_EX_reg_RD2;
	wire[31:0] ID_EX_reg_extend_immed;
	wire ID_EX_reg_RegDst, ID_EX_reg_ALUSrc, ID_EX_reg_MemtoReg, ID_EX_reg_RegWrite, ID_EX_reg_MemRead, ID_EX_reg_MemWrite, ID_EX_reg_Branch, ID_EX_reg_Jump;
    wire[1:0] ID_EX_reg_ALUOp;
	wire [31:0] ID_EX_reg_pc_incr;
	
	wire EX_MEM_reg_zero, EX_MEM_reg_Branch, EX_MEM_reg_MemRead, EX_MEM_reg_MemWrite, EX_MEM_reg_MemtoReg, EX_MEM_reg_RegWrite, EX_MEM_reg_jump;
	wire [31:0] EX_MEM_reg_ALU_out;
	wire [31:0] EX_MEM_reg_WD;	
	wire [31:0] EX_MEM_reg_b_tgt;	
	
	wire MEM_WB_MemtoReg, MEM_WB_RegWrite;
	wire [31:0] MEM_WB_RD, MEM_WB_ALU_out;
	wire [4:0]  MEM_WB_WN, EX_MEM_reg_WN;
	
	
    assign opcode = IF_ID_Reg_RD[31:26];
    assign rs = IF_ID_Reg_RD[25:21];
    assign rt = IF_ID_Reg_RD[20:16];
    assign rd = IF_ID_Reg_RD[15:11];
    assign shamt = IF_ID_Reg_RD[10:6];
    assign funct = ID_EX_reg_extend_immed[5:0];
    assign immed = IF_ID_Reg_RD[15:0];
    assign jumpoffset = IF_ID_Reg_RD[25:0];

	
	// branch offset shifter
    //assign b_offset = extend_immed << 2;
	assign b_offset = ID_EX_reg_extend_immed << 2;
	
	// jump offset shifter & concatenation
	
	//assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };
	assign jump_addr = { IF_ID_Reg_pc_incr[31:28], jumpoffset <<2 };
	
	// module instantiations
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );

    //add32 BRADD( .a(pc_incr), .b(b_offset), .result(b_tgt) );
	add32 BRADD( .a(ID_EX_reg_pc_incr), .b(b_offset), .result(b_tgt) );
	
    //alu ALU( .ctl(Operation), .a(rfile_rd1), .b(alu_b), .result(alu_out), .zero(Zero) );
	ALU ALU( .signal(Operation), .dataA(ID_EX_reg_RD1), .dataB(alu_b), .dataOut(aluOut), .zero(Zero) );
	
	Shifter SHT( .dataA(ID_EX_reg_RD1), .dataB(alu_b), .Signal(SHToperation), .dataOut(sht_out) );
	
	Divider DIV( .clk(clk), .dataA(ID_EX_reg_RD1), .dataB(alu_b), .Signal(DIVoperation), .dataOut(div_out), .reset(rst) );
	
	HiLo HiLo( .clk(clk), .DivAns(div_out), .HiOut(hi_out), .LoOut(lo_out), .reset(rst) );
	
	ALUMUX ALU_MUX( .ALUOut(aluOut), .HiOut(hi_out), .LoOut(lo_out), .Shifter(sht_out), .Signal(MUXoperation), .dataOut(alu_out) );
	
    //and BR_AND(PCSrc, Branch, Zero);
	and BR_AND(PCSrc, EX_MEM_reg_Branch, EX_MEM_reg_zero);

    //mux2 #(5) RFMUX( .sel(RegDst), .a(rt), .b(rd), .y(rfile_wn) );
	mux2 #(5) RFMUX( .sel(ID_EX_reg_RegDst), .a(ID_EX_reg_rt), .b(ID_EX_reg_rd), .y(rfile_wn) );

    //mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt), .y(branch_addr) );
	mux2 #(32) PCMUX( .sel(1'b0), .a(pc_incr), .b(EX_MEM_reg_b_tgt), .y(pc_next) );
	
	/********mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );*********/
	
    //mux2 #(32) ALUMUX( .sel(ALUSrc), .a(rfile_rd2), .b(extend_immed), .y(alu_b) );
	mux2 #(32) ALUMUX( .sel(ID_EX_reg_ALUSrc), .a(ID_EX_reg_RD2), .b(ID_EX_reg_extend_immed), .y(alu_b) );

    //mux2 #(32) WRMUX( .sel(MemtoReg), .a(alu_out), .b(dmem_rdata), .y(rfile_wd) );
	mux2 #(32) WRMUX( .sel(MEM_WB_MemtoReg), .a(MEM_WB_ALU_out), .b(MEM_WB_RD), .y(rfile_wd) );
	
    control_single CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp));

    //alu_ctl ALUCTL( .ALUOp(ALUOp), .Funct(funct), .ALUOperation(Operation) );
	alu_ctl ALUCTL( .clk(clk), .ALUOp(ID_EX_reg_ALUOp), .Funct(funct), .SignaltoALU(Operation), .SignaltoSHT(SHToperation), .SignaltoDIV(DIVoperation), .SignaltoMUX(MUXoperation) );

	//reg_file RegFile( .clk(clk), .RegWrite(RegWrite), .RN1(rs), .RN2(rt), .WN(rfile_wn), 
					  //.WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );
	reg_file RegFile( .clk(clk), .RegWrite(MEM_WB_RegWrite), .RN1(rs), .RN2(rt), .WN(MEM_WB_WN), 
					.WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );
					  
	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );
	
	//memory DatMem( .clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .wd(rfile_rd2), 
				   //.addr(alu_out), .rd(dmem_rdata) );
				   
	memory DatMem( .clk(clk), .MemRead(EX_MEM_reg_MemRead), .MemWrite(EX_MEM_reg_MemWrite), .wd(EX_MEM_reg_WD), 
				   .addr(EX_MEM_reg_ALU_out), .rd(dmem_rdata) );
	

	
	IF_ID p1( .clk(clk), .pc_incr(pc_incr), .RD(instr), .IF_ID_Reg_pc_incr(IF_ID_Reg_pc_incr), .IF_ID_Reg_RD(IF_ID_Reg_RD) );
	
	ID_EX p2( .clk(clk), .pc_incr(IF_ID_Reg_pc_incr), .RD1(rfile_rd1), .RD2(rfile_rd2), .extend_immed(extend_immed), .rt(rt), .rd(rd), .RegDst(RegDst), .ALUSrc(ALUSrc),
				.MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .Jump(Jump),
				.ALUOp(ALUOp), .ID_EX_pc_incr(ID_EX_reg_pc_incr), .ID_EX_reg_RD1(ID_EX_reg_RD1), .ID_EX_reg_RD2(ID_EX_reg_RD2), .ID_EX_reg_extend_immed(ID_EX_reg_extend_immed), .ID_EX_reg_rt(ID_EX_reg_rt), .ID_EX_reg_rd(ID_EX_reg_rd), .ID_EX_reg_RegDst(ID_EX_reg_RegDst), 
				.ID_EX_reg_ALUSrc(ID_EX_reg_ALUSrc), .ID_EX_reg_MemtoReg(ID_EX_reg_MemtoReg), .ID_EX_reg_RegWrite(ID_EX_reg_RegWrite), .ID_EX_reg_MemRead(ID_EX_reg_MemRead), .ID_EX_reg_MemWrite(ID_EX_reg_MemWrite), 
				.ID_EX_reg_Branch(ID_EX_reg_Branch), .ID_EX_reg_Jump(ID_EX_reg_Jump), .ID_EX_reg_ALUOp(ID_EX_reg_ALUOp)	);
	
	EX_MEM p3( .clk(clk), .zero(Zero), .Branch(Branch), .MemWrite(ID_EX_reg_MemWrite), .MemRead(ID_EX_reg_MemRead), .MemtoReg(ID_EX_reg_MemtoReg), .RegWrite(ID_EX_reg_RegWrite), .jump(ID_EX_reg_Jump), .ALU_out(alu_out), .WD(ID_EX_reg_RD2), .WN(rfile_wn), .b_tgt(b_tgt),
				.EX_MEM_reg_zero(EX_MEM_reg_zero), .EX_MEM_reg_Branch(EX_MEM_reg_Branch), .EX_MEM_reg_MemWrite(EX_MEM_reg_MemWrite), .EX_MEM_reg_MemRead(EX_MEM_reg_MemRead), .EX_MEM_reg_MemtoReg(EX_MEM_reg_MemtoReg),
				.EX_MEM_reg_RegWrite(EX_MEM_reg_RegWrite), .EX_MEM_reg_ALU_out(EX_MEM_reg_ALU_out), .EX_MEM_reg_WD(EX_MEM_reg_WD), .EX_MEM_reg_WN(EX_MEM_reg_WN), .EX_MEM_reg_b_tgt(EX_MEM_reg_b_tgt), .EX_MEM_reg_jump(EX_MEM_reg_jump) );

	MEM_WB p4( .clk(clk), .MemtoReg(EX_MEM_reg_MemtoReg), .RegWrite(EX_MEM_reg_RegWrite), .RD(dmem_rdata), .ALU_out(EX_MEM_reg_ALU_out), .WN(EX_MEM_reg_WN), .MEM_WB_MemtoReg(MEM_WB_MemtoReg), .MEM_WB_RegWrite(MEM_WB_RegWrite), .MEM_WB_RD(MEM_WB_RD), .MEM_WB_ALU_out(MEM_WB_ALU_out), .MEM_WB_WN(MEM_WB_WN) );
	
				   
endmodule
