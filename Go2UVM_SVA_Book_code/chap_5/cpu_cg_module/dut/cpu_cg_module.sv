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
typedef enum {NOP, ADD, SUB, MULT, JMP, MOV, READ, WRITE, IDLE} instr_e;
typedef enum {FETCH, DECODE, EXECUTE}  mode_e;
typedef enum {PC, IR1, IR2, REGA, REGB, MAR, REG_FILE, STK} resource_e;
module cpu_cg_module(input clk=1,input [15:0]addr=0,data=1000, input instr_e instr,mode_e mode,resource_e resource ); 
//timeunit 1ns;
//timeprecision 1ns;	
  //logic clk=1;				   
  //instr_e instr;	
  //logic[15:0] addr	=0, data = 1000;			   
 // mode_e mode=EXECUTE;
 // resource_e resource;
  //initial forever #50 clk=!clk;
  // cpu_cg cpu_1(.*);
 
  covergroup instr_cg;
    Instr_cp    : coverpoint instr;
	Resource_cp : coverpoint resource;
	Mode_cp     : coverpoint mode;
	InstXrsc   : cross instr, resource, mode;
   endgroup : instr_cg
   instr_cg instr_cg1=new();

  covergroup addr_cg @(posedge clk);
	addr_cp : coverpoint addr
	  { bins instruction = {[0:255]};
	    bins data   = {[256:32767]};
      }
  endgroup : addr_cg
 addr_cg addr_cg1=new();

  always @ (posedge clk) 
      if(mode==FETCH) instr_cg1.sample();  

  final begin : report_cov
    $display ("Final cov achieved is %g ",
               $get_coverage());
  end : report_cov

endmodule : cpu_cg_module

