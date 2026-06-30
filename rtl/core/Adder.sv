module Adder(added_data, data1, data2);

    output logic [31:0] added_data;
    input logic [31:0] data1, data2;

    always_comb begin
        added_data = data1 + data2;
    end

endmodule