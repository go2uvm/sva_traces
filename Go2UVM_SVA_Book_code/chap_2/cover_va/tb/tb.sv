module top1;
   logic  a , b, c,  clk;
   // Instantiate the DUT
   
   cover_va dut(.*);
  default clocking cb_clk @ (posedge clk);
   endclocking
 
     initial  begin
     repeat(4)##1;
     a <= !a;
     ##1;
     ##1;
     ##1;
     ##1;
     b <= !b;
     ##1;
     ##1; 
     ##5; $finish;//CVC change added current line	
end 
      
endmodule : top1
