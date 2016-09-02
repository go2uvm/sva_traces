import fifo_pkg::*;
import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual fifo_if b_if;   
 //default clocking  @ ( posedge clk );  endclocking


   task reset_task (int num);
	 begin
	 for (int i=0; i < num; i++) 
	   begin 
			  b_if.cb.reset_n <= 1'b0;
			  
@(b_if.cb);
	   end
	 b_if.cb.reset_n <= 1'b1;
@(b_if.cb);
	 end
   endtask : reset_task 
   task push_task (word_t data);
     begin
       $display ("%0t %m Push data %0h ", $time, data);
	   b_if.cb.data_in <= data;
	   b_if.cb.push <= 1'b1;
	   b_if.cb.pop  <= 1'b0;
       b_if.wr_ptr++;
	@(b_if.cb);
      end
    endtask : push_task 

    task pop_task;
      begin
        b_if.cb.data_in <= 'X; // unsized Xs 
        b_if.cb.push <= 1'b0;
        b_if.cb.pop  <= 1'b1;
        b_if.rd_ptr++;
       @(b_if.cb);
       end
    endtask : pop_task
      
    task idle_task (int num_idle_cycles);
      begin
        assert (num_idle_cycles < 10000) else 
          $warning ("%0t %0m idle_task is invoked with LARGE number of idle cycles %0d ",
                    $time, num_idle_cycles); 
        b_if.cb.data_in <= 'X; // unsized Xs 
        b_if.cb.push <= 1'b0;
        b_if.cb.pop  <= 1'b0;
        repeat (num_idle_cycles) @(b_if.cb);
      end
    endtask : idle_task 
 task main;
   //initial   
    begin : client 
		 // directed tests
		 reset_task(5);
		 // 3 pushes
		 for (int i=0; i<= 3; i++) begin 
		   // push_task($random % WIDTH);
		  b_if.push_task($random );
		  b_if.idle_task($random % 5);
		  b_if.push_task(11 );
		 end

		 // 3 pop
		 for (int i=0; i<= 3; i++) begin 
		   b_if.pop_task;
		   b_if.idle_task($random % 5);
		 end

		 // push/pop random
		 for (int i=0; i<= 5; i++) begin
		   if ($random %2) begin
			 b_if.push_task($random % WIDTH);
			 b_if.idle_task($random % 3);
		   end
		   else begin
			 b_if.pop_task;
			 b_if.idle_task($random % 4);
		    end
		 end
		 
		 end 
endtask : main
endclass :uvm_sva_test

module top;
 

   timeunit 1ns;
    timeprecision 100ps;
   logic clk =0;
   logic reset_n = 1'b0;
   initial forever #10 clk = !clk;

 fifo_if b_if(.*);
  fifo dut(.clk          (clk),
             .reset_n      (reset_n), 
             .empty        (b_if.empty),
             .almost_empty (b_if.almost_empty),
             .almost_full  (b_if.almost_full),
             .full         (b_if.full),
             .data_out     (b_if.data_out),
             .error        (b_if.error),
             .data_in      (b_if.data_in),
             .push         (b_if.push),
             .pop          (b_if.pop));

 uvm_sva_test test_0;
 
   initial begin
    test_0 = new();
    test_0.b_if = b_if;
    run_test();
  end
endmodule : top 

