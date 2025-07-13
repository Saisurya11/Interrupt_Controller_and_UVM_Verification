class intr_sbd extends uvm_scoreboard;
  `uvm_component_utils(intr_sbd)
  `NEW_COMP
  intr_tx tx[$],temp;
  uvm_analysis_imp#(intr_tx,intr_sbd) imp_port;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp_port=new("imp_port",this);
  endfunction

  function void write(intr_tx temp);
    tx.push_back(temp);
  endfunction

  bit[`peripherals-1:0]active;
  bit [`peri_index-1:0]peri[`peripherals-1:0];
  bit [`peri_index-1:0]intr_to_serv;
  int match=1;
  task run_phase(uvm_phase phase);
    forever begin
      wait(tx.size()>0);
      temp=tx.pop_front();
      if(temp.en && temp.ready) begin
        if(temp.w_r)
          peri[temp.addr]=temp.wdata;
      end

      if(temp.intr_valid) begin
        match=1;
        slave_model(active,intr_to_serv);
        if(temp.intr_to_serv==intr_to_serv)
          intr_common::match++;
        else
          intr_common::mis_match++;

        active=temp.intr_active;
      end
      else if(!temp.en && !temp.intr_valid) begin
        active=temp.intr_active;
      end
    end
  endtask

  function void slave_model(input bit[`peripherals-1:0]active, output bit [`peri_index-1:0]intr_to_serv);
    int temp,high;
    for(int i=0;i<`peripherals;i++) begin
      if(active[i]) begin
        if(match==1) begin
          temp=peri[i];
          high=i;
          match=0;
        end
        else if(temp<peri[i])
          begin
            temp=peri[i];
            high=i;
          end
      end
    end
    intr_to_serv=high;
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info("MATCHES",$psprintf("Match=%d,Mismatch=%d",intr_common::match,intr_common::mis_match),UVM_NONE)
  endfunction
endclass