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
module sect1_1_3_2(input clk, ack, input crc_pass, done, req,  output crc_err );
  //logic clk, ack, crc_err, crc_pass, done, req;

   ap_crc_err : assert property(@ (posedge clk) 
                     not(ack ##[1:256] crc_err));
   ap_crc : assert property(@ (posedge clk) 
      $rose(req) |=> $rose(ack) ##[1:256] ((crc_pass || done) && !crc_err)); 

endmodule : sect1_1_3_2
