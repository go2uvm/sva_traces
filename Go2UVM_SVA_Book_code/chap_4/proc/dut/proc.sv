module proc(input clk,clk2,a=0,b=1,c=1,d,e,f);
       always @ (posedge clk) begin 
        if(a) begin : if1
            ap_clk:  assert property(@ (posedge clk)   b |=> c);
            ap_clk2: assert property(@ (posedge clk2)  b |=> c);
        end : if1
    end
  // test
//    task tsk(); // ** Error: proc.sv(17): Concurrent assertions are not allowed in tasks/class methods.
//        @ (posedge clk) begin 
//            if(a) begin : if1
//                ap_clktsk:  assert property(@ (posedge clk)   b |=> c);
//            end : if1
//            repeat(2) @ (posedge clk); 
//            ap_clk2tsk: assert property(@ (posedge clk2)  b |=> c);
//        end

//    endtask : tsk
endmodule : proc
