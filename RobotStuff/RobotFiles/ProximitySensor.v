`timescale 1us/1us
module ProximitySensor(output reg trigger, input echo, input clk, output reg isCrash); //trigger begins ranging, echo gives ranging value, clk is used for timing
    //need to supply a short 10us pulse to trigger ranging                          is crash is ouput to motor module
    reg [16:0]timer = 0; //timer used for trigger output (minimum 10 microseconds)
    reg [31:0]distance; //actual distance value used for determining if something is in range. Interpreted from distanceTimer
    reg distanceTimer = 0; //Distance is measured in time it takes for the sound pulse to get back to the sensor
    //basys3 board FPGA has a 450 MHz clock 450,000,000 clks/s = 450/us
    // 10us = 4500 clocks
    reg [16:0]tenMicro = 1000; //~10us
    reg [16:0]frequencyStepperValue = 100000;
    reg [16:0]stepTimer;
    reg steppedClock = 0;
    stepTimer = frequencyStepperValue;
        initial begin
        trigger = 0;
    end
    always @(posedge clk) //every clock pulse
        begin
            if(timer == 0) //if the timer is 0 invert trigger (turn on at start and off at end)
                begin                   
                  trigger = ~trigger; //invert
                  timer = tenMicro; //set timer to tenMicro seconds for another count down
                end
            if(timer > 0 && echo == 0) //only if echo is not currently high begin counting down
                begin
                  timer = timer - 1;
                end
        end
    
    always @(posedge clk)
        begin
            if(stepTimer <= frequencyStepperValue)
                begin
                stepTimer = timer - 1;
                end
            if(stepTimer == 0)
                begin
                steppedClock = ~steppedClock;
                end
        end
  
    always@(posedge steppedClock)
        begin
            if(echo)
                begin
                distanceTimer = distanceTimer+1;
                distance = distanceTimer*340;
                end
        end
    //speed of sound (m/s) * time (s) = distance (m)   time must be halved because pulse goes to and back from location

  always@(negedge echo)
    begin
    if(distance >= 153 && distance <= 306) //within 6 to 15 cms or 3 to 6 inches
        begin
          isCrash = 1; //you're gonna crash dawg
        end
    else
        begin
          isCrash = 0; //all is good
        end
        end
endmodule