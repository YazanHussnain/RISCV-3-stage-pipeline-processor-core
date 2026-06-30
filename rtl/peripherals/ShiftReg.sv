module Shift_Reg (
    serial_out,
    IN_Data,
    assert_shift,
    load_data,
    reset,
    byte_ready,
    uart_select,
    CLK
);
  output logic serial_out;
  input logic [7:0] IN_Data;
  input logic assert_shift;
  input logic load_data, reset, byte_ready, uart_select, CLK;
  logic [8:0] data;

  // Synchronous shift register. (Previously modelled combinationally, which
  // inferred latches and a data->data feedback path; a shift register is
  // inherently sequential, so it is clocked here.)
  always_ff @(posedge CLK or posedge reset) begin
    if (reset) begin
      serial_out <= 1'b1;
      data <= 9'b0;
    end else begin
      if (load_data) begin
        data <= {IN_Data, 1'b0};
      end
      if (assert_shift) begin
        serial_out <= data[0];
        data <= {1'b0, data[8:1]};
      end
    end
  end
endmodule
