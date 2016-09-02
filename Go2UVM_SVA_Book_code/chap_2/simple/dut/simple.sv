module simple(input clk, req, ack, done, crc_pass, crc_err, busy=1, ready=0, reset, x, a=0, b0, b, c, d, x1=0, x0=0, a1=1,a2=1 , a0, a4, a5, reset_n, input int i, j 
 );
    
   
   // default disable iff  (reset);
    
    ap1: assert property(@(posedge clk)a1 ##[1:2] a2 |=> a1);
    always begin
        @ (posedge clk); 
        aim1: assert(a);
        //a2 <= a0; 
    end

    always_comb begin
       // x1=0;
        aim1b: assert(a);
        if(a) 
        ap12: assert property(@(posedge clk)a1 ##[1:2] a2 |=> a1);
    end




endmodule : simple
