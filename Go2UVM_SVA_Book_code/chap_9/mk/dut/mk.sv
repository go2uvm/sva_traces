module mk(input clk,clk0, clk2, a0, a1, b, c, d);
   // bit clk0, clk2, a0, a1, b, c, d; 
    ap_a0a1: assert property(@(posedge clk0) a0 |-> @(posedge clk2) a1);    
    ap_a0_next_a1: assert property(@(posedge clk0) a0 |=> @(posedge clk2) a1);  
    
    // task_description 
    //task tsk();
        //@ (posedge clk0)
 ap1: assert property (@(posedge clk)a0 |=> b);//Cannot use SVA concurrent assertion inside task
        
  // endtask : tsk  
endmodule : mk
