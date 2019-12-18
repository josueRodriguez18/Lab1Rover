`timescale 1us/1us
module ProximitySensor(output reg trigger, input echo, input clk, output reg isCrash); //trigger begins ranging, echo gives ranging value, clk is used for timing
  reg [31:0] counter = 32'b0;
  reg [31:0] distance = 100000;
  reg [31:0] echo_cntr = 32'b0;
  always@(posedge clk)
    begin
        if(counter <= 1000)
            begin
              trigger = 1'b1;
            end
        else
            begin
              trigger = 1'b0;
            end
        if(echo)
            begin
              echo_cntr <= echo_cntr + 1;
            end
        else
            begin
              if(echo_cntr)
                begin
                    if(echo_cntr < distance)
                        begin
                          isCrash = 1'b1;
                        end
                    else
                        begin
                          isCrash = 0;
                        end
                end
            end

            if(counter == 3000000)
                begin
                    trigger <= 0;
                    counter <= 0;
                    echo_cntr <= 1'b0;
                end
            else
                begin
                  counter <= counter +1;
                end
    end
    
    //speed of sound (m/s) * time (s) = distance (m)   time must be halved because pulse goes to and back from location

endmodule
 //basys3 board FPGA has a 100 MHz clock 100,000,000 clks/s = 1/10ns
    // 10us = 1000 clocks