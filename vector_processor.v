module vector_processor (
    input clk, reset,
    input[12:0] instruction_set,
    output reg[511:0] mem_written, A3_out, A4_out, Register_out 
);

    reg[1:0] opcode;

    // connections of the alu instance
    reg mul, add;
    reg[511:0] A1, A2;
    wire[511:0] A3, A4;

    // connections of the mem instance
    reg mem_read_enable, mem_write_enable;
    reg[8:0] mem_read_address, mem_write_address;
    reg [511:0] mem_data;
    wire[511:0] out;

    // connection of the reg_f instance
    reg [511:0] regf_A3, regf_A4, load_data;
    wire [511:0] A1_regf, A2_regf, regf_store_data;
    reg[1:0] load_addr_reg, store_addr_reg;
    reg load_regf, regf_store, regf_write_enable, regf_read_enable, random_set;

    register_file reg_f(
        .A3(regf_A3),
        .A4(regf_A4),
        .load_data(load_data),
        .clk(clk),
        .reset(reset),
        .load(load_regf),
        .store(regf_store),
        .random_set(random_set),
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
    initial begin
        random_set = 1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // initialize the signals to default values
            mem_read_address <= 0;
            random_set <= 0;
            load_addr_reg <= 0;
            load_data <= 0;
            load_regf <= 0;
            mem_read_enable <= 0;
            mem_write_enable <= 0;
            regf_store <= 0;
            store_addr_reg <= 0;
            mem_data <= 0;
            add <= 0;
            mul <= 0;
            regf_read_enable <= 0;
            regf_write_enable <= 0;
            A1 <= 0;
            A2 <= 0;
            regf_A3 <= 0;
            regf_A4 <= 0;
            mem_written <= 0;
            A3_out <= 0;
            A4_out <= 0;
            Register_out <= 0;
        end else begin
            opcode <= instruction_set[12:11];
            mem_read_address <= 0;
            random_set <= 0;
            load_addr_reg <= 0;
            load_data <= 0;
            load_regf <= 0;
            mem_read_enable <= 0;
            mem_write_enable <= 0;
            regf_store <= 0;
            store_addr_reg <= 0;
            mem_data <= 0;
            add <= 0;
            mul <= 0;
            regf_read_enable <= 0;
            regf_write_enable <= 0;
            A1 <= 0;
            A2 <= 0;
            regf_A3 <= 0;
            regf_A4 <= 0;

            case (opcode)
                2'b00: begin // load from memory to register
                    mem_read_enable <= 1;
                    mem_read_address <= instruction_set[8:0];
                    load_addr_reg <= instruction_set[10:9];
                    load_regf <= 0;
                    load_data <= out;
                    Register_out <= out;
                end
                2'b01: begin // store register content in memory
                    regf_store <= 1;
                    store_addr_reg <= instruction_set[10:9];
                    mem_write_enable <= 1;
                    mem_write_address <= instruction_set[8:0];
                    mem_data <= regf_store_data;
                    mem_written <= regf_store_data;
                end
                2'b10: begin // ALU add
                    regf_read_enable <= 1;
                    add <= 1;
                    A1 <= A1_regf;
                    A2 <= A2_regf;
                    regf_write_enable <= 1;
                    regf_A3 <= A3;
                    regf_A4 <= A4;
                    A3_out <= A3;
                    A4_out <= A4;
                end
                2'b11: begin // ALU Multiplication
                    regf_read_enable <= 1;
                    mul <= 1;
                    A1 <= A1_regf;
                    A2 <= A2_regf;
                    regf_write_enable <= 1;
                    regf_A3 <= A3;
                    regf_A4 <= A4;
                    A3_out <= A3;
                    A4_out <= A4;
                end
            endcase
        end
    end
endmodule
