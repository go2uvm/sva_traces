module m9_13(input clk,read,write,rd_served,interrupt,wr_served);
    //bit clk, read, write, rd_served, interrupt, wr_served;
   
    property pNeverReadWrite;   
        read |-> !write;  
    endproperty : pNeverReadWrite
    apNeverReadWrite: assert property(@(posedge clk)pNeverReadWrite);
    apNeverWriteRead: assert property(@(posedge clk)write |-> !read);

    property pReadSchedule;  // succeeds nonvacuously when interrupted or read serviced
        $rose(read) |-> (##[1:5]rd_served) or (##[1:5] interrupt && !rd_served);
    endproperty : pReadSchedule 
    apReadSchedule: assert property(@(posedge clk)pReadSchedule);

    property pWriteSchedule;  // succeeds nonvacuously when interrupted or write serviced
        $rose(write) |-> 
        (##[1:5]wr_served) or (##[1:5] interrupt && !wr_served);
    endproperty : pWriteSchedule
    apWriteSchedule: assert property(@(posedge clk)pWriteSchedule);

    property pReadSchedule2;  // Property passes if interrupt  or rd_serve
        @ (posedge clk)  sync_accept_on (interrupt)  
            $rose(read) |-> (##[1:5] rd_served);
    endproperty : pReadSchedule2
    apReadSchedule2: assert property(pReadSchedule2);

    property pWriteIntrpt ;  // Property passes if interrupt  or wr_served
        @ (posedge clk) sync_accept_on (interrupt)
            ($rose(write)) |-> (##[1:5] (wr_served ));
    endproperty : pWriteIntrpt
    apWriteIntrpt: assert property(pWriteIntrpt);

    property pReadSchedule3;  // Property cancelled  if interrupt, passed if rd_serve
        @ (posedge clk)  disable iff  (interrupt)  
            $rose(read) |-> (##[1:5]rd_served);
    endproperty : pReadSchedule3
    apReadSchedule3 : assert property(pReadSchedule3);

    property pWriteIntrpt2;  // Property cancelled  if interrupt, passed if wr_served
        @ (posedge clk) disable iff  (interrupt)
            ($rose(write)) |-> (##[1:5] (wr_served ));
    endproperty : pWriteIntrpt2
    apWriteIntrpt2: assert property(pWriteIntrpt2);

    cq_read_no_intrpt: cover sequence (@(posedge clk)$rose(read) ##[1:5]rd_served);

    cq_read_intrpt: cover sequence (@(posedge clk)$rose(read) ##[1:5] interrupt && !rd_served);

    cq_write_no_intrpt: cover sequence (@(posedge clk)$rose(write) ##[1:5]wr_served);

    cq_write_intrpt: cover sequence (@(posedge clk)$rose(write) ##[1:5] interrupt && !wr_served); 



    

endmodule : m9_13
