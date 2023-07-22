module decoder(en, w, x, y, z, out);

input en, w, x, y, z;
output reg [15:0] out;

always @(*) begin
    if (en) begin
        out = 16'b0000000000000001 << (w * 8 + x * 4 + y * 2 + z);
    end 
    else out = 0;
end

endmodule


module counter(clk, res, load, pload, out);

input clk, res, load;
input [3:0] pload;
output reg [3:0] out;

initial out = 4'b1111;

always @(posedge clk) begin
    if (res) begin
        out <= 0;
    end else if (load) begin
        out <= pload;
    end else begin
        out <= out + 1;
    end
end

endmodule


module sequencer(en, clk, res, load, pload, out);

input en, clk, res, load;
input [3:0] pload;
output [15:0] out;
wire [3:0] con;

counter ctr(clk, res, load, pload, con);
decoder dcd(en, con[3], con[2], con[1], con[0], out);

endmodule


module test_counter;

reg en, clk, res, load;
reg [3:0] pload;
wire [15:0] out;

sequencer seq(en, clk, res, load, pload, out);

initial
begin
en = 1;
res = 0;
load = 0;
pload = 0;

// Load a value into the counter
#10 load = 1;
#10 pload = 4'b1010;
#10 load = 0;
end

initial
begin
clk = 1'b0;
forever
#5 clk = ~clk;
end
endmodule


