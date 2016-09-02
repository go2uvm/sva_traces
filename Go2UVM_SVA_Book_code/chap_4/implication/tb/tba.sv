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
module top1;
  timeunit 1ns;   timeprecision 100ps;
  logic req 	 =1'b0, ack=1'b0, done=1'b0;
  logic ready	 =0, transfer_envelope=0;
  logic clk 	 = 1'b1;   // system clock
  logic bus_req  =0, bus_ack=0, err=1'b0;
  
  initial forever #5 clk = ~clk;

implication1 dut(.*);
  
  default clocking @(negedge clk); endclocking
  
  initial begin
     	bus_req   <= 1'b1; ##1; 
     	bus_ack <= 1'b1;  bus_req   <= 1'b0;
     	##1
     	bus_req <= 1'b0; bus_ack <= 1'b0;
     	##1;  
        //  err <= 1'b0;
     	##1;
     	done <= 1'b1;
	// err <= 1'b0;
     	##1; 
     	bus_req    <= 1'b0;
     	bus_ack  <= 1'b0;
     	done <= 1'b0;
  	##1; 
	##1;##1;##1;
	bus_req   <= 1'b1; 
      	##1; 
       	bus_ack <= 1'b1;  ready <= 1'b1; bus_req   <= 1'b0; 
      	##1;  bus_req <= 1'b0; ready <=1'b0; bus_ack <= 1'b0;
	transfer_envelope <= 1'b1;
        ##1;  
   	transfer_envelope <= 1'b0; // error injection
	##1 ;	  
       	done <= 1'b1;
	// err <= 1'b0;
  	##1; 
    	bus_req   <= 1'b0;
      	bus_ack <= 1'b0;
      	done 	  <= 1'b0; transfer_envelope <= 1'b0;
  	##1;
	##1;##1;
    	bus_req   <= 1'b0;
      	bus_ack <= 1'b0;
      	done 	  <= 1'b0;
   	##1; 
    	bus_req    <= 1'b0;
      	bus_ack  <= 1'b0;
      	done <= 1'b0;
  	// error case
	bus_req   <= 1'b1;
	##1;
       	bus_ack <= 1'b1;
	bus_req   <= 1'b0;
  	##1;
       	bus_req <= 1'b0;
      	bus_ack <= 1'b0;
      
  	##1;  
       	err <= 1'b1;
   	##1;
       	done <= 1'b1;
	err <= 0;
  	##1; 
    	bus_req    <= 1'b0;
      	bus_ack  <= 1'b0;
      	done <= 1'b0;
  	##1; 
    	bus_req    <= 1'b0;
      	bus_ack  <= 1'b0;
      	done <= 1'b0;
   	##1; 
   	##1;    ##1;    ##1;    ##1;    ##1; 	 
    	bus_req    <= 1'b0;
      	bus_ack  <= 1'b0;
      	done <= 1'b0;
	##50;$finish;
		end	
endmodule : top1

