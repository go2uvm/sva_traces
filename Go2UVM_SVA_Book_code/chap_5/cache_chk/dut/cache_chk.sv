module cache_chk (input clk, snoop, hit_modified, writeback);
    apCacheSnoopWriteback: assert property (@ (posedge clk) 
        snoop && hit_modified |-> ##[1:5] writeback);
endmodule : cache_chk

module rtl_1(
    input snoop, hit_modified, writeback, clk,
    output fetch, wr,rd);
    logic a;
//default clocking cb_clk @ (posedge clk);  endclocking 
    always @(posedge clk) begin
        if(a) 
            if(fetch) begin 
                // rtl code
            // cache_chk cache_chk1(.*); // ILLEGAL 
                a <= 1'b1; 
            end 
    end
    assign rd=a;
        // The only legal choice 
         cache_chk cache_chk1(.*); 
endmodule : rtl_1
