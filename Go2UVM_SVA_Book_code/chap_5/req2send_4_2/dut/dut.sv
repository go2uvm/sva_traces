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
module req2send_4_2(input clk, request, sent_data, received_data); 
  timeunit 1ns;
  timeprecision 100ps;
  
property p_req2send (a, b, c);
   @(posedge clk)     // at every clock 
      $rose(a) |=>  // if  a  then starting from next cycle 
      ##[0:10] b    //  either at this next cycle or up to 10 cycles later b must occur 
      ##2 c;  // c  must then occur 2 cycles later, after b 
 endproperty : p_req2send
 ap_req2send_1: assert property   (p_req2send(request, sent_data, received_data));


 property p_req2send_var (a, b, c, d, data, xbus);
   int v_data;   // Every thread maintains its own copy of the variable 
   @(posedge clk)     // at every clock 
      $rose(a) ##[1:5] (b, v_data=data) |=>  // if  a and later b, then variable v_data ==data
      ##[0:10] c  ##2 d && xbus==v_data;  // when d, then  xbus must equal to v_data 
 endproperty : p_req2send_var


endmodule : req2send_4_2

