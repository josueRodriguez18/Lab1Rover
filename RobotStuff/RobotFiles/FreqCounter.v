module FreqCounter(input clk, input sensorFreq,  output Freq);
reg [31:0] Freq; //kHz
reg gate = 0;
reg [31:0] count = 0;
reg [31:0] tempFreq = 0;



always@ (posedge clk)
        begin
            if(count < 100000)
			    begin
				    count = count + 1;
				    gate = 1;
			    end
	        else if(count == 100000)
			    begin
				    count = count + 1;
                    Freq = tempFreq;
                    gate = 0;
                    tempFreq = 0;
			    end
            else
                begin
                    count = 0;
                    Freq = 0;
                end
        end


always@(posedge(sensorFreq && gate))
    begin
        tempFreq = tempFreq + 1;
    end
endmodule