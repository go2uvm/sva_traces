 parameter WIDTH=4; 

module elab(input clk,trig,[WIDTH-1:0] vect, w); 

       //bit[WIDTH-1:0] vect, w; 
   // bit clk; 
   // default clocking cb_clk @ (posedge clk);  endclocking 

    generate
        if ($bits(vect) == 1) begin : err 
            $error("Only a 1-bit vector"            ); 
        end
        for (genvar i = 0; i < $bits(vect); i++) begin : Loop
            if (i==0) begin : Cond0
                sequence t; vect[0]; endsequence
                $info("i=0 branch generated"                );
            end : Cond0
            else begin : Cond
                sequence t; vect[i] ##1 Loop[i-1].Cond0.t; endsequence
                $info("i = %0d branch generated", i);
            end : Cond
        end : Loop
    endgenerate
// instantiate the last generated sequence in a property
    property p;
        @(posedge clk) trig |-> Loop[$bits(vect)-1].Cond.t;
    endproperty
endmodule : elab
