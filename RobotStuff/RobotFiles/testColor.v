module ColorSensor(output reg [2:0]color, input clk, input reg [1:0]sensorFreq)
reg [31:0] greenTemp; reg [31:0] clearTemp; reg[31:0] temp;
reg [31:0] GreenFreq; reg [31:0] ClearFreq; 
reg [31:0] count; 
reg gate; reg [31:0] percent;
reg filter = 2'b00;
assign filter = switches;
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
						if(ClearFreq <= greenTemp)
							begin
								temp <= temp - ClearFreq
								count <= count +1;
							end
						else
							begin
								percent <= count;
								count <= 0;
								if(57 <= percent && percent <= 80)
									begin
										color <= 1;
									end
								count <= 0;
							end

					end
				
  	end

always@(posedge (sensorFreq[1]))
	begin
		if(gate == 1)
			begin
				tempFreq <= tempFreq +1;
			end
		else
			begin
				tempFreq <= 0;
			end
	end
always@(posedge(sensorFreq[0]))
	begin
		if(gate == 1)
			begin
				tempFreq2 <= tempFreq2 +1;
			end
		else
			begin
				tempFreq <= 0;
			end
	end


endmodule
