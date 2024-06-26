
module ALU_tb;
    reg clk, mul, add, start;
    reg [511:0] A1, A2;
    wire [511:0] A3, A4;

    ALU alu(
        .clk(clk),
        .mul(mul),
        .add(add),
        .start(start),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .A4(A4)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        mul = 0;
        add = 0;
        start = 0;
        A1 = 0;
        A2 = 0;
        #10
        $display("Test 0; start the ALU");
        start = 1;
        #10
        $display("Test 1: multiply two registers:");
        start = 0;
        A1 = {1'b1, 511'b0};
        A2 = {1'b1, 511'b0};
        mul = 1;
        #10
        $display("time: %0t, the A3 is: %b, the A4 is: %b", $time, A3, A4);
        $diplay("Test2: add two registers:");
        mul = 0;
        add = 1;
        A1 = {1'b1, 511'b0};
        A2 = {1'b1, 511'b0};
        #10
        $display("time: %0t, A3 is: %b, A4 is: %b", $time, A3, A4);
        $stop;  
    end
endmodule