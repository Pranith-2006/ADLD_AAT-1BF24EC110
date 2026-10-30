`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 10:15:09
// Design Name: 
// Module Name: sequence_detector_moore
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


module sequence_detector_moore(input wire clk,reset,in,
                               output reg out
    );
    reg [2:0]ps,ns; // State declaration
        //State encoding
        parameter s0 = 3'b000,
                  s1 = 3'b001,
                  s2 = 3'b010,
                  s3 = 3'b011,
                  s4 = 3'b100,
                  s5 = 3'b101;
    always@(posedge clk or posedge reset)
    begin
        if(reset)
            ps<=s0;
        else
            ps <= ns;
    end
    
    always@(*)
    begin
        ns=ps;
    case(ps)
    s0:ns = in?s1:s0;
    s1:ns = in?s1:s2;
    s2:ns = in?s3:s0;
    s3:ns = in?s4:s2;
    
    s4:begin
        if(in) 
            ns=s5;
        else
            ns=s2;
        end  
s5:begin    
ns=in?s1:s2;
end
default:ns=s0;
endcase
end

always@(*)begin
case(ps)
s5:out = 1'b1;
default: out = 1'b0;
endcase
end
endmodule

module sequence_detector_moore_tb;
reg clk,in,reset;
wire out;
sequence_detector_moore A1(clk,reset,in,out);
initial begin
clk = 0; reset = 1; in = 0;
#10 reset = 0; in = 0;
#10 in = 1;
#10 in = 0;
#10 in = 1;
#10 in = 1;
#50 $finish;
end
always #5 clk = ~clk;
endmodule