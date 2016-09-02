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

interface req2send_if (input clk, reset_n, input request,[7:0] source_data,output ack,[7:0] data_out);
    timeunit 1ns;
    timeprecision 100ps;
   
    // Define a clocking for the properties and IO ports 
    clocking reqclk @(posedge clk);
        input ack, data_out;   
        output request, source_data;

        // Using the clock defined in clocking,  define the property
        property p_req2send (req, datain, ack, dataout);
            logic [7:0] v_data;  // local assertion variable 
            (req, v_data=datain)  |=>  // if  req then assertion variable v_data = datain
            ##[0:3]  (ack   && // within next cycle to 3 cycles later an ack, and 
                      dataout  ==v_data);  // dataout must be equal to v_data
        endproperty : p_req2send
    endclocking : reqclk

    // Define port direction for a module that sends data
    modport sendmode_if (
                         output ack, data_out,   
                         input request, source_data);
    // Define verification directives 
    ap_req2send_1: assert property (reqclk.p_req2send(request, source_data,  
                                                      ack, data_out)); 
endinterface : req2send_if




