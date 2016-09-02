 //typedef enum {IDLE, STATE1, STATE2, STATE3}  state_enum;

module top1;
 logic clk,start; int i;  
  state_enum s_bits;

     unexpectedA_5_2 dut(.*);
 
       default clocking @(negedge clk); endclocking
   initial begin
    clk = 1'b1;
    forever #5 clk = ~clk;
  end

initial begin
    for (int i=1; i<=5; i=i+1) begin
      ##1;
      s_bits <= IDLE;
    end
 
    start <= 1'b1;
    ##1;
    s_bits <= STATE1;
    ##1;
    s_bits <= STATE2;
    ##1;
    repeat (100)##1;
    $stop;
  end // initial

    
    
endmodule : top1
//
