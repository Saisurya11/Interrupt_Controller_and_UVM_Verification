class intr_drv extends uvm_driver#(intr_tx);
  `uvm_component_utils(intr_drv)
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
  bit flag=1;
  int value;
  task drive(intr_tx tx);
    wait(vif.rst==0);
    @(vif.drv_cb);
    if(tx.flag==1) begin
      vif.drv_cb.intr_active<=tx.intr_active;
      flag=1;
    end
    while(tx.intr_active!=0) begin
      @(vif.drv_cb);
      wait(vif.drv_cb.intr_valid==1);
      repeat(intr_common::wait_time) @(vif.drv_cb);
      vif.drv_cb.intr_active[vif.drv_cb.intr_to_serv]<=0;
      tx.intr_active[vif.drv_cb.intr_to_serv]=0;
      vif.drv_cb.intr_service<=1;
      if(flag==1 && tx.intr_active<=100) begin
        repeat(intr_common::inter_interrupts) begin
          value=$urandom_range(0,`peripherals-1);
          tx.intr_active[value]=0;
        end
        flag=0;
        vif.drv_cb.intr_active<=tx.intr_active;
      end
      @(vif.mon_cb);
      vif.drv_cb.intr_service<=0;
    end
  endtask
endclass