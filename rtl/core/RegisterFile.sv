module RegisterFile #(parameter string INIT_FILE = "")
                    (readData1, readData2, writeData, readAddr1, readAddr2, writeAddr, write_enable, clk, reset, TimerIntrpt, intrpt);

    output logic [31:0] readData1, readData2;
    input logic [4:0] readAddr1, readAddr2, writeAddr;
    input logic [31:0] writeData;
    input clk, reset, write_enable, TimerIntrpt, intrpt;

    logic [31:0] registers [0:31];
    logic interrupt;
    string regfile_path;

    initial begin
        if (INIT_FILE != "") begin
            $readmemh(INIT_FILE, registers);
        end else if ($value$plusargs("regfile=%s", regfile_path)) begin
            $readmemh(regfile_path, registers);
        end
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