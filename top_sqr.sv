class top_sqr extends uvm_sequencer;
  `uvm_component_utils(top_sqr)
  `NEW_COMP
  intr_sqr intr;
  mem_sqr mem;
endclass