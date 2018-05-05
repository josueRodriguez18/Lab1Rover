module ColorSensor(output reg color, output reg [1:0]filter, input clk, input Freq);
reg [31:0] greenTemp; 
reg [31:0] GreenFreq; reg [31:0] ClearFreq; 
reg [31:0] count; 
reg [31:0] percent;

always@(Freq)
	
	case(filter)
	
	2'b10: //clear
		begin
				ClearFreq <= Freq;
				filter = filter + 1;
		end
	
	2'b11: // green
    	begin	
				GreenFreq <= Freq;			
				Greentemp <= GreenFreq * 100;
				filter = filter -1;
		end

	endcase

always@(posedge clk)
	begin
		if(Greentemp >= ClearFreq)
			begin
			  Greentemp = Greentemnp - ClearFreq;
			  count = count + 1;
			end
		else
			begin
			  percent <= count;
			  if(57<= percent <=80)
			  	begin
					color =1;
				end
			end
	end

endmodule