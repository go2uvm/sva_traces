module static_auto(input clk,input [8:0]data=9'b000000101);
       always_ff @ (posedge clk) begin
        $display("@ %t  data=%b", $time, data); 
        for (int i=0; i<3; i++) begin
            automatic int auto_lp = 0; // executes every loop
            for (int j=0; j<3; j++) begin
                $display("auto_lp %d data[auto_lp]= %b", 
                                       auto_lp, data[auto_lp]);
                ap_data012: assert property(data[auto_lp]==1'b1); // will only address bits 0, 1, 2
                auto_lp++;
            end
        end // prints 1 2 3 1 2 3 1 2 3
        for (int i=0; i<3; i++) begin
            static int static_lp = 0; // executes once before time 0
            for (int j=0; j<3; j++) begin
                $display("$sampled(static_lp) %d data[$sampled(static_lp)]= %b", 
                                   $sampled(static_lp), data[$sampled(static_lp)]);
                ap_data0to8: assert property(data[static_lp]==1'b1); 
                    // will  address bits sampled values of static_lp 0, 9, 18
                static_lp++;
            end
        end // prints 1 2 3 4 5 6 7 8 9
        
        for (int i=0; i<3; i++) begin
            static int static_lp = 0; // executes once before time 0
            for (int j=0; j<3; j++) begin
                $display("const'(static_lp) %d data[const'(static_lp)]= %b", 
                                   (static_lp), data[(static_lp)]);
                ap_const_static_lp: assert property(data[(static_lp)]==1'b1); //const'
                    // will  address bits current values of static_lp 0, 9, 18
                static_lp++;
            end
        end // prints 1 2 3 4 5 6 7 8 9
        
    end
endmodule : static_auto

