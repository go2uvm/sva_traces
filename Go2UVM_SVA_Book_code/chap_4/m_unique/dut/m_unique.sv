module m_unique(input [2:0]a,input clk);
    
    
    always @(posedge clk) begin
        $display("unique 0,1,2,4 %t a=%d", $time, a); 
        unique if ((a==0) || (a==1)) $display("0 or 1");
        else if (a == 2) $display("2");
        else if (a == 4) $display("4"); // values 3,5,6,7 cause a violation report

        $display("priority 0,1,2,3 %t a=%d", $time, a); 
        priority if (a[2:1]==0) $display("0 or 1");
        else if (a[2] == 0) $display("2 or 3");
        // else $display("4 to 7"); // covers all other possible values,

        // If the keyword unique0 is used, there shall be no violation if no condition is matched. For example:
        //unique0 if ((a==0) || (a==1)) $display("0 or 1");
        //else if (a == 2) $display("2");
        //else if (a == 4) $display("4"); // values 3,5,6,7
        // cause no violation report
        
        
        $display("unique 0,1 %t a=%d", $time, a); 
        unique if ((a==0) || (a==1)) $display("0 or 1");
        else if (a == 1) $display("1b");
        else if (a == 0) $display("0b"); // values 3,5,6,7 cause a violation report
    end

    /*always_ff @ (posedge clk)  begin : aly 
        if(!randomize(a))  $error("randomization failure"); 
    end  : aly*/
endmodule : m_unique
