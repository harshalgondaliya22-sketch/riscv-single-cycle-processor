`timescale 1ns / 1ps
module imm_gen(
            input [31:0] instr_memory,
            output [31:0]imm_val_r

    );
    
    reg [6:0] opcode; 
    reg [31:0] imm_val_reg;
    
    always@(*)
        begin
         opcode = instr_memory[6:0];
        end
        
    always@(*)
        begin
            if(opcode == 7'b001_0011)
                begin
                    imm_val_reg = instr_memory[31 : 20];
                end
        end
        
     assign imm_val_r = imm_val_reg;
     
     
                              
endmodule