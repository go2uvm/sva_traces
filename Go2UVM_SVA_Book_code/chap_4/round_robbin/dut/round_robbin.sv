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
/*
 * 
 */// chance for access moves to the next requester. 
module round_robin_chk (input [7:0] req, grant,
                          input go, reset_n,input clk);
  logic [2:0] counter  = 0; // checker variable

  always @(posedge clk) begin : a1
    if (!reset_n) counter <= 3'b0;
    else if ($rose(go)); 
      counter  <= counter + 1'b1;
  end : a1  

  always @(posedge clk) begin : b1  
    for (int i=0; i<8; i++) begin : lp
      if($rose(go) && req[i] && counter==i) 
        ap_round_grant: assert (grant[i]); // immediate assertion
      else
        ap_round_no_grant : assert (!grant[i]);
    end : lp
  end : b1 
endmodule : round_robin_chk       
	
