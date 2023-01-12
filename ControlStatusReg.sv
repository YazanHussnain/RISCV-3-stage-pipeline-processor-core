module CSR(csrPC, csrAddr, intrpt, TimerIntrpt, csr_wdata, csrRegwr, csrRegrd, csrRdata, csrEvec, pcIntrpt, mretFlag, clk, reset, instruction, lowMRET, timerIntrpt, Intrpt);

    input logic [31:0] csrPC, csrAddr, csr_wdata, instruction;
    input logic csrRegrd, csrRegwr, intrpt, clk, reset, TimerIntrpt, mretFlag;
    output logic [31:0] csrRdata, csrEvec;
    output logic pcIntrpt, lowMRET, timerIntrpt, Intrpt;

    logic [31:0] csrReg [0:5];

    logic csrMstatus_wrFlag, csrMie_wrFlag, csrMtvec_wrFlag, csrMepc_wrFlag, csrMcause_wrFlag, csrMip_wrFlag, intrptPc, hold;

    logic [31:0] MIP, MIE, MSTATUS, MTVEC, MCAUSE, MEPC;

    always_comb begin
        timerIntrpt = ((MIP[7] & MIE[7] & MSTATUS[3]) & TimerIntrpt);
        Intrpt = ((MIP[11] & MIE[11] & MSTATUS[3]) & intrpt);
    end

    always_comb begin
        MIP = csrReg[5];
        MIE = csrReg[1];
        MSTATUS = csrReg[0];
        MTVEC = csrReg[2];
        MCAUSE = csrReg[4];
        MEPC = csrReg[3];
        if((MIP[7] & MIE[7] & MSTATUS[3]) | (MIP[11] & MIE[11] & MSTATUS[3])) begin
            case(MTVEC[0])
                1'b1: begin
                    csrEvec = {2'b00, MTVEC[31:2]};
                end
                1'b0: begin
                    csrEvec = ({1'b0, MCAUSE[30:0]} << 2) + ({2'b00, MTVEC[31:2]});
                end
            endcase
        end
        if(mretFlag) begin
            csrEvec = MEPC;
        end
    end

    always_ff @(posedge clk) begin
        if(mretFlag) begin
            lowMRET = 1'b1;
        end
        else begin
            lowMRET = 1'b0;
        end
    end

    always_comb begin
        if(((MIP[7] & MIE[7] & MSTATUS[3]) & TimerIntrpt) | (intrpt & (MIP[11] & MIE[11] & MSTATUS[3]))) begin
            pcIntrpt = 1'b1;
        end
        else if (mretFlag) begin
            pcIntrpt = 1'b1;
        end
        else begin
            pcIntrpt = 1'b0;
        end
    end

    always_comb begin
        
        if(csrRegrd) begin
            case(csrAddr)
                32'h300: begin /* MSTATUS */
                    csrRdata = csrReg[0];
                end
                32'h304: begin /* MIE */
                    csrRdata = csrReg[1];
                end
                32'h305: begin /* MTVEC */
                    csrRdata = csrReg[2];
                end
                32'h341: begin /* MEPC */
                    csrRdata = csrReg[3];
                end
                32'h342: begin /* MCAUSE */
                    csrRdata = csrReg[4];
                end
                32'h344: begin /* MIP */
                    csrRdata = csrReg[5];
                end
            endcase
        end
        else begin
            csrRdata = 32'h0;
        end

    end

    always_comb begin
        csrMstatus_wrFlag = 1'b0;
        csrMepc_wrFlag = 1'b0;
        csrMie_wrFlag = 1'b0;
        csrMip_wrFlag = 1'b0;
        csrMcause_wrFlag = 1'b0;
        csrMtvec_wrFlag = 1'b0;
        if(csrRegwr) begin
            case(csrAddr)
                32'h300: begin /* MSTATUS */
                    csrMstatus_wrFlag = 1'b1;
                end
                32'h304: begin /* MIE */
                    csrMie_wrFlag = 1'b1;
                end
                32'h305: begin /* MTVEC */
                    csrMtvec_wrFlag = 1'b1;
                end
                32'h341: begin /* MEPC */
                    csrMepc_wrFlag = 1'b1;
                end
                32'h342: begin /* MCAUSE */
                    csrMcause_wrFlag = 1'b1;
                end
                32'h344: begin /* MIP */
                    csrMip_wrFlag = 1'b1;
                end
            endcase
        end
    end
    always_ff @(posedge clk) begin
        if(reset) begin
            csrReg[2] <= 32'h0;
            csrReg[1] <= 32'h0;
            csrReg[0] <= 32'h0;
        end
        else begin
            if (csrMtvec_wrFlag) begin
                csrReg[2] <= csr_wdata;
            end
            if (csrMie_wrFlag) begin
                csrReg[1] <= csr_wdata;
            end
            if (csrMstatus_wrFlag) begin
                csrReg[0] <= csr_wdata;
            end
        end
    end

    always_comb begin
        if(((MIP[7] & MIE[7] & MSTATUS[3]) & TimerIntrpt)) begin
            csrReg[4] = 32'h1;
        end
        else if((intrpt & (MIP[11] & MIE[11] & MSTATUS[3])))begin
            csrReg[4] = 32'h2;
        end
        else begin
            csrReg[4] = 32'h0;
        end
    end

    always_comb begin
        if(((MIE[7] & MSTATUS[3]) & TimerIntrpt) | (intrpt & (MIE[11] & MSTATUS[3]))) begin
            if(instruction == 32'h00000033)
                csrReg[3] = csrPC - 32'h4;
            else begin
                csrReg[3] = csrPC;
            end
            if((intrpt & (MIE[11] & MSTATUS[3]))) begin
                csrReg[5] = 32'h800;
            end
            else begin
                csrReg[5] = 32'h80;
            end
        end
    end

endmodule