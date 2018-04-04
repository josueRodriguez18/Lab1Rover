module ColorSensor(output [1:0] scale, output [1:0]filter, output enf, output [2:0] color, input Freq, input clk)

always@(posedge clk)
    
    begin
      scale <= 2b'11;
      enf <= 1;
      Freq = Frequncy();
      //if(counter increment)
        filter <= 2b'01;

        if( x < Freq && Freq < y)
            begin
                color = 3'b001;        
            end

        filter <= 2b'10;

        if(x < Freq && Freq < y)
            begin
                color = 3'b010;  
            end
            

        filter <= 2b'11;

        if (x < Freq && Freq < y)
            begin
                color = 3'b100;
            end
    end    

endmodule