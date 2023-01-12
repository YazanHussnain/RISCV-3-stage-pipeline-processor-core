module ALU(ALUout, readData1, readData2, ALUsel);

    output logic [31:0] ALUout;
    input logic [31:0] readData1, readData2;
    input logic [3:0] ALUsel;

    always_comb begin
        case(ALUsel)
            4'h0: begin
                ALUout = readData1 + readData2;
            end
            4'h1: begin
                ALUout = readData1 - readData2;
            end
            4'h2: begin
                ALUout = readData1 << readData2[4:0];
            end
            4'h3: begin
                ALUout = (readData1 < readData2) ? 32'h1 : 32'h0;
            end
            4'h4: begin
                ALUout = ($signed(readData1) < $signed(readData2)) ? 32'h1 : 32'h0;
            end
            4'h5: begin
                ALUout = readData1 ^ readData2;
            end
            4'h6: begin
                ALUout = readData1 >> readData2[4:0];
            end
            4'h7: begin
                ALUout = $signed(readData1) >>> readData2[4:0];
            end
            4'h8:begin
                ALUout = readData1 | readData2;
            end
            4'h9: begin
                ALUout = readData1 & readData2;
            end
            4'hA: begin
                ALUout = readData2;
            end
            default: begin
                ALUout = 32'h0;
            end
        endcase
    end

endmodule