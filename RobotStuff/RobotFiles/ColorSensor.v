module ColorSensor(output reg color, input clk, input freq);
reg [31:0] greenTemp; reg[31:0] tempFreq; reg last = 0;
reg [31:0] GreenFreq; 
reg [31:0] count; 
always@(posedge clk)
	begin
		if(count <= 200000)
			begin
				if(~last &&freq)
					begin
						tempFreq <= tempFreq + 1;	
					end
				count <= count + 1;
				last <= freq;
			end
		else
			begin
				count <= 0;
				GreenFreq <= tempFreq;
				if(GreenFreq > 0)
					begin
						color <= 1;
						tempFreq <= 0;
					end 

				else
					begin
						color <= 0;
						tempFreq <= 0;
					end
			end
	end
endmodule
