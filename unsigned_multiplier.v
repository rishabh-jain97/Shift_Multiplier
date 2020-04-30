`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2019 11:07:27 AM
// Design Name: 
// Module Name: unsigned_multiplier
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

//uses a classic shift algorithm to multiply two numbers 

module  unsigned_multiplier 
    #(parameter N=11, parameter M=12) ( input [N-1:0] x, input [M-1:0] y, 
    input reset, input clk, input mul, 
    output reg [N+M-1:0] z_pos, output reg done
    );
 
     //register to hold the counter to know when done
     //register to indicate when we shift next and a register for the si carry value 
     reg [7:0] counter; 
     reg shift;
     reg si; 
     reg load;
     
    always @(posedge clk) begin 
    
        //if reset then set everything back to zero and fill z_pos least significant bits
        //with the value of x
        if (reset) begin 
            z_pos <= 0; 
            counter <=0; 
            done <=0;
            //z_pos[N-1:0] <= x;
            z_pos[N-1:0] <= 0;
            z_pos[N+M-1:N] <= 0;
            shift <=0;
            load <=1;
        end
 
 
        //if counter hit max number (N) number bits then done
         else if (counter >= N) begin
            done <=1;
        end
 
        //load a new value into the shift register 
        //load gets asserted as reset 
        else if(load) begin 
            z_pos[N-1:0] <= x;
            load <=0;
        end
 
 
        //if the least significant bit is 1, then we add in the y value to the most significant bits
        //the shift bit indicates when to shift 
        
        //the shifting algorithm first checks if a "1" bit is seen at the lsb 
        //if this is seen, add the value of y to the msb N bits of the register 
        //save the si carry of this addition and shift next cycle 
        else if (mul && !done && z_pos[0] ==1'b1 && !shift) begin
            //store the carry value as well
            {si,z_pos[N+M-1:N]} <= z_pos[N+M-1:N] + y;
            shift <=1;
        end
 
        //if the lsb is a 0, just shift next cycle 
        else if (mul && !done && z_pos[0] ==1'b0 && !shift ) begin
            si <=0;
            shift <=1;
        end
        
        //shift operation, remove ls bit of z_pos and shift in the carry from previous addition 
        else if (mul && shift && !done) begin 
            z_pos[N+M-1:0] <= {si,z_pos[N+M-1:1]};
            counter <= counter +1;
            shift <=0;
        end
 
    end   
        
endmodule
