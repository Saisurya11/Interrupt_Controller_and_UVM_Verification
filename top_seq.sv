class top_seq_incr extends uvm_sequence;
  `uvm_object_utils(top_seq_incr)
  `NEW_OBJ
  wr_seq_incr wr;
  rd_seq rd;
  active_intr_seq intr;
  `uvm_declare_p_sequencer(top_sqr)
  task body();
    `uvm_do_on(wr,p_sequencer.mem)
    `uvm_do_on(rd,p_sequencer.mem)
    `uvm_do_on(intr,p_sequencer.intr)
  endtask
endclass

class top_seq_decr extends uvm_sequence;
  `uvm_object_utils(top_seq_decr)
  `NEW_OBJ
  wr_seq_decr wr;
  rd_seq rd;
  active_intr_seq intr;
  `uvm_declare_p_sequencer(top_sqr)
  task body();
    `uvm_do_on(wr,p_sequencer.mem)
    `uvm_do_on(rd,p_sequencer.mem)
    `uvm_do_on(intr,p_sequencer.intr)
  endtask
endclass

class top_seq_random extends uvm_sequence;
  `uvm_object_utils(top_seq_random)
  `NEW_OBJ
  wr_seq_random wr;
  rd_seq rd;
  active_intr_seq intr;
  `uvm_declare_p_sequencer(top_sqr)
  task body();
    `uvm_do_on(wr,p_sequencer.mem)
    `uvm_do_on(rd,p_sequencer.mem)
    `uvm_do_on(intr,p_sequencer.intr)
  endtask
endclass