module top1;
 logic clk, clk2, a, b, c, d, e, f; 
    initial forever #10 clk=!clk;
    initial forever #13 clk2=!clk2; 

 
 proc dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
      initial begin
        @ (posedge clk) #2 a<=1; 
        @ (posedge clk) #1 a<=0; b <=1; c<=0;  
    end  
    
    initial begin
        fork
            begin
                c <= 1; 
                @ (posedge clk);
            end
            begin
                @ (posedge clk); 
                d <= 1; 
            end
        join
    end
 
    
endmodule : top1
//
