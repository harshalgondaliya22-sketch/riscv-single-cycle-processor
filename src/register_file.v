`timescale 1ns / 1ps

module register_file(
    input clk,
    input rst,
    input lui_control, //lui control signal
    input [4:0] read_reg_num1,//address of first source register
    input [4:0] read_reg_num2,//address of second source register
    input [4:0] write_reg_num1,//address of destination register
    input [31:0] write_data_dm,//data from data memory
    input [31:0] imm_val_lui ,
    input jump,
    input lb,
    input sw,
    output  [31:0] read_data1,//read data of first source register
    output  [31:0] read_data2, //read data of second source register
    output [4:0] read_data_addr_dm, // address for data memory
    output  reg [31:0] data_out_2_dm // data of destination register

);

integer i;
reg [31:0] reg_mem[31:0]; // 32 registers of 32 bits each
wire [31:0] write_reg_data; //address for load  instruction

  assign read_data_addr_dm = write_reg_num1;
  assign write_reg_dm = write_reg_num1;
        
always @(posedge clk)
begin
  
  if(rst)
    begin
      for(i=0;i<32;i=i+1)
      begin
      reg_mem[i] <= i;  // Initialize to 0
      data_out_2_dm <= 0;
    end
  end

  else
    begin
      if(lb)
        reg_mem[write_reg_num1]=write_data_dm;

      else if(sw)
      data_out_2_dm=reg_mem[read_reg_num1];
  
      else if(lui_control)
      reg_mem[write_reg_num1]=imm_val_lui;
  end

end

assign read_data1=reg_mem[read_reg_num1];

assign read_data2=reg_mem[read_reg_num2];

endmodule

