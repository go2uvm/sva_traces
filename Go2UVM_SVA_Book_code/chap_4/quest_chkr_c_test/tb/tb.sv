module top1;
   
    bit clk, a, b, d;
    int min, max;  
    logic[7:0] addr; 
    logic[MEM_DATA_WIDTH-1:0] data; 
    logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem; 
    logic [2:0] a3, b3; 
     
 top2 dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
    
    
endmodule : top1
//
