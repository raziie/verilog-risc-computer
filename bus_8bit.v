module bus_8bit(input [7:0] data_in,output reg [7:0] data_out);

always @(*) begin
    data_out = data_in;
end

endmodule
