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
module  round_robin_chk (input[7:0] req, grant,
                          input go, output go_r, input clk, reset_n);
  
reg temp;

logic [2:0] counter;
//  reg      counter    = 0; 
  
  function logic[2:0] counter_new_value;
    if (!reset_n) return 3'b0;
    else if (!go_r && go)
      return (counter + 1'b1);
    else
      return counter;
  endfunction:  counter_new_value

  always @ (posedge clk) begin : a1
    counter <= counter_new_value();
    temp    <= go;
  end : a1  
 assign go_r=temp;
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
    // always @ (posedge clk) begin : b1    
    // for (int i=0; i<8; i++) begin : lp
    //   if($rose(go) && req[i] && counter==i)  
    //     ap_round_grant: assert (grant[i]); // immediate assertion
    //   else
    //     ap_round_no_grant : assert (!grant[i]);
    // end : lp
    //  end : b1 
endmodule : round_robin_chk          					   
