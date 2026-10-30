`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 17:36:39
// Design Name: 
// Module Name: 4bit_Parity_Gen
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



module Parity (input [3:0] data,input parity_bit,output even_parity, odd_parity, 
even_error, odd_error);

    // Generate even parity bit
    assign even_parity = ^data;

    // Generate odd parity bit
    assign odd_parity = ~(^data);

    // Check even parity: 0 means correct, 1 means error
    assign even_error = ^{data, parity_bit};

    // Check odd parity: 0 means correct, 1 means error
    assign odd_error = ~(^({data, parity_bit}));

endmodule

module Parity_tb;
    reg [3:0] data;
    reg parity_bit;
    wire even_parity,odd_parity,even_error,odd_error;

    Parity uut (.data(data),.parity_bit(parity_bit), .even_parity(even_parity),
    .odd_parity(odd_parity),.even_error(even_error),.odd_error(odd_error));

    initial begin
        $monitor(
            "Time=%0t | data=%b | parity_bit=%b | even_parity=%b | odd_parity=%b | even_error=%b | odd_error=%b",
            $time, data, parity_bit,even_parity, odd_parity, even_error, odd_error);

        // Test 1: Three ones; even parity bit should be 1
        data = 4'b1011;
        parity_bit = 1'b1;
        #10;

        // Test 2: Same data with incorrect even parity bit
        data = 4'b1011;
        parity_bit = 1'b0;
        #10;

        // Test 3: Two ones; even parity bit should be 0
        data = 4'b1100;
        parity_bit = 1'b0;
        #10;

        // Test 4: Same data with incorrect odd parity bit
        data = 4'b1100;
        parity_bit = 1'b0;
        #10;
        $finish;
    end
endmodule



