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
module switch(input clk=1,switch_enb=0, done=1,input [1:0] switch_select=2'b00, lock_enb=2'b00);
    timeunit 1ns;
    timeprecision 1ns;
     
    property p_switch; 
        if (switch_enb)
            if (switch_select inside{2'b00, 2'b01, 2'b10, 2'b11}) 
                if  (switch_select ==2'b00 && $past(switch_select==2'b11)) // from 11 to 00
                    ##1  lock_enb[*1:10] ##1 done      // NO ";"
                else lock_enb[*1:2] ##1 done; 
    endproperty : p_switch 
  
    mp_switch : assume property (@ (posedge clk) p_switch);

    property p_switch_prop; 
        if (switch_enb)
            if (switch_select inside{2'b00, 2'b01, 2'b10, 2'b11} && switch_enb) 
                if  (switch_select ==2'b00 && $past(switch_select==2'b11)) // from 11 to 00
                    ##1  lock_enb[*2:10] ##1 done 
                else lock_enb[*1:2] ##1 done; 
    endproperty : p_switch_prop

   
    property p_switch_prop_in_simulation; 
        if (switch_enb)
            if (switch_select inside{2'b00, 2'b01, 2'b10, 2'b11})
                if  (switch_select ==2'b00 && $past(switch_select==2'b11)) // from 11 to 00
                    ##1  lock_enb[*1:10] ##1 done 
                else lock_enb[*1:2] ##1 done; 
    endproperty : p_switch_prop_in_simulation
    ap_switch_prop_in_simulation: assert property(@(posedge clk)p_switch_prop_in_simulation);
  
  
endmodule : switch

    

