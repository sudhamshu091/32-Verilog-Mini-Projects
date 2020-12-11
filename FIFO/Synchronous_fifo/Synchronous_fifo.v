module sync_fifo(clock, rd_en, wr_en, full, empty, data_in, data_out, rst);

#Constants
parameter WIDTH = 16;
parameter DEPTH = 16;
parameter POINTER_SIZE = 5;

#Port Declarations
input clock;
input rd_en;
input wr_en;
input rst;
input [WIDTH - 1 : 0] data_in;

output full;
output empty;
output [WIDTH - 1 : 0] data_out;

#Internal Registers and wires
wire full;
wire empty;
reg [WIDTH - 1 : 0 ] memory [0 : DEPTH - 1];
reg [POINTER_SIZE - 1 : 0] wr_ptr;
reg [POINTER_SIZE - 1 : 0] rd_ptr;
reg [WIDTH - 1 : 0] data_out;

#Asynchronous logic
empty = ((wr_ptr - rd_ptr) == 0) ? 1'b1 : 1'b0;   
full = ((wr_ptr - rd_ptr) == DEPTH) ? 1'b1 : 1'b0; 

#Synchronous logic
always@(posedge clock)
  begin
    if (rst == 1'b0)
      begin
        data_out <= 0;
        rd_ptr <= 0;
        wr_ptr <= 0;
      end
    else
      begin
        if (wr_en == 1'b1)  && (full == 1'b0)
          begin
          memory[wr_ptr] <= data_in;
          wr_ptr = wr_ptr + 1;
          end
        end
        
        if(rd_en == 1'b1) && (empty == 1'b0)
          begin
          data_ out <= memory[rd_ptr];
          rd_ptr <= rd_ptr + 1
          end
        end
      end
endmodule
      
