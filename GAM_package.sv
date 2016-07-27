package GAM_package;

parameter NODE_COUNT=50;
parameter CLASS_COUNT=5;  
parameter DIMENSION_ROWS=2; 
parameter DIMENSION_COLUMNS=2;
parameter VECTOR_LEN=DIMENSION_ROWS*DIMENSION_COLUMNS;       


parameter AGE_MAX=6 ;                 
        
typedef enum {READ,WRITE} RD_WR_T;       
    
typedef enum logic[1:0]{EQUAL,GREATER,LESSER} comparator_T;      

//typedef  logic [7:0] pixel_T;      
//typedef  pixel_T [DIMENSION_ROWS-1:0][DIMENSION_COLUMNS-1:0] node_vector_T;        
typedef logic [(VECTOR_LEN*8)-1:0] node_vector_T;  

typedef logic [(VECTOR_LEN*9)-1:0] node_vector_signed_T;            

////////////////////memory structure//////////////////////////////
//single node structure in a class in memory layer    
                  
typedef struct { 
//bit node_valid;    //define enum type enum {INVALID,VALID} 
node_vector_T X;                       
int class_name; // chek if needed
node_vector_T W;       
int Th;  
int M;  
}node_T;                                     
    

// class structure in memory layer   
typedef struct{                                      
int class_name;    
node_T node[NODE_COUNT:1];       
//single_node_connection_T connections[NODE_COUNT-1:0][NODE_COUNT-1:0];  //use a separate connection mem
int node_count;     
}class_T;
 
typedef struct{
class_T classes[CLASS_COUNT:1];     
}memory_T;   
////////////////////////////////////////////////////////////////////////
   
 
///////////////node counter structure /////////
typedef struct{
int node_count[CLASS_COUNT:1];       
}node_counter_mem_T;     
///////////////////////////////////////////////  

                 

/////////connection memory structure/////////// 
typedef struct{  
logic connection_presence;
int age;  
}single_node_connection_T;    
  
typedef struct {
single_node_connection_T connection[CLASS_COUNT:1][NODE_COUNT:1][NODE_COUNT:1]; 
}connection_mem_T ; 
 ///////////////////////////////////////////// 

memory_T memory;           
 endpackage:GAM_package     