module Bit_Counter (
    count_of,
    clear_count,
    tx_clk,
    reset,
    done
);
  output logic count_of, done;
  input logic clear_count;
  input logic tx_clk, reset;
  logic [3:0] bit_counter = 0;
  ;
  always_ff @(posedge tx_clk or posedge reset) begin
    if(reset) begin
      count_of <= 1'b0;
      bit_counter <= 4'b0000;
      done <= 1'b1;
    end else if (clear_count) begin
      count_of <= 1'b0;
      bit_counter <= 4'b0000;
      done <= 1'b1;
    end else if (bit_counter == 4'h9) begin
      count_of <= 1'b1;
      bit_counter <= 1'b0;
      done <= 1'b1;
    end else begin
      count_of <= 1'b0;
      bit_counter = bit_counter + 1'b1;
      done <= 1'b1;
    end
  end
endmodule
