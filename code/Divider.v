module Divider( clk, dataA, dataB, Signal, dataOut, reset );
input clk ;
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output [63:0] dataOut ;
reg [63:0] temp ;
reg [63:0] divr ;
reg [63:0] rem ;
parameter DIVU = 6'b011011;
parameter OUT = 6'b111111;

//   Signal ( 6-bits)?
//   AND  : 36
//   OR   : 37
//   ADD  : 32
//   SUB  : 34
//   SRL  : 2
//   SLT  : 42
//   DIVU : 27

reg[31:0] quot ;


always @( Signal )
	begin
		if ( Signal == DIVU ) begin
			rem = {32'h00000000,dataA};
			divr = {dataB,32'h00000000};
		end
		
	end

always @( posedge clk ) begin
	if( reset == 1 )
		begin
			temp = 64'b0 ;
			quot = 32'b0 ;
		end
	
	if(Signal==DIVU)
		begin
			rem = rem - divr ;		
			if( rem[63] == 1'b0  )
				begin
					quot = {quot[30:0],1'b1} ;
				end			
			else
				begin
					rem = rem + divr ;
					quot = {quot[30:0],1'b0} ;	
				end

		
			divr = {1'b0,divr[63:1]} ;
		
		end
		
	else if(Signal==OUT)
		begin
			temp = {quot,rem[31:0]} ;
		end
end

assign	dataOut = temp ;

endmodule