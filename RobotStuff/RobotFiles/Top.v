module Top(output [1:0]JA, input clk, input [1:0]JB, output [7:0]led);
            //uncomment for motor
            // sw[2] sw[1] sw[0] =  inductance 3 bit number set to switches for test
            // JA[3] JA[2] JA[1] JA[0] = IN4 IN3 IN2 IN1    
            // JB[1] JB[0] = ENA ENB
//            reg red = 0;
//            reg proxim = 0;
//            wire [2:0]induct;
//            assign induct[2:0] = JB[2:0];
//            wire [3:0]MotorIn;
//            wire [1:0]MotorEn;
//            assign MotorIn = JA[3:0];
//            assign MotorEn = JA[5:4];
//            Motor motorTest(induct, proxim, MotorIn, MotorEn, red);
             tempProx prox(JA[0], JB[0], clk, led[7:0]);
            
            
            
            
endmodule