module RISCV(clk, reset, intrpt, ledOut, Anodeselect, Tx, reset1);

    input logic clk, reset, intrpt, reset1;
    output logic [6:0] ledOut;
    output logic [7:0] Anodeselect;
    output logic Tx;

    logic [31:0] instruction, lsuDataout, lsuDataIn, Addr, dataDisplay, loadData;
    logic reg_write, readData2_muxSel, wr_en, rd_en, rdata1_mux_sel, chipSelect, rd_enOut, wr_enOut, MWstall, stallMW, stallIn, stallOut, csr_reg_rd, csr_reg_wr, mretFlag, lowMRET, ack_timerIntrpt, ack_intrpt, uart_select, tx_busy, byte_ready, tx_byte, clkOut;
    logic [1:0] wr_sel, dm_mux_sel;
    logic [2:0] rd_sel, signEx_sel, branchType;
    logic [3:0] ALUsel, mask;

    ClockDivider clkDiv(.clk(clk), .reset(reset1), .clkOut(clkOut));

    UART uart(.Tx(Tx), .tx_busy(tx_busy), .done(), .byte_ready(byte_ready), .tx_byte(tx_byte), .CLK(clkOut), .reset(reset), .IN_Data(loadData[15:8]), .uart_select(uart_select));

    sevenSeg SS(.clk(clk), .reset(reset), .data1(dataDisplay), .ledOut(ledOut), .Anodeselect(Anodeselect));

    DataMemory DM(.readData(lsuDataIn), .stallOut(stallOut), .Addr(Addr), .dataWrite(lsuDataout), .wr_en(wr_enOut), .rd_en(rd_enOut), .chipSelect(chipSelect), .clk(clkOut), .reset(reset), .mask(mask), .stallIn(stallIn), .ack_intrpt(ack_intrpt), .ack_timerIntrpt(ack_timerIntrpt), .dataDisplay(dataDisplay));

    Datapath DP(.instruction(instruction), .lsuDataout(lsuDataout), .addrOut(Addr), .mask(mask), .MWstall(stallMW), .chipSelect(chipSelect), .rd_enOut(rd_enOut), .wr_enOut(wr_enOut), .stallOut(stallIn), .lsuDataIn(lsuDataIn), .branchType(branchType), .clk(clkOut), .reset(reset), .reg_write(reg_write), .ALUsel(ALUsel), .signEx_sel(signEx_sel), .readData2_muxSel(readData2_muxSel), .wr_sel(wr_sel), .rd_sel(rd_sel), .rd_en(rd_en), .wr_en(wr_en), .dm_mux_sel(dm_mux_sel), .rdata1_mux_sel(rdata1_mux_sel), .stallIn(stallOut), .csr_reg_rd(csr_reg_rd), .csr_reg_wr(csr_reg_wr), .mretFlag(mretFlag), .lowMRET(lowMRET), .intrpt(intrpt), .ack_timerIntrpt(ack_timerIntrpt), .ack_intrpt(ack_intrpt), .uart_select(uart_select), .tx_busy(tx_busy), .byte_ready(byte_ready), .tx_byte(tx_byte), .loadData(loadData));

    Controller Control(.reg_write(reg_write), .ALUsel(ALUsel), .readData2_muxSel(readData2_muxSel), .signEx_sel(signEx_sel), .wr_en(wr_en), .rd_en(rd_en), .wr_sel(wr_sel), .rd_sel(rd_sel), .dm_mux_sel(dm_mux_sel), .rdata1_mux_sel(rdata1_mux_sel), .instruction(instruction), .branchType(branchType), .clk(clkOut), .reset(reset), .stallMW(stallMW), .csr_reg_rdOut(csr_reg_rd), .csr_reg_wrOut(csr_reg_wr), .mretFlag(mretFlag), .lowMRET(lowMRET), .uart_select(uart_select));

endmodule