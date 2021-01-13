module Compare_Logic(
  clock,
  reset,
  write_Pointer,
  read_Pointer,
  write_Enable,
  read_Enable,
  sig_Full,
  sig_Empty,
  counter,
  );

  parameter BUFFER_WIDTH = 3;
  parameter BUFFER_SIZE = 8;

  input clock;
  input reset;
  input [BUFFER_WIDTH-1:0] write_Pointer;
  inout [BUFFER_WIDTH-1:0] read_Pointer;
  input write_Enable;
  input read_Enable;
  output reg sig_Full;
  output reg sig_Empty;
  output reg [BUFFER_WIDTH-1:0] counter;         
  
  always @(counter) begin
    sig_Empty = (counter==0);
    sig_Full = (counter== BUFFER_SIZE);
  end

  always @(posedge clock or negedge reset) begin
    if( !reset )
      counter <= 0;
    else if(!sig_Full && write_Enable )
      counter <= counter + 1;
    else if(!sig_Empty && read_Enable )
      counter <= counter - 1;
    else
      counter <= counter;
  end

endmodule  
