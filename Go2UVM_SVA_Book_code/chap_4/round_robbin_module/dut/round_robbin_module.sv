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
// provided the requester wants access to the resource.  
// If the requester with the potential grant does not want access to the
// resource, then there is no grant. In all cases, the potential 
// chance for access moves to the next requester. 

module round_robbin_chk (input[7:0] req, grant,	input clk,					 
                        input go, reset_n,output [2:0] counter);
timeunit 1ns;
timeprecision 1ns;
  logic [2:0]     temp    = 0; // 
  logic 		go_r =0;
  ap_round_grant : assert property(@ (posedge clk) 
                 $rose(go) && req[temp] |-> ##[0:8] grant[temp]);

always @ (posedge clk) begin : a1 	
	if (!reset_n) temp <= 3'b0;
	else if ($rose(go)) 
      temp <= temp + 1'b1;
  end : a1  
assign counter=temp;
  always @ (posedge clk) begin : b1
//  always @$global_clock begin : b1	
	for (int i=0; i<8; i++) begin : lp
	  // low number has priority 
	  if(req[i] && counter==i) 
		ap_round_grant: assert (grant[i]); // immediate assertion
	  else
		ap_round_no_grant : assert (!grant[i]);
	end : lp
  end : b1 
endmodule : round_robbin_chk


