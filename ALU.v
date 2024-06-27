
module ALU (
    input clk, mul, add, reset,
    input[511:0] A1, A2,
    output [511:0] A3, A4
);
    reg[1023:0] alu_result;
    assign A3 = alu_result[511:0];
    assign A4 = alu_result[1023:512];
    always @(*) begin
        if (reset)
            alu_result = 0;
        else if (mul)
            alu_result = A1 * A2;
        else if (add) begin
            alu_result = A1 + A2;
        end
    end
    
endmodule
