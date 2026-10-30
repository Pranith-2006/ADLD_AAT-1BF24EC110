`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 09:34:29
// Design Name: 
// Module Name: sequence_detector_meely
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



module sequence_detector_mealy(
    input wire clk, reset, in,
    output reg out
);

    reg [1:0] st, next_state;
    parameter s0 = 2'b00,
              s1 = 2'b01,
              s2 = 2'b10,
              s3 = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset)
            st <= s0;
        else
            st <= next_state;
    end

    always @(*) begin
        next_state = st;
        out = 1'b0;

        case (st)
            s0: begin
                if (in)
                    next_state = s1;
                else
                    next_state = s0;
            end

            s1: begin
                if (in == 0)
                    next_state = s2;
                else
                    next_state = s1;
            end

            s2: begin
                if (in)
                    next_state = s3;
                else
                    next_state = s0;
            end

            s3: begin
                if (in == 0) begin
                    next_state = s2;
                    out = 1'b1;
                end
                else
                    next_state = s1;
            end
            default: next_state = s0;
        endcase
    end
endmodule


module sequence_detector_mealy_tb;
reg clk,in,reset;
wire out;
sequence_detector_mealy uut(clk,reset,in,out);
initial begin
clk = 0; reset = 1; in = 0;
#10 reset = 0; in = 0;
#10 in = 1;
#10 in = 0;
#10 in = 1;
#10 in = 0;
#10 in = 0;
#50 $finish;
end
always #5 clk = ~clk;
endmodule


