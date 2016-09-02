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
module cpu_cg_module2(input clk,output [15:0]addr,input [15:0]data );   
      //  logic clk=1;                 
    instr_e instr;// reg temp;   
   // logic[15:0] data = 1000;               
    mode_e mode=EXECUTE;
    resource_e resource;
       sequence q_add_sub; (@ (posedge clk) 
        instr==READ ##1 instr==WRITE); 
    endsequence : q_add_sub
    initial begin : stimulus
        repeat (100) begin : stim_gen
           // ##1;
            //temp <= std::randomize(addr);
            assert (std::randomize(instr,  mode, resource) );
            $display ("addr %0x instr %p mode %p resource %p",
            addr, instr, mode, resource);
           //assign temp=addr;
           // ##1;
        end : stim_gen
        $finish;
    end : stimulus

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

    always  @ (q_add_sub) instr_cg1.sample();  
     

    final begin : report_cov
        $display ("Final cov achieved is %g ",
        $get_coverage());
    end : report_cov

endmodule : cpu_cg_module2

