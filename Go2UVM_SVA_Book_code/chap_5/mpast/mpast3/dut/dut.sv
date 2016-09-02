module top_illegal(input clk); // should not compile
    initial begin
        int svar2 = 2; // static/automatic needed to show intent
        for (int i=0; i<3; i++) begin
            int loop3 = 0; // illegal statement
            for (int i=0; i<3; i++) begin
                loop3++;
                $display(loop3);
            end
        end
    end
endmodule : top_illegal
