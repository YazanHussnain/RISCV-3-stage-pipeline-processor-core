module tb_sevenSeg();

    logic clk, reset;
    logic [31:0] data;
    logic [6:0] ledOut;
    logic [7:0] Anodeselect;

    sevenSeg uut(.clk(clk), .reset(reset), .data(data), .ledOut(ledOut), .Anodeselect(Anodeselect));

    initial begin
        clk <= 1'b0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        reset <= 1'b1;
        data <= 32'hABCDEF11;
        @(posedge clk);
        reset <= 1'b0;
        repeat (12000000) @(posedge clk);
        $stop;
    end

endmodule