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
module test(input clk,go,input int data,addr);
timeunit 1ns;
timeprecision 100ps;
  //int data, addr;
 //logic go, clk=1;

  sequence q_data  (data,      // Untyped local variables used as input arguments only
                                  addr,      // Untyped local variables used as input arguments only
                                 lv_data,   // Untyped local variables
            lv_addr); // Typed local variables in the port list
//         local input int lv_addr); // Typed local variables in the port list


    int v_data;      // Typed local variable declared in the assertion variable declaration section
           (1, lv_addr=addr, lv_data= data) ##1  // assignments to local variables 
            (addr==lv_addr+1) && (data==lv_data+1);   // comparison tests 
  endsequence :q_data

  property p_test(data, addr);
	int v_datap, v_addrp;
	(go, v_addrp=addr, v_datap=data)  |=> q_data(.data(data),  
                                                 			  .addr(addr), 
                                                			  .lv_data(v_datap), 
                                                			  .lv_addr(v_addrp));
  endproperty :p_test

 ap_test : assert property(@ (posedge clk) p_test(data, addr) );
endmodule : test
