`timescale 1us/1ps
module BasicMotorTest();
    reg [2:0] induct;
    reg proxim;
    wire leftOut, rightOut, leftEn, rightEn;

    initial begin
      induct <= 0;
      proxim <= 0;
    end
    BasicMotor bm1(induct, proxim, leftOut, rightOut, leftEn, rightEn);
    always
        begin
        //every 100 micro seconds check next state
          induct = 3'b101;
          #100
          induct = 3'b001;
          #100
          induct = 3'b011;
          #100
          induct = 3'b100;
          #100
          induct = 3'b110;
        end

endmodule