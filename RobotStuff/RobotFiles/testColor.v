module ColorSensor(output reg [1:0]scale, output reg [1:0] filter, output reg [2:0]color, input [2:0] switches, input clk, input sensorFreq)
reg [31:0] tempFreq;
reg [31:0] RedFreq; reg [31:0] BlueFreq; reg [31:0] GreenFreq; 
reg [31:0] count; 
reg gate;
reg filter = 2'b00;
assign filter = switches;
always@(posedge clk)
    begin
        scale = 2'b11;
			case(filter)
				2'b00: //RED
					begin				
						if(count < 100000)
							begin
								count <= count + 1;
								gate <= 1;
							end
						else if(count == 100000)
							begin
								RedFreq <= tempFreq-14;
								count <= count + 1;
							end
						else
							begin
								count <= 0;
								gate <= 0;
								//filter <= 2'b01;
							end	
					end
				2'b01: //BLUE
					begin
						if(count < 100000)
							begin
								count <= count + 1;
								gate <= 1;
							end
						else if(count == 100000)
							begin
								BlueFreq <= tempFreq-11;
								count = count + 1;	
							end
						else
							begin
								count <= 0;
								gate <= 0;
								//filter <= 2'b11;
							end
					end
				2'b11: //GREEN
					begin
						if(count < 100000)
							begin
								count <= count + 1;
								gate <= 1;
							end
						else if(count == 100000)
							begin
								GreenFreq <= tempFreq-8;
								count <= count + 1;
							end
						else
							begin
								count <= 0;
								gate <= 0;
								//filter <= 2'b10;
							end
      					end
				2'b10: //clear
					begin
			  		if(RedFreq > BlueFreq && RedFreq > GreenFreq)//&& RedFreq < 24
						begin
				  			color <= 3'b001;
						end
			  		else if (BlueFreq > RedFreq && BlueFreq > GreenFreq )//&& BlueFreq < 21
			  			begin
							color <= 3'b010;
						end
			  		else if (GreenFreq > RedFreq && GreenFreq > BlueFreq)//&& GreenFreq < 19) 
			  			begin
							color <= 3'b100;
						end
					else if (GreenFreq == RedFreq && BlueFreq == RedFreq && RedFreq== GreenFreq)
					   begin
					       color <= 3'b111;
					   end 
					//filter <= 2'b00;
				end
			endcase
  	end

always@(posedge (sensorFreq))
	begin
		if(gate == 1)
			begin
				tempFreq <= tempFreq +1;
			end
		else
			begin
				tempFreq <= 0;
			end
	end
endmodule
