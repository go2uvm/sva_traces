module top1;
    bit [2:0] a; 
    bit clk; 
    initial forever #10 clk=!clk; 

m_unique dut(.*);

default clocking @ (posedge clk);
endclocking
 
  
endmodule : top1
