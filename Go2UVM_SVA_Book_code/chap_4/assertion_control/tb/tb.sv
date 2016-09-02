module top1;
    logic clk, a, b, c, d;
    event start_sim; 
    int count1=0,count2=0; 
  test dut (.*);
default clocking cb @(posedge clk);
endclocking:cb
endmodule:top1

