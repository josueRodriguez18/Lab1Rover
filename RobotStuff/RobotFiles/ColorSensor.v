module ColorSensor(output reg color, input clk, output reg enable);
reg [31:0] greenTemp; reg [31:0] clearTemp; reg[31:0] temp;
reg [31:0] GreenFreq; reg [31:0] ClearFreq; 
reg [31:0] count; 
reg gate; reg [31:0] percent;
always@(posedge clk)
	begin
		if(count <= 100000)
			begin
				if(~last &&freq)
					begin
						tempFreq <= tempFreq + 1;
					end
				count <= count + 1;
			end
		else
			begin
				count <= 0;
				GreenFreq <= tempFreq;
				if(GreenFreq < 58 && GreenFreq > 52)
					begin
						color <= 1;
					end 

				else
					begin
						color <= 0;
					end
			end
	last <= freq;
	end
endmodule
