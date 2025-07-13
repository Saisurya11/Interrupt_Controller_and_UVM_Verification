`define NEW_COMP\
function new(string name="",uvm_component parent); \
  super.new(name,parent); \
endfunction

`define NEW_OBJ\
function new(string name=""); \
  super.new(name); \
endfunction
`define peripherals 16
`define add $clog2(`peripherals)
`define width $clog2(`peripherals)
`define peri_index $clog2(`peripherals)
class intr_common;
  static int peripherals=16;
  static int add = $clog2(peripherals);
  static int width = $clog2(peripherals);
  static int peri_index = $clog2(peripherals);
  static bit [`peripherals-1:0]interrupts='d90919;
  static int wait_time=30,match,mis_match;
  static int inter_interrupts=9,num_intr=4;
endclass