//
module or_multi(input clk,clk2,a=0,b=0,c=1,d,e);

       ap_1: assert property(@(posedge clk)
        ($rose(a) ##[1:5] b) or 
        ($rose(a) ##[1:2] c)  |-> 1
        );
    ap_b: assert property(@(posedge clk)
        ($rose(a) ##[1:5] b) and 
        ($rose(a) ##[1:2] c) |-> 1
        );

  apxx: assert property(@ (posedge clk) e |-> (a ##1 b) intersect (@ (posedge clk) c ##1 d)); 
  apxx2: assert property(@ (posedge clk2) e |-> a ##1 b intersect @ (posedge clk2) c ##1 d); 
      
   
endmodule : or_multi
