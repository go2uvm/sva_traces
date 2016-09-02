// For example, in a write-back policy-based cache coherency controller, 
// once a write request to an address is found in the cache (i.e. a write hit), 
// the following sequences of events should occur (possibly at varied time intervals):
// •   The line is marked as “dirty”.
// •   Any other caches having a copy of this address shall mark their copies as invalid.
// •   Eventually, the dirty line shall be cleaned – i.e. modified data shall be written back to main memory.

module top1;
     typedef bit[15:0] data_t;

    `define DIRTY 1'b0
    `define INVALIDATE 1'b0
  bit[9:0]addr_write;
  data_t wr_data;
  data_t[0:1023] cache,remote_cache;
 logic clk,bus_req,ack,wr,cache_hit;
 
    cache_wr_hit dut (.*);

    default clocking @(posedge clk);
    endclocking 
    endmodule : top1               
