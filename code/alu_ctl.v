
module alu_ctl( clk, ALUOp, Funct, SignaltoALU, SignaltoSHT, SignaltoDIV, SignaltoMUX );
    input [1:0] ALUOp;
    input [5:0] Funct;
	input clk;
    output [5:0] SignaltoALU;
    output [5:0] SignaltoSHT;
    output [5:0] SignaltoDIV;
    output [5:0] SignaltoMUX;		
	reg [6:0] counter ;	
	reg[5:0] temp;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	parameter F_srl = 6'b000010;
	parameter F_divu = 6'b011011;
	parameter F_mfhi = 6'b010000;
	parameter F_mflo = 6'b010010;
	
	always@( Funct )
	begin
		if ( Funct == F_divu )
		begin
			counter = 0 ;
		end

	end	
	
	always@( posedge clk )
	begin
		if ( Funct == F_divu )
		begin
			counter = counter + 1 ;
			if ( counter == 33 )
			begin
			temp = 6'b111111 ; // Open HiLo reg for Div
			counter = 0 ;
			end
		end

	end	
	
    always @(ALUOp or Funct)
    begin
        case (ALUOp) 
            2'b00 : temp = F_add;
            2'b01 : temp = F_sub;
            2'b10 : case (Funct) 
                        F_add : temp = F_add;
                        F_sub : temp = F_sub;
                        F_and : temp = F_and;
                        F_or  : temp = F_or;
                        F_slt : temp = F_slt;
						F_srl : temp = F_srl;							
						F_divu : temp = F_divu;
						F_mfhi : temp = F_mfhi;
						F_mflo : temp = F_mflo;					
						
                        default temp = 6'bxxxxxx;
                    endcase
            default temp = 6'bxxxxxx;
        endcase
    end
	
	assign SignaltoALU = temp ;
	assign SignaltoSHT = temp ;
	assign SignaltoDIV = temp ;
	assign SignaltoMUX = temp ;	
	
	
endmodule

