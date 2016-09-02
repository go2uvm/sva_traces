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
*/
module  count_err(input clk,logic [3:0] count=4'b0000, logic [3:0] prevcount=4'b1111);
reg temp; // logic clk=1'b1;
  //logic [3:0] count=4'b0000, prevcount=4'b1111;
  always @ (posedge clk) begin
    if (count == (prevcount + 1))     $display("case 1");
    if (count == (prevcount + 1'b1))  $display("case 2");
    if (count == 4'(prevcount + 1))   $display("case 3");
    $display ("count == (prevcount + 1) = %b", (prevcount + 1));
    $display("count == (prevcount + 1'b1) = %b", (prevcount + 1'b1));
    $display("count == 4'(prevcount + 1) = %b", 4'(prevcount + 1));
    temp <= count+1'b1;
   assign temp=count;
end 

  ap_case1 : assert property(@ (posedge clk) (count == (prevcount + 1)));
  ap_case2 : assert property(@ (posedge clk) (count == (prevcount + 1'b1)));
  ap_case3 : assert property(@ (posedge clk) (count == 4'(prevcount + 1)));

 // initial forever #50 clk=!clk; 
endmodule : count_err 

