`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 22:46:56
// Design Name: 
// Module Name: Ring Counter
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



module Ring_Counter (
    input clk,reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0001;
        else
            q <= {q[2:0], q[3]};
    end
endmodule

module Ring_Counter_tb;

    reg clk, reset;
    wire [3:0] q;

    Ring_Counter uut (.clk(clk),.reset(reset),.q(q));

    always #5 clk = ~clk;
    initial begin
        $monitor("Time=%0t | reset=%b | q=%b",
                 $time, reset, q);
        clk = 1;
        reset = 1;
        #10;
        reset = 0;
        #80;
        $finish;
    end
endmodule


