module top1; 
  timeunit 1ns;   timeprecision 100ps;
  logic clk=0, reset_n=0, go = 0;
  int cntr =0;
 

 assertion_err dut(.*);
  default clocking cb @(posedge clk);
 endclocking:cb
  
  initial forever #50 clk=!clk;
  initial begin 
  repeat (2) @ (posedge clk);
    go <= 1'b1;
   end 

  endmodule : top1
// vlog -sv -O0 +acc=a assertion_err.sv
// vsim -novopt work.assertion_err  -voptargs=+acc -assertdebug
