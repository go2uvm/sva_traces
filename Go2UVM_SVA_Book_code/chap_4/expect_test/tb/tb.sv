
module top1;
    typedef enum {DISARMED=0, ARMED=1 } relay_state_e;
    
    bit clk, go, ready, relay, abort; 
    initial forever #10 clk=!clk; 

expect_test dut(.*);

    initial begin
        #50 ready =1; 
        #6  relay = ARMED; 
        #10 go=1; 
    end


endmodule : top1
