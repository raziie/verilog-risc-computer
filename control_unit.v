module Control_Unit(input clk, input R, input carry_flag, input [63:0] in_bus, output wire [15:0] T, output wire [7:0] D);

wire en_sc, res_sc, load_sc;
wire [3:0] pload;
wire en_dcd;

assign en_sc = 1'b1;
assign res_sc = (T[5]&D[0])|(T[5]&D[1])|(T[5]&D[2])|(T[5]&D[3])|(T[6]&D[6])|(T[5]&D[4])|(T[4]&D[5])|(T[12]&D[7]);

assign load_sc=(T[10]&D[7])|((T[7]|T[6]) & D[7] & carry_flag);
assign pload = ((T[7]|T[6]) & D[7] & carry_flag) ? 4'b1011 : 4'b0110;

sequencer sc (en_sc, clk, res_sc, load_sc, pload, T);

assign en_dcd = T[2]|T[3]|T[4]|T[5]|T[6]|T[7]|T[8]|T[9]|T[10]|T[11]|T[12]|T[13];

decoder_3_8 dcd_ir(en_dcd, in_bus[39], in_bus[38], in_bus[37], D);

endmodule

