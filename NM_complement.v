`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 12:03:37 PM
// Design Name: 
// Module Name: NM_complement
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

//provides the 2's complement of the number if enabled 
module NM_complement
    ( input [22:0] x_parallel, input enable, input rst, 
    output reg [22:0] x_pos
    );
 
    always @ (*) begin 
 
        if (rst) 
            x_pos <= 0; 
        
        else begin 
            if (enable) 
                x_pos = ~(x_parallel) + 1'b1;
            else    
                x_pos = x_parallel;     
        end
        
    end   
        
endmodule
