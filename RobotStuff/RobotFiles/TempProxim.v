`timescale 1us/1us
module tempProx(output reg trigger, input echo, input clk, output reg [7:0]isCrash); //trigger begins ranging, echo gives ranging value, clk is used for timing)
    reg [31:0]distance = 0;    
    always @(posedge clk) //every clock pulse
        begin
            case (echo)
            0:
                begin
                    if(distance > 0)
                        begin
                            if(distance <= 6029)
                                begin
                                  isCrash <= 8'b00000001;
                                end
                            else if(distance > 6029 && distance <= 12058)
                                begin
                                  isCrash <= 8'b00000011;
                                end
                            else if(distance > 12058 && distance <= 24116)
                                begin
                                  isCrash <= 8'b00000111;
                                end
                            else if(distance > 24116 && distance <= 48232)
                                begin
                                  isCrash <= 8'b00001111;
                                end
                            else if(distance > 48232 && distance <= 96464)
                                begin
                                  isCrash <= 8'b00011111;
                                end
                            else if(distance > 96464 && distance <= 192928)
                                begin
                                  isCrash <= 8'b00111111;
                                end
                            else if(distance > 192928 && distance <= 385856 )
                                begin
                                  isCrash <= 8'b01111111;
                                end
                            else if(distance > 385856)
                                begin
                                  isCrash <= 8'b11111111;
                                end
                             
                             trigger = 1;
                             distance = 0;
                        end  
                      else
                           begin
                              isCrash <= 0;
                           end
                end       
            1:
                begin
                    trigger <= 0;
                    distance <= distance + 1;
                end
                endcase
        end
    
    //speed of sound (m/s) * time (s) = distance (m)   time must be halved because pulse goes to and back from location

endmodule
 //basys3 board FPGA has a 100 MHz clock 100,000,000 clks/s = 1/10ns
    // 10us = 1000 clocks