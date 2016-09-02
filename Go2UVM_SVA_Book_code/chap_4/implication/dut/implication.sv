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
module implication(input req,clk,bus_req,done, output  ready,ack,bus_ack,err, transfer_envelope );
  timeunit 1ns;   timeprecision 1ns;
/*  logic req 	 =0, ack=0, done=0;
  logic ready	 =0, transfer_envelope=0;
  logic clk 	 = 1;   // system clock
  logic bus_req  =0, bus_ack=0, err=0; */
  
  // initial forever #5 clk = ~clk;

  property p_req2done;
	@ (posedge clk)
	  $rose(bus_req) |=> (bus_ack ##[1:5] done) and 
        (ready )|-> (transfer_envelope[*1:$] ##1 done );
                      // (ready |-> transfer_envelope[*1:$] until done );
  endproperty : p_req2done

  ap_req2done : assert property(@ (posedge clk) p_req2done);

//cp_ready_xfr_done: cover sequence  // This simulation used cover property 
//  (@ (posedge clk)  (ready ##0  transfer_envelope[*0:$] ##1 done ));
  
  cp_ready_xfr_done: cover property  // This simulation used cover property
  // It addresses the same start of bus_ack and ready followed by transfer_envelope and done
  (@ (posedge clk)  (bus_ack ##0 ready ##0  transfer_envelope[*0:$] ##1 done ));

  cp_bus_req_ack_done : cover property(@ (posedge clk) bus_req ##1 bus_ack ##[1:5] done);
  default clocking @(negedge clk); endclocking
  
 
endmodule : implication

