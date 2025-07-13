class intr_mon extends uvm_monitor;
  `uvm_component_utils(intr_mon)
  `NEW_COMP
  virtual intr_intf vif;
  uvm_analysis_port#(intr_tx) ap_port;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_port=new("ap_port",this);
    uvm_resource_db#(virtual intr_intf)::read_by_name("GLOBAL","VIF",vif,this);
  endfunction

  task run_phase(uvm_phase phase);
    fork
      memory();
      intr();
    join_none
  endtask

  task memory();
        wait(vif.rst==0);
    forever begin
      @(vif.mon_cb);
      if(vif.mon_cb.enable && vif.mon_cb.ready) begin
        intr_tx tx=intr_tx::type_id::create("tx");
        tx.en=vif.mon_cb.enable;
        tx.w_r=vif.mon_cb.wr_rd;
        tx.wdata=vif.mon_cb.wdata;
        tx.addr=vif.mon_cb.addr;
        tx.rdata=vif.mon_cb.rdata;
        tx.ready=vif.mon_cb.ready;
        ap_port.write(tx);
      end
    end
  endtask
  bit service=0;
  int active=0;
  task intr();
        wait(vif.rst==0);
    forever begin
      @(vif.mon_cb);
      if((service==0 && vif.mon_cb.intr_service==1)|| active!=vif.mon_cb.intr_active) begin
                intr_tx tx=intr_tx::type_id::create("tx");
        tx.intr_to_serv=vif.mon_cb.intr_to_serv;
        tx.intr_service=vif.mon_cb.intr_service;
        tx.intr_active=vif.mon_cb.intr_active;
        tx.intr_valid=vif.mon_cb.intr_valid;
        ap_port.write(tx);
      end
      active=vif.mon_cb.intr_active;
      service=vif.mon_cb.intr_service;
    end
  endtask
endclass

