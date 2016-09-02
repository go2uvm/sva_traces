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

module check_req_ack_done (input req, ack, done_xfr, clk);
    timeunit 1ns; timeprecision 1ns;
        sequence qReq2send; // first_match needed 
        @(posedge clk) first_match(req ##[0:$] ack ##2 1'b1);  // clock statement needed for endpoint 
    endsequence : qReq2send

    always @(posedge clk) begin
        wait(qReq2send.triggered);      // check of endpoint for sequence qReq2send  
        // do something here  
        assert_end_xfr : assert (done_xfr) else 
            $display ("Incorrect data transfer, done_xfr not received");
                                    
    end

    logic reset, cancel, dma_req, dma_ack, cpu_rd, mem_data_available;

    sequence qAbort; 
        @ (posedge clk) (reset || cancel) or (dma_req ##1 dma_ack); 
    endsequence : qAbort

    property p_cpu_data_trasnsfer; 
        disable iff (qAbort.triggered) //   
        cpu_rd |-> ##[1:4]  mem_data_available; 
    endproperty : p_cpu_data_trasnsfer
    ap_cpu_data_trasnsfer: assert property (@ (posedge clk)p_cpu_data_trasnsfer);
endmodule : check_req_ack_done

