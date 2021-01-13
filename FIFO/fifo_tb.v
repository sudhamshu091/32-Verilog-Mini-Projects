module Fifo_Memory_tb();

    reg clock;
    reg reset;
    reg write_Enable;
    reg read_Enable;    
    reg [7:0] buffer_Input;

    wire [7:0] buffer_Output;
    wire sig_Full;
    wire sig_Empty;


    Fifo_Memory uut(
    .clock(clock),
    .reset(reset),
    .write_Enable(write_Enable),
    .read_Enable(read_Enable),
    .buffer_Input(buffer_Input),
    .buffer_Output(buffer_Output),
    .sig_Full(sig_Full),
    .sig_Empty(sig_Empty)
    );

    initial begin
    

        clock = 0;
        reset = 0;
        write_Enable = 1;
        read_Enable = 0;
        buffer_Input = 8'd1;
    end

endmodule 
