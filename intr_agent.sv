class intr_agent extends uvm_agent;
  `uvm_component_utils(intr_agent)
  `NEW_COMP
  
  intr_drv drv;
  intr_sqr sqr;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv=intr_drv::type_id::create("drv",this);
    sqr=intr_sqr::type_id::create("sqr",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass