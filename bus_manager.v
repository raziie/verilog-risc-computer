module bus_manager(input [7:0] req, input [63:0] data,output reg [7:0] data_out);
always @(*) begin
   case (req)
  	8'b00000001: data_out = data[7:0];
        8'b00000010: data_out = data[15:8];
        8'b00000100: data_out = data[23:16];
        8'b00001000: data_out = data[31:24];
        8'b00010000: data_out = data[39:32];
        8'b00100000: data_out = data[47:40];
	8'b01000000: data_out = data[55:48];
	8'b10000000: data_out = data[63:56];
        default: data_out = 8'b0;
    endcase
end

endmodule

module bus_manager_test;

reg [7:0] req;
reg [63:0] data;
wire [7:0] data_out;

bus_manager bus_manager_inst(req, data, data_out);

initial begin
    // Test case 1: Request from AR
    req = 8'b00000001;
    data[7:0] = 8'b00000001;
    #10;

    // Test case 2: Request from PC
    req = 8'b00000010;
    data[15:8] = 8'b00000010;
    #10;

    // Test case 3: Request from DR
    req = 8'b00000100;
    data[23:16] = 8'b00000100;
    #10;

    // Test case 4: No request
    req = 8'b00000000;
    #10;

end

endmodule
