class intr_seq extends uvm_sequence#(intr_tx);
  `uvm_object_utils(intr_seq)
  `NEW_OBJ
  uvm_phase phase;
  //   task pre_body();
  //     phase=get_starting_phase();
  //     phase.raise_objection(this);
  //     phase.phase_done.set_drain_time(this,100);
  //   endtask
  //   task post_body();
  //     phase.drop_objection(this);
  //   endtask
endclass

class wr_seq_incr extends intr_seq;
  `uvm_object_utils(wr_seq_incr)
  `NEW_OBJ
  int i=0;
  task body();
    intr_tx tx;
    repeat(intr_common::peripherals) begin
      tx=intr_tx::type_id::create("tx");
      `uvm_do_with(req,{req.w_r==1;req.addr==i;req.intr_active==1;req.wdata==i;flag==0;})
      i=i+1;
    end
  endtask
endclass


class wr_seq_decr extends intr_seq;
  `uvm_object_utils(wr_seq_decr)
  `NEW_OBJ
  int i=0;
  task body();
    intr_tx tx;
    repeat(intr_common::peripherals) begin
      tx=intr_tx::type_id::create("tx");
      `uvm_do_with(req,{req.w_r==1;req.addr==i;req.intr_active==0;req.wdata==15-i;flag==0;})
      i=i+1;
    end
  endtask
endclass


class wr_seq_random extends intr_seq;
  `uvm_object_utils(wr_seq_random)
  `NEW_OBJ
  int i=0;
  int a[];
  intr_tx tx;

  task body();
    a=new[intr_common::peripherals];
    foreach(a[i])
      a[i]=i;

    a.shuffle();
    repeat(intr_common::peripherals) begin
     
      tx=intr_tx::type_id::create("tx");
      `uvm_do_with(req,{req.w_r==1;req.addr==i;req.intr_active==0;req.wdata==a[i];flag==0;})
      i=i+1;
    end
  endtask
endclass

class rd_seq extends intr_seq;
  `uvm_object_utils(rd_seq)
  `NEW_OBJ
  int i=0;
  task body();
    intr_tx tx;
    repeat(intr_common::peripherals) begin
      tx=intr_tx::type_id::create("tx");
      `uvm_do_with(req,{req.w_r==0;req.addr==i;req.intr_active==0;flag==0;})
      i=i+1;
    end
  endtask
endclass

class active_intr_seq extends intr_seq;
  `uvm_object_utils(active_intr_seq)
  `NEW_OBJ    intr_tx tx;
  task body();
    int i;
    repeat(intr_common::num_intr) begin
//       i=0;
    tx=intr_tx::type_id::create("tx");
      `uvm_do_with(req,{req.w_r==0;req.addr==0;flag==1;})
//       i=i+req.intr_active;
    end
  endtask
endclass

// class incr_wr_seq extends intr_seq;
//   `uvm_object_utils(incr_wr_seq)
//   `NEW_OBJ
//   intr_tx tx;
//   task body();
//     int i=0;
//     bit [`peripherals-1:0]intr_active_;
//     repeat(intr_common::peripherals) begin
//       tx=intr_tx::type_id::create("tx");
//       if(i==15)
//         intr_active_=intr_common::interrupts;
//       else
//         intr_active_=0;

//       `uvm_do_with(req,{req.w_r==1;req.addr==i;req.intr_active==intr_active_;req.wdata==i;})
//       i=i+1;
//     end
//   endtask
// endclass

// // class incr_rd_seq extends intr_seq;
// //   `uvm_object_utils(incr_rd_seq)
// //   `NEW_OBJ
// //   intr_tx tx;
// //   task body();
// //     int i=0;
// //     bit [`peripherals-1:0]intr_active_;
// //     repeat(intr_common::peripherals) begin
// //       tx=intr_tx::type_id::create("tx");
// //       `uvm_do_with(req,{req.w_r==0;req.addr==i;})
// //       i=i+1;
// //     end
// //   endtask
// // endclass