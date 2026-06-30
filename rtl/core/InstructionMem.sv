module Instruction_Memory #(parameter string INIT_FILE = "", parameter int DEPTH = 65536)
                           (read_addr, instruction);
	input  logic [31:0] read_addr;
	output logic [31:0] instruction;
	localparam int AW = $clog2(DEPTH);
	logic [31:0] memory [0:DEPTH-1];
	string imem_path;

	initial begin
		if (INIT_FILE != "") begin
			$readmemh(INIT_FILE, memory);
		end else if ($value$plusargs("imem=%s", imem_path)) begin
			$readmemh(imem_path, memory);
		end
	end

	always_comb begin
		instruction = memory[read_addr[AW+1:2]];
	end
endmodule
