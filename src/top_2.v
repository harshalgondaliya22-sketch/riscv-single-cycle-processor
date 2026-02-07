
`timescale 1ns / 1ps
module top_2(
                    input clk,
                    input reset
    );
    
    wire [31:0] imm_val_top;        //extracted immediate value (sign extended)
    wire [31:0] pc;                 //programme counter
    wire [31:0] instruction_out;    //output of instruction memory
    wire  [5:0] alu_control;        // control signal for determining the type of the alu operation
    wire  mem_to_reg;               // control signal for enabling memory to register file operation           
    wire  bneq_control;             // control signal for enabling bneq instruction                  
    wire  beq_control;              // control signal for branch equal to instruction     
    wire  jump;                     // control signal for enabling jump instruction
    wire [4:0] read_data_addr_dm;  // address for reading the data from data memory
    wire [31:0] imm_val;            // extracted immediate value from the instruction (sign extended)
    wire lb;                        // signal for enabling load operation
    wire sw;                        // signal for enabling store opeation
    wire [31:0] imm_val_branch_top; // extracted immediate value for branch instruction (sign extended)
    wire beq,bneq;                  // control signals for performiing branch equal to and not equal to operations
    wire bgeq_control;              // control signals for enabling branch greater than or equal to instruction
    wire blt_control;               // control signal for enabling branch less than instruction
    wire bge;                       // control signal for enabling branch greater than instruciton       
    wire blt;                       // control signal for enabling branch less than instruction
    wire lui_control;               // control signal for enabling load upper immediate operation
    wire [31:0] imm_val_lui;        // extracted immediate value for load upper immediate instruction (sign extended)
    wire [31:0] imm_val_jump;       // extracted immediate value for jump instruction (sign extended)
    wire [31:0] current_pc;         // register for storing return programme counter
	wire [31:0]immediate_value_store_temp;
	wire [31:0]immediate_value_store;
	wire [4:0] base_addr;
    
    instruction_fetch_unit ifu(
        .clk(clk),
        .reset(reset),
        .imm_address(imm_val_branch_top),
        .imm_address_jump(imm_val_jump),
        .beq(beq),
        .bneq(bneq),
        .bge(bge),
        .blt(blt),
        .jump(jump),
        .pc(pc),
        .current_pc(current_pc));

   
    
   
    instruction_memory imu(
        .clk(clk),
        .pc(pc),
        .reset(reset),
        .instruction_code(instruction_out));
                    
 
   
    control_unit cu(
        .reset(reset),
        .funct7(instruction_out[31:25]),
        .funct3(instruction_out[14:12]),
        .opcode(instruction_out[6:0]),
        .alu_control(alu_control),
        .lb(lb),
        .mem_to_reg(mem_to_reg),
        .bneq_control(bneq_control),
        .beq_control(beq_control),
        .bgeq_control(bgeq_control),
        .blt_control(blt_control),
        .jump(jump),
        .sw(sw),
        .lui_control(lui_control)
    );
 
 
                    
    data_path dpu(
            .clk(clk),
            .rst(reset),
            .read_reg_num1(instruction_out[19:15]),
            .read_reg_num2(instruction_out[24 : 20]),
            .write_reg_num1(instruction_out[11 : 7]),
            .alu_control(alu_control),
            .jump(jump),
            .beq_control(beq_control),
            .bneq_control(bneq_control),
            .lb(lb),
            .sw(sw),
            .bgeq_control(bgeq_control),
            .blt_control(blt_control),
            .lui_control(lui_control),
            .imm_val_lui(imm_val_lui),
            .read_data_addr_dm(read_data_addr_dm),
            .beq(beq),
            .bneq(bneq),
            .bge(bge),
            .blt(blt)
            );
        
    assign imm_val_top = {{20{instruction_out[31]}},instruction_out[31:21]};

    assign imm_val_branch_top = {{20{instruction_out[31]}},instruction_out[30:25],instruction_out[11:8],instruction_out[7]};
    assign imm_val_lui = {10'b0,instruction_out[31:12]};
    assign imm_val_jump = {{10{instruction_out[31]}},instruction_out[31:12]};
    assign imm_val = imm_val_top;
	

	
	
    
    endmodule
