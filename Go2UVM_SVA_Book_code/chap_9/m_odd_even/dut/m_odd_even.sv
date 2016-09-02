module m_odd_even(input clk,req[], input ack[]);

//    If req[i] is true, then ack[i] is also true at the next cycle, provided the index i 
//    is odd (i.e., 1, 3, 5).  If req[j] is true, then ack[j] is false two cycles later, 
//    provided the index i is even (i.e., 2, 4, 6).  
   // bit clk;
    //logic[7:0] req=8'b10101010, ack=8'b11110000; 
 //   initial forever #10 clk=!clk; 
 //   default clocking cb_clk @ (posedge clk);  endclocking 
    always_ff @ (posedge clk)  begin : aly 
        for (int i=0; i<=7; i++) begin : for_loop// i is automatic 
            automatic int x; 
            x=i%2;  // $display("i=%d, pct_i=%d", i, x); 
            if (x==1) 
            ap_odd: assert property(req[i] |=> ack[i]);  
            else
            ap_even: assert property(req[i] |-> ##2 !ack[i]);          
        end : for_loop      
    end  : aly
    // Equivalent assertions
    generate for (genvar i=0; i<=7; i++) begin
            if (i%2==1) 
            ap_odd_g: assert property(@(posedge clk)req[i] |=> ack[i]);  
            else
            ap_even_g: assert property(@(posedge clk)req[i] |-> ##2 !ack[i]);  
    end          
    endgenerate
   
endmodule : m_odd_even
