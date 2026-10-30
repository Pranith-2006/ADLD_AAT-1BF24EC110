`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 23:54:10
// Design Name: 
// Module Name: Random Seq Gen
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



module Random_Sequence_Generator (
    input clk,
    input reset,
    output reg [3:0] q
);
    wire feedback;
    
    // XOR feedback from selected register bits
    assign feedback = q[3] ^ q[2];

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0001;  // Nonzero initial seed
        else
            q <= {q[2:0], feedback};
    end
endmodule

module Random_Sequence_Generator_tb;

    reg clk, reset;
    wire [3:0] q;

    Random_Sequence_Generator uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | reset=%b | q=%b",
                 $time, reset, q);

        clk = 1;
        reset = 1;

        #10 reset = 0;

        // Observe the generated sequence
        #200 $finish;
    end

endmodule


