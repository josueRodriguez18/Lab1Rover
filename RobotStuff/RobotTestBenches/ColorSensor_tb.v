`timescale 1ns / 1ps

module ColorSensor_tb();
reg color; reg sensorFreq; reg sensorFreq2;
wire [1:0] scale; reg clk;
reg [31:0] freqStep = 1000000, freqStep2 = 500000; reg [31:0] count, count2;

initial begin
    clk = 0;
    sensorFreq = 0;
    sensorFreq2 = 0;
    count = 0; count2 = 0;
    
end

ColorSensor c1(color, scale, sensorFreq, sensorFreq2, clk);

always
    #10 clk = ~clk;
    
    always@(posedge clk)
        begin
            if(count <= freqStep)
                begin
                    count <= count + 1;
                end
             else
                begin
                    sensorFreq <= ~sensorFreq;
                    count <= 0;
                end
             if(count2 <= freqStep2)
                begin
                    count2 <= count2 + 1;
                end
             else
                begin
                    count2 <= 0;
                    sensorFreq2 <= ~sensorFreq2;
                end
        end


endmodule
