module bcd(ledBCD, ledOut);

    input logic [3:0] ledBCD;
    output logic [6:0] ledOut;

    always_comb begin
        case(ledBCD)
            4'b0000: begin
                ledOut = 7'b0000001;
            end
            4'b0001: begin
                ledOut = 7'b1001111;
            end
            4'b0010: begin
                ledOut = 7'b0010010;
            end
            4'b0011: begin
                ledOut = 7'b0000110;
            end
            4'b0100: begin
                ledOut = 7'b1001100;
            end
            4'b0101: begin
                ledOut = 7'b0100100;
            end
            4'b0110: begin
                ledOut = 7'b0100000;
            end
            4'b0111: begin
                ledOut = 7'b0001111;
            end
            4'b1000: begin
                ledOut = 7'b0000000;
            end
            4'b1001: begin
                ledOut = 7'b0000100;
            end
            4'b1010: begin
                ledOut = 7'b0001000;
            end
            4'b1011: begin
                ledOut = 7'b1100000;
            end
            4'b1100: begin
                ledOut = 7'b0110001;
            end
            4'b1101: begin
                ledOut = 7'b1000010;
            end
            4'b1110: begin
                ledOut = 7'b0110000;
            end
            4'b1111: begin
                ledOut = 7'b0111000;
            end
            default: begin
                ledOut = 7'b1111110;
            end
        endcase
    end

endmodule