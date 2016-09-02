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
// checker round_robin_chk (logic[7:0] req, grant,
module round_robin_chk (input[7:0] req, grant,	input clk,					 
                        input go, reset_n,output [2:0] counter);
timeunit 1ns;
timeprecision 1ns;
  logic [2:0]     temp    = 0; // 
  logic 		go_r =0;
  
  function logic[2:0] counter_new_value;
	if (!reset_n) return 3'b0;
    else if (!go_r && go) 
      return (temp + 1'b1);
	else
	  return temp;
  endfunction 
  assign counter=temp;
//  always @$global_clock begin : a1
  always @ (posedge clk) begin : a1	
   temp <= counter_new_value();
	go_r 	<= go;
  end : a1  
assign counter=temp;
//  always @$global_clock begin : b1
//   always @ (posedge clk) begin : b1
	ap_round_grant : assert property(@ (posedge clk) $rose(go) |-> 
          if (req[0] && counter==0) grant[0]
     else if (req[1] && counter==1) grant[1]
	 else if (req[2] && counter==2) grant[2]
	 else if (req[3] && counter==3) grant[3]
	 else if (req[4] && counter==4) grant[4]
	 else if (req[5] && counter==5) grant[5]
	 else if (req[6] && counter==6) grant[6]
	 else if (req[7] && counter==7) grant[7]);

    ap_round_no_grant : assert property(@ (posedge clk) $rose(go) |-> 
          if (!req[0] && counter==0) !grant[0]
     else if (!req[1] && counter==1) !grant[1]
     else if (!req[2] && counter==2) !grant[2]
     else if (!req[3] && counter==3) !grant[3]
     else if (!req[4] && counter==4) !grant[4]
     else if (!req[5] && counter==5) !grant[5]
     else if (!req[6] && counter==6) !grant[6]
     else if (!req[7] && counter==7) !grant[7]);	
	// Illegal in checker 
    // for (int i=0; i<8; i++) begin : lp
    //   if($rose(go) && req[i] && counter==i)  
    //     ap_round_grant: assert (grant[i]); // immediate assertion
    //   else
    //     ap_round_no_grant : assert (!grant[i]);
    // end : lp
//  end : b1 
endmodule :round_robin_chk
// endchecker : round_robin_chk          					   
