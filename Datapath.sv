module Datapath(instruction, lsuDataout, addrOut, mask, MWstall, chipSelect, rd_enOut, wr_enOut, stallOut, lsuDataIn, branchType, clk, reset, reg_write, ALUsel, signEx_sel, readData2_muxSel, wr_sel, rd_sel, rd_en, wr_en, dm_mux_sel, rdata1_mux_sel, stallIn, csr_reg_rd, csr_reg_wr, mretFlag, lowMRET, intrpt, ack_timerIntrpt, ack_intrpt, uart_select, tx_busy, byte_ready, tx_byte, loadData);

    output logic [31:0] instruction, lsuDataout, addrOut, loadData;
    output logic wr_enOut, rd_enOut, chipSelect, MWstall, stallOut, lowMRET, ack_intrpt, ack_timerIntrpt, byte_ready, tx_byte;
    output logic [3:0] mask;
    input logic clk, reset, reg_write, readData2_muxSel, wr_en, rd_en, rdata1_mux_sel, stallIn, csr_reg_rd, csr_reg_wr, mretFlag, intrpt, uart_select, tx_busy;
    input logic [3:0] ALUsel;
    input logic [1:0] wr_sel, dm_mux_sel;
    input logic [2:0] rd_sel, signEx_sel, branchType;
    input logic [31:0] lsuDataIn;

    logic [31:0] pc_to_adder, adder_to_pc, pc_mux_out, rdata1_mux_out, adder_to_dm_mux, instIN, pcOut, writeDataOut, DEMW_regpcOut, DEMW_aluOut, DEMW_instOut;
    logic [31:0] readData1, readData2_muxIn, ALUout, signEx_out, dm_mux_out, readData_dm, readData2_muxOut, forwA_rdata1, forwB_rdata2, csr_wdataOut, csr_AddrOut, csrEvec, csrRdata, pcToEIpc;
    logic branchTaken, forwA, forwB, stallDE, flush, validIn, pcIntrpt, intrptTimer, timerIntrpt, Intrpt;

    Mux_2x1 Mux2x1_PC(.Mux2_out(pcToEIpc), .Mux2_In1(adder_to_pc), .Mux2_In2(ALUout), .Mux2_sel(branchTaken));

    Mux_2x1 Mux2x1_PC_EI(.Mux2_out(pc_mux_out), .Mux2_In1(pcToEIpc), .Mux2_In2(csrEvec), .Mux2_sel(pcIntrpt));

    Program_Counter PC(.clk(clk), .reset(reset), .stall(stallDE), .flush(flush), .PC_Next(pc_mux_out), .PC_Out(pc_to_adder));

    Adder adder(.added_data(adder_to_pc), .data1(32'h4), .data2(pc_to_adder));

    Instruction_Memory IM(.read_addr(pc_to_adder), .instruction(instIN));

    regFDE FDE_reg(.pcOut(pcOut), .instOut(instruction), .pcIn(pc_to_adder), .instIn(instIN), .clk(clk), .reset(reset), .stall(stallDE), .flush(flush), .TimerIntrpt(timerIntrpt), .intrpt(Intrpt));

    RegisterFile RF(.readData1(forwA_rdata1), .readData2(forwB_rdata2), .writeData(dm_mux_out), .readAddr1(instruction[19:15]), .readAddr2(instruction[24:20]), .writeAddr(DEMW_instOut[11:7]), .write_enable(reg_write), .clk(clk), .reset(reset), .TimerIntrpt(timerIntrpt), .intrpt(Intrpt));

    Mux_2x1 ForwA(.Mux2_out(readData1), .Mux2_In1(forwA_rdata1), .Mux2_In2(DEMW_aluOut), .Mux2_sel(forwA));

    Mux_2x1 ForwB(.Mux2_out(readData2_muxIn), .Mux2_In1(forwB_rdata2), .Mux2_In2(DEMW_aluOut), .Mux2_sel(forwB));

    ALU Alu(.ALUout(ALUout), .readData1(rdata1_mux_out), .readData2(readData2_muxOut), .ALUsel(ALUsel));

    SignExtender SE(.signEx_out(signEx_out), .signEx_in(instruction[31:7]), .signEx_sel(signEx_sel));

    Mux_2x1 Mux2x1(.Mux2_out(readData2_muxOut), .Mux2_In1(readData2_muxIn), .Mux2_In2(signEx_out), .Mux2_sel(readData2_muxSel));

    Mux_2x1 Mux2x1_Reg1(.Mux2_out(rdata1_mux_out), .Mux2_In1(readData1), .Mux2_In2(pcOut), .Mux2_sel(rdata1_mux_sel));

    regDEMW DEMW_reg(.pcOut(DEMW_regpcOut), .aluOut(DEMW_aluOut), .writeDataOut(writeDataOut), .instOut(DEMW_instOut), .csr_wdataOut(csr_wdataOut), .csr_AddrOut(csr_AddrOut), .pcIn(pcOut), .aluIn(ALUout), .writeDataIn(readData2_muxIn), .instIn(instruction), .csr_wdataIn(readData1), .csr_AddrIn(signEx_out), .clk(clk), .reset(reset), .stall(MWstall));

    LoadStoreUnit LSU(.lsuDataout(lsuDataout), .Addr(DEMW_aluOut), .lsuDataIn(lsuDataIn), .WBdata(readData_dm), .addrOut(addrOut), .mask(mask), .writeData(writeDataOut), .rd_en(rd_enOut), .wr_en(wr_enOut), .rd_enIn(rd_en), .wr_enIn(wr_en), .wr_sel(wr_sel), .rd_sel(rd_sel), .chipSelect(chipSelect), .stallDPIN(stallIn), .stallDPOut(stallOut), .stallFSFIn(validIn), .stallFSFOut(MWstall), .ack_intrptIn(Intrpt), .ack_timerIntrptIn(timerIntrpt), .ack_intrptOut(ack_intrpt), .ack_timerIntrptOut(ack_timerIntrpt), .uart_select(uart_select), .tx_busy(tx_busy), .byte_ready(byte_ready), .tx_byte(tx_byte), .loadData(loadData), .clk(clk));

    //DataMemory DM(.readData(readData_dm), .Addr(ALUout), .dataWrite(readData2_muxIn), .wr_sel(wr_sel), .rd_sel(rd_sel), .wr_en(wr_en), .rd_en(rd_en), .clk(clk), .reset(reset));

    TimerIntrpt TI(.intrpt(intrptTimer), .clk(clk), .reset(reset));

    CSR controlStatusReg(.csrPC(DEMW_regpcOut), .csrAddr(csr_AddrOut), .intrpt(intrpt), .TimerIntrpt(intrptTimer), .csr_wdata(csr_wdataOut), .csrRegwr(csr_reg_wr), .csrRegrd(csr_reg_rd), .csrRdata(csrRdata), .csrEvec(csrEvec), .pcIntrpt(pcIntrpt), .mretFlag(mretFlag), .clk(clk), .reset(reset), .instruction(DEMW_instOut), .lowMRET(lowMRET), .timerIntrpt(timerIntrpt), .Intrpt(Intrpt));
    
    Mux_4x1 Mux4x1_DM(.Mux4_out(dm_mux_out), .Mux4_In1(DEMW_aluOut), .Mux4_In2(readData_dm), .Mux4_In3(adder_to_dm_mux), .Mux4_In4(csrRdata), .Mux4_sel(dm_mux_sel));

    Adder adder1(.added_data(adder_to_dm_mux), .data1(32'h4), .data2(DEMW_regpcOut));

    BranchComparator BC(.branchType(branchType), .branchTaken(branchTaken), .reg1(readData1), .reg2(readData2_muxIn));

    FSF_unit UnitFSF(.forwA(forwA), .forwB(forwB), .stallDE(stallDE), .stallMW(MWstall), .flush(flush), .DE_inst(instruction), .MW_inst(DEMW_instOut), .reg_wrMW(reg_write), .clk(clk), .reset(reset), .branchTaken(branchTaken), .validIn(validIn));

endmodule