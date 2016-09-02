module m9_5(input clk,hit,pending,sel5);
//    bit clk, hit, pending, sel5;
reg temp,temp2,temp3;
        property pHitPendingSel5;
        $rose(hit && !pending) ##1 pending[->1] |=> (sel5); //  Good solution
    endproperty : pHitPendingSel5
    apHitPendingSel5: assert property(@(posedge clk)pHitPendingSel5);
    
    property pHitPendingSel5b;   //  another option 
        if ($rose(hit && !pending))
            pending[->1] |=> (sel5); 
    endproperty : pHitPendingSel5b
    apHitPendingSel5b: assert property(@(posedge clk)pHitPendingSel5b);
    
    property pHitPendingSel5c;   // pending and sel in same cycle  
        if ($rose(hit && !pending))
            !pending[*1:$] ##1 pending |-> (sel5); 
    endproperty : pHitPendingSel5c
    apHitPendingSel5c: assert property(@(posedge clk)pHitPendingSel5c);

    initial begin
        @ (posedge clk) temp <= 1'b1;
	assign temp=hit; 
        repeat(3) @ (posedge clk); 
        temp2 <=1'b1;
	assign temp2=pending; 
        @ (posedge clk) temp3 <=1'b1;
	assign temp3=sel5; 
    end


endmodule : m9_5
