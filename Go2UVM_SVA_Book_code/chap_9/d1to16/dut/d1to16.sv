/*
Code for use with the book
"SystemVerilog Assertions Handbook, 2nd edition"ISBN  878-0-9705394-8-7

Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2009 

www.systemverilog.us  ben@systemverilog.us
www.cvcblr.com, info@cvcblr.com

All code provided in this book and in the accompanied website is distributed
 with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
the authors nor any supporting vendors shall be liable for damage in connection
with, or arising out of, the furnishing, performance or use of the models
provided in the book and website.
*/
module dict(input clk, snoop, hit_modified, writeback, reset_n, go,
input reset_cmd, trans_start,
input enable,xfr,pending,req4,ack,acquire,id,hit,busy,req,sel5,packet,lastbit,first,cmd,size,gx_start,
input dgrant,dbusy_n,dbus_enb,data_last,frame,grant,time_out,addr,aquired,write_en,write); 


 //reg clk, snoop, hit_modified, writeback, reset_n, go;
//reg reset_cmd, trans_start;
//reg //enable,xfr,pending,req4,ack,acquire,id,hit,busy,req,sel5,packet//,lastbit,first,cmd,size,gx_start;
//reg //dgrant,dbusy_n,dbus_enb,data_last,frame,grant,time_out,addr,aqu//ired,write_en,write;

property pCacheSnoopWriteback;
  @ (posedge clk) (snoop && hit_modified)|=> (writeback);
 endproperty : pCacheSnoopWriteback

property pCacheSnoopWriteback2;
  @ (posedge clk) disable iff (!reset_n) 
 (snoop && hit_modified)|=> (writeback);
 endproperty : pCacheSnoopWriteback2


sequence qSoftReset;
   @ (posedge clk) (reset_cmd ##1 go ); 
endsequence: qSoftReset

  /*property pCacheSnoopWriteback3;
  disable iff (qSoftReset.triggered) 
   (snoop && hit_modified)|=> (writeback);
   endproperty : pCacheSnoopWriteback3*/


property pCacheSnoopWriteback4;
 // @ (posedge clk) (snoop && hit_modified) |=>  ##[0:$] $rose(trans_start) |-> writeback;
    @ (posedge clk) (snoop && hit_modified) |=>  ##[0:$] $rose(trans_start) ##0 writeback;
  endproperty : pCacheSnoopWriteback4

  
  property pCacheSnoopWriteback_not_same;
    @ (posedge clk) (snoop && hit_modified) |=>  ##[0:$] $rose(trans_start) ##0 writeback;
  endproperty : pCacheSnoopWriteback_not_same

   
property pEnable2Pending;
     @ (posedge clk) $rose(enable) |-> xfr[=4] ##1 $rose(pending); 
    endproperty :  pEnable2Pending


property pEnable2Pending1;
      @ (posedge clk) $rose(enable) |-> xfr[->4] ##1 $rose(pending);
  endproperty : pEnable2Pending1


property pReqAck4 ; 
  //@ (posedge clk) $rose(req4)  |->  ##[0:$] (ack && id !=8Æd4) |-> (!req4 [*0:$] ##1 acquire);
  @ (posedge clk) $rose(req4)  |->  ##[0:$] (ack && id !=8'd4) ##0 (!req4 [*0:$] ##1 acquire);
endproperty : pReqAck4

  
 
property pHitPendingSel5;
   @ (posedge clk) $rose(hit) && !pending ##1 pending[->1] |-> (sel5); 
  endproperty : pHitPendingSel5


   property HitPendingSel5;
    @ (posedge clk) (hit && !pending ##1 pending[->1]) |=> (sel5); 
  endproperty : HitPendingSel5

 
 property pReqAckBusy;
     @ (posedge clk) $rose(req) |-> (busy[*0:$] ##1 ack); 
  endproperty : pReqAckBusy

property pReqAckBusy2;
       @ (posedge clk) $rose(req) |-> (busy&& req [*0:$]) ##1  ack;
     endproperty : pReqAckBusy2


property pPacketLastFirst1;
     //@ (posedge clk) $rose(packet) |-> ##[*0:$](lastbit) |-> ##[0:$] ($rose(packet) && first));
     @ (posedge clk) $rose(packet) |-> ##[0:$](lastbit)  ##[0:$] ($rose(packet) && first);
    
endproperty : pPacketLastFirst1


property pPacketLAstFirst2; 
  @ (posedge clk) $rose(packet) ##1 lastbit[->1] 
                   |=> (##[0:$] $rose(packet) && first); 
endproperty : pPacketLAstFirst2


property pPacketLastFirst3;
  @ (posedge clk) $rose(packet) ##1 lastbit[->1] 
                   |=> (##[0:100] $rose(packet) && first); 
endproperty : pPacketLastFirst3


  /*property pWriteNstart; //    OK 
     @ (posedge clk) 
     if ($rose(cmd==WRITE) && size ==1) gx_start[=1 ] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==2) gx_start[= 2] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==3) gx_start[= 3] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==4) gx_start[= 4] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==5) gx_start[= 5] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==6) gx_start[= 6] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==7) gx_start[= 7] ##1  data_last else 
     if ($rose(cmd==WRITE) && size ==8) gx_start[= 8] ##1  data_last ; 
     endproperty : pWriteNstart*/



  /*property pWriteNstart_ERROR; //     
      @ (posedge clk)
        $rose(cmd==WRITE) && size >=1 && size <=8 |=>( gx_start[=size] ##1  data_last);
        endproperty : pWriteNstart_ERROR

        Error-[NCE] Non-constant expression
        The following expression should be a constant.
        Expression: size
        "../src/d1to16.sv", 110: token is ']'
        $rose(cmd==WRITE) && size >=1 && size <=8 |=>( gx_start[=size] ##1  data_last);
                                                                      ^


  */



property pDataGrantDbusy; 
  @ (posedge clk) $rose(dgrant) ##[0:255] dbusy_n[*2] |=> $rose(dbus_enb);
endproperty : pDataGrantDbusy


property pDataGrantDbusy2;
     @ (posedge clk) $rose(dgrant) |-> ##[1:$]( (dbusy_n) [=2]) ##1 $rose(dbus_enb);
endproperty : pDataGrantDbusy2

property pDataGrantDbusy3;
    @ (posedge clk)  $rose(dgrant) |-> ##[1:$] (dbusy_n [->2]) ##1 $rose(dbus_enb);
endproperty : pDataGrantDbusy3


property pBusRequest;
  @ (posedge clk) $rose(req) |-> (busy[*0:$]  ##1 ack); 
endproperty : pBusRequest


property pReqGrantTimeout;  
   @ (posedge clk) (req && $rose(grant) ##1 (!frame && grant )[*63]) |-> (time_out);
endproperty : pReqGrantTimeout


property pReqGrantAcquired;
  @ (posedge clk) (req && $rose(grant) ##1 (!frame && grant )[*0:62] ##1 frame) |-> (aquired); 
endproperty : pReqGrantAcquired



property pWriteOddEven;
   @ (posedge clk) 
     ( (! write_en[*0:$]  ##1 write_en && !addr ##1  
           ! write_en[*0:$] ##1 write_en && addr)[*0:$] 
      )  within   ($rose(write) ##[1:$]  $fell(write));
endproperty : pWriteOddEven

endmodule : dict
    
