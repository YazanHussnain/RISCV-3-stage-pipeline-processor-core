module ControllerA(reg_write, ALUsel, readData2_muxSel, signEx_sel, wr_en, rd_en, wr_sel, rd_sel, dm_mux_sel, rdata1_mux_sel, instruction, branchType, csr_reg_rd, csr_reg_wr, mretFlag, lowMRET, uart_select);

    output logic reg_write, rd_en, wr_en, rdata1_mux_sel, csr_reg_rd, csr_reg_wr, uart_select;
    output logic [3:0] ALUsel;
    output logic [1:0] wr_sel, dm_mux_sel;
    output logic [2:0] rd_sel, signEx_sel, branchType;
    output logic readData2_muxSel, mretFlag;
    input logic [31:0] instruction;
    input logic lowMRET;

    always_comb begin
        case(instruction[6:0])
            7'b0110011: begin
                case(instruction[31:25])
                    7'b0000000: begin
                        case(instruction[14:12])
                            3'b000: begin
                                ALUsel = 4'h0;
                            end
                            3'b001: begin
                                ALUsel = 4'h2;
                            end
                            3'b010: begin
                                ALUsel = 4'h3;
                            end
                            3'b011: begin
                                ALUsel = 4'h4;
                            end
                            3'b100: begin
                                ALUsel = 4'h5;
                            end
                            3'b101: begin
                                ALUsel = 4'h6;
                            end
                            3'b110: begin
                                ALUsel = 4'h8;
                            end
                            3'b111: begin
                                ALUsel = 4'h9;
                            end
                        endcase
                    end
                    7'b0100000: begin
                        case(instruction[14:12])
                            3'b000: begin
                                ALUsel = 4'h1;
                            end
                            3'b101: begin
                                ALUsel = 4'h7;
                            end
                        endcase
                    end
                endcase
                readData2_muxSel = 1'b0;
                wr_en = 1'b1;
                rd_en = 1'b0;
                dm_mux_sel = 2'h0;
                reg_write = 1'b0;
                branchType = 3'h7;
                rdata1_mux_sel = 1'b0;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b0010011: begin
                case(instruction[31:25])
                    7'b0000000: begin
                        case(instruction[14:12])
                            3'b001: begin
                                ALUsel = 4'h2;
                            end
                            3'b101: begin
                                ALUsel = 4'h6;
                            end
                        endcase
                    end
                    7'b0100000: begin
                        ALUsel = 4'h7;
                    end
                endcase
                case(instruction[14:12])
                    3'b000: begin
                        ALUsel = 4'h0;
                    end
                    3'b010: begin
                        ALUsel = 4'h4;
                    end
                    3'b011: begin
                        ALUsel = 4'h3;
                    end
                    3'b100: begin
                        ALUsel = 4'h5;
                    end
                    3'b110: begin
                        ALUsel = 4'h8;
                    end
                    3'b111: begin
                        ALUsel = 4'h9;
                    end
                endcase
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b0;
                dm_mux_sel = 2'h0;
                reg_write = 1'b0;
                signEx_sel = 3'h0;
                branchType = 3'h7;
                rdata1_mux_sel = 1'b0;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b0000011: begin
                case(instruction[14:12])
                    3'h0: begin
                        rd_sel = 3'h0;
                    end
                    3'h1: begin
                        rd_sel = 3'h1;
                    end
                    3'h2: begin
                        rd_sel = 3'h2;
                    end
                    3'h4: begin
                        rd_sel = 3'h3;
                    end
                    3'h5: begin
                        rd_sel = 3'h4;
                    end
                endcase
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b1;
                dm_mux_sel = 2'h1;
                reg_write = 1'b0;
                signEx_sel = 3'h0;
                ALUsel = 4'h0;
                branchType = 3'h7;
                rdata1_mux_sel = 1'b0;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b0100011: begin
                case(instruction[14:12])
                    3'h0: begin
                        wr_sel = 2'h1;
                    end
                    3'h1: begin
                        wr_sel = 2'h2;
                    end
                    3'h2: begin
                        wr_sel = 2'h0;
                    end
                endcase
                readData2_muxSel = 1'b1;
                wr_en = 1'b0;
                rd_en = 1'b0;
                reg_write = 1'b1;
                signEx_sel = 3'h4;
                ALUsel = 4'h0;
                branchType = 3'h7;
                rdata1_mux_sel = 1'b0;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
                if(instruction[31])
                    uart_select = 1'b1;
            end
            7'b1100011: begin
                case(instruction[14:12])
                    3'h0: begin
                        branchType = 3'h0;
                    end
                    3'h1: begin
                        branchType = 3'h1;
                    end
                    3'h4: begin
                        branchType = 3'h2;
                    end
                    3'h5: begin
                        branchType = 3'h3;
                    end
                    3'h6: begin
                        branchType = 3'h4;
                    end
                    3'h7: begin
                        branchType = 3'h5;
                    end
                endcase
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b0;
                reg_write = 1'b1;
                signEx_sel = 3'h1;
                ALUsel = 4'h0;
                rdata1_mux_sel = 1'b1;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b1100111: begin
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b0;
                reg_write = 1'b0;
                signEx_sel = 3'h0;
                ALUsel = 4'h0;
                rdata1_mux_sel = 1'b0;
                branchType = 3'h6;
                dm_mux_sel = 2'h2;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b0110111: begin
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b0;
                reg_write = 1'b0;
                signEx_sel = 3'h2;
                ALUsel = 4'hA;
                rdata1_mux_sel = 1'b0;
                branchType = 3'h7;
                dm_mux_sel = 2'h0;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b0010111: begin
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b0;
                reg_write = 1'b0;
                signEx_sel = 3'h2;
                ALUsel = 4'h0;
                rdata1_mux_sel = 1'b1;
                branchType = 3'h7;
                dm_mux_sel = 2'h0;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b1101111: begin
                readData2_muxSel = 1'b1;
                wr_en = 1'b1;
                rd_en = 1'b0;
                reg_write = 1'b0;
                signEx_sel = 3'h3;
                ALUsel = 4'h0;
                rdata1_mux_sel = 1'b1;
                branchType = 3'h6;
                dm_mux_sel = 2'h2;
                csr_reg_wr = 1'b0;
                csr_reg_rd = 1'b0;
                mretFlag = 1'b0;
                uart_select = 1'b0;
            end
            7'b1110011: begin
                csr_reg_wr = 1'b1;
                csr_reg_rd = 1'b1;
                reg_write = 1'b0;
                signEx_sel = 3'h0;
                dm_mux_sel = 2'h3;
                mretFlag = 1'b0;
                uart_select = 1'b0;
                case(instruction[31:20])
                    12'h302: begin
                        mretFlag = 1'b1;
                        csr_reg_wr = 1'b0;
                        csr_reg_rd = 1'b0;
                        reg_write = 1'b1;
                    end
                endcase
            end
        endcase
        if(lowMRET) begin
            mretFlag = 1'b0;
        end
    end

endmodule