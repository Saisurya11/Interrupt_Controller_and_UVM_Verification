class mem_agent extends uvm_agent;
  `uvm_component_utils(mem_agent)
  `NEW_COMP
  
  mem_drv drv;
  mem_sqr sqr;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv=mem_drv::type_id::create("drv",this);
    sqr=mem_sqr::type_id::create("sqr",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass