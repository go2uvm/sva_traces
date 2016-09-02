
module top1;
logic clk,clk2,rst;
logic a,b,c,d,e;
      default clocking cb_clk @ (posedge clk);  
    endclocking 
    initial forever #10 clk=!clk;
    or_multi dut (.*);      
    initial begin
   
        @ (posedge clk) a <= 1'b1; 
    end

endmodule :top1
