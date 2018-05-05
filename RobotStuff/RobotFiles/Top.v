module Top(input [7:5]JB, input clk, output [3:2]JC, input [1:0]sw);
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
                SegDisplay s1(input reg [15:0]display_number, output reg [3:0]anode_activate, output reg [6:0] led_out, input clk, input reset);

endmodule