module Top(output [6:0]JA, input [3:0]JB, input clk); 
            //uncomment for motor
            // sw[2] sw[1] sw[0] =  inductance 3 bit number set to switches for test
            // JA[3] JA[2] JA[1] JA[0] = IN4 IN3 IN2 IN1    
            // JB[1] JB[0] = ENA ENB
            reg red = 0;
            wire proxim;
            wire [2:0]induct;
            wire echo;
            wire trigger;
            wire [3:0]MotorIn;
            wire [1:0]MotorEn;
            assign trigger = JA[6];
            assign echo = JB[3];
            assign induct[2:0] = JB[2:0];
            assign MotorIn = JA[3:0];
            assign MotorEn = JA[5:4];
             Motor motorTest(induct, proxim, MotorIn, MotorEn, red);
             ProximitySensor prox(trigger, echo, clk, proxim);
            
            
            
            
endmodule