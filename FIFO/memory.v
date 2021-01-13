module Memory_Array(
  clock,
  write_Enable,
  write_Pointer,
  sig_Full,
  read_Pointer,
  buffer_Input,
  buffer_Output
  );

  parameter BUFFER_WIDTH = 3;
  parameter DATA_WIDTH = 8;
  parameter BUFFER_SIZE = 8;

  input clock;
  input sig_Full;
  input write_Enable;
  input [BUFFER_WIDTH-1:0] write_Pointer;
  input [BUFFER_WIDTH-1:0] read_Pointer;
  input [DATA_WIDTH-1:0] buffer_Input;
  output [DATA_WIDTH-1:0] buffer_Output;
  reg  [DATA_WIDTH-1:0] buffer [BUFFER_SIZE-1: 0];
  
  reg [DATA_WIDTH-1:0] buffer_Output;
  always @(posedge clock) begin
    buffer_Output = buffer [read_Pointer];
    if( write_Enable  & !sig_Full)
      buffer[write_Pointer ] <= buffer_Input;
  end
  
endmodule 
