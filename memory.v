
module memory (
    input clk, write_enable, reset, read_enable,
    input [8:0] read_address, write_address,
    input [511: 0] data,
    output reg [511:0] out
);
    reg[31:0] single_port_mem[0:511];
    integer i;
    integer j;
    always @(*) begin
        if (reset) begin
            for (i = 0; i < 512; i = i + 1) begin
                single_port_mem[i] <= 0;
            end                         
        end
        else if(write_enable) begin
            j = 0;
            for (i = write_address; i < write_address + 16; i = i + 1) begin
                single_port_mem[i] <= data[j +: 32];
                j = j + 32;
            end
        end
        else if(read_enable) begin
            j = 0;
            for (i = read_address; i < read_address + 16; i = i + 1) begin
                out[j +: 32] <= single_port_mem[i];
                j = j + 32;            
            end
        end
    end
    
endmodule
