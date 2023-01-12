module RegisterFile(readData1, readData2, writeData, readAddr1, readAddr2, writeAddr, write_enable, clk, reset, TimerIntrpt, intrpt);

    output logic [31:0] readData1, readData2;
    input logic [4:0] readAddr1, readAddr2, writeAddr;
    input logic [31:0] writeData;
    input clk, reset, write_enable, TimerIntrpt, intrpt;

    logic [31:0] registers [0:31];
    logic interrupt;

    initial begin
        $readmemh("E:/CA_Lab/RISC-V/RISC-V_3Stage_Pipeline_HDU_CSR_7SEG_uart/Register.mem", registers, 0, 31);
    end

    always_comb begin
        readData1 = (|readAddr1) ? registers[readAddr1] : 32'h0;
        readData2 = (|readAddr2) ? registers[readAddr2] : 32'h0;
    end

    always_ff @(posedge clk) begin
        if(TimerIntrpt | intrpt) begin
            interrupt <= 1'b1;
        end else begin
            interrupt <= 1'b0;
        end
    end

    always_ff @(negedge clk) begin
        if((|writeAddr) && (!write_enable) && (~interrupt) && (~TimerIntrpt) && (~intrpt))
            registers[writeAddr] <= writeData;
        else
            registers[writeAddr] <= registers[writeAddr];
    end

endmodule