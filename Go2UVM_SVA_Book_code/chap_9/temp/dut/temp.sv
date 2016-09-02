/*
    Code for use with the book
    
    "SystemVerilog Assertions Handbook, 2nd edition"ISBN  878-0-9705394-8-7

    Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2009 

    www.systemverilog.us  ben@systemverilog.us
    www.cvcblr.com, info@cvcblr.com

    All code provided in this book and in the accompanied website is distributed
    with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
    the authors nor any supporting vendors shall be liable for damage in connection
    with, or arising out of, the furnishing, performance or use of the models
    provided in the book and website.

module mk;
    bit clk0, clk2, a, b, c, d; 
    assert property(@(posedge clk0) a0 |-> @(posedge clk2) a1);    
    assert property(@(posedge clk0) a0 |=> @(posedge clk2) a1);   // 
    

endmodule : mk*/


module temp(input clk, a=1,b=1, input [3:0] i = 1, j = 1);
reg req,ack,status_reg,done;
    apReqAckDoneSuccess: assert property(@(posedge clk)
        first_match($rose(req) ##[1:5] ack ##[1:100] done)
            |-> (status_reg == 1'b0) );
    apReqAckDoneFail: assert property(@(posedge clk)
        $rose(req) |=> !done[*105] |-> (status_reg == 1'b1) );


    //logic a = 1, b = 1;
   // logic [3:0] i = 1, j = 1;
    initial begin
        $display("a=%b, b=%b, i=%b, j=%b", a, b, i, j);
        $display("!a=%b, ~b=%b, ~i=%b, j=%b", !a, ~b, ~i, j);
        $display("a&b=%b, a&&b=%b, i&j=%b, j=%b", a & b, a && b, i & j, j);
        ap_a_is1: assert (!a)  $info ("PASS !a -- a=%b, b=%b, i=%b, j=%b", a, b, i, j);
        else $info("FAIL !a -- a=%b, b=%b, i=%b, j=%b", a, b, i, j);
        ap_j_is1: assert (~j) $info("PASS ~j -- a=%b, b=%b, i=%b, ~j=%b", a, b, i, ~j);
        else $info("FAIL ~j -- a=%b, b=%b, i=%b, ~j=%b", a, b, i, ~j);
        ap_j_is1_logical: assert (!j) $info("PASS !j -- a=%b, b=%b, i=%b, !j=%b", a, b, i, !j
                );
        else $info("FAIL !j -- a=%b, b=%b, i=%b, j=%b", a, b, i, !j);
    end
endmodule


