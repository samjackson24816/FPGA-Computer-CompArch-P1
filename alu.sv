// ALU (arithmetic logic unit) implementation
// This will perform arthimetic, logical, and comparison operations
// Using 4 bits for the operation code, so there are 16 possible codes

module alu (
    input  logic [31:0] in_alu1, // 32-bit value that is coming in (from reg or pc) to ALU
    input  logic [31:0] in_alu2, // another 32-bit value coming in (from reg or pc) to ALU
    input  logic [3:0]  op_alu, // operation code to select the operation 
    output logic [31:0] out_alu // 32-bit result produced by ALU
);

    logic signed [31:0] in1_signed;
    logic signed [31:0] in2_signed;
    logic [4:0] shift_amt; // shift amount

    assign in1_signed = in_alu1; // copy inputs into their signed versions
    assign in2_signed = in_alu2;
    assign shift_amt = in_alu2[4:0]; // five bits of in2 as the shift amount

    always_comb begin
        case (op)
            4'b0000: out_alu = in_alu1 + in_alu2; // add
            4'b1000: out_alu = in_alu1 - in_alu2; //subtract
            4'b0001: out_alu = in_alu1 << shift_amt; // shift to the left
            4'b0010: out_alu = {31'd0, (in1_signed < in2_signed)}; // less than comparison (signed)
            4'b0011: out_alu = {31'd0, (in_alu1 < in_alu2)}; // less than comparison (unsigned)
            4'b0100: out_alu = in_alu1 ^ in_alu2; // XOR
            4'b0101: out_alu = in_alu1 >> shift_amt; // shift to the right (logically), zeroes are inserted to the left side
            4'b1101: out_alu = in1_signed >>> shift_amt; // shift to the right (arithmetically),  sign bit is copied into the left side
            4'b0110: out_alu = in_alu1 | in_alu2; // OR
            4'b0111: out_alu = in_alu1 & in_alu2; // AND
            default: out_alu = 32'd0; // if op code not recognized, zero
        endcase
    end

endmodule