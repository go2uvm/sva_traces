module top1;
 logic clk, request, sent_data, received_data; 
  initial forever #5 clk=!clk;
 
req2send_4_2 dut(.*);
 
       default clocking d_clk  @(posedge clk);  endclocking

 always  @ (posedge clk)
     assert(std::randomize(request, sent_data, received_data));
 
         
endmodule : top1
//
