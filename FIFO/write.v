module Write_Interface(
    clock,
    reset,
    write_Enable,
    sig_Full,
    write_Pointer
    );

    parameter BUFFER_WIDTH = 3;
    input clock;
    input reset;
    input write_Enable;
    input sig_Full;
    output [BUFFER_WIDTH-1:0] write_Pointer;
    
    reg [BUFFER_WIDTH-1:0] write_Pointer;  
    wire fifo_Write_Enable;

    assign fifo_Write_Enable = (~sig_Full) & write_Enable;  
    always @(posedge clock or negedge reset) begin  
        if(~reset)
            write_Pointer <= 0;  
        else if(fifo_Write_Enable)  
            write_Pointer <= write_Pointer + 1;     
    end 

endmodule  
