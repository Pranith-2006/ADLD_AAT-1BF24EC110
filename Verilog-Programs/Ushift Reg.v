`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 23:14:52
// Design Name: 
// Module Name: Ushift Reg
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



module Universal_Shift_Register (
    input clk,reset,serial_left, serial_right,
    input [1:0] mode,
    input [3:0] parallel_in,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000;
        else begin
            case (mode)
                2'b00: q <= q;                       // Hold
                2'b01: q <= {serial_right, q[3:1]};  // Shift right
                2'b10: q <= {q[2:0], serial_left};   // Shift left
                2'b11: q <= parallel_in;             // Parallel load
            endcase
        end
    end
endmodule

module Universal_Shift_Register_tb;

    reg clk, reset;
    reg [1:0] mode;
    reg serial_left, serial_right;
    reg [3:0] parallel_in;
    wire [3:0] q;

    Universal_Shift_Register uut (.clk(clk),.reset(reset),.mode(mode),.serial_left(serial_left),
    .serial_right(serial_right),.parallel_in(parallel_in),.q(q));
    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | mode=%b | parallel_in=%b | q=%b",
                 $time, mode, parallel_in, q);
        clk = 1;
        reset = 1;
        mode = 2'b00;
        serial_left = 0;
        serial_right = 0;
        parallel_in = 4'b0000;
        #10 reset = 0;
        // Parallel load 1011
        mode = 2'b11;
        parallel_in = 4'b1011;
        #10;

        // Hold
        mode = 2'b00;
        #10;

        // Shift right
        mode = 2'b01;
        serial_right = 0;
        #10;

        // Shift left
        mode = 2'b10;
        serial_left = 1;
        #10;
        
        // Parallel load another value
        mode = 2'b11;
        parallel_in = 4'b1100;
        #10;
        #10 $finish;
    end
endmodule
