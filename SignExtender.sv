module SignExtender(signEx_out, signEx_in, signEx_sel);

    output logic [31:0] signEx_out;
    input logic [24:0] signEx_in;
    input logic [2:0] signEx_sel;

    always_comb begin
        case(signEx_sel)
            3'h0: begin
                signEx_out = {{20{signEx_in[24]}}, signEx_in[24:13]}; /* Imm 31:21 I type */
            end
            3'h1: begin
                signEx_out = {{19{signEx_in[24]}}, signEx_in[24], signEx_in[0], signEx_in[23:18], signEx_in[4:1], 1'b0}; /* B type Imm 31:25 + Imm 11:7 */
            end
            3'h2: begin
                signEx_out = {signEx_in[24:5], {12{1'b0}}}; /* LUI */
            end
            3'h3: begin
                signEx_out = {{11{signEx_in[24]}}, signEx_in[24], signEx_in[12:5], signEx_in[13], signEx_in[23:14], 1'b0}; /* JAL */
            end
            3'h4: begin
                signEx_out = {{20{signEx_in[24]}}, signEx_in[24:18], signEx_in[4:0]};
            end
        endcase
    end

endmodule