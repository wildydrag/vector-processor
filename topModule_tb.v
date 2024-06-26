
module topModule_tb;
    reg clk, reset;
    reg [12:0] command;
    wire[511:0] mem_written, A3_out, A4_out, Register_out;



    vector_processor proc (
        .clk(clk),
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
        command = 0;
        #10
        $display("Test 1: store A3 value on memory location 0x00");
        command = 13'b0110000000000;
        $display("time : %0t, The content written on the memory location starting from the adress 0x00 is: %b", $time, mem_written);
        $stop;
    end



endmodule