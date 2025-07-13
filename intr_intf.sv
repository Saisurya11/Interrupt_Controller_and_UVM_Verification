`define peripherals 16
`define add $clog2(`peripherals)
`define width $clog2(`peripherals)
`define peri_index $clog2(`peripherals)
interface intr_intf(input clk,rst);
  bit wr_rd;
  bit enable;
  bit [`add-1:0]addr;
  bit [`width-1:0]wdata;
  bit [`width-1:0]rdata;
  bit ready;
  bit error;
  bit intr_service; //comes from the processor after completion of interrupt
  bit intr_valid; //high when sending the interrupt to the processor
  bit [`peri_index-1:0]intr_to_serv; //interrupt number for the processor
  bit [`peripherals-1:0]intr_active; //input of all interrupts
  clocking drv_cb@(posedge clk);
    default input #1 output #1;
    output wr_rd,enable,addr,wdata,intr_service;
    output intr_active;
    
    input ready,rdata,intr_valid,error,intr_to_serv;
  endclocking
  
  clocking mon_cb@(posedge clk);
    default input #0;
    input wr_rd,enable,addr,wdata,rdata,ready,error;
    
    input #1 intr_active,intr_service,intr_valid,intr_to_serv;
  endclocking
  modport mon_mp(clocking mon_cb);
endinterface
