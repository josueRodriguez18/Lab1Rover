module ColorSensor_Pt2(output reg color, output reg [1:0]filter, output reg enable,input clk, input Freq);
reg [31:0] greenTemp; 
reg [31:0] GreenFreq; reg [31:0] ClearFreq; 
reg [31:0] count; 
reg [31:0] percent;
reg [31:0] Freq;
reg enable;

always@(Freq)
	
	case(filter)
	
	2'b10: //clear
		begin
				enable = 0;
				ClearFreq <= Freq;
				filter = filter + 1;
		end
	
	2'b11: // green
    	begin	
				enable = 0;
				GreenFreq <= Freq;			
				Greentemp <= GreenFreq * 100;
				enable = 1;
				filter <= 2'b00;
		end
	2'b00: // calc
		begin
			if(Greentemp >= ClearFreq)
				begin
				  Greentemp = Greentemp - ClearFreq;
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
		enable = 0;
	endcase

// always@(posedge clk)
// 	begin
// 		if(Greentemp >= ClearFreq)
// 			begin
// 			  Greentemp = Greentemp - ClearFreq;
// 			  count = count + 1;
// 			end
// 		else
// 			begin
// 			  percent <= count;
// 			  if(57<= percent <=80)
// 			  	begin
// 					color =1;
// 				end
// 			end
// 	end

endmodule