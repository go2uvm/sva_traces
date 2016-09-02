module top1;
timeunit 1ns;
  timeprecision 1ns;
  logic clk, req, ack;
   future_gclk_test dut (.*);
  default clocking @(posedge clk);
 endclocking


  initial begin : stim
    ##100;
    @(negedge clk);
    {req, ack} <= 2'b11;
    @(negedge clk);
    {req, ack} <= 2'b00;
    ##10;
    @(negedge clk);
    {req, ack} <= 2'b10;
    @(negedge clk);
    {req, ack} <= 2'b01;
    @(negedge clk);
    {req, ack} <= 2'b00;
    ##10;
    $finish;
  end : stim

endmodule : top1
 
