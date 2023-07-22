module ALU(input[1:0] control,input [2:0] opcode,input [7:0] in_reg_ac,input [7:0] in_reg_dr,output reg[7:0] out_reg,output reg carry);

always@(*) begin
if (opcode == 3'b111) begin
        case (control)
            2'b01: begin
                out_reg = in_reg_dr;
	    end
            2'b10: begin
                {carry, out_reg} = in_reg_ac - in_reg_dr;
            end
        endcase
end else
case (opcode)
	3'b000: {carry, out_reg} = in_reg_ac + in_reg_dr;
	3'b001: {carry, out_reg} = in_reg_ac - in_reg_dr;
	3'b010: begin
		if(in_reg_ac==in_reg_dr) out_reg=1;
		else out_reg=0;
		end	
	3'b011: out_reg = in_reg_dr * 2;
	3'b100: out_reg = in_reg_dr;
	3'b110: out_reg = ~in_reg_dr;
	default: out_reg = in_reg_ac;
endcase
end

endmodule

module ALU_test;

reg [1:0]control;
reg [2:0] opcode;
reg [7:0] in_reg_ac;
reg [7:0] in_reg_dr;
wire [7:0] out_reg;
wire carry;

ALU alu_inst(control,opcode, in_reg_ac, in_reg_dr, out_reg, carry);

initial begin
    // Test case 1: Addition
    opcode = 3'b000;
    in_reg_ac = 8'b00000001;
    in_reg_dr = 8'b00000010;
    #10;
    
    // Test case 2: Subtraction
    opcode = 3'b001;
    in_reg_ac = 8'b00000100;
    in_reg_dr = 8'b00000010;
    #10;
    
    // Test case 3: Equality check
    opcode = 3'b010;
    in_reg_ac = 8'b00000100;
    in_reg_dr = 8'b00000100;
    #10;
    
    // Test case 4: Shift left
    opcode = 3'b011;
    in_reg_dr = 8'b00000100;
    #10;
    
    // Test case 5: Pass through
    opcode = 3'b100;
    in_reg_dr = 8'b00001000;
    #10;
    
    // Test case 6: Bitwise NOT
    opcode = 3'b110;
    in_reg_dr = 8'b11110000;
    #10;

    // Test case 7: Square root material
    control = 2'b01;
    opcode = 3'b111;
    in_reg_ac = 8'b00000000;
    in_reg_dr = 8'b00000011;
    #10;


    control = 2'b10;
    opcode = 3'b111;
    in_reg_ac = 8'b00000101;
    in_reg_dr = 8'b00000111;

end
endmodule

