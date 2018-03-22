module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn, output reg [1:0] motorEn, input red);
// induct active LOW
// motorIn = direction of each motor
// motorEn = motor on/off
// induct 3 bit number 000 ====== left | middle | out
reg [3:0] last;
reg [3:0] redLast = 4'b0101;
reg proxim_last;
    always @(*)
        begin
             if((induct == 3'b001 || induct == 3'b011) && !proxim) //left sensor on tape
                   begin
                       motorIn = 4'b1010;
                       motorEn <= 2'b11;
                       last = motorIn; //saves last state
                   end
                if((induct == 3'b100 || induct == 3'b110)&& !proxim) //right sensor on tape
                   begin
                       motorIn = 4'b0101;
                       motorEn <= 2'b11;
                       last = motorIn; //saves last state
                   end
                if(induct == 3'b101 && !proxim) //middle sensor only on tape
                       begin    
                        motorIn = 4'b0110;
                        motorEn <= 2'b11;
                        last = motorIn; //saves last state
                       end
                 if(proxim) 
                    begin
                        motorIn = 4'b1010;
                        proxim_last = ~proxim_last; //toggle proxim_last to show we've encountered a cone
                        motorEn <=2'b11;
                    end
                 if(induct == 3'b010 || induct == 3'b111) //either mid junction turn or mid 180 turn
                    begin
                        motorEn <= 2'b11;
                        motorIn = last; //finish turn
                    end 
                if(induct == 3'b000) //at junction
                    begin
                      motorEn <= 2'b11;
                      motorIn = redLast; //decision is executed
                      last = motorIn; //saves last state
                    end
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