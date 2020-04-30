//Verilog HDL for "lab3", "shift_in" "verilog"
`timescale 1ns / 1ps

module shift_in_y (y_in, sy, rst, clk, y_par, fy);
	input y_in, sy,rst,clk;
	output fy;
	output reg [12 - 1:0] y_par;
	wire fy; 
	reg [3 : 0] shifts;
	
	assign fy = (shifts >= 12);

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			y_par<= 12'b0;
			shifts<= 4'b0;
		end
		 else if(sy && shifts< 12) begin
			y_par[12-1:0]<={ y_par[12-2:0], y_in};
			shifts <= shifts + 1;
		end
		
	end
	
endmodule

