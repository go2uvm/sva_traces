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
module x(input clk,a,b);
  timeunit 1ns;
  timeprecision 1ns;	 
  //logic clk, a, b;
  sequence q_ab;
	  @ (posedge clk) a ##1 b;
  endsequence : q_ab

    sequence q_ab2(q, x);
	    q ##1 x;
    endsequence : q_ab2

      //  checker a_chk(seq, prop, req, ack,  event clk);
      ap_q_ab2: assert property( @ (clk) q_ab2(q_ab, b));
	      property p;
	        b |=> q_ab;
	      endproperty : p
          //  endchecker : a_chk

          

          endmodule : x

