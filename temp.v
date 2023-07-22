`include "ALU.v"
`include "ROM.v"
`include "oct_register.v"
`include "pent_register.v"
`include "bus_manager.v"
`include "sequence_counter.v"
`include "decoder_3_8.v"


module ROM2(input [4:0] address, output reg [7:0] instruction);

reg [7:0] memory [0:31];
initial begin
	memory[0] = 8'b11100000;

end

always @(address) 
begin
    instruction = memory[address];
end

endmodule

module memory2(output reg [7:0] data_out,input [4:0] address,input [7:0] data_in,input write);

reg [7:0] memory [0:31];
initial memory[0]=8'b00001001;
initial memory[1]=8'b10010101;
initial memory[21]=8'b00000001;

always @(*)
begin
	if (write) memory[address] <= data_in;
	else data_out <= memory[address];	
end

endmodule

module CPU2(input clk ,input R,output [7:0]out1,output [7:0]out2,output [15:0] out3);

wire [15:0] T;
wire en_sc,res_sc,write,load_sc;
wire [3:0] pload;
wire [15:0] D;
assign en_sc=1'b1;


wire [7:0] out_bus;
wire [63:0] in_bus;

wire carry_flag;

wire [4:0] out_ar;
wire [7:0] out_dr;
wire [7:0] out_ac;
wire [7:0] in_ac;


assign in_bus[23:16]=out_dr;
assign in_bus[31:24]=out_ac;
assign in_bus[4:0]=out_ar;


wire [7:0] x;

assign x[0] = 0;	//AR
assign x[1] = T[0];	//PC
assign x[2] = 0;	//DR
assign x[3] = (T[3]&D[5])|(T[5]&D[6]);	//AC
assign x[4] = T[2];	//IR
assign x[5] = (T[3]&D[0])|(T[3]&D[1])|(T[3]&D[2])|(T[3]&D[3])|(T[3]&D[4])|(T[3]&D[6])|(T[3]&D[7]);	//RAM
assign x[6] = T[1];	//ROM
assign x[7] = (T[5]&D[7])|(T[11]&D[7]);	//TR

wire load_dr,load_ac,load_ir,load_pc,load_ar;
wire inc_dr,inc_ac,inc_ir,inc_pc,inc_ar;
wire res_dr,res_ac,res_ir,res_pc,res_ar;


assign load_ar=T[0] | T[2];
assign inc_ar=1'bx;
assign res_ar=R&T[15];

assign load_pc=1'bx;
assign inc_pc=T[1];
assign res_pc=R&T[15];

assign load_dr=(T[3]&D[0])|(T[3]&D[1])|(T[3]&D[2])|(T[3]&D[3])|(T[3]&D[4])|(T[3]&D[6])|(T[5]&D[7])|(T[3]&D[7]);
assign inc_dr=(T[8]&D[7])|(T[9]&D[7]);
assign res_dr=R&T[15];

assign load_ac=(T[4]&D[0])|(T[4]&D[1])|(T[4]&D[2])|(T[4]&D[3])|(T[4]&D[6])|(T[4]&D[4])|(T[4]&D[7])|(T[6]&D[7]);
assign inc_ac=1'bx;
assign res_ac=R&T[15];

assign load_ir=T[1];
assign inc_ir=1'bx;
assign res_ir=R&T[15];

assign load_tr=1'bx;
assign inc_tr=(T[4]&D[7])|(T[8]&D[7]);
assign res_tr=(R&T[15])|(T[3]&D[7]);

assign res_sc=(T[5]&D[0])|(T[5]&D[1])|(T[5]&D[2])|(T[5]&D[3])|(T[6]&D[6])|(T[5]&D[4])|(T[4]&D[5])|(T[12]&D[7]);

assign load_sc=(T[10]&D[7])|((T[6])&D[7]&carry_flag);
assign pload = ((T[6]) & D[7] & carry_flag) ? 4'b1011 : 4'b0110;

assign write=(T[3]&D[5])|(T[5]&D[6])|(T[11]&D[7]);


sequencer sc (en_sc,clk,res_sc,load_sc, pload,T);

memory2 main_memory (in_bus[47:40], out_ar, out_bus, write);
ROM2 rom(out_ar,in_bus[55:48]);


ALU alu({T[6],T[4]},in_bus[39:37], out_ac, out_dr, in_ac, carry_flag);

bus_manager bus_manager(x, in_bus, out_bus);

oct_register DR(out_bus,out_dr,load_dr,inc_dr,res_dr,clk);
oct_register AC(in_ac,out_ac,load_ac,inc_ac,res_ac,clk);
oct_register IR(out_bus,in_bus[39:32],load_ir,inc_ir,res_ir,clk);
oct_register TR(out_bus,in_bus[63:56],load_tr,inc_tr,res_tr,clk);
pent_register PC(out_bus[4:0],in_bus[15:8],load_pc,inc_pc,res_pc,clk);
pent_register AR(out_bus[4:0],out_ar,load_ar,inc_ar,res_ar,clk);

assign out1 = out_ac;
assign out2 = in_bus[63:56];
assign out3 = {T[7],carry_flag};

wire en_dcd;
assign en_dcd=T[2]|T[3]|T[4]|T[5]|T[6]|T[7]|T[8]|T[9]|T[10]|T[11]|T[12]|T[13];

decoder_3_8 dcd_ir(en_dcd,in_bus[39],in_bus[38],in_bus[37],D);


endmodule




module CPUt_tb;

reg clk,R;
wire [7:0] out1, out2;
wire [15:0] out3;


CPU2 cpu(clk,R,out1,out2,out3);

initial begin
    clk = 0;
    R = 1;
    #10 R = 0; #1
    forever #5 clk = ~clk;
end

endmodule

