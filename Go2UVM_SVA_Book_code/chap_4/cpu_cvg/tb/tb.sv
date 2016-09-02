module top2;
  timeunit 1ns;
  timeprecision 1ns;
  logic clk=1;				   
 
 logic[15:0] addr=5;
logic [15:0] data = 1000;

//logic clk=1;				   
  instr_e instr;	
		   
  mode_e mode=EXECUTE;
  resource_e resource;
 initial forever #5 clk=!clk;
 
  default clocking @(negedge clk); endclocking
     

 cpu_module dut(.*);
initial begin : stimulus
    repeat (10) begin : stim_gen
        assert(std::randomize(addr, data));// randomization error: addr. A variable reference expected
      assert(std::randomize(instr,  mode, resource));
      $display ("addr %0x instr %p mode %p resource %p",
                 addr, instr, mode, resource);
          end : stim_gen
    $finish;
  end : stimulus

  
    
endmodule : top2

