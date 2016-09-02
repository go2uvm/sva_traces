module top1;
 parameter IDLE = 2'b00;
  parameter STATE1 = 2'b01;
  parameter STATE2 = 2'b10;
  parameter STATE3 = 2'b11;

 logic clk,start; 
    logic[1:0]s_bits;  
    initial forever #10 clk=!clk; 
 unexpectedB_5_2 dut(.*);
 
      initial begin
	clk = 1'b1;
	start = 1'b0;
	s_bits=IDLE;
	forever #5 clk = ~clk;
  end
  default clocking @(negedge clk); endclocking
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
  end

    
    
endmodule : top1
//
