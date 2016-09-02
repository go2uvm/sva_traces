module m_expect(input clk,output t,input go,ready,input [1:0] req,ack);
    int pri_level;
    reg t; 
    integer data;  
   /* task automatic wait_for( integer value, output bit success );
        expect( @(posedge clk) ##[1:10] data == value ) success = 1;
            else success = 0;
    endtask
*/

    property p_reqack (bit [1:0] i);
        req[i]  ##1 ack[i];
    endproperty : p_reqack
    sequence q_go;  @ (posedge clk) ready ##1 go; endsequence :q_go
    // ap_q_go: assert property(q_go);
    always @ (q_go) begin : a1
        t <= 0; 
        for (int i=0; i<=3; i++) begin : loop_priority
            pri_level <= i;  //start with low priority 
            // Evaluation of property p_reqack  starts at next  clocking event with the expect
            ae_reqack: expect (@ (posedge clk) p_reqack(pri_level)) 
            begin // Pass action block 
                t <= 1;  
                $display ("%t expect PASS i= %d", $time, i);
                disable a1; // pass action block
            end 
            // if pass (truly or vacuously), then exit the loop block, 
else $display ("%t expect FAIL i= %d", $time, i);  // Fail action block, shown for demonstration since the 
// desired action is to continue the loop, which raises the priority level in the loop and restarts.
        end : loop_priority
    end : a1   
    endmodule : m_expect

