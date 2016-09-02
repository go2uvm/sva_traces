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

module past(input clk,regload=1'b0,load_enable,reg_data=5,output load_data=0,count=0,output Data=0,output data_if=0);
  /*  bit clk, regload=1'b0, load_enable; 
    int reg_data=5, load_data=0; 
    int count=0, Data=0, data_if=0; */
  //  initial forever #10 clk=!clk; 
logic temp;
logic temp1,temp2,temp3;
    default clocking cb_clk @ (posedge clk);  endclocking 
    ap_past1: assert property( 
        regload |-> ##2 reg_data==$past(Data, 1, load_enable, @ (posedge clk) )
            );
    ap_past2: assert property( 
        regload |-> ##2 reg_data==$past(Data, 2, load_enable, @ (posedge clk) )
            );
    ap_past3: assert property( 
        regload |-> ##2 reg_data==$past(Data, 3, load_enable, @ (posedge clk) )
            );

    ap_past1a: assert property( 
        1 |-> ##2 1) $display("%t, data1a=%h, data_if=%h", $time, 
             $past(Data, 1, load_enable, @ (posedge clk) ), data_if
            );
    ap_past2a: assert property( 
        1 |-> ##2 1) $display("%t, data2a=%h, data_if=%h", $time, 
             $past(Data, 2, load_enable, @ (posedge clk) ), data_if
            );
    ap_past3a: assert property( 
        1 |-> ##2 1) $display("%t, data3a=%h, data_if=%h", 
             $time, $past(Data, 3, load_enable, @ (posedge clk) ), data_if
            );
            
    always_ff @ (posedge clk iff load_enable)  begin : aly 
        temp <= temp+1;
  
        temp1 <= temp2; 
    end : aly
 assign count = temp;
assign data_if=temp1;

    always_ff @ (posedge clk)  begin : aly1 
        static int vdata; 
        if(!randomize(vdata))  $error("randomization failure"); 
        temp2 <= vdata; 
       temp3 <= vdata; 
    end : aly1
assign Data=temp2;
assign load_data=temp3;
  endmodule : past
