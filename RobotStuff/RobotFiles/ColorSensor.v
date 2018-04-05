module ColorSensor(output reg [1:0] scale, output reg [1:0]filter, output reg enf, output reg [2:0] color, input sensorFreq, input clk);
reg [31:0] Freq; //kHz
reg [31:0] gate = 1000000; //1 ms
reg [31:0] count = 0;
reg [31:0] tempFreq = 0;
reg [31:0] avRedFreq; reg[31:0]avRedFeq; reg[31:0] avBlueFreq;
reg [31:0] tolerance;


always@(posedge clk)
	begin
		scale <= 2'b11;
		enf <= 1'b1;
		if(count <= gate)
			begin
				count = count + 1;
			end
		else
			begin
				count = 0;
				Freq= tempFreq;
			end
		if(sensorFreq)
			begin
				tempFreq = tempFreq +1;
			end
	end

always@(count==0)
    begin
	  case(filter)
		00: //RED
			begin
				if(avRedFreq - tolerance <= Freq && Freq <= avRedFreq + tolerance)
					begin
					color = 3'b001;        
					end
				filter = 2'b01;
			end
		01: //BLUE
			begin
				if(avBlueFreq - tolerance <= Freq && Freq <= avBlueFreq + tolerance)
					begin
						color = 3'b010;  
					end
				filter = 2'b10;
			end
		11: //GREEN
			begin
				if (avGreenFreq - tolerance <= Freq && Freq <= avGreenFreq + tolerance)
					begin
						color = 3'b100;
					end
				filter = 2'b11;
            end
		endcase
    end

endmodule