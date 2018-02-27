module InductSensor(sensor, out);
    input [0:width] sensor; //output of hardware sensor
    output [0:width] out; //motor control
    parameter range, width;
    if(sensor == range*1.05 or sensor == range*.95)
        begin
          out = 1b'1; //if signal is within 5%
        end

endmodule