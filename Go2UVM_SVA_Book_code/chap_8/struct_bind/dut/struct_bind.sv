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
// File of the dut 
 typedef struct { 
    logic [31:0] a; 
    logic [31:0] b; 
  } LS; 
module dut( 
 input logic [31:0]     data, 
 input logic            clock, 
 output logic [31:0]    result 
); 
timeunit 1ns;
timeprecision 100ps; 
  LS ls0, ls1; 
  always @ (posedge clock) begin 
     ls0.a <= data; 
     result <= ls0.a; 
  end
endmodule 


module dut_sv_assert_module( 
input LS ls0,  
input LS ls1, 
input logic clock); 
timeunit 1ns;
timeprecision 100ps;
//LS ls0,ls1; 
    property prop0; 
     always  @( posedge clock) 
           ls0.a != ls1.a; 
    endproperty : prop0 
    assert_prop0 : assert property(prop0) else begin 
        $display("TIME[%0d] ERROR: assertion prop0 in <test.dut> failed", $time); 
       $assertoff( 0, assert_prop0 ); 
    end 
endmodule 

module top(input clock=1, input [31:0] data,output [31:0] result); 
  timeunit 1ns;
  timeprecision 100ps;
//  logic clock=1; 
 // logic [31:0]     data;
//  logic [31:0]    result;
    dut dut1(.*); 

endmodule : top 

bind dut 
dut_sv_assert_module dut_sv_assert_instance( 
.ls0(ls0), 
.ls1(ls1), 
.clock(clock)  
); 
// File of the assertion module 
