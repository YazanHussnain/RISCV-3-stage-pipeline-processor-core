module ClockDivider(clk, reset, clkOut);

    input logic clk, reset;
    output logic clkOut;

    logic [7:0] counter;

    always_ff @(posedge clk) begin
        if(reset) begin
            counter <= 8'h0;
            clkOut = 1'b0;
        end
        else begin
            counter <= counter + 1;
        end
        if(counter == 50) begin
            counter <= 8'h0;
            clkOut = ~clkOut;
        end
    end

endmodule