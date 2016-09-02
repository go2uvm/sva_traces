module top1;
    bit clk, req, ack, done, fetch, cache_hit, data_ready; 
    default clocking cb_clk @ (posedge clk);    
    endclocking 

    initial forever #10 clk=!clk; 
 or_vacuity dut(.*);
    initial  begin
        @ (posedge clk) req <= 1'b1; 
        repeat (1) @ (posedge clk); 
        req <= 0; 
        @ (posedge clk) ack <= 1'b1; 
        repeat(2) 
        @ (posedge clk); 
        done <= 1'b1; 
        @ (posedge clk); 
        $display ("end of sim"); 
    end
          
endmodule :  top1
  
