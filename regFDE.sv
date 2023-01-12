module regFDE(pcOut, instOut, pcIn, instIn, clk, reset, stall, flush, TimerIntrpt, intrpt);

    output logic [31:0] instOut, pcOut;
    input logic [31:0] pcIn, instIn;
    input logic clk, reset, stall, flush, TimerIntrpt, intrpt;

    always_ff @(posedge clk) begin
        if(reset) begin
            pcOut <= 32'h0;
            instOut <= 32'h0;
        end
        else begin
            if(!stall) begin
                pcOut <= pcIn;
                if(flush | TimerIntrpt | intrpt) begin
                    instOut <= 32'h00000033;
                end
                else begin
                    instOut <= instIn;
                end
            end
            else begin
                pcOut <= pcOut;
                instOut <= instIn;
            end
        end
    end

endmodule