module anodeSelect(number, anodeCounter, ledBCD, Anodeselect);

    input logic [31:0] number;
    input logic [2:0] anodeCounter;
    output logic [3:0] ledBCD;
    output logic [7:0] Anodeselect;

    always_comb begin
        case(anodeCounter)
            3'b000: begin
                ledBCD = number[3:0];
                Anodeselect = ~8'b00000001;
            end
            3'b001: begin
                ledBCD = number[7:4];
                Anodeselect = ~8'b00000010;
            end
            3'b010: begin
                ledBCD = number[11:8];
                Anodeselect = ~8'b00000100;
            end
            3'b011: begin
                ledBCD = number[15:12];
                Anodeselect = ~8'b00001000;
            end
            3'b100: begin
                ledBCD = number[19:16];
                Anodeselect = ~8'b00010000;
            end
            3'b101: begin
                ledBCD = number[23:20];
                Anodeselect = ~8'b00100000;
            end
            3'b110: begin
                ledBCD = number[27:24];
                Anodeselect = ~8'b01000000;
            end
            3'b111: begin
                ledBCD = number[31:28];
                Anodeselect = ~8'b10000000;
            end
        endcase
    end

endmodule