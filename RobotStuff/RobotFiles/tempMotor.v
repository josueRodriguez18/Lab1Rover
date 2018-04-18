module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn, output reg [1:0] motorEn, input red);
// induct active LOW
// motorIn = direction of each motor
// motorEn = motor on/off
// induct 3 bit number 000 ====== left | middle | out
reg [3:0] last;
reg [3:0] redLast = 4'b0101;
reg proxim_last;
reg at_Proxim;
    always @(*)
        begin
             if((induct == 3'b001 || induct == 3'b011) && !proxim) //left sensor on tape
                   begin
                    if(at_Proxim)
                        begin
                            motorIn = last
                            motorEn = 2'b11;
                        end
                    else
                        begin
                            motorIn = 4'b1010;
                            motorEn <= 2'b11;
                            last = motorIn; //saves last state
                        end
                   end
                if((induct == 3'b100 || induct == 3'b110)&& !proxim) //right sensor on tape
                   begin
                       if(at_Proxim)
                        begin
                          motorIn = last;
                          motorIn = 2'b11;
                        end
                       else
                        begin
                            motorIn = 4'b0101;
                            motorEn <= 2'b11;
                            last = motorIn; //saves last state
                        end
                   end
                if(induct == 3'b101 && !proxim) //middle sensor only on tape
                       begin    
                        motorIn = 4'b0110;
                        motorEn <= 2'b11;
                       end
                 if(proxim) 
                    begin
                        motorIn = last;
                        at_Proxim = 1;
                        motorEn <=2'b11;
                    end
                 if(induct == 3'b010 || induct == 3'b111) //either mid junction turn or mid 180 turn
                    begin
                        motorEn <= 2'b11;
                        motorIn = last; //finish turn
                        at_Proxim = 0;
                    end 
                if(induct == 3'b000) //at junction
                    begin
                      motorEn <= 2'b11;
                      motorIn = last;
                    end
                end    
endmodule