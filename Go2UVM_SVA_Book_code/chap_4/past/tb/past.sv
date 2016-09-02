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

module tb;
    logic clk, regload, load_enable; 
    int reg_data, load_data; 
    int count, Data, data_if; 
  //  initial forever #10 clk=!clk; 
    default clocking cb_clk @ (posedge clk);    

     endclocking : cb_clk 
    
    initial begin
        @ (posedge clk) regload <=1'b1;
        ##4 load_data = 5; 
        #2; ##1 load_enable <= 1'b1; 
        ##1 load_enable <= 1'b0; 
        ##2 load_enable <= 1'b1; 
        ##2 load_enable <= 1'b0; 
        ##1 load_enable <= 1'b1; 
        ##4 load_enable <= 1'b0; 
    end 
endmodule : tb
