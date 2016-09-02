// For example, in a write-back policy-based cache coherency controller, 
// once a write request to an address is found in the cache (i.e. a write hit), 
// the following sequences of events should occur (possibly at varied time intervals):
// •   The line is marked as “dirty”.
// •   Any other caches having a copy of this address shall mark their copies as invalid.
// •   Eventually, the dirty line shall be cleaned – i.e. modified data shall be written back to main memory.
 typedef bit[15:0] data_t;

module cache_wr_hit(input clk,bus_req, ack,wr, cache_hit,input[9:0]addr_write, data_t wr_data,data_t[0:1023]cache,remote_cache);
    `define DIRTY 1'b0
    `define INVALIDATE 1'b0
     
   
    sequence q_wr_hit;
        @ (posedge clk) first_match(wr ##[1:2] cache_hit);
    endsequence : q_wr_hit

    sequence q_invalidate;
        bus_req ##[1:2] ack ##1 remote_cache[addr_write]== `INVALIDATE; 
    endsequence : q_invalidate

    ap_wr_hit: assert property(@(posedge clk)
        q_wr_hit.triggered |=> 
            first_match(cache[addr_write] == `DIRTY ##1 q_invalidate
      ##[1:$] cache[addr_write]==wr_data) |-> 
  remote_cache[addr_write]==wr_data 
        );
endmodule : cache_wr_hit
