`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2025 21:21:04
// Design Name: 
// Module Name: sync_counter
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

/*up counter
module sync_counter_up(
    input clk,reset,
    output [3:0] counter
    );
    reg [3:0]counter_up;
    always@(posedge clk or posedge reset)
    begin 
    if(reset)
    counter_up <=4'd0;
    else counter_up <= counter_up + 4'd1;
    end 
    assign counter = counter_up;
    endmodule
    
    module sync_counter_up_tb;
    reg clk, reset;
    wire [3:0]counter;
    sync_counter_up A1(clk,reset,counter);
    initial begin 
    clk = 0;
    forever #5 clk = ~clk;
    end 
    initial begin 
    reset = 1;
    #20 reset = 0;
    #155 $finish;
    end 
    endmodule
*/
//down counter
module sync_counter_down(
    input clk,reset,
    output [3:0] counter
    );
    reg [3:0]counter_down;
    always@(posedge clk or posedge reset)
    begin 
    if(reset)
    counter_down <=4'd15;
    else counter_down <= counter_down - 4'd1;
    end 
    assign counter = counter_down;
    endmodule
    
    module sync_counter_down_tb;
    reg clk, reset;
    wire [3:0]counter;
    sync_counter_down A1(clk,reset,counter);
    initial begin 
    clk = 0;
    forever #5 clk = ~clk;
    end 
    initial begin 
    reset = 1;
    #20 reset = 0;
    #155 $finish;
    end 
    endmodule