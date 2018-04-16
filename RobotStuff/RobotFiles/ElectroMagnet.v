//electromagnet control module by Robert Kirkman for ECE 3331
module electromagnet (in, out, clk);
//port declarations
input [1:0] in, clk;
output reg[1:0] out = 2'b0;

//data type declarations
parameter deltadelay = 27'd100000;
reg[26:0] delay = 27'd1000000;
reg[26:0] count = 27'b0;
reg toggle = 1'b0;

//circuit functionality
always @(posedge clk)
if (in[0]) 
begin
	out <= 2'b01;
end
else if (in[1])
begin
	if (count == delay && delay > 0)
	begin
		if (toggle)
		begin
			out <= 2'b10;
			toggle <= ~toggle;
		end
		else
		begin
			out <= 2'b01;
			toggle <= ~toggle;
		end
		delay <= delay - deltadelay;
		count <= 26'b0;
	end
	else if (delay == 0)
		out <= 2'b0;
	else
		count <= count + 26'b1;
end

endmodule