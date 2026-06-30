module Mux_4x1(Mux4_out, Mux4_In1, Mux4_In2, Mux4_In3, Mux4_In4, Mux4_sel);

    output logic [31:0] Mux4_out;
    input logic [31:0] Mux4_In1, Mux4_In2, Mux4_In3, Mux4_In4;
    input logic [1:0] Mux4_sel;

    always_comb begin
        case(Mux4_sel)
            2'h0: begin
                Mux4_out = Mux4_In1;
            end

            2'h1: begin
                Mux4_out = Mux4_In2;
            end

            2'h2: begin
                Mux4_out = Mux4_In3;
            end

            2'h3: begin
                Mux4_out = Mux4_In4;
            end
            default: begin
                Mux4_out = Mux4_In1;
            end
        endcase
    end

endmodule