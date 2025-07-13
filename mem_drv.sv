class mem_drv extends uvm_driver#(intr_tx);
  `uvm_component_utils(mem_drv)
  `NEW_COMP
  virtual intr_intf vif;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_resource_db#(virtual intr_intf)::read_by_name("GLOBAL","VIF",vif,this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask

  task drive(intr_tx tx);
    wait(vif.rst==0);
    @(vif.drv_cb);
        if(tx.flag==0) begin
    vif.drv_cb.wr_rd<=tx.w_r;
    vif.drv_cb.enable<=1;
    vif.drv_cb.addr<=tx.addr;
    if(tx.w_r) vif.drv_cb.wdata<=tx.wdata;
    vif.drv_cb.intr_service<=0;
    wait(vif.drv_cb.ready);
    @(vif.drv_cb);
    vif.drv_cb.wr_rd<=0;
    vif.drv_cb.enable<=0;
    vif.drv_cb.addr<=0;
    vif.drv_cb.wdata<=0;
        end
  endtask
endclass