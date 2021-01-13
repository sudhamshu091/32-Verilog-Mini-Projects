module Fifo_Memory(
  clock,
  reset,
  write_Enable,
  read_Enable,
  buffer_Input,
  buffer_Output,
  sig_Full,
  sig_Empty
  ); 

  parameter BUFFER_WIDTH = 3;
  parameter DATA_WIDTH = 8;
  parameter BUFFER_SIZE = 8;

  input clock;
  input reset;
  input write_Enable;
  input read_Enable;
  input [DATA_WIDTH-1:0] buffer_Input;
  output [DATA_WIDTH-1:0] buffer_Output;
  output sig_Full;
  output sig_Empty;
  
  
  wire sig_Full;
  wire sig_Empty;
  wire [BUFFER_WIDTH-1:0] read_Pointer;
  wire [BUFFER_WIDTH-1:0] write_Pointer;
  wire [DATA_WIDTH-1:0] buffer_Output;
  wire [BUFFER_WIDTH-1:0] counter;         

  Write_Interface #(.BUFFER_WIDTH(3))write_interface(
    .clock(clock),
    .reset(reset),
    .write_Enable(write_Enable),
    .sig_Full(sig_Full),
    .write_Pointer(write_Pointer)
    );


  Memory_Array #(.BUFFER_WIDTH(3),
                 .DATA_WIDTH(8),
                 .BUFFER_SIZE(8))
    memory_array(
      .clock(clock),
      .write_Enable(write_Enable),
      .write_Pointer(write_Pointer),
      .sig_Full(sig_Full),
      .read_Pointer(read_Pointer),
      .buffer_Input(buffer_Input),
      .buffer_Output(buffer_Output)
    );


  Read_Interface #(.BUFFER_WIDTH(3))read_interface(
    .clock(clock),
    .reset(reset),
    .read_Enable(read_Enable),
    .sig_Empty(sig_Empty),
    .read_Pointer(read_Pointer)
    ); 


  Compare_Logic #(.BUFFER_WIDTH(3),
                 .BUFFER_SIZE(8))
    compare_logic(
      .clock(clock),
      .reset(reset),
      .write_Pointer(write_Pointer),
      .read_Pointer(read_Pointer),
      .write_Enable(write_Enable),
      .read_Enable(read_Enable),
      .sig_Full(sig_Full),
      .sig_Empty(sig_Empty),
      .counter(counter)
    );

endmodule  
