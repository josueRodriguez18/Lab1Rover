module Top(/*input [1:0]JB,*/ input clk, output [3:2]JC, input [1:0]sw);
//            wire proxim; wire echo; wire trigger;
//            wire [2:0]induct; wire [3:0]MotorIn;
//            assign trigger = JA[4];
//            assign echo = JB[3];
//            assign induct[2:0] = JB[2:0];
//            assign MotorIn = JA[3:0];
//            Motor motorTest(induct, proxim, MotorIn);
//            ProximitySensor prox(trigger, echo, clk, proxim); 
              wire color; wire [1:0]switches;
              assign switches = sw[1:0];
              
              //ColorSensor c1(color, clk, sensorFreq); 
              colorTest c2(switches , JC[3:2], clk);
endmodule