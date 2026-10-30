`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 22:11:43
// Design Name: 
// Module Name: Timer
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


module Timer #(parameter COUNT_MAX = 5)(
    input clk, reset, enable,
    output reg stop);

    reg [31:0] count;
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            stop <= 0;
        end
        else if (enable) begin
            if (count == COUNT_MAX - 1) begin
                count <= 0;
                stop <= 1;
            end
            else begin
                count <= count + 1;
                stop <= 0;
            end
        end
        else begin
            stop <= 0;
        end
    end
endmodule

module Timer_tb;

    reg clk, reset, enable;
    wire stop;

    Timer #(.COUNT_MAX(5)) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .stop(stop)
    );

    // Generate clock with a 10 ns period
    always #5 clk = ~clk;

    initial begin
    $monitor("Time=%0t | reset=%b enable=%b count=%d stop=%b",
             $time, reset, enable, uut.count, stop);

    clk = 1;
    reset = 1;
    enable = 0;

    #20;
    reset = 0;
    enable = 1;

    #60;
    enable = 0;

    #20;
    enable = 1;

    #60;
    $finish;
    end
endmodule