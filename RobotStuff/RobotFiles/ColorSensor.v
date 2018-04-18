module ColorSensor(output reg [1:0] scale, output reg [1:0]filter, output reg [2:0] color, input sensorFreq, input clk);
reg [31:0] tempFreq = 0;
reg [31:0] RedFreq; //reg [31:0] BlueFreq; reg [31:0] GreenFreq; 
reg [31:0] count = 0; 
reg gate = 0;
always@(posedge clk)
    begin  	
			case(filter)
				2'b00: //RED
					begin				
						if(count < 100000)
							begin
								count = count + 1;
								gate = 1;
							end
						if(count == 100000)
							begin
								gate = 0;
								count = count + 1;
								RedFreq = tempFreq;
							end
						else
							begin
								count = 0;
								tempFreq = 0;
								filter = 2'b01;
							end
						
					end
				// 2'b01: //BLUE
				// 	begin
				// 		BlueFreq = Freq;
				// 		filter = 2'b11;
				// 	end
				// 2'b11: //GREEN
				// 	begin
				// 		GreenFreq = Freq;
				// 		filter = 2'b10;
      		    //     end
				// 2'b10: //clear
				// 	begin
			  	// 	if(RedFreq < BlueFreq && RedFreq < GreenFreq && RedFreq < 24)
				// 		begin
				//   			color = 3'b001;
				// 		end
			  	// 	else if (BlueFreq < RedFreq && BlueFreq < GreenFreq && BlueFreq < 21)
			  	// 		begin
				// 			color = 3'b010;
				// 		end
			  	// 	else if (GreenFreq < RedFreq && GreenFreq < BlueFreq && GreenFreq < 19)
			  	// 		begin
				// 			color = 3'b100;
				// 		end
			  	// 	filter = 2'b00;
			   	
				// end
			endcase
  	end

always@(posedge(sensorFreq && gate))
	begin
		tempFreq = tempFreq + 1;  
	end
endmodule
