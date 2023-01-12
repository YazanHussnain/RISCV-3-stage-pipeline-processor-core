module Instruction_Memory(read_addr, instruction);
	input logic [31:0] read_addr;
	output logic [31:0] instruction;
	logic [31:0] memory [0:511];

    initial begin
        $readmemh("E:/CA_Lab/RISC-V/RISC-V_3Stage_Pipeline_HDU_CSR_7SEG_uart/Instructions.mem", memory, 0, 511);
    end

	always_comb begin
		instruction = memory[read_addr[31:2]];
	end
endmodule