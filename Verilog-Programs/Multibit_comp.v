`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 16:56:07
// Design Name: 
// Module Name: Multibit_comp
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


module Multibit_Comp(A,B,AgtB,AeqB,AltB);

    parameter N = 4;
    input [N-1:0]A,B;
    output reg AgtB,AeqB,AltB;
    
    always@(A,B)
    if (A>B)
    begin
    AgtB=1;
    AeqB=0;
    AltB=0;
    end
    
    else if(A<B)
    begin
    AgtB=0;
    AeqB=0;
    AltB=1;
    end
    
    else
    begin
    AgtB=0;
    AeqB=1;
    AltB=0; 
    end
endmodule
