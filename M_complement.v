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


module M_complement
    ( input [11:0] y_parallel, input enable, input rst, 
    output reg [11:0] y_pos
    );
    
    always @ (*) begin 

        if (rst) 
            y_pos = 0; 

        else begin 
            if (enable) begin 
                if(y_parallel[11] == 1)
                y_pos = ~(y_parallel) + 1'b1;  
                    
                else 
                y_pos = y_parallel;
            end

        else    
            y_pos = y_parallel; 

        end
    end//end always 
endmodule
