
module memory_tb;

    reg clk, reset, write_enable, read_enable;
    reg [8:0] read_address, write_address;
    reg [511:0] data;
    wire [511:0] out;

    memory uut(
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .read_address(read_address),
        .write_address(write_address),
        .data(data),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        write_enable = 0;
        read_enable = 0;
        read_address = 0;
        write_address = 0;
        data = 0;

        #10;
        $display("Test 1: reset the memory!");
        reset = 1;
        #10;
        reset = 0;
        read_enable = 1;
        read_address = 10;
        #10;
        $display("time: %0t, the output is: %b", $time, out);
        $display("Test 2: write some data on memory and read the data");
        #10;
        read_enable = 0;
        write_enable = 1;
        write_address = 10;
        data = 120;
        #10;
        read_enable = 1;
        write_enable = 0;
        read_address = 10;
        #10;
        $display("time: %0t, the output is: %b", $time, out);
        $display("Test 3: write another data on that location and read");
        #10;
        read_enable = 0;
        write_enable = 1;
        write_address = 10;
        data = 15;
        #10;
        read_enable = 1;
        write_enable = 0;
        read_address = 10;
        #10;
        $display("time: %0t, the output is: %b", $time, out);
        $display("Test 4: reset the memory on that location");
        reset = 1;
        #10
        reset = 0;
        write_enable = 0;
        read_enable = 1;
        read_address = 10;
        #10
        $display("time :%0t, the output is: %b", $time, out);
        $stop;
    end



endmodule