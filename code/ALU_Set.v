module ALU_Set( sum, a, b, signal, ctr, cin, cout, less, set );
input a, b, cin, ctr, less;
input [5:0] signal ;

output sum, cout, set ;

//   Signal ( 6-bits)?
//   AND  : 36
//   OR   : 37
//   ADD  : 32
//   SUB  : 34
//   SRL  : 2
//   SLT  : 42
//   DIVU : 27


wire	tempAND, tempOR, temp;

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;

		and (tempAND, a, b);
		or	(tempOR, a, b);
		
		FA	fa(.a(a), .b(b), .c(cin), .cout(cout), .sum(temp), .ctr(ctr));
		
		assign set = temp;
		
		assign	sum=(signal==AND)?tempAND:
					(signal==OR)?tempOR:
					(signal==SLT)?less:
					temp;
		
		


endmodule