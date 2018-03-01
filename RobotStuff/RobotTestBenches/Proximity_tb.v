`timescale 1ns / 1ps


module Proximity_tb();
    wire trig;
    wire crash;
    reg clock;
    reg Echo;
    
    initial begin
        clock = 0;
        Echo = 0;
    end
    
    always
        begin
            #10;
            clock = ~clock;
            always@(negedge trigger)
                begin
                    if(case1==0)
                        begin
                            Echo = 1; // false
                            #1000
                            Echo = 0;
                            #100
                            case1 = 1;
                        end
                    if(case1)
                        begin
                            #100
                            Echo = 1; //true
                            #100
                        end

                end

        end
    ProximitySensor P1(trig, Echo, clock, crash);
    

endmodule
