module InductSensor([2:0]sensor, [2:0]out);
  reg junction = 0;
  always
    begin
      if(sensor == 3'b001)
        begin
          assign [2:1]out = [2:1]sensor;
          assign [0]out = 1;
        end
      if(sensor == 3'b100)
        begin
          assign [1:0]out = [1:0]sensor
          assign [2]out = 1;
        end
      if(sensor == 3'b000)
        begin
          assign out = 3'b110;
        end
      else
        begin
          assign out = sensor;
        end
    end

endmodule