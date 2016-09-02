module or_vacuity(input clk,req,done,fetch,cache_hit, ack,output data_ready);
   // bit clk, req, ack, done, fetch, cahe_hit, data_ready; 
   


    ap_or0: assert property(@(posedge clk)(0 |-> 1) or (req ##5 1));
    ap_or: assert property(@(posedge clk)req |=> (0 |-> 1) or (1 ##5 1));
    ap_or2: assert property(@(posedge clk)req |=> (0 |-> 1) or (1 ##5 0));
    ap_or3: assert property(@(posedge clk)req |=> (0 |-> 1) or (0 ##5 1));
    
    ap_reqack1_or_cache_hit: assert property(@(posedge clk)
      fetch |-> (req |-> ##[1:5] ack) or (cache_hit |=> data_ready));
        
endmodule : or_vacuity
