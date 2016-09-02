typedef enum {DISARMED=0, ARMED=1 } relay_state_e;
module expect_test(input clk,go,ready,relay, output abort);
    
    reg temp;
    initial @ (posedge go) 
        xp: expect (@ (posedge clk) 
        ready && relay==DISARMED) else temp <= 1'b1;
        
   assign abort=temp;

endmodule : expect_test
