module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn, output reg [1:0] motorEn, input red);
reg [3:0] last; reg [1:0]proxim_last; reg at_Proxim; reg [2:0]induct_last;

    always @(proxim || induct) //any time induct changes
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
                                 proxim_last <= 0;
                                 induct_last <= induct;
                               end
                           if(induct_last == 3'b000)
                                begin
                                    motorIn <= 4'b0101;
                                    motorEn <= 2'b11;
                                end
                           else
                               begin
                                    motorIn <= 4'b1010; //left motor backward right motor forward
                                    motorEn <= 2'b11; //enable on
                                    last = 4'b1010; //save last
                                    induct_last <= induct;
                                end
                        end
                    3'b011:
                         begin
                            if(at_Proxim)
                                begin
                                  motorIn <= last;
                                  motorEn <= 2'b11;
                                  induct_last <= induct;
                                end
                            else
                                begin
                                    motorIn <= 4'b1010;
                                    motorEn <= 2'b11;
                                    last <= 4'b1010;
                                    induct_last <= induct;
                                end
                         end
                        
                    3'b110:
                        begin
                            if(at_Proxim)
                                begin
                                    motorIn <= last;
                                    motorEn <= 2'b11;
                                    induct_last <= induct;
                                end
                            else
                                begin
                                    motorIn <= 4'b0101;
                                    motorEn <= 2'b11;
                                    last = motorIn;
                                    induct_last <= induct;
                                end
                        end
                    3'b100:
                        begin
                            if(at_Proxim)
                               begin
                                  motorIn <= last;
                                  motorEn <= 2'b11;
                                  induct_last <= induct;
                                end
                             else
                               begin
                                  motorIn <= 4'b0101;
                                  motorEn <= 2'b11;
                                  last = motorIn;
                                  induct_last <= induct;
                               end
                        end
                    
                    
                    3'b000:
                        begin
                          motorIn <= 4'b0101;
                          motorEn <= 2'b11;
                          last <= 4'b0101;
                          induct_last <= induct;
                        end
                    3'b101:
                        begin
                            motorIn <= 4'b0110;
                            motorEn <= 2'b11;
                            at_Proxim <= 0;
                            induct_last <= induct;
                        end
                    3'b111:
                        begin
                          motorIn <= last;
                          motorEn <= 2'b11;
                          induct_last <= induct;
                        end
                    3'b010:
                        begin
                            motorIn <= last;
                            motorEn <= 2'b11;
                            induct_last <= induct;
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