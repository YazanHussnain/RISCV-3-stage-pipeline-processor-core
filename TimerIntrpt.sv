module TimerIntrpt(intrpt, clk, reset);

    output logic intrpt;
    input logic clk, reset;

    logic [15:0] count;

    always_ff @(posedge clk) begin
        if(reset) begin
            count <= 16'b0;
        end else begin
            count <= count + 16'b1;
        end
        if(count == 30) begin
            intrpt <= 1'b1;
            count <= 1'b0;
        end
        else begin
            intrpt <= 1'b0;
        end
    end

endmodule