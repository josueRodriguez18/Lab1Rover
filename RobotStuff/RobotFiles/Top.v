module Top(input [7:5]JB, input clk, output [0:0]led);
		reg [15:0] displayed_number;
			wire [3:0]anode_activate;
			wire [6:0]led_out;
			reg [26:0] one_second_counter; // counter for generating 1 second clock enable
            wire one_second_enable;
//            wire proxim; wire echo; wire trigger;
//            wire [2:0]induct; wire [3:0]MotorIn;
//            assign trigger = JA[4];
//            assign echo = JB[3];
//            assign induct[2:0] = JB[2:0];
//            assign MotorIn = JA[3:0];
//            Motor motorTest(induct, proxim, MotorIn);
//            ProximitySensor prox(trigger, echo, clk, proxim);
                reg [31:0] freqValue; wire sensorFreq; wire color;
                assign color = led[0];
                assign sensorFreq = JB[7]; 
                ColorSensor c1(color, sensorFreq, clk);
			
//			assign an[3:0] = anode_activate[3:0];
//			assign seg[6:0] = led_out[6:0];
//              SegDisplay s1(displayed_number, anode_activate, led_out, clk);
            
//                always @(posedge clk)
//              begin
//                      if(one_second_counter>=99999999) 
//                           one_second_counter <= 0;
//                      else
//                          one_second_counter <= one_second_counter + 1;
//              end 
//              assign one_second_enable = (one_second_counter==99999999)?1:0;
//              always @(posedge clk)
//              begin
//              if(one_second_enable==1)
//                      displayed_number <= displayed_number + 1;
//              end
endmodule