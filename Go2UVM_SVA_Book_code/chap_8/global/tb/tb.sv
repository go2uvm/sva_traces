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
module t1;
    bit a, b, c;
    logic clk10,clk13;
   t dut(.*);
   // initial forever #10 clk10=!clk10;
    initial forever #13 clk13=!clk13; 
   // global clocking clk_global @(posedge clk10); endclocking
    default clocking cb_clk13 @ (posedge clk13);  endclocking 
   


endmodule : t1 

