module ColorSensor(output reg color, input clk, input [1:0]sensorFreq);
reg [31:0] greenTemp; reg [31:0] clearTemp; reg[31:0] temp;
reg [31:0] GreenFreq; reg [31:0] ClearFreq; 
reg [31:0] count; 
reg gate; reg [31:0] percent;
always@(posedge clk)
    begin				
				if(count < 100000)
					begin
						count <= count + 1;
						gate <= 1;
					end
				else if(count == 100000)
					begin
						GreenFreq <= greenTemp;
						ClearFreq <= clearTemp;
						temp <= GreenFreq * 100;
						count <= count + 1;
					end
				else
					begin
						gate <= 0;
						if(ClearFreq <= temp)
							begin
								temp <= temp - ClearFreq;
								count <= count +1;
							end
						else
							begin
								percent <= count;
								if(57 <= percent && percent <= 80)
									begin
										color <= 1;
									end
								else
								    begin
								        color <= 0;
								    end
								count <= 0;
							end

					end
				
  	end

always@(posedge (sensorFreq[1]))
	begin
		if(gate == 1)
			begin
				greenTemp <= greenTemp +1;
			end
		else
			begin
				greenTemp <= 0;
			end
	end
always@(posedge(sensorFreq[0]))
	begin
		if(gate == 1)
			begin
				clearTemp <= clearTemp +1;
			end
		else
			begin
				clearTemp <= 0;
			end
	end


endmodule
