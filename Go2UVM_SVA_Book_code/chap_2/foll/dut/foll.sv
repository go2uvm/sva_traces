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
module p_switch(input clk,switch_enb,done,input [1:0] switch_select,lock_enb);
  timeunit 1ns;
  timeprecision 1ns;

  
  property p_switch_prop; 
    if (switch_enb)
   //   if (switch_select dist{2'b00:= 1, 2'b01 := 4, 2'b10:= 3, 2'b11:=2}) 
        if  (switch_select ==2'b00 && $past(switch_select==2'b11)) // from 11 to 00
               ##1  lock_enb[*1:10] ##1 done      // NO ";"  ê
        else lock_enb[*1:2] ##1 done; 
  endproperty : p_switch_prop 
  
mp_switch_prop : assume property (@ (posedge clk) p_switch_prop);

endmodule : p_switch
