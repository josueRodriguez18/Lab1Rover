module ColorSensor(clk, data, dataOut);
    parameter width;
    input clk, [0:7]data;
    output [0:width]dataOut;
    reg[0:7]colorValue; //8-bit RGB color value from 0-255
    



endmodule