`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 11:08:19 PM
// Design Name: 
// Module Name: top_boy
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


module top_multiplier

    (input y, input x, input clk, input rst, input mul, input sx, input sy,
    output fx, output fy, output unsigned_done,output [22:0] z_par, output z_serial,output fz, 
    output [11:0] y_par,output [10:0] x_par

    //output [22:0] z, output fz
    );
    
    // y_par,x_par
    wire [11:0] y_par_comp;
    wire [10:0] x_par_comp;
    
    wire un_reset; 
    wire out_two_complement;
    wire [22:0] z_uncomplemented;
 
    //xor the first bit of xpar and y pay 
    //if they are both negative then the output will be positive, if one is neg
    //then output will also be positive 
    //essentially this determines if the output is positive or negative
    assign out_two_complement = (y_par[11] ^ x_par[10]); 
 
    //shift in the serial data to parallelize it 
    //fx and fy signal when it is completed 
    shift_in_x shiftyx(x, sx, rst, clk, x_par, fx); 
    shift_in_y shiftyy(y, sy, rst, clk, y_par, fy);

    //check if a negative number was given and convert to positive 
    N_complement x_complemented( x_par, 1'b1, rst, x_par_comp);
    M_complement y_complemented(y_par,1'b1,rst,y_par_comp);

    //multiply the output of the parallel data
    //assure fx and fy go low indicating shifting is done 
    //mul must also be asserted externally to start 
    //will return z_uncomplemented as output and a done signal 
    unsigned_multiplier  mully(  x_par_comp,  y_par_comp, 
    !(fx&&fy) || rst, clk, (fx && fy) && mul,  z_uncomplemented, unsigned_done);
    
    //change the sign of the unsigned output if needed
    //determined by the out_two_complement signal to see if it should be negative
    NM_complement  z_complemented(z_uncomplemented,out_two_complement,rst, z_par);
 
    //shift the output out in a serial manor
    shift_out shifty_Z(z_par,unsigned_done,rst,clk,fz,
    z_serial);
    
endmodule
