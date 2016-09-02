class C;
    byte dly; 
    constraint req2rdy_cst { dly > 0 && dly <= 5 ;}
endclass : C


module cover_seq(input clk, a, b, c, d);
    C cx; 



   // bit clk, a, b, c, d; 
     
    cq1: cover sequence(@(posedge clk)a ##[1:5] b); 

    generate for (genvar i=1; i<=5; i++)  
            cq_aib: cover sequence(@(posedge clk)a ##i b);
    endgenerate

        
endmodule : cover_seq
