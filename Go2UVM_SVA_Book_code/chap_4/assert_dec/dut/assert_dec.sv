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
// FROM LRM 
/* -----\/----- EXCLUDED -----\/-----
checker data_legal(start_ev, end_ev, in_data, out_data);
 rand const bit [$bits(in_data)-1:0] mem_data;
 sequence transaction;
   start_ev && (in_data == mem_data) ##1 end_ev[->1];
 endsequence
  a1: assert property (@clock transaction |-> out_data == mem_data);
	endchecker : data_legal

	  // FOR OUR BOOK
	  // NOT COMPLETE CODE ??
	  
checker assert_decrement(logic clk = $inferred_clock, 
                         reset_n = $inferred_disable, 
                         untyped test_expr);
//  Missing  assertion 
  logic [$bits(test_expr)-1 : 0] my_test_expr;
  let my_test_expr = test_expr;

endchecker : assert_decrement
 -----/\----- EXCLUDED -----/\----- */
typedef enum {INCREMENT, DECREMENT} st_t;
	
module qos (input [31:0]avail_credit,input clk);
st_t m_st;

  always @(posedge clk) begin : qos_blk
    case (m_st)
      DECREMENT : 
                 chk_decr : assert (avail_credit);
    endcase 
  end : qos_blk
endmodule : qos
