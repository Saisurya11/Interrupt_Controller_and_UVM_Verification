class intr_env extends uvm_env;
  `uvm_component_utils(intr_env)
  `NEW_COMP
  intr_agent i_agent;
  mem_agent m_agent;
  intr_mon mon;
  intr_cov cov;
  intr_sbd sbd;
  top_sqr sqr;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    i_agent=intr_agent::type_id::create("i_agent",this);
    m_agent=mem_agent::type_id::create("m_agent",this);
    mon=intr_mon::type_id::create("mon",this);
    cov=intr_cov::type_id::create("cov",this);
    sbd=intr_sbd::type_id::create("sbd",this);
    sqr=top_sqr::type_id::create("sqr",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    sqr.intr=i_agent.sqr;
    sqr.mem=m_agent.sqr;
    mon.ap_port.connect(cov.analysis_export);
    mon.ap_port.connect(sbd.imp_port);
  endfunction
endclass