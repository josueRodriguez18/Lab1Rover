module FreqCounter(input clk, input sensorFreq,  output Freq);
reg [31:0] Freq; //kHz
reg gate = 0;
reg [31:0] count = 0;
reg [31:0] tempFreq = 0;
reg flag = 1;


always@ (posedge clk)
    begin
        //if (flag == 1)
        begin
            if((count <= 50000) && clk)
			    begin
				    count = count + 1;
				    gate = 1;
			    end
	        else 
			    begin
				    count = 0;
                    Freq = tempFreq;
                    gate = 0;
                    tempFreq = 0;
			    end
        end
    end

always@(posedge(sensorFreq && gate))
    begin
    tempFreq = tempFreq + 1;
    end
endmodule