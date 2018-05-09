module Top(input [7:5]JB, input clk, output [3:2]JC, input [1:0]sw, output [6:0]seg, output [3:0]an);
			reg [15:0]display_number = 2345;
			wire [3:0]anode_activate;
			wire [6:0]led_out;
//            wire proxim; wire echo; wire trigger;
//            wire [2:0]induct; wire [3:0]MotorIn;
//            assign trigger = JA[4];
//            assign echo = JB[3];
//            assign induct[2:0] = JB[2:0];
//            assign MotorIn = JA[3:0];
//            Motor motorTest(induct, proxim, MotorIn);
//            ProximitySensor prox(trigger, echo, clk, proxim);
                //reg [31:0] freqValue; wire sensorFreq;
                //assign sensorFreq = JB[7];
                //FreqCounter f1(sw[0], sensorFreq, input clk, freqValue);
			assign an[3:0] = anode_activate[3:0];
			assign seg[6:0] = led_out[3:0];
              SegDisplay s1(display_number, anode_activate, led_out, clk);

endmodule