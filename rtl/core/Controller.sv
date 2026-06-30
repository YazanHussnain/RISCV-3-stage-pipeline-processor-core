module Controller(reg_write, ALUsel, readData2_muxSel, signEx_sel, wr_en, rd_en, wr_sel, rd_sel, dm_mux_sel, rdata1_mux_sel, instruction, branchType, clk, reset, stallMW, csr_reg_rdOut, csr_reg_wrOut, mretFlag, lowMRET, uart_select);

    output logic reg_write, rd_en, wr_en, rdata1_mux_sel, mretFlag, uart_select;
    output logic [3:0] ALUsel;
    output logic [1:0] wr_sel, dm_mux_sel;
    output logic [2:0] rd_sel, signEx_sel, branchType;
    output logic readData2_muxSel, csr_reg_rdOut, csr_reg_wrOut;
    input logic [31:0] instruction;
    input logic clk, reset, stallMW, lowMRET;

    logic rd_DMIn, wr_DMIn, reg_writeIn, csr_reg_rdIn, csr_reg_wrIn, uart_selectIn;
    logic [1:0] wr_selIn, DEMW_wbMux;
    logic [2:0] rd_selIn;

    ControllerA controllerA(.reg_write(reg_writeIn), .ALUsel(ALUsel), .readData2_muxSel(readData2_muxSel), .signEx_sel(signEx_sel), .wr_en(wr_DMIn), .rd_en(rd_DMIn), .wr_sel(wr_selIn), .rd_sel(rd_selIn), .dm_mux_sel(DEMW_wbMux), .rdata1_mux_sel(rdata1_mux_sel), .instruction(instruction), .branchType(branchType), .csr_reg_rd(csr_reg_rdIn), .csr_reg_wr(csr_reg_wrIn), .mretFlag(mretFlag), .lowMRET(lowMRET), .uart_select(uart_selectIn));

    ControllerB controllerB(.wr_selOut(wr_sel), .rd_selOut(rd_sel), .rd_DMOut(rd_en), .wr_DMOut(wr_en), .reg_writeOut(reg_write), .wb_muxSelOut(dm_mux_sel), .csr_reg_rdOut(csr_reg_rdOut), .csr_reg_wrOut(csr_reg_wrOut), .wr_selIn(wr_selIn), .rd_selIn(rd_selIn), .rd_DMIn(rd_DMIn), .wr_DMIn(wr_DMIn), .reg_writeIn(reg_writeIn), .wb_muxSelIn(DEMW_wbMux), .csr_reg_rdIn(csr_reg_rdIn), .csr_reg_wrIn(csr_reg_wrIn), .clk(clk), .reset(reset), .stallMW(stallMW), .uart_selectIn(uart_selectIn), .uart_selectOut(uart_select));

endmodule