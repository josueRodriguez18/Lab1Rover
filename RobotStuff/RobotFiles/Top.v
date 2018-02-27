module Top( input [3:0]sw, 
            output [3:0]JA, [1:0]JB);
            
            // sw[2] sw[1] sw[0] =  inductance 3 bit number set to switches for test
            // JA[3] JA[2] JA[1] JA[0] = IN4 IN3 IN2 IN1    
            // JB[1] JB[0] = ENA ENB
            wire [2:0]induct;
            assign induct[2:0] = sw[2:0];
            wire proxim;
            assign proxim = sw[3];
            wire [3:0]MotorIn;
            wire [1:0]MotorEn;
            assign MotorIn = JA[3:0];
            assign MotorEn = JB[1:0];
            Motor motorTest(induct, proxim, MotorIn, MotorEn);
endmodule