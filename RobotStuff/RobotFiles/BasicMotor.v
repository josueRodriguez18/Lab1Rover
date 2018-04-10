module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn, output reg [1:0] motorEn, input red);
// induct active LOW | motorIn = direction of each motor | motorEn = motor on/off | induct 3 bit number 000 ====== left | middle | out
reg [3:0] last;
reg [3:0] redLast = 4'b0101;
reg proxim_last;
    always @(induct) //any time induct changes
        begin
             case (proxim) //proxim case so it's checked instantly
              1'b0: //low
                case(induct) 
                    3'b001: //left and center detecting
                        begin //have to turn left
                            motorIn <= 4'b1010; //left motor backward right motor forward
                            motorEn <= 2'b11; //enable on
                            last = motorIn; //save last
                        end
                    3'b011:
                         begin
                            motorIn <= 4'b1010;
                            motorEn <= 2'b11;
                            last = motorIn;
                         end 
                    3'b100:
                        begin
                            motorIn <= 4'b0101;
                            motorEn <= 2'b11;
                            last = motorIn;
                        end
                    3'b110:
                        begin
                            motorIn <= 4'b0101;
                            motorEn <= 2'b11;
                            last = motorIn;
                        end
                    3'b101:
                        begin
                            motorIn <= 4'b0110;
                            motorEn <= 2'b11;
                            last = motorIn;
                        end
                    3'b000:
                        begin
                            motorIn <= redLast; //junction execution
                            motorEn <= 2'b11; 
                            last = motorIn;
                        end
                    3'b111:
                        begin
                          motorIn <= last;
                          motorEn <= 2'b11;
                          last = motorIn;
                        end
                endcase
            1'b1: 
                begin
                     motorIn <= 4'b1010; //proxim high so turn
                     last <= 4'b1010;
                     motorEn <= 2'b11;
                     proxim_last = 1 'b1; //toggle proxim_last
                end         
            endcase
        end
                always@(posedge red) //only execute when red is driven onto
                    begin
                        redLast = ~redLast; //toggle direction decision
                        if(proxim_last) //if cone was encountered we already tried one branch
                            begin
                                
                                while(induct != 3'b111) //while not off of line
                                    begin
                                        motorIn = redLast; //turn off of line to start 180 (which will be finished by other turn routines)
                                    end
                            end
                    end
                always@(negedge red) //execute when red is driven off of
                    begin
                        proxim_last = proxim_last~^1'b1; //reset last proxim for next junction ~^ = xnor
                    end       
    
endmodule