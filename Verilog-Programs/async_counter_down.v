
module async_counter_down (
    input clk,
    input reset,
    output [2:0] Q
);

    JKFF A1 (
        .clk(clk), .J(1'b1), .K(1'b1),
        .reset(reset), .Q(Q[0])
    );

    JKFF A2 (
        .clk(~Q[0]), .J(1'b1), .K(1'b1),
        .reset(reset), .Q(Q[1])
    );

    JKFF A3 (
        .clk(~Q[1]), .J(1'b1), .K(1'b1),
        .reset(reset), .Q(Q[2])
    );

endmodule

module JKFF (
    input clk,J,K,reset,
    output reg Q);
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else begin
            case ({J, K})
                2'b00: Q <= Q;      // Hold
                2'b01: Q <= 1'b0;    // Reset
                2'b10: Q <= 1'b1;    // Set
                2'b11: Q <= ~Q;      // Toggle
            endcase
        end
    end
endmodule
