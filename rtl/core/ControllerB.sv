module ControllerB(wr_selOut, rd_selOut, rd_DMOut, wr_DMOut, reg_writeOut, wb_muxSelOut, csr_reg_rdOut, csr_reg_wrOut, wr_selIn, rd_selIn, rd_DMIn, wr_DMIn, reg_writeIn, wb_muxSelIn, csr_reg_rdIn, csr_reg_wrIn, clk, reset, stallMW, uart_selectIn, uart_selectOut);

    output logic rd_DMOut, wr_DMOut, reg_writeOut, csr_reg_rdOut, csr_reg_wrOut, uart_selectOut;
    output logic [1:0] wr_selOut, wb_muxSelOut;
    output logic [2:0] rd_selOut;

    input logic rd_DMIn, wr_DMIn, reg_writeIn, csr_reg_rdIn, csr_reg_wrIn, uart_selectIn;
    input logic [1:0] wr_selIn, wb_muxSelIn;
    input logic [2:0] rd_selIn;
    input logic clk, reset, stallMW;

    always_ff @(posedge clk) begin
        if(reset) begin
            rd_DMOut <= 1'b0;
            wr_DMOut <= 1'b0;
            reg_writeOut <= 1'b0;
            wr_selOut <= 2'b0;
            rd_selOut <= 3'b0;
            wb_muxSelOut <= 2'b0;
            csr_reg_rdOut <= 1'b0;
            csr_reg_wrOut <= 1'b0;
            uart_selectOut <= 1'b0;
        end
        else if(~stallMW) begin
            rd_DMOut <= rd_DMIn;
            wr_DMOut <= wr_DMIn;
            reg_writeOut <= reg_writeIn;
            wr_selOut <= wr_selIn;
            rd_selOut <= rd_selIn;
            wb_muxSelOut <= wb_muxSelIn;
            csr_reg_rdOut <= csr_reg_rdIn;
            csr_reg_wrOut <= csr_reg_wrIn;
            uart_selectOut <= uart_selectIn;
        end
    end

endmodule