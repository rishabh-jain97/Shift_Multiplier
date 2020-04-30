`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2019 12:26:16 AM
// Design Name: 
// Module Name: top_boy_tb
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


module top_multiplier_tb();
    reg  x,y, clk,rst,mul,sx,sy;
    reg tracker;
    wire fx,fy,unsigned_done;
    
    wire [22:0] z;
    wire [11:0] y_shift;
    wire [10:0] x_shift;
    
    wire z_serial,z_done;
 
    top_multiplier multiplier(y,x,clk,rst,mul,sx,sy,fx,fy,unsigned_done,z,z_serial,z_done,y_shift,x_shift); 
 
    always begin #1 clk= ~clk; end 
    
    initial begin 
        x=1;y=0;sx=0;sy=0;mul=1;rst=1; clk=0; tracker =0;
        #2
        //come out of reset nicely
        rst=0;
        sx =1; sy=1;
        //x is going to be a negative number of all 1's
        #2//first bit is added to msb 
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        y=1; //use y just as a single 1 
        #2
        //the values have been completely shifted in by now 
        #2
        //the unsigned multiplier has come out of reset, will need 23 shift operations to multiply
        #46 
        tracker =1;
        //completed the unsigned multiplication
        #2
        //shift out starts 
        #46
 
    $finish;
    end
    
endmodule
