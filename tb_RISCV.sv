module tb_RISCV();

    logic clk, reset, intrpt, Tx, reset1;
    logic [6:0] ledOut;
    logic [7:0] Anodeselect;
    RISCV riscv(.clk(clk), .reset(reset), .intrpt(intrpt), .ledOut(ledOut), .Anodeselect(Anodeselect), .Tx(Tx), .reset1(reset1));

    initial begin
        clk <= 1'b1;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        reset1 <= 1'b1;
        intrpt <= 1'b0;
        repeat(2) @(posedge clk);
        reset1 <= 1'b0;
        repeat (20) @(posedge clk);
        reset <= 1'b1;
        intrpt <= 1'b0;
        repeat(2) @(posedge riscv.clkOut);
        intrpt <= 1'b0;
        reset <= 1'b0;
        repeat (12000000) @(posedge clk);
        $stop;
    end

endmodule