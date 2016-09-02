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
`define true 1'b1
  module sampled4_3 ( input clk,reset_n,req,a,b,c,k,data_valid,output ack);
  timeunit 1ns;
  timeprecision 1ns;

  logic clk, reset_n, req, ack, a, b, c, k, data_valid;
  logic  t = 1;

  property pReqAckSynchronousReset; 
    @ (posedge clk) disable iff (! $sampled (reset_n)) 
       req |=> ##[0:3] ack;
  endproperty : pReqAckSynchronousReset
  apReqAckSynchronousReset  : assert property (pReqAckSynchronousReset);

  // sequence a then b 
  sequence qT; @ (posedge clk) a ##1 b; endsequence : qT

  //  sequence a then b then don't care
  sequence qTended; a ##1 b ##1 `true; endsequence : qTended

  // property example: 
  // property P1; @ (posedge clk)
  //   k |-> $past(qT.triggered);
  // endproperty : P1
  // aP1: assert property(@ (posedge clk) P1);

// property example2: 
  property P1b; @ (posedge clk)
    k |-> $past(qT.ended); // .ended is deprecated in P1800-2009  
	// Method 'ended/triggered' is not allowed in argument of system task function.
  endproperty : P1b
  aP1b: assert property(@ (posedge clk) P1b);	
	

  property P2; @ (posedge clk)
    k |-> qT.ended;
  endproperty : P2

  property pABC_rose;
   $rose(a) |=> (b [*0:2]  ##1 c);
  endproperty : pABC_rose

  property pABC;
    a |=> ##[0:2]  b ##1 c;
  endproperty : pABC

  //
  typedef enum { RED, YELLOW, GREEN } tlight_enum;
  tlight_enum tlight; 
  property p_traffic_light_YELLOW2RED; 
   @ (posedge clk) 
       $rose(tlight==YELLOW) |=> tlight==YELLOW[*1:4] ##1 tlight == RED; 
    // If YELLOW, then remain YELLOW for 1 to 4 cycles, and then RED
    // i.e., RED in 2 to 5 cycles after YELLOW, but YELLOW until RED. 
  endproperty : p_traffic_light_YELLOW2RED
                 //
                 
  // Following an active low request, the active high acknowledge must remain active
  // for up to 100 cycles until data valid is asserted. 
  // Example emphasizes use of  $fell and $stable 
  property pReq2sendValid; 
    $fell(req) |=> ack ##1 $stable(ack)[*0:100] ##1 data_valid; 
  endproperty : pReq2sendValid


  property pReq2sendValid2; 
   $fell(req) |=> ack [*0:100] ##1 data_valid; 
  endproperty : pReq2sendValid2

  
                 
//    ap_no_mem_leak : assert property (p_no_mem_leak) else
//      $fatal (2, "%m @ time %0t, Memory leak detected in system, 
//                        terminating simulation ", $time ); 
//    ap_handshake : assert property (p_handshake) else
//      $error ("%m @ time %0t, req = %0h, ack=%0h", $time, request_bus, ack_bus); 
//    ap_handshake : assert property (p_handshake) else
//      $warning ("%m @ time %0t, req = %0h, ack=%0h", $time, request_bus, ack_bus); 
//   
//    ap_handshake :  assert property (p_handshake) else
//      $info ("%m @ time %0t, req = %0h, ack=%0h", $time, request_bus, ack_bus); 

                 


endmodule : sampled4_3


