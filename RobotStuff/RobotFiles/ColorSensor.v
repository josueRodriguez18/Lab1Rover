module ColorSensor(output reg [1:0] scale, output reg [1:0]filter, output reg enf, output reg [2:0] color, input sensorFreq, input clk);
reg [31:0] Freq; //kHz
reg [31:0] tempFreq = 0;
reg [31:0] RedFreq; 
reg [31:0]BlueFreq; 
reg [31:0] GreenFreq;
reg enf = 0;

always@(!Freq)
    begin
			
	    FreqCounter f1(clk, sensorFreq, Freq); //This line has syntax error, do not know why
	  	
			case(filter)
				2'b00: //RED
					begin				
				
						RedFreq = Freq;
						filter = 2'b01;
						Freq = 0;

					end
				2'b01: //BLUE
					begin
				
						BlueFreq = Freq;
						filter = 2'b11;
						Freq = 0;
				
					end
				2'b11: //GREEN
					begin
				
						GreenFreq = Freq;
						filter = 2'b10;
						Freq = 0;
				
      		end
				2'b10: //clear
					begin
			  		if(RedFreq < BlueFreq && RedFreq < GreenFreq && RedFreq < 24)
							begin
				  			color = 3'b001;
							end
			  		else if (BlueFreq < RedFreq && BlueFreq < GreenFreq && BlueFreq < 21)
			  			begin
								color = 3'b010;
							end
			  		else if (GreenFreq < RedFreq && GreenFreq < BlueFreq && GreenFreq < 19)
			  			begin
								color = 3'b100;
							end
			  		filter = 2'b00;
			   	
				end
			endcase
  	end

endmodule
