
module register_file (
    input[511:0] A3, A4,load_data,
    input[1:0] load_addr_reg, store_addr_reg, //todo specify the size for this part
    input clk , reset, load, store, write_enable, read, random_set,
    output reg [511:0] A1, A2, store_data
);

    reg[511:0] reg_file[0:3]; // a register file with size 4*512
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1) begin
                reg_file[i] <= 0;
            end
        end
        else if(random_set) begin
            for (i = 0; i < 4; i = i + 1) begin
                reg_file[i] <= $random;
            end
        end
        else if (write_enable) begin
            reg_file[2] <= A3;
            reg_file[3] <= A4;
        end
        else if(read) begin
            A1 <= reg_file[0];
            A2 <= reg_file[1];
        end
        else if(load) reg_file[load_addr_reg] <= load_data;
        else if(store) store_data <= reg_file[store_addr_reg];
    end
endmodule