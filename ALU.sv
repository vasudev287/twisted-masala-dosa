parameter array_length = 8; 

 
module  addition(
input logic signed [array_length  :0] a, b,      
output logic signed[array_length-1:0] c);
logic   overflow;  

always_comb 
begin  
	overflow= (a[array_length -1] & b[array_length -1]) ;   //changed     
	 c =  a+ b;         
	assert (overflow != 1) $display ("Overflow occured");	
end   	  
 

endmodule                    
 
module subtraction(
input logic [array_length-1:0] a, b,
//input  logic[ array_length -1: 0] b;
output  logic [array_length-1:0] c);
always_comb 
begin 	
	
	if ( a < b  )
	 begin
	   c  = a - b;
	end 
	else c = b-a; 
end  	
endmodule 
 
module subtraction_signed(
	input logic signed [array_length:0] a,b,
	output logic signed [array_length:0] out);   
  
always_comb
out<=a-b;              

endmodule 

   
module  multiplication(   //change w.r.t port sizes and overflow  

input int a,
input int b,  
output logic   [array_length-1:0] c);
logic overflow;
always_comb 
begin 
 {overflow, c} = a * b;
// assert to check overflow
	assert (overflow != 1) $display ("Overflow occured");	

end 
endmodule


module  division(
input int signed a, // 
input int signed b,
output int signed c); 
always_comb 
begin 
 c = a / b; 
end
endmodule 

module  division_logic(                       //new module        
input logic signed [array_length:0] a, // 
input int signed b,
output logic signed[array_length:0] c);  
always_comb 
begin 
 c = a / b;              
end
endmodule  
     
 

module  square(
input logic [array_length -1 :0] a,

output int   b);
always_comb 
begin 
 b = a ** 2; 
end    
endmodule   

   
module  sqrt(
input logic [array_length -1 :0] a,
output logic [array_length -1 :0] out);
int  square = 1;
int  delta = 3;
always_comb 
begin 
while(square <= a)
begin 
square = square + delta;
delta = delta + 2;
end 
out = (delta/2 - 1);
end 
endmodule 
 
module  int_addition(
input int signed a, b,
output int signed c);     //change port c size to 8                 
logic   overflow;    		
 
always_comb 
begin 
	{overflow, c} = {a[31], a} + {b[31], b};
	assert (overflow != 1) $display ("Overflow occured");	
end   	
endmodule      


module vector_addition (
input [(array_length*8) -1: 0] a, 
output [array_length-1 : 0] out);
always_comb   
begin        
	for ( int i =0; i< 8; i++ )
	begin
	out[array_length -1: 0] += a[array_length*i -1: i];
	end 
end 
  
endmodule             