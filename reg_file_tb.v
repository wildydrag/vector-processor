
module reg_file_tb;

    reg clk, reset, load, store, write_enable, read, random_set;
    reg [511:0] A3, A4, load_data;
    reg load_addr_reg, store_addr_reg;
    wire [511:0] A1, A2, store_data;

    register_file uut(
        .A3(A3),
        .A4(A4),
        .load_data(load_data),
        .clk(clk),
        .reset(reset),
        .load(load),
        .random_set(random_set),
        .store(store),
        .write_enable(write_enable),
        .read(read),
        .load_addr_reg(load_addr_reg),
        .store_addr_reg(store_addr_reg),
        .A1(A1),
        .A2(A2),
        .store_data(store_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        random_set = 0;
        load = 0;
        read = 0;
        write_enable = 0;
        store = 0;
        store_addr_reg = 0;
        load_addr_reg = 0;
        load_data = 0;
        A3 = 0;
        A4 = 0;
        #10;
        $display("Test1: Reset all registers");
        reset = 1;
        #10;
        reset = 0;
        store = 1;
        store_addr_reg = 2;
        #10;
        $display("time: %t\t, store_data:%b", $time, store_data);
        // $display("Test 2: Random set");
        // store = 0;
        // random_set = 1;
        // #10
        // random_set = 0;
        // store_addr_reg = 2;
        // #10
        // $display("time: %t\t, A3 value is: %b", $time, store_data);



        $stop;
        
    end
endmodule