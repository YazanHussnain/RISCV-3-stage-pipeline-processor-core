module FSF_unit(forwA, forwB, stallDE, stallMW, flush, DE_inst, MW_inst, reg_wrMW, clk, reset, branchTaken, validIn);

    output logic forwA, forwB,stallDE, stallMW, flush;
    input logic [31:0] DE_inst, MW_inst;
    input logic reg_wrMW, clk, reset, branchTaken, validIn;

    always_comb begin
        if(reset) begin
            stallDE = 1'b0;
            stallMW = 1'b0;
            forwA = 1'b0;
            forwB = 1'b0;
            flush = 1'b0;
        end
        else begin
            if((~validIn) & (!reg_wrMW)) begin
                if(MW_inst[11:7] == DE_inst[19:15]) begin
                    forwA = 1'b1;
                end
                else begin
                    forwA = 1'b0;
                end
                if(MW_inst[11:7] == DE_inst[24:20]) begin
                    forwB = 1'b1;
                end
                else begin
                    forwB = 1'b0;
                end
                if((MW_inst[6:0] == 7'b0000011) & ((MW_inst[11:7] == DE_inst[19:15]) | (MW_inst[11:7] == DE_inst[24:20]))) begin
                    stallDE = 1'b1;
                    stallMW = 1'b1;
                end
                else begin
                    stallDE = 1'b0;
                    stallMW = 1'b0;
                end
            end
            else begin
                stallDE = 1'b0;
                stallMW = 1'b0;
                forwA = 1'b0;
                forwB = 1'b0;
            end
            if(branchTaken) begin
                flush = 1'b1;
            end
            else begin
                flush = 1'b0;
            end
        end
    end

endmodule