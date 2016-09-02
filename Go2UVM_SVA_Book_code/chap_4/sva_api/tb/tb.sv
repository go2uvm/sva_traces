module top2;
  timeunit 1ns;
  timeprecision 1ns;
logic rst, clk;
  

 

 k dut (.*);


initial begin
clk = 1'b0;
forever #10 clk = ~clk;
end



initial begin
rst = 1'b0;
@(posedge clk);
@(posedge clk);
rst = 1'b1;
@(posedge clk);
@(posedge clk);
rst = 1'b0;
@(posedge clk);
@(posedge clk);
  $display ("End");
  $finish;
end

  
        
endmodule : top2

