import GAM_package::* ;  

module Memory_Layer_controller(
	input clk,reset, learning_done,assoc_learning_done,comparator_T comparator,
	output logic ld_upcounter,en_upcounter,en_node_counter,assoc_learning_start,
   	en_connection,en_2min, X_c,C_c,W_c,T_c,M_c,RD_WR_T RD_WR_c,
	output logic [1:0] mux1,mux2,mux3,mux4,mux5,mux6,demux);    
   
             
  
 
enum {idle,waiting_assoc,new_input,no_class,
     existing_class,read_MWT,update_M_compare_Th_ED,
     greater_than_Th,less_than_Th,update_Ths1,
    write_Ws1_Ths1,write_Ws2, connections} present_state,next_state;  

//write outputs for en_2min 
   
always_ff @(posedge clk)
begin
if (reset)
present_state<= idle;
else 
present_state<=next_state;
end

//outputs in each state
always_comb
begin
//setting all the values to 0
{ld_upcounter,en_upcounter,en_node_counter,
assoc_learning_start,en_connection,en_2min}='0;
{X_c,C_c,W_c,T_c,M_c}='0;
{mux1,mux2,mux3,mux4,mux5,mux6,demux}= '1;  
RD_WR_c=READ; 
unique case(present_state)
idle: 
	{ld_upcounter,en_upcounter}=2'b11;     
waiting_assoc: 
	{ld_upcounter,assoc_learning_start}=2'b11;    
new_input:
	begin
	{C_c,ld_upcounter}=2'b11;
	{mux5,mux6}='0;
	end
no_class:
	begin
	{X_c,C_c,W_c,T_c,M_c,ld_upcounter,en_node_counter}='1; 
    	RD_WR_c=WRITE;
	{mux1,mux2,mux3}='0;
	end
existing_class:  
	begin
	{W_c,en_upcounter,en_2min}='1; 
	{mux1,mux5,mux6}={3{2'b01}};       
	demux=2'b00;	 
	end
read_MWT: 
	begin
	{W_c,T_c,M_c,ld_upcounter}='1;
	mux1=2'b10;
	demux=2'b01; 	
	end	
update_M_compare_Th_ED:
	begin
	{M_c,ld_upcounter}='1;
	RD_WR_c=WRITE;
	{mux1,mux4}={2{2'b01}};
	{mux5,mux6}={2{2'b10}}; 
	end
greater_than_Th:
	begin
	{X_c,C_c,W_c,T_c,M_c,ld_upcounter,en_node_counter}='1;
	RD_WR_c=WRITE;	
	{mux1,mux2,mux4}='0;
	mux3=2'b01;  
	end
less_than_Th: 
	begin
	{W_c,ld_upcounter}='1; 
	demux=2'b10; 
	end
update_Ths1: 
	begin
	{T_c,ld_upcounter}='1;
	RD_WR_c=WRITE;
	mux1=2'b10;
	mux3=2'b01;
	end
write_Ws1_Ths1:
	begin
	{W_c,T_c,ld_upcounter}='1;
	RD_WR_c=WRITE;
	{mux1,mux3}={2{2'b10}};
	mux2=2'b01;
	end
write_Ws2:
begin
	{W_c,ld_upcounter}='1; 
	RD_WR_c=WRITE;
	mux2=2'b10; 
	end
connections:
	{ld_upcounter,en_connection}='1;

endcase
end
 
//next state logic
always_comb 
begin
case(present_state)
idle: begin
	if(learning_done) next_state=idle; 
	else 		  next_state=new_input;
       end
waiting_assoc: 
begin
	if(assoc_learning_done) 
	next_state=idle ;
	else 		       
	next_state=waiting_assoc; 
end
new_input:
begin
	if(comparator==EQUAL) 
	next_state=existing_class; 
	else 		  
	next_state=no_class;
end 
no_class: 
	next_state=new_input;
existing_class:
	if(comparator==EQUAL) 
	next_state=read_MWT ;
	else 		  
	next_state=existing_class;
read_MWT:
	next_state=update_M_compare_Th_ED; 
update_M_compare_Th_ED:  
	if(comparator==GREATER)  
	next_state=greater_than_Th;
	else 		   
	next_state=less_than_Th;             
greater_than_Th:
	next_state=update_Ths1;
less_than_Th:
	next_state=write_Ws1_Ths1;
update_Ths1:
	next_state=connections;
write_Ws1_Ths1:
	next_state=write_Ws2;
write_Ws2:
	next_state=connections;
connections:
	next_state=waiting_assoc;
endcase
end
   
endmodule               