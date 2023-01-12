module DataMemory(readData, stallOut, Addr, dataWrite, wr_en, rd_en, chipSelect, clk, reset, mask, stallIn, ack_intrpt, ack_timerIntrpt, dataDisplay);

    output logic [31:0] readData;
    output logic stallOut;
    output logic [31:0] dataDisplay;
    input logic [31:0] Addr, dataWrite;
    input logic clk, reset, wr_en, rd_en, chipSelect, stallIn, ack_intrpt, ack_timerIntrpt;
    input [3:0] mask;

    logic [31:0] dataMemory [0:512];
    logic interrupt;

    initial begin
        $readmemh("E:/CA_Lab/RISC-V/RISC-V_3Stage_Pipeline_HDU_CSR_7SEG_uart/DataMemory.mem", dataMemory, 0, 511);
    end

    always_ff @(posedge clk) begin
        if(reset) begin
            stallOut <= 1'b0;
        end
        else begin
            stallOut <= stallIn;
        end
    end

    always_ff @(negedge clk) begin
        if(reset) begin
            readData <= 32'h0;
        end
        else begin
            if(rd_en & (!chipSelect)) begin
                readData <= dataMemory[Addr >> 2];
            end
            else begin
                readData <= 32'h0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(ack_intrpt | ack_timerIntrpt) begin
            interrupt <= 1'b1;
        end
        else begin
            interrupt <= 1'b0;
        end
    end

    always_ff @(negedge clk) begin
        if((!wr_en & (~interrupt) & (~ack_intrpt) & (~ack_timerIntrpt)) & (!chipSelect)) begin
            if(mask[0]) begin
                dataMemory[Addr >> 2][7:0] <= dataWrite[7:0];
            end
            if(mask[1]) begin
                dataMemory[Addr >> 2][15:8] <= dataWrite[15:8];
            end
            if(mask[2]) begin
                dataMemory[Addr >> 2][23:16] <= dataWrite[23:16];
            end
            if(mask[3]) begin
                dataMemory[Addr >> 2][31:24] <= dataWrite[31:24];
            end
        end
    end

    assign dataDisplay = dataMemory[1];

endmodule