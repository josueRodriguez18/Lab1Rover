module Top(output [6:0]JA, input [3:0]JB, input clk); 
            wire proxim; wire echo; wire trigger;
            wire [2:0]induct; wire [3:0]MotorIn;
            assign trigger = JA[4];
            assign echo = JB[3];
            assign induct[2:0] = JB[2:0];
            assign MotorIn = JA[3:0];
            Motor motorTest(induct, proxim, MotorIn);
            ProximitySensor prox(trigger, echo, clk, proxim);    
endmodule