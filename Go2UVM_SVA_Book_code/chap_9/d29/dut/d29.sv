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
module d29(input  bus_enb,bus_ack,done,dma_ack,mem_enb,bus_req,dma_req,clk); 
  
//logic bus_enb,bus_ack,done,dma_ack,mem_enb,bus_req,dma_req;
//logic clk;
//Bus transfer sequence:  within 5 cycles bus_ack is followed by a bus transfer
//  of 1 to 128 words (bus_enb) followed by done. 
sequence qBusTransfer; 
     @ (posedge clk) ##[1:5] bus_ack ##1 bus_enb [*1:128] ##1 done;
endsequence : qBusTransfer

// DMA transfer sequence: within 3 cycles dma_ack is followed by
// the transfer of 128 data words (mem_enb). 
sequence qDmaTransfer; 
     @ (posedge clk) ##[1:3] dma_ack ##1 mem_enb[*128]; 
endsequence :  qDmaTransfer

// Never a trigger for both DMA and Bus transfers 
property BusXfr_XOR_DmaXfr; 
  not ($rose(bus_req) or $rose(dma_req)); 
endproperty : BusXfr_XOR_DmaXfr
// If a bus transfer, then no DMA sequence endpoint throughout the bus transfer
property IfBusXfr_NoDmaXfr; 
    ($rose(bus_req) or $rose(dma_req));//  |-> !qDmaTransfer.ended throughout qBusTransfer); 
endproperty : IfBusXfr_NoDmaXfr
// If a DMA transfer, then no bus sequence endpoint throughout the DMA transfer
property IfDmaXfr_NoBusXfr; 
    ($rose(dma_req) and !$rose(bus_req));//|-> !qBusTransfer.ended throughout qDmaTransfer); 
endproperty : IfDmaXfr_NoBusXfr

endmodule :d29
