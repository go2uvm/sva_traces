module top2;
  timeunit 1ns;
  timeprecision 1ns;
bit clk, a,b,c,d;  

default clocking @(negedge clk); endclocking
 

 k dut (.*);
  
initial clk <= ~clk;

  initial begin : stim
    
    @(negedge clk);
    {a,b,c,d} <= 4'b1000;
    @(negedge clk);
    {a,b,c,d} <= 4'b0100;
    @(negedge clk);
    {a,b,c,d} <= 4'b0000;

    repeat (10) @(negedge clk);
    {a,b,c,d} <= 4'b0010;
     @(negedge clk);
    {a,b,c,d} <= 4'b0001;
    repeat (10) @(negedge clk);
    $finish;
    
  end : stim

        
endmodule : top2

