module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn, output reg [1:0] motorEn, input red);
// induct active LOW | motorIn = direction of each motor | motorEn = motor on/off | induct 3 bit number 000 ====== left | middle | out
reg [3:0] last;
reg [1:0]proxim_last;
    always @(posedge clk) //any time induct changes
        begin
             case (proxim) //proxim case
             // so it's checked instantly
              1'b0: //low
                casex(induct) 
                    3'b001: //left and center detecting
                        begin //have to turn left
                           if(proxim_last)
                               begin
                                 motorIn <= 4'b0110;
                                 motorEn <= 2'b11;
                               end
                           else
                               begin
                                    motorIn <= 4'b1010; //left motor backward right motor forward
                                    motorEn <= 2'b11; //enable on
                                    last = 4'b1010; //save last
                                end
                        end
                    3'b011:
                         begin
                            if(at_Proxim)
                                begin
                                  motorIn <= last;
                                  motorEn <= 2'b11;
                                end
                            else
                                begin
                                    motorIn <= 4'b1010;
                                    motorEn <= 2'b11;
                                    last <= 4'b1010;
                                end
                         end
                        
                    3'bxx0:
                        begin
                            if(at_Proxim)
                                begin
                                    motorIn <= last;
                                    motorEn <= 2'b11;
                                end
                            else
                                begin
                                    motorIn <= 4'b0101;
                                    motorEn <= 2'b11;
                                    last = motorIn;
                                end
                        end
                    3'b101:
                        begin
                            motorIn <= 4'b0110;
                            motorEn <= 2'b11;
                        end
                    3'b111:
                        begin
                          motorIn <= last;
                          motorEn <= 2'b11;
                          at_Proxim <= 0;
                        end
                endcase
            1'b1: 
                begin
                     motorIn <= last;
                     motorEn <= 2'b11;
                     proxim_last <= 1'b1; //toggle proxim_last
                     at_Proxim <= 1;
                end         
            endcase
        end    
endmodule