`timescale 1ns/1ps

module data_path (
    input  clk,
    input  rst,

    // -------- Register addresses --------
    input [4:0]  read_reg_num1,
    input [4:0]  read_reg_num2,
    input [4:0]  write_reg_num1,

    // -------- Control signals --------
    input [5:0]  alu_control,
    input  jump,
    input  beq_control,
    input  bneq_control,
    input  bgeq_control,
    input  blt_control,
    input  lb,
    input  sw,
    input  lui_control,

    // -------- Immediate & shift --------
    input  [31:0] imm_val_lui,
    input  [3:0]  shamt,

    // -------- Outputs --------
    output  [4:0]  read_data_addr_dm,
    output beq,
    output bneq,
    output bge,
    output blt
);

    wire [31:0] read_data1;
    
    wire [31:0] read_data2;
    
    wire [4:0] read_data_addr_dm_2;
    
    wire [31:0] write_data_alu;
    
    
    
    wire [31:0] data_out;
    
    wire [31:0]  data_out_2_dm;
    
    register_file rfu (
       .clk(clk),
       .rst(rst),
       .lui_control(lui_control),
       .read_reg_num1(read_reg_num1),
       .read_reg_num2(read_reg_num2),
       .write_reg_num1(write_reg_num1),
       .imm_val_lui(imm_val_lui),
       .jump(jump),
       .lb(lb),
       .sw(sw),
       .read_data1(read_data1),
       .read_data2(read_data2),
       .read_data_addr_dm(read_data_addr_dm_2),
       .data_out_2_dm(data_out_2_dm)
    );

    alu alu_unit (
        .src1(read_data1),
        .src2(read_data2),
        .alu_control(alu_control),
        .imm_val_r(imm_val_lui),
        .shamt(shamt),
        .result(write_data_alu)
    );

    data_memory dm(
        .clk(clk),
        .rst(rst),
        .wr_addr(imm_val_lui[4:0]),
        .wr_data(data_out_2_dm),
        .sw(sw),
        .rd_addr(imm_val_lui[4:0]),
        .data_out(data_out)
    );  
    

    assign read_data_addr_dm = read_data_addr_dm_2;
    assign beq=(write_data_alu==1||beq_control==1)?1:0;
    assign bneq=(write_data_alu==1 || bneq_control==1)?1:0;
    assign bge=(write_data_alu==1 || bgeq_control==1)?1:0;
    assign blt=(write_data_alu==1 || blt_control==1)?1:0;

endmodule