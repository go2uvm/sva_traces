module test(input clk,a,b,c,d,input event start_sim,input int count1,count2);
     
// now define lets to make the code more readable
    let LOCK = 1;
    let UNLOCK = 2;
    let ON = 3;
    let OFF = 4;
    let KILL = 5;
    let CONCURRENT = 1;
    let S_IMMEDIATE = 2; // simple immediate
    let D_IMMEDIATE = 12; // Final and Observed deferred immediate
    let EXPECT = 16;
    let ASSERT = 1;
    let COVER = 2;
    let ASSUME = 4;
    let ALL_DIRECTIVES = (ASSERT|COVER|ASSUME);
    let ALL_ASSERTS = (CONCURRENT|S_IMMEDIATE|D_IMMEDIATE|EXPECT);
    let VACUOUSOFF = 11;
    a1: assert property (@(posedge clk) a |=> b) $info("assert passed");
    else $error("assert failed");
    c1: cover property (@(posedge clk) a ##1 b);
    always @(posedge clk) begin
        ia1: assert (a);
    end
    always_comb begin
        if (c)
        df1: assert  (d);
    end
    function automatic void pass();
        $display("ap1 pass"); 
    endfunction : pass
    function automatic void fail();
        $display("ap1 fail"); 
    endfunction : fail
    ap1: assert property(@ (posedge clk) 
        a |-> b) pass(); else fail();

    initial begin
// the following systasks affect the whole design so no modules
// are specified
// disable vacuous pass action for all the concurrent asserts,
// covers and assumes in the design. Also disable vacuous pass
// action for expect statements.
    $assertcontrol(VACUOUSOFF, CONCURRENT | EXPECT);
// disable concurrent and immediate asserts and covers.
// The following systask does not affect expect
// statements as control type is Off.
    $assertcontrol(OFF); // using default values of all the
// arguments after first argument
// After 20 time units, enable assertions.
// explicitly specifying second, third and fourth arguments
// in the following task call
    #20 $assertcontrol(ON, CONCURRENT|S_IMMEDIATE|D_IMMEDIATE,
    ASSERT|COVER|ASSUME, 0);
// kill currently executing concurrent assertions after
// 100 time units but do not kill concurrent covers/assumes
// and immediate/deferred asserts/covers/assumes
// using appropriate values of second and third arguments
    #100 $assertcontrol(KILL, CONCURRENT, ASSERT, 0);
// the following assertion control task does not have any effect as
// directive_type is assert but it has selected cover directive c1
   // #10 $assertcontrol(ON, CONCURRENT|S_IMMEDIATE|D_IMMEDIATE, ASSERT, 0, c1);
// now, after 10 time units, enable all the assertions except a1.
// To accomplish this, first we’ll lock a1 and then we’ll enable all
// the assertions and then unlock a1 as we want future assertion
// control tasks to affect a1.
   // #10 $assertcontrol(LOCK, ALL_ASSERTS, ALL_DIRECTIVES, 0, a1);
    $assertcontrol(ON); // enable all the assertions except a1
  //  $assertcontrol(UNLOCK, ALL_ASSERTS, ALL_DIRECTIVES, 0, a1);
   // if(!obj.randomize()) 
   //     `uvm_error("run_phase", "seq randomization failure"); 
end
// ap_x1: assert property(Px1) count1 <= count1 + 1'b1; // pass action block increments variable 
// ap_x2: assert property(Px1) count2 <= count2 + 1'b1; // pass action block increments variable 
initial begin
    $assertcontrol(KILL);
   // wait (start_sim); 
    $assertcontrol(ON);
    // Optional if pass action does not update 
  //  $assertcontrol(LOCK, ALL_ASSERTS, ALL_DIRECTIVES, 0, ap_x1, ap_x2);
    //$assertcontrol(PASSOFF);
    //$assertcontrol(UNLOCK, ALL_ASSERTS, ALL_DIRECTIVES, 0, ap_x1, ap_x2);
  //  if (!req.randomize()) `uvm_error("MYERR", "This is a randomize error");
end
endmodule:test
