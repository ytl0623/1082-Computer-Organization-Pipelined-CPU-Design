module ALU( signal, dataA, dataB, dataOut, zero );
output	[31:0]	dataOut;
input	[31:0]	dataA, dataB;
input	[5:0]	signal;
output zero;
wire	cin, ctr;
wire    set;
wire	[31:0]cout;
wire	[31:0]	temp;



parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;

		assign ctr=(signal == ADD)?1'b0:1'b1;
		
		
		ALU_bit a1(.sum(temp[0]), .a(dataA[0]), .b(dataB[0]), .signal(signal), .ctr(ctr), .cin(ctr), .cout(cout[0]), .less(set));
		ALU_bit a2(.sum(temp[1]), .a(dataA[1]), .b(dataB[1]), .signal(signal), .ctr(ctr), .cin(cout[0]), .cout(cout[1]), .less(1'b0));
		ALU_bit a3(.sum(temp[2]), .a(dataA[2]), .b(dataB[2]), .signal(signal), .ctr(ctr), .cin(cout[1]), .cout(cout[2]), .less(1'b0));
		ALU_bit a4(.sum(temp[3]), .a(dataA[3]), .b(dataB[3]), .signal(signal), .ctr(ctr), .cin(cout[2]), .cout(cout[3]), .less(1'b0));
		ALU_bit a5(.sum(temp[4]), .a(dataA[4]), .b(dataB[4]), .signal(signal), .ctr(ctr), .cin(cout[3]), .cout(cout[4]), .less(1'b0));
		ALU_bit a6(.sum(temp[5]), .a(dataA[5]), .b(dataB[5]), .signal(signal), .ctr(ctr), .cin(cout[4]), .cout(cout[5]), .less(1'b0));
		ALU_bit a7(.sum(temp[6]), .a(dataA[6]), .b(dataB[6]), .signal(signal), .ctr(ctr), .cin(cout[5]), .cout(cout[6]), .less(1'b0));
		ALU_bit a8(.sum(temp[7]), .a(dataA[7]), .b(dataB[7]), .signal(signal), .ctr(ctr), .cin(cout[6]), .cout(cout[7]), .less(1'b0));
		ALU_bit a9(.sum(temp[8]), .a(dataA[8]), .b(dataB[8]), .signal(signal), .ctr(ctr), .cin(cout[7]), .cout(cout[8]), .less(1'b0));
		ALU_bit a10(.sum(temp[9]), .a(dataA[9]), .b(dataB[9]), .signal(signal), .ctr(ctr), .cin(cout[8]), .cout(cout[9]), .less(1'b0));
		ALU_bit a11(.sum(temp[10]), .a(dataA[10]), .b(dataB[10]), .signal(signal), .ctr(ctr), .cin(cout[9]), .cout(cout[10]), .less(1'b0));
		ALU_bit a12(.sum(temp[11]), .a(dataA[11]), .b(dataB[11]), .signal(signal), .ctr(ctr), .cin(cout[10]), .cout(cout[11]), .less(1'b0));
		ALU_bit a13(.sum(temp[12]), .a(dataA[12]), .b(dataB[12]), .signal(signal), .ctr(ctr), .cin(cout[11]), .cout(cout[12]), .less(1'b0));
		ALU_bit a14(.sum(temp[13]), .a(dataA[13]), .b(dataB[13]), .signal(signal), .ctr(ctr), .cin(cout[12]), .cout(cout[13]), .less(1'b0));
		ALU_bit a15(.sum(temp[14]), .a(dataA[14]), .b(dataB[14]), .signal(signal), .ctr(ctr), .cin(cout[13]), .cout(cout[14]), .less(1'b0));
		ALU_bit a16(.sum(temp[15]), .a(dataA[15]), .b(dataB[15]), .signal(signal), .ctr(ctr), .cin(cout[14]), .cout(cout[15]), .less(1'b0));
		ALU_bit a17(.sum(temp[16]), .a(dataA[16]), .b(dataB[16]), .signal(signal), .ctr(ctr), .cin(cout[15]), .cout(cout[16]), .less(1'b0));
		ALU_bit a18(.sum(temp[17]), .a(dataA[17]), .b(dataB[17]), .signal(signal), .ctr(ctr), .cin(cout[16]), .cout(cout[17]), .less(1'b0));
		ALU_bit a19(.sum(temp[18]), .a(dataA[18]), .b(dataB[18]), .signal(signal), .ctr(ctr), .cin(cout[17]), .cout(cout[18]), .less(1'b0));
		ALU_bit a20(.sum(temp[19]), .a(dataA[19]), .b(dataB[19]), .signal(signal), .ctr(ctr), .cin(cout[18]), .cout(cout[19]), .less(1'b0));
		ALU_bit a21(.sum(temp[20]), .a(dataA[20]), .b(dataB[20]), .signal(signal), .ctr(ctr), .cin(cout[19]), .cout(cout[20]), .less(1'b0));
		ALU_bit a22(.sum(temp[21]), .a(dataA[21]), .b(dataB[21]), .signal(signal), .ctr(ctr), .cin(cout[20]), .cout(cout[21]), .less(1'b0));
		ALU_bit a23(.sum(temp[22]), .a(dataA[22]), .b(dataB[22]), .signal(signal), .ctr(ctr), .cin(cout[21]), .cout(cout[22]), .less(1'b0));
		ALU_bit a24(.sum(temp[23]), .a(dataA[23]), .b(dataB[23]), .signal(signal), .ctr(ctr), .cin(cout[22]), .cout(cout[23]), .less(1'b0));
		ALU_bit a25(.sum(temp[24]), .a(dataA[24]), .b(dataB[24]), .signal(signal), .ctr(ctr), .cin(cout[23]), .cout(cout[24]), .less(1'b0));
		ALU_bit a26(.sum(temp[25]), .a(dataA[25]), .b(dataB[25]), .signal(signal), .ctr(ctr), .cin(cout[24]), .cout(cout[25]), .less(1'b0));
		ALU_bit a27(.sum(temp[26]), .a(dataA[26]), .b(dataB[26]), .signal(signal), .ctr(ctr), .cin(cout[25]), .cout(cout[26]), .less(1'b0));
		ALU_bit a28(.sum(temp[27]), .a(dataA[27]), .b(dataB[27]), .signal(signal), .ctr(ctr), .cin(cout[26]), .cout(cout[27]), .less(1'b0));
		ALU_bit a29(.sum(temp[28]), .a(dataA[28]), .b(dataB[28]), .signal(signal), .ctr(ctr), .cin(cout[27]), .cout(cout[28]), .less(1'b0));
		ALU_bit a30(.sum(temp[29]), .a(dataA[29]), .b(dataB[29]), .signal(signal), .ctr(ctr), .cin(cout[28]), .cout(cout[29]), .less(1'b0));
		ALU_bit a31(.sum(temp[30]), .a(dataA[30]), .b(dataB[30]), .signal(signal), .ctr(ctr), .cin(cout[29]), .cout(cout[30]), .less(1'b0));
		ALU_Set a32(.sum(temp[31]), .a(dataA[31]), .b(dataB[31]), .signal(signal), .ctr(ctr), .cin(cout[30]), .cout(cout[31]), .less(1'b0), .set(set));
		
		assign dataOut = temp;
		assign zero = (dataOut == 32'd0)? 1 : 0;
		

endmodule