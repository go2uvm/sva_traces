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
// Upon a go, grant can only be given to the next requester 
// provided the requester wants access to the resource. There are 8 requesters.  
// If the requester with the potential grant does not want access to the
// resource, then there is no grant. In all cases, the potential 
// chance for access moves to the next requester.
module round_robin_chk1;
timeunit 1ns;
timeprecision 1ns; 
logic[7:0] req, grant;
 logic go,go_r,clk, reset_n;
  logic [2:0]     counter  ; 
 // logic         go_r =0;
round_robin_chk dut (.*);  
default  clocking cb @(posedge clk);endclocking   
 endmodule : round_robin_chk1          					   
