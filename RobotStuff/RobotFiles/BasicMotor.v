module Motor( input [2:0]induct, input proxim, output reg [3:0]motorIn, output reg [1:0] motorEn);
// induct active LOW
// motorIn = direction of each motor
// motorEn = motor on/off
// induct 3 bit number 000 ====== left | middle | out
reg [3:0] last;
    always @(*)
        begin
             
             if((induct == 3'b001 || induct == 3'b011) && !proxim) //left sensor on tape
                   begin
                       motorIn = 4'b0101;
                       motorEn <= 2'b11;
                       last = motorIn;
                   end
                if((induct == 3'b100 || induct == 3'b110)&& !proxim) //right sensor on tape
                   begin
                       motorIn = 4'b1010;
                       motorEn <= 2'b11;
                       last = motorIn;
                   end
                if((induct == 3'b101 && !proxim) //middle sensor only on tape
                       begin    
                        motorIn = 4'b1001;
                        motorEn <= 2'b11;
                        last = motorIn;
                       end
                 if(proxim) //this will change eventually
                    begin
                        motorIn = 4'b0110;
                        motorEn <=2'b11;
                    end
                 if(induct == 3'b000 || induct == 3'b111)
                    begin
                        motorEn <= 2'b00;
                        last = induct;
                    end 
                if(induct == 3'b010)
                    begin
                      motorEn <= 2'b00;
                      motorIn = last;
                    end
        end      
    
endmodule