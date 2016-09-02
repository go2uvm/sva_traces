module top2;
  timeunit 1ns;
  timeprecision 1ns;

logic clk,reset_n;
logic   [(width1 - 1):0] test_expr1;
  default clocking cb @ (posedge clk);
  endclocking : cb
  
  initial forever #10 clk <= ~clk;

  initial begin : test
    reset_n  = 0;
    ##10 reset_n = 1'b1;
    ##1 test_expr1--;
    ##1 test_expr1--;
    test_expr1 = 10;
    ##1 test_expr1--;
    ##1 test_expr1--;
    ##10;
    $finish;
    
  end : test



 k dut (.*);
  
        
endmodule : top2

