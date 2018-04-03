//The rover contains four motors, two of which are removed for this project, that are rated at 7.2 Volts and a max speed of .62 miles per hour`timescale 1us/1us
module ProximitySensor(output reg trigger, input echo, input clk, output reg isCrash); //trigger begins ranging, echo gives ranging value, clk is used for timing
    //need to supply a short 10us pulse to trigger ranging                          is crash is ouput to motor module
 //timer used for trigger output (minimum 10 microseconds)
    reg [31:0]distance = 0;
    
    always @(posedge clk) //every clock pulse
        begin
            case (echo)
            0:
                begin
                    
                    if(distance <= 294117 && distance > 0)
                        begin
                            isCrash <= 1;
                            distance <=0;
                        end
                     else if(distance > 294117)
                        begin
                            isCrash <= 0;
                            distance <= 0;
                        end
                        trigger = 1;
                    
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