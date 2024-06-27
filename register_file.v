
module register_file (
    input[511:0] A3, A4,load_data,
    input[1:0] load_addr_reg, store_addr_reg, //todo specify the size for this part
    input clk , reset, load, store, write_enable, read, set,
    output reg [511:0] A1, A2, store_data
);

    reg[511:0] reg_file[0:3]; // a register file with size 4*512    
    integer i;
    always @(*) begin 
        if (reset) begin
            for (i = 0; i < 4; i = i + 1) begin
                reg_file[i] <= 0;
            end
        end
        if(set) begin
           reg_file[0] <= {1'b1, 511'b0};
           reg_file[1] <= {1'b1, 511'b0};
           reg_file[2] <= 1000;
           reg_file[3] <= 2000;
        end
        if (write_enable) begin
            reg_file[2] <= A3;
            reg_file[3] <= A4;
        end
        if(read) begin
            A1 <= reg_file[0];
            A2 <= reg_file[1];
        end
        if(load) begin
         reg_file[load_addr_reg] <= load_data;
        end
        if(store) begin   
            store_data <= reg_file[store_addr_reg];
        end
            
    end
endmodule
