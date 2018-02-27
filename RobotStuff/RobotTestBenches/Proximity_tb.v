`timescale 1ps / 1ps


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
            #2222;
            clock <= ~clock;
        end
    ProximitySensor P1(trig, Echo, clock, crash);
    

endmodule
