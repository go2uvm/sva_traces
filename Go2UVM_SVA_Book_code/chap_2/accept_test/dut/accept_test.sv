module accept_test(
    input  clk, reset_n,dma_req, data_transfer, done); 
    
	ap_accept_disable : assert property (@ (posedge clk) 
        disable iff (!reset_n)
        sync_accept_on ( done ) 
        $rose(dma_req) |=> data_transfer[*100]
        );
    
	ap_reject_disable : assert property (@ (posedge clk) 
        disable iff (!reset_n)
        sync_reject_on ( done ) 
        $rose(dma_req) |=> data_transfer[*100]
        );
endmodule : accept_test
