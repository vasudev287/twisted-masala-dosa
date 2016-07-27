import GAM_package::* ;

module Algorithm1_validation();
logic  clk;
node_vector_T x;
int c;
logic  reset,learning_done,assoc_learning_done;
logic assoc_learning_start;  
 

Memory_Layer memory_module (
	clk,x, c, reset,learning_done,assoc_learning_done, assoc_learning_start);  
 
always 
#10 clk = ~clk;

initial 
begin 

learning_done = 0;
 x= 4'b 0001;
#20
learning_done =1;

end 
endmodule 


