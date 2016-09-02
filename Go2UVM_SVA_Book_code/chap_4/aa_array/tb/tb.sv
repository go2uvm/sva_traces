
module top1;
    logic clk,reset_n,write,read;
    logic [2**16-1:0] [31:0] memory;
    
   logic [16:0]wdata,rdata;
logic [31:0]addr;

    //logic [31:0] memory;
         
top_aa dut(.*);
       initial begin : init
        @ (posedge clk) reset_n <= 0; 
        @ (posedge clk) reset_n <= 1'b1; 
        wdata=16'h55;
        write=1'b1; 
        addr=32'h000000F0; 
        for (int i=0; i<10; i++) begin
            @ (posedge clk) addr=addr+(i*3);
            write <= 1'b1; 
            wdata = wdata*3;
        end
        @ ( posedge clk); write <= 1'b0;
        addr=32'h000000F0; 
        for (int i=0; i<10; i++) begin
            @ (posedge clk)  addr=addr+(i*3);
            read <= 1'b1; 
        end
        @ (posedge clk) read <= 1'b0;
    end  :init

endmodule : top1
