module refreshCounter(clk, reset, anodeCounter);

    input logic clk, reset;
    output logic [2:0] anodeCounter;

    logic [19:0] counter;

    always_comb begin
        anodeCounter = counter[19:17];
    end

    always_ff @(posedge clk) begin
        if(reset) begin
            counter <= 1'b0;
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule