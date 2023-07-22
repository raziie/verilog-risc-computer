module ROM(input [4:0] address, output reg [7:0] instruction);

reg [7:0] memory [0:31];
initial begin
	memory[0] = 8'b10001100; //load M[12] = 102 to AC(0110 0110)
	memory[1] = 8'b00110010; //sub : AC = AC - M[18] = 102 - 76 = 26(0001 1010)
	memory[2] = 8'b00000111; //add : AC = AC + M[7] = 26 + (-126) = -100(1001 1100)
	memory[3] = 8'b00011100; //add : AC = AC + M[28] = (-100) + 103 = 3(0000 0011) 
	memory[4] = 8'b10101100; //store : M[12] = AC = 3(0000 0011)
	memory[5] = 8'b01111111; //mult : AC = M[31] * 2 = 11 * 2 = 22(0001 0110)
	memory[6] = 8'b11010011; //CMP : M[19] = ~ M[19] = 15(0000 1111)
	memory[7] = 8'b11110011; //sqrt : M[19] = sqrt(M[19]) = 4(0000 0100)
	memory[8] = 8'b01010011; //compare : AC != M[19] so AC = 0
	memory[9] = 8'b01000011; //compare : AC == M[3](0) so AC = 1
	memory[10] = 8'b11111010; //sqrt : M[26] = sqrt(M[26]) = sqrt(5) = 2(0000 0010)
	memory[11] = 8'b0000000; //add : AC + M[0] = AC + 0 = Ac (no change)
	memory[12] = 8'b0000000; //no change
	memory[13] = 8'b0000000; //no change
	memory[14] = 8'b0000000; //no change
	memory[15] = 8'b0000000; //no change
	memory[16] = 8'b0000000; //no change
	memory[17] = 8'b0000000; //no change
	memory[18] = 8'b0000000; //no change
	memory[19] = 8'b0000000; //no change
	memory[20] = 8'b0000000; //no change
	memory[21] = 8'b0000000; //no change
	memory[22] = 8'b0000000; //no change
	memory[23] = 8'b0000000; //no change
	memory[24] = 8'b0000000; //no change
	memory[25] = 8'b0000000; //no change
	memory[26] = 8'b0000000; //no change
	memory[27] = 8'b0000000; //no change
	memory[28] = 8'b0000000; //no change
	memory[29] = 8'b00000000; //no change
	memory[30] = 8'b00000000; //no change
	memory[31] = 8'b00000000; //no change
end

always @(address) 
begin
    instruction = memory[address];
end

endmodule

