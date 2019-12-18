`timescale 1ns / 100ps

module electromagnet_simulation();
reg[1:0] in1 = 2'b0;
reg clk1 = 1'b0;
wire[1:0] out1;

electromagnet DUT(.in(in1), .out(out1), .clk(clk1));

initial begin
    in1 = 2'b10;
    #20000000
    in1 = 2'b0;
    #200
    in1 = 2'b01;
    #50
    in1 = 2'b0;
    #200
    in1 = 2'b10;
end

always clk1 = #5 ~clk1;
endmodule
