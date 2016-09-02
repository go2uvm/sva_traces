module frkjn; 

    initial
    begin
        for (int j=0; j<3; j++)
            fork
                $write(j); // Bug – will get final value of index
            join_none
            //#0 $display("\n");
    end

        initial
        begin
            for (int j=0; j<3; j++)
            begin
                 int k = j; // Make copy of index
                fork
                    $write(k); // Print copy
                join_none
            end
            #0 $display;
        end


endmodule : frkjn
 parameter CACHE_SIZE = 8;
    parameter MEM_DATA_WIDTH    = 8;

module msl(input clk,a,b, output logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem);
       int st0; // static
    logic clk, a, b;
     int k; // Illegal use of 'automatic' for variable declaration (k).
   // logic [(CACHE_SIZE-1):0] [MEM_DATA_WIDTH-1:0]  cache_mem ; // cache data storage 

    initial begin
        int st1; // static
        static int st2; // static
        automatic int auto1; // automatic
    end
    task automatic t1();
        int auto2; // automatic
        static int st3; // static
        automatic int auto3; // automatic
    endtask

    always_ff @ (posedge clk)  begin : aly 
         int au1; 
         int st; 
        if(a)
            for (int i=0; i<= 255; i++) begin
                cache_mem[i]=i;
             
            end
    end  : aly
     initial begin
            aly.st = 0; 
            aly.au1 =0; 
        end


       endmodule : msl

