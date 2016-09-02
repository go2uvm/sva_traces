module top2;
  timeunit 1ns;
  timeprecision 1ns;
bit clk, rd, wr;
    int min=1, max=100;  
    logic[7:0] addr; 
    logic[DATA_WIDTH-1:0] rd_data, wr_data; 
    logic [(SIZE-1):0] [DATA_WIDTH-1:0]  mem; 
   
 default clocking cb_clk @ (posedge clk); endclocking 
     

top5 dut (.*); 
     

endmodule : top2

