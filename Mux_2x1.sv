module Mux_2x1(Mux2_out, Mux2_In1, Mux2_In2, Mux2_sel);

    output logic [31:0] Mux2_out;
    input logic [31:0] Mux2_In1, Mux2_In2;
    input logic Mux2_sel;

    always_comb begin
        case(Mux2_sel)
            1'b0: begin
                Mux2_out = Mux2_In1;
            end

            1'b1: begin
                Mux2_out = Mux2_In2;
            end
            default: begin
                Mux2_out = Mux2_In1;
            end
        endcase
    end

endmodule