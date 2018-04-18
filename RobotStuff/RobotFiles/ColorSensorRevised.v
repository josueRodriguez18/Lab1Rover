module ColorSensor(output reg [1:0] scale, output reg [1:0]filter, output reg enf, output reg [2:0] color, input sensorFreq, input clk);
reg [31:0] Freq; //kHz
reg [31:0] gate = 100000; //1 ms
reg [31:0] count = 0;
reg [31:0] tempFreq = 0;
reg [31:0] RedFreq; reg[31:0]BlueFreq; reg[31:0] GreenFreq;

//reg [31:0] tolerance;


always@(count==0)
    begin
	  case(filter)
		2'b00: //RED
			begin
				RedFreq = FreqCounter f1(clk, sensorFreq, flag, Freq);
				filter = 2'b01;
				flag = 1;
			end
		2'b01: //BLUE
			begin
				BlueFreq = FreqCounter f2(clk, sensorFreq, flag, Freq);
				filter = 2'b11;
				flag = 1;
			end
		2'b11: //GREEN
			begin
				GreenFreq = FreqCounter f3(clk, sensorFreq, flag, Freq);
				filter = 2'b10;
				flag = 1;
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
			  flag = 1; 	
			end
		endcase
    end

endmodule
