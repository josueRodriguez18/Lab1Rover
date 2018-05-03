`timescale 1ns/1ps
module ColorSensor(output reg [1:0] scale, output reg [1:0]filter, output reg [2:0] color, input sensorFreq, input clk);
reg [31:0] tempFreq = 0;
reg [31:0] RedFreq; reg [31:0] BlueFreq; reg [31:0] GreenFreq; reg [31:0] clearFreq; 
reg [31:0] count = 0;
reg [31:0] count2 = 0;
reg [31:0]tempRedFreq; reg [31:0] tempBlueFreq; reg [31:0] tempGreenFreq; 
reg gate;
reg [1:0] filter = 2'b00;
reg [1:0] scale = 2'b11;

reg last = 0;

always@(posedge clk)
    begin
        last<= sensorFreq;
		case(filter)
			2'b00: //RED
			begin				
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
						RedFreq <= tempFreq;
						tempFreq <= 0;
						count <= 0;
						filter <= 2'b01;
					end	
			end
			2'b01: //BLUE
			begin
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
						BlueFreq <= tempFreq;
						tempFreq <= 0;
						count <= 0;
						filter <= 2'b11;
					end
				end
			2'b11: //GREEN
			begin
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
						filter <= 2'b10;
					end
      			end
				2'b10: //clear
				begin
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
						clearFreq <= tempFreq;
						tempFreq <= 0;
						count <= 0;
						filter <= 2'b00;
					end
				end
			endcase
  	end

 always@(RedFreq && BlueFreq && GreenFreq && clearFreq)
 	begin
 		tempRedFreq <= RedFreq * 100;
 		if(clearFreq <= tempRedFreq)
 			begin
 				tempRedFreq <= tempRedFreq - clearFreq;
 				count2 <= count2 +1;
 			end
 		else
 			begin
 			  RedFreq <= count2;
 			  count2 <= 0;
 			end
		
 		tempBlueFreq <= BlueFreq * 100;
 		if(clearFreq <= tempBlueFreq)
 			begin
 				tempBlueFreq <= clearFreq;
 				count2 <= count2 +1;
 			end
 		else
 			begin
 			  BlueFreq <= count2;
 			  count2 <= 0;
 			end
 		tempGreenFreq <= GreenFreq * 100;
 		if(clearFreq <= tempGreenFreq)
 			begin
 				tempGreenFreq <= clearFreq;
 				count2 <= count2 +1;
 			end
 		else
 			begin
 			  GreenFreq <= count2;
 			  count2 <= 0;
 			end
		if(61 < BlueFreq < 84)
		  begin
		      color = 3'b001;
		  end
		else if(57 < GreenFreq < 80)
		  begin
		      color = 3'b010;
		  end
		else if(84 < RedFreq < 105)
		  begin
		      color = 3'b100;
		  end
 	end

//always@(posedge (sensorFreq))
//	begin
//		if(gate == 1)
//			begin
//				tempFreq = tempFreq + 1;
//			end
//		else
//			begin
//				tempFreq <= 0;
//			end
//	end

// if(RedFreq < BlueFreq && RedFreq < GreenFreq)//&& RedFreq < 24
// 						begin
// 				  			color <= 3'b001;
// 						end
// 			  		else if (BlueFreq < RedFreq && BlueFreq < GreenFreq )//&& BlueFreq < 21
// 			  			begin
// 							color <= 3'b010;
// 						end
// 			  		else if (GreenFreq < RedFreq && GreenFreq < BlueFreq)//&& GreenFreq < 19) 
// 			  			begin
// 							color <= 3'b100;
// 						end
// 					else if (GreenFreq == RedFreq && BlueFreq == RedFreq && RedFreq== GreenFreq)
// 					   begin
// 					       color <= 3'b111;
// 					   end
endmodule

