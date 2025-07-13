class intr_test extends uvm_test;
  `uvm_component_utils(intr_test)
  `NEW_COMP
  intr_env env;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=intr_env::type_id::create("env",this);
  endfunction
endclass

class incr_wr_test_incr extends intr_test;
  `uvm_component_utils(incr_wr_test_incr)
  `NEW_COMP
  top_seq_incr seq;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=top_seq_incr::type_id::create("seq");
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    seq.start(env.sqr);
    phase.drop_objection(this);
  endtask
endclass

class incr_wr_test_decr extends intr_test;
  `uvm_component_utils(incr_wr_test_decr)
  `NEW_COMP
  top_seq_decr seq;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=top_seq_decr::type_id::create("seq");
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    seq.start(env.sqr);
    phase.drop_objection(this);
  endtask
endclass

class incr_wr_test_random extends intr_test;
  `uvm_component_utils(incr_wr_test_random)
  `NEW_COMP
  top_seq_random seq;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=top_seq_random::type_id::create("seq");
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    seq.start(env.sqr);
    phase.drop_objection(this);
  endtask
endclass