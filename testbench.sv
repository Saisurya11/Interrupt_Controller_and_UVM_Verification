// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "intr_common.sv"
`include "intr_intf.sv"
`include "intr_tx.sv"
`include "intr_sqr.sv"
`include "intr_drv.sv"
`include "mem_sqr.sv"
`include "mem_drv.sv"
`include "seq.sv"
`include "top_sqr.sv"
`include "top_seq.sv"
`include "intr_mon.sv"
`include "intr_cov.sv"
`include "intr_sbd.sv"
`include "intr_agent.sv"
`include "mem_agent.sv"
`include "intr_env.sv"
`include "intr_test.sv"
module top;
  reg clk,rst;
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=1;
    repeat(2) @(posedge clk);
    rst=0;
  end
  
  intr_intf pif(clk,rst);
  
  intr_ctrlr dut(.clk(pif.clk),
                 .rst(pif.rst),
                 .addr(pif.addr),
                 .w_r(pif.wr_rd),
                 .wdata(pif.wdata),
                 .rdata(pif.rdata),
                 .enable(pif.enable),
                 .ready(pif.ready),
                 .error(pif.error),
                 .intr_service(pif.intr_service),
                 .intr_valid(pif.intr_valid),
                 .intr_to_serv(pif.intr_to_serv),
                 .intr_active(pif.intr_active)
                );
  
  initial
    run_test("incr_wr_test_incr");
  
  initial
    uvm_resource_db#(virtual intr_intf)::set("GLOBAL","VIF",pif,null);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,pif);
    end
endmodule