module ColorSensor(output reg color, output reg [1:0] scale, output reg [1:0] scale2, input sensorFreq, input sensorFreq2, input clk);
reg [31:0] tempFreq = 0;
reg [31:0] tempFreq2 = 0;
reg [31:0] GreenFreq; reg [31:0] clearFreq; 
reg [31:0] tempGreenFreq; reg[31:0] percent;
reg [31:0] count = 0;
reg [31:0] count2 = 0;
reg[31:0] count3 = 0;
reg [1:0] scale = 2'b11;
reg [1:0] scale2 = 2'b11;

reg last = 0;
reg last2 = 0;
always@(posedge clk)
    begin
        last<= sensorFreq;
		
		if(count <= 100000)
			begin
				count <= count + 1;
						
				if(~last & sensorFreq)
				    begin
				        tempFreq <= tempFreq + 1;
				    end
			end
			
		else
			begin
				GreenFreq <= tempFreq;
				tempFreq <= 0;
				count <= 0;
				
			end
      	
		//clear
		
		if(count2 <= 100000)
			begin
				count2 <= count2 + 1;
				
				if(~last2 & sensorFreq2)
				    begin
				        tempFreq2 <= tempFreq2 + 1;
				    end
				end
				
			else
				begin
					clearFreq <= tempFreq2;
					tempFreq2 <= 0;
					count2 <= 0;
					
				end
			end
		
  	
 always@(GreenFreq && clearFreq)
 	begin
 		tempGreenFreq <= GreenFreq * 100;
 		if(clearFreq <= tempGreenFreq)
 			begin
 				tempGreenFreq <= clearFreq;
 				count3 <= count3 +1;
 			end
 		else
 			begin
 			  percent <= count3;
 			  count3 <= 0;
 			  if(57 < percent < 80)
                         begin
                             color = 1;
                         end
 			end
		
		
		
 	end


endmodule