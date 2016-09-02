//typedef enum {BK_RED , BK_GREEN, BK_BLUE } colors_e;

module types1;
    logic clk, a, b, rd; 
    real r, y; 
    string s, g; 
    realtime rtime;
    time t;  
    int mem_aarray; // associative array (AA) to be used by property
     logic [31:0] rdata;  // data read from memory
    logic read;  // memory read
    logic[31:0] wdata, foo, bar; // data written to memory
    logic[3:0]  addr;   
  types dut(.*);
    initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);
    endclocking 
   endmodule : types1
