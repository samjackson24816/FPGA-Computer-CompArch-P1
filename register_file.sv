// Register file implementation
// 32 registers, each are 32 bits

module regfile (
    input  logic        clk, // register writes happen on rising edge of clock
    input  logic        we, // write enable. when it's 1, processor can write to a register
    input  logic [4:0]  rs1_addr, // first register's address
    input  logic [4:0]  rs2_addr, // second register's address
    input  logic [4:0]  rd_addr, // address of register we want to write to
    input  logic [31:0] rd_data, // the 32-bit value that will be written into the selected register
    output logic [31:0] rs1_data, // first selected register's current value
    output logic [31:0] rs2_data // second selected register's current value
);

    logic [31:0] regs [0:31];

    // initialization. We will initialize all 32 registers to 0 when the simulation starts
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            regs[i] = 32'd0;
    end

    // write to register file.
    always_ff @(posedge clk) begin
        // only write if writing enabled and destination reg is not x0 (since that's always 0)
        if (we && rd_addr != 5'd0)
            regs[rd_addr] <= rd_data; // store in selected destination register
    end

    assign rs1_data = (rs1_addr == 5'd0) ? 32'd0 : regs[rs1_addr]; // read port 1. If 0, return 0
    assign rs2_data = (rs2_addr == 5'd0) ? 32'd0 : regs[rs2_addr]; // read port 2

endmodule