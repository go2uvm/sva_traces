module m18(input clk, reset_n, system_ready);
    //bit clk, reset_n, system_ready; 
    
    initial begin 
      wait(system_ready);
//      a1: assume property(
//         first_match(!reset_n[*50:100] ##1 reset_n) |-> always reset_n);
//      // can also use the following tha has no range restriction 
      a2_reset: assume property (@(posedge clk)$rose(reset_n) |-> reset_n[*1:$]); // always (reset_n););
      a3: assume property(@(posedge clk)
         first_match(!reset_n[*50:100] ##1 reset_n) |-> reset_n[*1:$]);
    end
    
    

endmodule : m18
