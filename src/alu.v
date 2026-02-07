
`timescale 1ns / 1ps

module alu(
  input [31:0] src1,
input [31:0] src2,
input [5:0] alu_control,
input [31:0] imm_val_r,
input [3:0] shamt,
output reg [31:0] result
);


always @(*)
begin
  
case(alu_control)
  6'b000001:
  begin
    result=src1+src2; //ADD
  end

  6'b000010:
  begin
    result=src1-src2; //SUB
  end

  6'b000011:
  begin
    result= src1<< src2;//SLL
  end

  6'b000100:
  begin
    result=(src1<src2)?1:0; //SLT
  end

  6'b000101:
  begin
    result=(src1<src2)?1:0; //SLTU
  end

  6'b000110:
  begin
    result= src1 ^src2; //XOR
  end

  6'b000111:
  begin
    result=src1>>src2 ;//SRL
  end

  6'b001000:
  begin
    result=$signed(src1)>>>src2 ;//SRA
  end

  6'b001001:
  begin
    result=src1| src2; //OR
  end

  6'b001010:
  begin
    result=src1 & src2; //AND
  end

  6'b001011:  //ADDI
  begin
    result=src1+imm_val_r;
  end

  6'b001100:  //SLLI
  begin
    result= src1 << shamt;

  end

  6'b001101: //SLTI
  begin
    result= ($signed(src1) <$signed(imm_val_r)) ? 32'd1:32'd0;    
  end

  6'b001110: //SLTIU
  begin
    result= ($unsigned(src1)<$unsigned(imm_val_r)) ? 32'd1:32'd0;
  end

  6'b001111: //XORI
  begin
    result=(src1 ^imm_val_r);
  end

  6'b010000: //SRLI
  begin
    result= src1 >> shamt;
  end

  6'b010001: //SRAI
  begin
    result= $signed(src1)>> shamt;
  end

  6'b010010: //ORI
  begin
    result=src1 | imm_val_r;
  end

  6'b010011: //ANDI
  begin
    result= src1 & imm_val_r;
  end
  

  6'b010100:
  begin
    result=imm_val_r; //LUI
    
  end

  6'b010101: //BEQ
  begin
    result= (src1==src2) ?1:0;
  end

  6'b010110: //BNE
  begin
    result= (src1 !=src2) ?1:0;
  end

  6'b010111: //BLT
  begin
    result=($signed(src1)< $signed(src2))?1:0;
  end

  6'b011000: //BGE
  begin
    result=($signed(src1)> $signed(src2))?1:0;
  end

  6'b011001: //BLTU
  begin
    result= ($unsigned(src1)<$unsigned(src2))?1:0;
  end

  6'b011010: //BGEU
  begin
    result= ($unsigned(src1)>$unsigned(src2))?1:0;
  end

  endcase



  end
endmodule



