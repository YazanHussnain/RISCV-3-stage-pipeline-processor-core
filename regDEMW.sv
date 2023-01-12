module regDEMW(pcOut, aluOut, writeDataOut, instOut, csr_wdataOut, csr_AddrOut, pcIn, aluIn, writeDataIn, instIn, csr_wdataIn, csr_AddrIn, clk, reset, stall);

    output logic [31:0] pcOut, aluOut, writeDataOut, instOut, csr_AddrOut, csr_wdataOut;
    input logic [31:0] pcIn, aluIn, writeDataIn, instIn, csr_AddrIn, csr_wdataIn;
    input logic clk, reset, stall;

    always_ff @(posedge clk) begin
        if(reset) begin
            pcOut <= 32'h0;
            instOut <= 32'h0;
            aluOut <= 32'h0;
            writeDataOut <= 32'h0;
            csr_AddrOut <= 32'h0;
            csr_wdataOut <= 32'h0;
        end
        else begin
            if(!stall) begin
                pcOut <= pcIn;
                instOut <= instIn;
                aluOut <= aluIn;
                writeDataOut <= writeDataIn;
                csr_AddrOut <= csr_AddrIn;
                csr_wdataOut <= csr_wdataIn;
            end
            else begin
                pcOut <= pcOut;
                instOut <= instOut;
                aluOut <= aluOut;
                writeDataOut <= writeDataOut;
                csr_AddrOut <= csr_AddrOut;
                csr_wdataOut <= csr_wdataOut;
            end
        end
    end

endmodule