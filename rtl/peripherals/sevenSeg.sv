module sevenSeg(clk, reset, data1, ledOut, Anodeselect);

    input logic clk, reset;
    input logic [31:0] data1;
    output logic [6:0] ledOut;
    output logic [7:0] Anodeselect;

    logic [2:0] anodeCounter;
    logic [3:0] ledBCD;

    refreshCounter refrshCnt(.clk(clk), .reset(reset), .anodeCounter(anodeCounter));

    anodeSelect selectAnode(.number(data1), .anodeCounter(anodeCounter), .ledBCD(ledBCD), .Anodeselect(Anodeselect));

    bcd BCD(.ledBCD(ledBCD), .ledOut(ledOut));

endmodule