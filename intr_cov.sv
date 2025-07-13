class intr_cov extends uvm_subscriber#(intr_tx);
  `uvm_component_utils(intr_cov)
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  intr_tx tx[$],temp,tx_temp;
  covergroup intr_cg;
    Addr: coverpoint tx_temp.addr{
      bins ADDR[]={[0:15]};
    }
    WR_RD: coverpoint tx_temp.w_r;
    WDATA: coverpoint tx_temp.wdata{
      bins WDATA[]={[0:15]};
    }
    SERVES: coverpoint tx_temp.intr_to_serv{
      option.auto_bin_max=8;
    }
        SERVICE: coverpoint tx_temp.intr_service{
          bins sent={1};
          ignore_bins zero={0};
        }
  endgroup

  function new(string name="",uvm_component parent);
    super.new(name,parent);
    intr_cg=new();
  endfunction

  function void write(T t);
    $cast(temp,t);
    tx.push_back(temp);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      wait(tx.size()>0);
      tx_temp=tx.pop_front();
      intr_cg.sample();
//       tx_temp.print();

    end
  endtask

  function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE",$psprintf("Coverage=%.3f",intr_cg.get_inst_coverage()),UVM_NONE)
    $display("Bin hits = %0d", intr_cg.Addr.get_coverage());
    $display("Bin hits = %0d", intr_cg.WR_RD.get_coverage());
    $display("Bin hits = %0d", intr_cg.WDATA.get_coverage());
    $display("Bin hits = %0d", intr_cg.SERVES.get_coverage());
    $display("Bin hits = %0d", intr_cg.SERVICE.get_coverage());

  endfunction

endclass