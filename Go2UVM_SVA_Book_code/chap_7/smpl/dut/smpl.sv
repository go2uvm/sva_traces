module smpl(input clk,c,output logic b,a);  
    //bit clk, a, b, c; 
    //initial forever #10 clk=!clk;
    always @ (posedge clk)  begin : aly 
        automatic bit v; 
        v=!a;
        b <= v;
        
        // ap_ab: assert property(!a |-> $past(v));
        ap_ab1: assert property(!a |-> $past(b));
        a <= !a;
           end : aly 

endmodule : smpl
// WORKS OK with line 8 commented out
//run 199ns
//# ** Fatal: (SIGSEGV) Bad handle or reference.
//#    Time: 0 ns  Iteration: 0  Process: /smpl File: smpl.sv
//# Fatal error in Module smpl in file smpl.sv
//# 
//# Fatal error reported during simulation. Cannot run 'fcover' command. Please look above output for the fatal error message(s).
//#  
//# Fatal error reported during simulation. Cannot run 'fcover' command. Please look above output for the fatal error message(s).
//#  
