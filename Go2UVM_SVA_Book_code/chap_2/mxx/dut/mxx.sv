module mxx(input push,pop,clk,output int fifo_count,MAXCOUNT); 
    
    always @ (posedge clk) begin :Fifo_Counter
        if (push && !pop)  begin : PushNoPop
          a_fifomax: assert (fifo_count < MAXCOUNT) else
            $warning ("%m @ time %0t, FIFO overflow:  maxcount = %h", $time, fifo_count);        
          fifo_count <= fifo_count + 1'b1;
        end : PushNoPop 
        else if (!push && pop) begin : NoPushPop
           a_fifomin : assert (fifo_count > 0) else
             $warning ("%m @ time %0t,  FIFO underflow: maxcount = %h", $time, fifo_count);
           fifo_count <= fifo_count - 1'b1;   
        end : NoPushPop
      end :Fifo_Counter

endmodule : mxx 