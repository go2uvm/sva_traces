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
module v9_21( input clk=1, bus_ack=0, bus_enb=0, done=0, 
               dma_ack=0, mem_enb=0, bus_req=0, dma_req=0);
timeunit 1ns;
timeprecision 100ps;
 // logic clk=1, bus_ack=0, bus_enb=0, done=0, 
       //        dma_ack=0, mem_enb=0, bus_req=0, dma_req=0;
  sequence qBusTransfer; 
     @ (posedge clk) ##[1:5] bus_ack ##1 bus_enb [*1:128] ##1 done;
  endsequence : qBusTransfer

  // DMA transfer sequence: within 3 cycles dma_ack is followed by
  // the transfer of 128 data words (mem_enb). 
  sequence qDmaTransfer; 
    @ (posedge clk)  ##[1:3] dma_ack ##1 mem_enb[*128]; 
  endsequence :  qDmaTransfer

  // If bus_req, then no dma_req throughout the bus transfer sequence 
  property pBusNoDMA;
    $rose(bus_req) |-> !$rose(dma_req) throughout qBusTransfer;
  endproperty : pBusNoDMA
  apBusNoDMA : assert property(@ (posedge clk) pBusNoDMA);

  // If dma_req, then no bus_req throughout the dma transfer sequence 
  property pDmaNoBus;
    $rose(dma_req) |-> !$rose(bus_req) throughout qDmaTransfer;
  endproperty : pDmaNoBus
  apDmaNoBus : assert property(@ (posedge clk) pDmaNoBus);	

endmodule : v9_21  

