`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 22:52:50
// Design Name: 
// Module Name: Johnson Counter
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



module Johnson_Counter (
    input clk,reset,
    output reg [3:0] q);
    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000;
        else
            q <= {q[2:0], ~q[3]};
    end
endmodule

module Johnson_Counter_tb;
    reg clk, reset;
    wire [3:0] q;

    Johnson_Counter uut (.clk(clk),.reset(reset),.q(q));

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | reset=%b | q=%b",
                 $time, reset, q);

        clk = 1;
        reset = 1;
        #10;
        reset = 0;
        #90;
        $finish;
    end
endmodule
