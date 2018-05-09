module FreqCounter(input enable, input sensorFreq, input clk, output reg freqValue);
    reg [31:0] tempFreq = 0;
       
        always@(posedge(clk))
            begin
                if(!enable)
                    begin
                        freqValue <= tempFreq;
                    end
            end

        always@(posedge(freqValue))
            begin
                tempFreq <= (tempFreq + 1)&&enable;  
            end

    endmodule