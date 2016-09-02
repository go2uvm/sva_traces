
module case_test; //--
    logic clk, ack1, ack2, req1, req2, bus_switch, b;
    logic[1:0] bus_select;
    default clocking cb_clk @ (posedge clk); endclocking
    property p; @ (posedge clk) b; endproperty : p
    ap_active_bus : assert property(
        disable iff (bus_switch)
        if (bus_select) p
        // $rose(req1) |-> ##[1:5] ack1
        else  p); // $rose(req2) |-> ##[1:5] ack2);
endmodule : case_test

module unique_m(input clk,b,output [3:0]a);
reg temp;
        always_ff @ (posedge clk)  begin : aly 
        unique if ((a==0) || (a==1)) $display("a=%d a, should be 0 or 1", a);
        else if (a == 2) $display("a=%d a, should be 2", a);
        else if (a == 4) $display("a=%d a, should be 4", a); // values 3,5,6,7 cause a violation report
        priority if (a[2:1]==0) $display("a=%d a, priority should be0 or 1", a);
        else if (a[2] == 0) $display("a=%d a, priority should be 2 or 3", a);
        else $display("a=%d a, priority should be 4 to 7", a); // covers all other possible values,
// so no violation report
//If the keyword unique0 is used, there shall be no violation if no condition is matched. For example:
//        unique0 if ((a==0) || (a==1)) $display("0 or 1");
//        else if (a == 2) $display("2");
//        else if (a == 4) $display("4"); // values 3,5,6,7
// cause no violation report
    end  : aly

    always @(negedge clk) begin
        temp <= a+1'b1; 
assign temp=a;
    end

    property p; @ (posedge clk) b; endproperty : p


    property foo; @ (posedge clk)
            case (a)
                1:  b;
                2:  p;
                default:  p;
            endcase;
    endproperty : foo

endmodule : unique_m
