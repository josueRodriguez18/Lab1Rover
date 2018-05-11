`timescale 1ns / 1ps

module ColorSensor_tb();
wire color; reg sensorFreq;
 reg clk;
reg [31:0] freqStep = 1818; reg [31:0] count;

initial begin
    clk = 0;
    sensorFreq = 0;
    count = 0;
    
end

ColorSensor c1(color, clk, sensorFreq);

always
    #10 clk = ~clk;
    


endmodule
