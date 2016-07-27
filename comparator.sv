import GAM_package::* ;

module comparator(input int in1,in2,
		 output comparator_T out);

always @ (*)
begin
//assert ( !($isunknown (in1,in2)) ) $display ("COMPARATOR:invalid input"); ; 
if(in1==in2) out=EQUAL;
else if(in1>in2) out=GREATER;
else out=LESSER;  
end

endmodule                                   