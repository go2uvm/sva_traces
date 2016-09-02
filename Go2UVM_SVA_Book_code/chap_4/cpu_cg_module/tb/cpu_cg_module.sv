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
module cpu_cg_module1; 
timeunit 1ns;
timeprecision 1ns;	
  logic clk;				   
  
  logic[15:0] addr, data;
 instr_e instr;				   
  mode_e mode=EXECUTE;
  resource_e resource;
 cpu_cg_module dut(.*);
  initial forever #50 clk=!clk;
   default clocking @ ( posedge clk ); endclocking
  initial begin : stimulus
    repeat (10) begin : stim_gen
      ##1;
      addr <= randomize(addr);
      assert (randomize(instr,  mode, resource) );
      $display ("addr %0x instr %p mode %p resource %p",
                 addr, instr, mode, resource);
      ##1;
    end : stim_gen
    #100 $finish;
  end : stimulus

  
endmodule : cpu_cg_module1

