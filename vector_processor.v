module vector_processor (
    input clk, reset, set,
    input[12:0] instruction_set,
    output [511:0] mem_written, A3_out, A4_out, Register_out 
);

    reg[1:0] opcode;

    // connections of the alu instance
    reg mul, add;
    wire[511:0] A1, A2;
    wire[511:0] A3, A4;

    // connections of the mem instance
    reg mem_read_enable, mem_write_enable;
    reg[8:0] mem_read_address, mem_write_address;
    wire [511:0] mem_data;
    wire[511:0] out;

    // connection of the reg_f instance
    wire [511:0] regf_A3, regf_A4, load_data;
    wire [511:0] A1_regf, A2_regf, regf_store_data;
    reg[1:0] load_addr_reg, store_addr_reg;
    reg load_regf, regf_store, regf_write_enable, regf_read_enable;

    register_file reg_f(
        .A3(regf_A3),
        .A4(regf_A4),
        .load_data(load_data),
        .clk(clk),
        .reset(reset),
        .load(load_regf),
        .store(regf_store),
        .set(set),
        .write_enable(regf_write_enable),
        .read(regf_read_enable),
        .load_addr_reg(load_addr_reg),
        .store_addr_reg(store_addr_reg),
        .A1(A1_regf),
        .A2(A2_regf),
        .store_data(regf_store_data)
    );

    ALU alu(
        .clk(clk),
        .mul(mul),
        .add(add),
        .reset(reset),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .A4(A4)
    );

    memory mem(
        .clk(clk),
        .reset(reset),
        .write_enable(mem_write_enable),
        .read_enable(mem_read_enable),
        .read_address(mem_read_address),
        .write_address(mem_write_address),
        .data(mem_data),
        .out(out)
    );

    // initialize the register file with random numbers


    assign mem_written = regf_store_data;
    assign mem_data = regf_store_data;
    assign A3_out = A3;
    assign A4_out = A4;
    assign regf_A3 = A3;
    assign regf_A4 = A4;
    assign Register_out = out;
    assign load_data = out;
    assign A1 = A1_regf;
    assign A2 = A2_regf;
    always @(posedge clk) begin
        opcode = instruction_set[12:11];
        load_addr_reg = instruction_set[10:9];
        store_addr_reg = instruction_set[10:9];
        mem_read_address = 0;
        load_regf = 0;
        mem_read_enable = 0;
        mem_write_enable = 0;
        regf_store = 0;
        add = 0;
        mul = 0;
        regf_read_enable = 0;
        regf_write_enable = 0;
        case (opcode)
            2'b00: begin // load from memory to register
                mem_read_enable = 1;
                mem_read_address = instruction_set[8:0];
                load_regf = 1;
            end
            2'b01: begin // store register content in memory
                regf_store = 1;
                mem_write_enable = 1;
                mem_write_address = instruction_set[8:0];
            end
            2'b10: begin // ALU add
                regf_read_enable = 1;
                add = 1;
                regf_read_enable = 1;
                regf_write_enable = 1;
            end
            2'b11: begin // ALU Multiplication
                regf_read_enable = 1;
                mul = 1;
                regf_write_enable = 1;
            end
        endcase
    end
endmodule
