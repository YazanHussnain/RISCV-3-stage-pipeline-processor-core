module BranchComparator(branchType, branchTaken, reg1, reg2);

    output logic branchTaken;
    input logic [2:0] branchType;
    input logic [31:0] reg1, reg2;

    logic [32:0] hold;
    logic notZeroFlag, negativeFlag, carryFlag, overflowFlag;

    always_comb begin
        hold = {1'b0, reg1} - {1'b0, reg2};
        notZeroFlag = |hold[31:0];
        negativeFlag = hold[31];
        overflowFlag = (negativeFlag & ~reg1[31] & reg2[31]) | (~negativeFlag & reg1[31] & ~reg2[31]);

        case(branchType)
            3'h0: begin
                branchTaken = !notZeroFlag;
            end
            3'h1: begin
                branchTaken = notZeroFlag;
            end
            3'h2: begin
                branchTaken = (negativeFlag ^ overflowFlag);
            end
            3'h3: begin
                branchTaken = ~(negativeFlag ^ overflowFlag);
            end
            3'h4: begin
                branchTaken = hold[32];
            end
            3'h5: begin
                branchTaken = ~hold[32];
            end
            3'h6: begin
                branchTaken = 1'b1;
            end
            4'h7: begin
                branchTaken = 1'b0;
            end
            default: begin
                branchTaken = 1'b0;
            end
        endcase
    end

endmodule