`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 17:06:32
// Design Name: 
// Module Name: ALU
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


module ALU (input [3:0] A, B, input [2:0] ch, output reg [3:0] result, output reg carry);

always @(*) begin
    result = 4'b0000;
    carry = 1'b0;
    case (ch)
         //addition
        3'b000: begin 
            {carry, result} = {1'b0, A} + {1'b0, B};
        end

        //subtraction
        3'b001: begin
            result = A - B;
            carry = (A < B);
        end

        //AND operation
        3'b010: begin
            result = A & B;
        end

        //OR operation
        3'b011: begin
            result = A | B;
        end

        //XOR operation
        3'b100: begin
            result = A ^ B;
        end

        //NOT operation
        3'b101: begin
            result = ~A;
        end

        //LEFT SHIFT
        3'b110: begin
            result = A << 1;
        end

        //RIGHT SHIFT
        3'b111: begin
            result = A >> 1;
        end

        default: begin
            result = 4'b0000;
            carry = 1'b0;
        end
    endcase
end
endmodule

module ALU_tb;
    reg [3:0] A, B;
    reg [2:0] ch;
    wire [3:0] result;
    wire carry;

    ALU uut (
        .A(A),.B(B),.ch(ch),.result(result),.carry(carry));

    initial begin
        $monitor("Time=%0t | A=%b B=%b ch=%b | result=%b carry=%b",
                 $time, A, B, ch, result, carry);

        // Operation 1: Addition
        A = 4'b1100; B = 4'b0111; ch = 3'b000;
        #10;

        // Operation 2: Subtraction (with borrow)
        A = 4'b0011; B = 4'b1001; ch = 3'b001;
        #10;

        // Operation 3: Bitwise AND
        A = 4'b1100; B = 4'b1010; ch = 3'b010;
        #10;

        // Operation 4: Bitwise OR
        A = 4'b1100; B = 4'b1010; ch = 3'b011;
        #10;

        // Operation 5: Bitwise XOR
        A = 4'b1100; B = 4'b1010; ch = 3'b100;
        #10;

        // Operation 6: Bitwise NOT of A
        A = 4'b1100; B = 4'b0000; ch = 3'b101;
        #10;

        // Operation 7: Left shift A by 1
        A = 4'b0101; B = 4'b0000; ch = 3'b110;
        #10;

        // Operation 8: Right shift A by 1
        A = 4'b0101; B = 4'b0000; ch = 3'b111;
        #10;      
        $finish;
    end
endmodule
