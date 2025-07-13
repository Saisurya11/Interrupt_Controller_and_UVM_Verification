// Code your design here
// Code your design here
// Code your design here
module intr_ctrlr(clk,rst,addr,w_r,wdata,rdata,enable,ready,error,intr_service,intr_valid,intr_to_serv,intr_active);
parameter s_idle=3'b001;
parameter s_got_give=3'b010;
parameter s_waiting=3'b100;
parameter peripherals=16;
parameter add=$clog2(peripherals);
parameter width=$clog2(peripherals);
parameter peri_index=$clog2(peripherals);
//apb signals:pclk,rst,addr,w_r,wdata,rdata,enable,ready,error
input clk,rst,w_r,enable;
input [add-1:0]addr;
input [width-1:0]wdata;
output reg [width-1:0]rdata;
output reg ready,error;
input intr_service; //comes from the processor after the serving with the peripheral
output reg intr_valid;
output reg [peri_index-1:0]intr_to_serv;
input [peripherals-1:0] intr_active;
integer i;
reg [2:0]state,n_state;
reg [peri_index-1:0]peri[peripherals-1:0];
integer current_priority,match,high;
always@(posedge clk)
begin
if(rst)
begin
rdata<=0;
ready<=0;
error<=0;
intr_valid<=0;
intr_to_serv<=0;
state<=s_idle;
n_state<=s_idle;
for(i=0;i<peripherals;i=i+1)
begin
peri[i]<=0;
end
end
else
begin
if(enable)
begin
ready<=1;
if(w_r==1)
	peri[addr]<=wdata;
else
	rdata<=peri[addr];
end
else
	ready<=0;
end

end



 //implmenting the logic for handling the interrupts in the design
//state: IDLE,ACTIVE(GET INTERRUPTS AND GIVE TO PROCESSOR),WAITING(INTERRUPT TO SERVE),
always@(posedge clk)
begin
  if(!rst && !enable)
begin
case(state)
s_idle:begin
if(intr_active!=0)
	n_state<=s_got_give;
	match<=1;
end
s_got_give:begin
for(i=0;i<peripherals;i=i+1)
begin
if(intr_active[i]==1)
	begin
/*current=-1;	
if(current_priority<peri[i])
	begin
	current_priority=peri[i];
	high=i;
	end*/
        if(match==1)
	begin
	match=0;
	current_priority=peri[i];
	high=i;
	end
	else
	begin
	if(current_priority<peri[i])
	begin
	current_priority=peri[i];
	high=i;
	end
	end

end
intr_to_serv<=high;
intr_valid<=1;
n_state<=s_waiting;
end
end
s_waiting:begin
if(intr_service==1)
begin		
// 	current_priority<=-1;
	intr_to_serv<=0;
	intr_valid<=0;
  if(intr_active!=0)begin
		n_state<=s_got_give;
		match<=1;

	end
	else
		n_state<=s_idle;
end

end
endcase
end
//   else
//     error<=1;
end

always@(n_state) state<=n_state;
endmodule
