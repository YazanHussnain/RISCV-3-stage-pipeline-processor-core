module Mux_3x1(Mux3_out, Mux3_In1, Mux3_In2, Mux3_In3, Mux3_sel);

    output logic [31:0] Mux3_out;
    input logic [31:0] Mux3_In1, Mux3_In2, Mux3_In3;
    input logic [1:0] Mux3_sel;

    always_comb begin
        case(Mux3_sel)
            2'h0: begin
                Mux3_out = Mux3_In1;
            end

            2'h1: begin
                Mux3_out = Mux3_In2;
            end

            2'h2: begin
                Mux3_out = Mux3_In3;
            end

            default:  begin
                Mux3_out = Mux3_In1;
            end
        endcase
    end

endmodule