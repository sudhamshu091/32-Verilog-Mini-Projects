module Read_Interface(
  clock,
  reset,
  read_Enable,
  sig_Empty,
  read_Pointer
  );

  parameter BUFFER_WIDTH = 3;
  input clock;
  input reset;
  input read_Enable;
  input sig_Empty;
  output [BUFFER_WIDTH-1:0] read_Pointer;
  
  reg[BUFFER_WIDTH-1:0] read_Pointer; 
  wire fifo_Read_Enable;

  assign fifo_Read_Enable = (~sig_Empty)& read_Enable;  
  always @(posedge clock or negedge reset) begin  
    if(~reset)
      read_Pointer <= 0;  
    else if(fifo_Read_Enable)  
      read_Pointer <= read_Pointer + 1;  
  end 

endmodule  
