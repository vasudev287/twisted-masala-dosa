// Testing the EUClidian Distance module by giving it scaled down vector inputs which are 2x2 or 4x4 

import GAM_package::*; 

module test;

 
// Inputs drivers in the testbench 
node_vector_T p, q; 
logic clk;
// Output 
int out; 
 // Port mapping values 
  ED_calculator EUCD ( .x(p), .w(q), .ED (out)); 

always 
#10 clk = ~clk;

 initial  
begin:testcase_block 


//p= 32'b 0000_0000_0001_0100_0000_0000_0111_1000;

//p = 32'b 0000_0000_0010_1000_0001_0100_1010_0000;

//p= 32'b01010000000000001111000000010100;

//q= 32'b00000000_00110010_10001100_00111100;

p = 128'b 00000000_00001010_00000000_00010100_00000000_10100000_00101000_00000000_00000000_00000000_11011100_00101000_01010000_00000000_00010100_10001100;

q = 128'b 00001010_00010100_00001010_00011110_00001010_10101010_00110010_00001010_00001010_00001010_11100110_00110010_01011010_00001010_00011110_10010110;

#10 
p = 128'b 00000101_00001111_00000101_00011001_00000101_10100101_00101101_00000101_00000101_00000101_11100001_00101101_01010101_00000101_00011001_10010001;




    end                 
always @ *
    begin 
	for(int j=0;j<VECTOR_LEN;j=j+1)	      
	begin  	
	$display(" Inputs Matrix are %d:   %0d, %0d ",j, p[(j*8)+:8],q[(j*8)+:8]); //[0:9] 9 units  //8 
	end 
	$display ("Value of out is %0d, hex value %0h", out, out); end 
   endmodule 
