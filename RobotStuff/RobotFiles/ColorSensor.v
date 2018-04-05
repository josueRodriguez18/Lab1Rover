module ColorSensor(output reg [1:0] scale, output reg [1:0]filter, output reg enf, output reg [2:0] color, input sensorFreq, input clk);
reg [31:0] Freq; //kHz
reg [31:0] gate = 1000000; //10 ms
reg [31:0] count = 0;
reg [31:0] tempFreq = 0;


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
				if(Average Blue Frequency - 5% <= Freq && Freq <= Average Red Frequency + 5%)
					begin
					color = 3'b001;        
					end
				filter = 2'b01;
			end
		01: //BLUE
			begin
				if(Average Blue Frequency - 5% <= Freq && Freq <= Average Blue Frequency + 5%)
					begin
						color = 3'b010;  
					end
				filter = 2'b10;
			end
		11: //GREEN
			begin
				if (Average Green Frequency - 5% <= Freq && Freq <= Average Green Frequency + 5%)
					begin
						color = 3'b100;
					end
				filter = 2'b00;
            end
		endcase
    end

endmodule