`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2019 04:54:00 PM
// Design Name: 
// Module Name: N_complement
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


module N_complement
    ( input [10:0] x_parallel, input enable, input rst, 
    output reg [10:0] x_pos
    );
 
    always @ (*) begin 
 
        if (rst) 
            x_pos = 0; 
        
        else begin 
            if (enable) begin 
                if(x_parallel[10] == 1)
                x_pos = ~(x_parallel) + 1'b1;  
                    
            else 
            x_pos = x_parallel;
        end
        
        else    
        x_pos = x_parallel; 
        
        end
 end       
endmodule
