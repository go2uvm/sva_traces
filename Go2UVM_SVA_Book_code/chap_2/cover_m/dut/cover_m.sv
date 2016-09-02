module cover_m(input clk,a=1'b0,b=1'b1,acknowledge,done,reset_n);
      
    cp_ab: cover property (@(posedge clk) (a |=> b)); 
    cp_ab2: cover property (@(posedge clk)(a ##1 b)); 
    ap_ab: assert property (@(posedge clk) (a |=> b)); 
    ap_ab2: assert property (@(posedge clk) (a ##1 b)); 
endmodule : cover_m
