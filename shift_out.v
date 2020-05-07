`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2019 06:31:02 PM
// Design Name: 
// Module Name: shift_out
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shift_out( input [22:0] z_par, input sz, input rst, input clk, output reg fz,
output reg  z_out
);

reg start,finished;
reg [7:0] counter = 0;

always @(posedge clk or posedge rst or posedge sz) begin 

//reset does it's thangggg
    if (rst) begin 
        fz <= 0; z_out <=0; counter <=0; start <=0;     
        end

//if the start bit has not already been hit and sz goes high indicating multiplication is done, time to start shifting out
    else if (sz && !start && !fz) 
        start <= 1;

//at every iteration, check and see if you done before anything else, finish start
    else if (counter == 23 && start ==1) begin
        fz <= 1;
        start <=0;
        counter <=0;
        z_out <=0;
    end 

//if you already started and you not finished, ball out and shift while incrementing counter
    else if (start && !fz)
    begin 
        z_out <= z_par[counter];
        counter <= counter +1;
    end
   
end

endmodule
