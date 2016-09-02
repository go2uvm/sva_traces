module top1;
   logic clk, reset_n=1'b1,dma_req, data_transfer,done; 

   // Instantiate the DUT
   
   accept_test dut (.*);
   
   default clocking cb_clk @ (posedge clk);
   endclocking

   
    always begin
        @ (posedge clk);
        @ (posedge clk);
        dma_req <= 1'b1; 
        data_transfer <=1'b1; 
        repeat (5) @ (posedge clk);
        done <= 1'b1; 
        repeat (5)   @ (posedge clk);    
        done <= 1'b0; 
        dma_req <= 1'b0; 
    end

    
endmodule : top1
