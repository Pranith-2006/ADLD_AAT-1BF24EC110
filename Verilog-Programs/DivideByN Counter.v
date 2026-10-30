`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 23:21:34
// Design Name: 
// Module Name: DivideByN Counter
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


module Divide_By_N #(parameter N = 5)(
    input clk,reset,
    output reg clk_out);
    
    integer count;
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            clk_out <= 0;
        end
        else begin
            if (count == (N/2)-1) begin
                count <= count + 1;
                clk_out <= 1;
            end
            else if (count == N-1) begin
                count <= 0;
                clk_out <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end
endmodule

module Divide_By_N_tb;
    reg clk, reset;
    wire clk_out;

    Divide_By_N #(.N(5)) uut (.clk(clk),.reset(reset),.clk_out(clk_out) );
    
    always #5 clk = ~clk;
    initial begin
        $monitor("Time=%0t | reset=%b | count=%d | clk_out=%b",
                 $time, reset, uut.count, clk_out);
        clk = 1;
        reset = 1;
        #10 reset = 0;
        #200 $finish;
    end
endmodule



