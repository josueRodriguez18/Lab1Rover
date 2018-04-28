module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn);
reg [3:0] last; reg [1:0]proxim_last; reg at_Proxim; reg [2:0]induct_last;

    always @(proxim || induct) //any time induct changes
        begin
             case (proxim) //proxim case
                1'b0: //low
                    case(induct) 
                        3'b001: //left and center detecting
                            begin //have to turn left
                                if(proxim_last)
                                    begin
                                        motorIn <= 4'b0110;
                                        proxim_last <= 0;
                                    end
                                else
                                    begin
                                        motorIn <= 4'b1010; //left motor backward right motor forward
                                        last <= 4'b1010; //save last
                                    end
                            end
                    3'b011:
                        begin
                            if(at_Proxim)
                                begin
                                    motorIn <= last;
                                end
                            else
                                begin
                                    motorIn <= 4'b1010;
                                    last <= 4'b1010;
                                end
                        end
                        
                    3'b110:
                        begin
                            if(at_Proxim)
                                begin
                                    motorIn <= last;
                                end
                            else
                                begin
                                    motorIn <= 4'b0101;
                                    last <= motorIn;
                                end
                        end
                    3'b100:
                        begin
                            if(at_Proxim)
                                begin
                                    motorIn <= last;
                                end
                             else
                               begin
                                    motorIn <= 4'b0101;
                                    last <= motorIn;
                               end
                        end
                    3'b000:
                        begin
                            motorIn <= 4'b0100;
                            last <= 4'b0101;
                        end
                    3'b101:
                        begin
                            motorIn <= 4'b0110;
                            at_Proxim <= 0;
                        end
                    3'b111:
                        begin
                            motorIn <= last;
                        end
                    3'b010:
                        begin
                            motorIn <= last;
                        end
                endcase
            1'b1: 
                begin
                     motorIn <= last;
                     proxim_last <= 1'b1; //toggle proxim_last
                     at_Proxim <= 1;
                end         
            endcase
        end    
endmodule