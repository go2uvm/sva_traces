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
 
 
module my_module1;
logic [31:0]a;
logic [31:0]b;
logic clk;
logic k;  
                 
my_module dut(.*);
  // local variable used inside this module

    default clocking @(posedge clk); endclocking
  initial begin 
    #1000;  // wait for 1000 timeunits.  In this case, wait for 1000 ns 
   ##1
         k <= 1'b1; 
         b <= 32'hFF00AABB; 
   ##1 k <= 1'b0;
  end

 endmodule : my_module1


 
