`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 22:03:27
// Design Name: 
// Module Name: Barrel Shifter
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



module Barrel_Shifter(
    input [3:0] A,
    input [1:0] shift,
    input dir,             // 0 = left shift, 1 = right shift
    output reg [3:0] Y);
    
    always @(*) begin
        if (dir == 1'b0)
            Y = A << shift;
        else
            Y = A >> shift;
    end
endmodule

module Barrel_Shifter_tb;
    reg [3:0] A;
    reg [1:0] shift;
    reg dir;
    wire [3:0] Y;

    Barrel_Shifter uut (.A(A),.shift(shift),.dir(dir),.Y(Y));

    initial begin
        $monitor("Time=%0t | A=%b | dir=%b | shift=%d | Y=%b", 
                 $time, A, dir, shift, Y);

        // Left shift by 0
        A = 4'b1011; dir = 1'b0; shift = 2'd0;
        #10;

        // Left shift by 1
        shift = 2'd1;
        #10;

        // Left shift by 2
        shift = 2'd2;
        #10;

        // Left shift by 3
        shift = 2'd3;
        #10;

        // Right shift by 0
        A = 4'b1011; dir = 1'b1; shift = 2'd0;
        #10;

        // Right shift by 1
        shift = 2'd1;
        #10;

        // Right shift by 2
        shift = 2'd2;
        #10;

        // Right shift by 3
        shift = 2'd3;
        #10;
        $finish;
    end
endmodule