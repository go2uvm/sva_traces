/*
    Code for use with the book
    "SystemVerilog Assertions Handbook, 3nd edition"ISBN  878-0-9705394-3-6

    Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2012

    www.systemverilog.us  ben@systemverilog.us
    www.cvcblr.com, info@cvcblr.com

    All code provided in this book and in the accompanied website is distributed
    with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
    the authors nor any supporting vendors shall be liable for damage in connection
    with, or arising out of, the furnishing, performance or use of the models
    provided in the book and website.
*/
package counter_pkg;
    timeunit 1ns; timeprecision 100ps;
  `define TOP counter_tb
    const int MAX_COUNT=6, MIN_COUNT=3; 
    typedef enum {CT_LOAD, CT_RESET, CT_WAIT, CT_DONE} ct_scen_e;
endpackage : counter_pkg

interface counter_if (input clk);
    import counter_pkg::*;  // Package with type declaration 
    logic[3:0] data_in;
    logic ld;
    logic[3:0] counter;
    logic rst_n;
    ct_scen_e kind_cp; // for debug only, copy of a class variable 


    clocking driver_cb @ (posedge clk);
        output rst_n, data_in, ld, kind_cp; 
        input counter;
    endclocking : driver_cb

    clocking mon_cb @ (posedge clk);
        input rst_n, data_in, ld, kind_cp; 
        input counter;
    endclocking : mon_cb

    modport drvr_if_mp (clocking driver_cb);
    modport mon_if_mp (clocking mon_cb);

    property p_load;
        logic[3:0] v_data_in; // local variable to property 
        (ld && (data_in>= MIN_COUNT && data_in <= MAX_COUNT), 
        v_data_in=data_in) 
        |=> counter==v_data_in;
    endproperty : p_load
    ap_load: assert property (  @(driver_cb) p_load); 

endinterface : counter_if


