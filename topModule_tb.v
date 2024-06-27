
module topModule_tb;
    reg clk, reset, set;
    reg [12:0] command;
    wire[511:0] mem_written, A3_out, A4_out, Register_out;



    vector_processor proc (
        .clk(clk),
        .set(set),
        .reset(reset),
        .instruction_set(command),
        .mem_written(mem_written),
        .A3_out(A3_out),
        .A4_out(A4_out),
        .Register_out(Register_out)
    );

   
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        #10
        reset = 1;
        #10
        reset = 0;
        set = 1;
        #10
        set = 0;
        $display("Test 1: store A3 value on memory location 0x00");
        command = 13'b0110000000000;
        #10
        $display("time : %0t, The content written on the memory location starting from the adress 0x00 is: %0d", $time, mem_written);
        $display("Test 2: load the value on memory location 0x00 on register A4");
        command = 13'b0011000000000;
        #10
        $display("time: %0t, the content written on register from memory location 0x00 is: %0d", $time, Register_out);
        $display("Test3: add two register A1 and A2 and show the result");
        command = 13'b1000000000000;
        #10
        $display("time: %0t, A3 is: %0d, A4 is: %0d", $time, A3_out, A4_out);
        $display("Test 4: multiply two register A1 and A2 and show the result");
        command = 13'b1100000000000;
        #10
        $display("time: %0t, A3 is: %0d, A4 is: %0d,", $time, A3_out, A4_out);
        $stop;
    end



endmodule
