`timescale 1us/1us
module ProximitySensor(output wire trigger, input echo, input clk, output reg isCrash); //trigger begins ranging, echo gives ranging value, clk is used for timing
    //need to supply a short 10us pulse to trigger ranging                          is crash is ouput to motor module
    reg [16:0]timer = 0; //timer used for trigger output (minimum 10 microseconds)
    reg [31:0]distance = 300000;
    reg [16:0]tenMicro = 1000; //~10us
    reg trig = 0;
    assign trigger = trig;
    always @(posedge clk) //every clock pulse
        begin
            if(timer == 0) //if the timer is 0 invert trigger (turn on at start and off at end)
                begin                   
                  trig <= ~trig; //invert
                  timer = tenMicro; //set timer to tenMicro seconds for another count down
                end
            if(timer > 0 && echo == 0) //only if echo is not currently high begin counting down
                begin
                  timer <= timer - 1;
                  distance <= 0;
                end
            if(echo)
                begin
                    distance <= distance + 1;
                end
            if(distance <= 294117 && echo == 0 && timer == 0) //within 1.5 ft
                begin
                    isCrash <= 1; //you're gonna crash
                end
            else
                begin
                    isCrash <= 0; //all is good
                end
        end

    //speed of sound (m/s) * time (s) = distance (m)   time must be halved because pulse goes to and back from location

endmodule
 //basys3 board FPGA has a 100 MHz clock 100,000,000 clks/s = 1/10ns
    // 10us = 1000 clocks