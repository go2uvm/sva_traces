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
module d1819(input write,read,addr,wdata,rd_served,rdata,clk,wr_valid); 
timeunit 1ns;
timeprecision 100ps;

//reg write,read,addr,wdata,rd_served,rdata;
//reg clk,wr_valid;

parameter Addr2ReadDelay = 0;  // Cycle delay between a READ and the data output.

/*property pReRead_matches_unless_write(write, read, addr, wdata, rdata);
   logic [31:0] vwaddr; // address to be stored at a write
   logic [31:0] vwdata; // data to be stored at a read 
   bit vstarted;        //  Identifies that a READ was started 
  @(posedge clk)
     disable iff (vstarted_v && qWrite.triggered && vwaddr== addr)
      (write, vstarted = 1'b1, vwaddr = addr, vwdata = wdata) ##[0:$] // a 1st write, then 
      (read && addr==vwaddr ) // A 1st read occurred,  
          |=>  (read && addr == vwraddr) [->1]    // another read to same address  
         ## Addr2ReadDelay (rdata == vwdata);                 // Data should match.
endproperty : pReRead_matches_unless_write

apReRead_matches_unless_write_1: assert property 
                         (pReRead_matches_unless_write (write, read, addr, wdata, rdata)) 
  else 
    begin 
       report_sva_violation("RE Read before Write Violation");
       $display("addr=%h, rdata=%h", addr, rdata); 
       end*/




sequence qWrite;
write;
endsequence : qWrite 

  /* property pread_after_write (write, read, addr, wdata, rdata) ;
   bit vstarted;           // detected if started.  Initialized to 0 
   logic [31:0] vwaddr;  // address to be stored at a write 
   logic [31:0] vwdata;  // data to be stored at a write 
   @(posedge clk)
     disable iff (vstarted && qWrite.triggered && vwaddr == addr)
                                             // stop if we find another write to same address 
   (write, vstarted = 1'b1, vwaddr = addr, vwdata = wdata) // Found a write, indicate we started
           |=>  (read && vwaddr == addr)[->1]               // found a read to same address
                    ##Addr2ReadDelay  rdata == vwdata;    //  data should match 
                    endproperty : pread_after_write


apread_after_write : assert property 
                         (pread_after_write (write, read, addr, wdata, rdata)) 
  else 
    begin 
       report_sva_violation("Read before Write Violation");
       $display("addr=%h, rdata=%h", addr, rdata); 
    end
  */

property pConsecutiveWrites;
   @ (posedge clk) (wr_valid[*2] ) |-> (addr  !=$past(addr));
endproperty : pConsecutiveWrites

endmodule
