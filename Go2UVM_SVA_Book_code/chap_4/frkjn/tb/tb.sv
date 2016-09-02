module top1;
    parameter CACHE_SIZE = 8;
    parameter MEM_DATA_WIDTH    = 8;

   
    int st0; // static
    logic clk, a, b;
    int k; // Illegal use of 'automatic' for variable declaration (k).
    logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem ; // cache data storage 
     
 msl dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking 
    /* initial begin
            aly.st = 0; 
            aly.au1 =0; 
        end*/

    
endmodule : top1
//
