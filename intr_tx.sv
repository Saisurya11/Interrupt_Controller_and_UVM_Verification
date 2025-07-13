class intr_tx extends uvm_sequence_item;
  rand bit w_r;
  rand bit flag; //flag for memory and intr_ctrlr
  rand bit [`add-1:0]addr;
  rand bit [`width-1:0]wdata;
  bit [`width-1:0]rdata;
  rand  bit [`peripherals-1:0]intr_active;
  bit en,ready;
  bit error;
  bit intr_valid;
  bit[`peri_index-1:0]intr_to_serv;
  bit intr_service;
  `uvm_object_utils_begin(intr_tx)
  `uvm_field_int(w_r,UVM_ALL_ON)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(flag,UVM_ALL_ON)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_field_int(intr_active,UVM_ALL_ON)
  `uvm_field_int(en,UVM_ALL_ON)
  `uvm_field_int(ready,UVM_ALL_ON)
  `uvm_field_int(error,UVM_ALL_ON)
  `uvm_field_int(intr_valid,UVM_ALL_ON)
  `uvm_field_int(intr_to_serv,UVM_ALL_ON)
  `uvm_field_int(intr_service,UVM_ALL_ON)
  `uvm_object_utils_end
  `NEW_OBJ

endclass