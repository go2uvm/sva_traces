module top1;
 logic a, b, c, d, clk; 
    logic[3:0] v; 
 
 mx dut(.*);
 
      default clocking cb_clk @ (posedge clk);  endclocking    
     initial begin 
        repeat (10) begin 
            #10  if(!randomize(a, b, v))  $error("randomization failure"); 
        end
    end
 
endmodule : top1
//
