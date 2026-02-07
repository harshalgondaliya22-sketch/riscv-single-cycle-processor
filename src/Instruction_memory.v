
`timescale 1ns / 1ps

module instruction_memory(
    input clk,
    input [31:0] pc,
    input reset,
    output  [31:0] instruction_code
);

reg[7:0]memory[108:0];

assign instruction_code= {memory[pc+3],memory[pc+2],memory[pc+1],memory[pc]};

always @(posedge clk)

begin
    if(reset==1)
    begin
    // ADD register to register
        memory[3]=8'h00;
        memory[2]=8'h94;
        memory[1]=8'h03;
        memory[0]=8'h33;

    // SUB register to register
        memory[7]=8'h80;
        memory[6]=8'h01;
        memory[5]=8'h00;
        memory[4]=8'hb3;

        // SLL
        memory[11]=8'h00;
        memory[10]=8'h94;
        memory[9]=8'h13;   // funct3 = 001
        memory[8]=8'h33;

        // SLT
        memory[15]=8'h00;
        memory[14]=8'h94;
        memory[13]=8'h23;   // funct3 = 010
        memory[12]=8'h33;

        // SLTU
        memory[16]=8'h00;
        memory[15]=8'h94;
        memory[14]=8'h33;   // funct3 = 011
        memory[13]=8'h33;        
    

    // XOR
        memory[17]=8'h00;
        memory[16]=8'h94;
        memory[15]=8'h43;   // funct3 = 100
        memory[14]=8'h33;

        // SRL
        memory[21]=8'h00;
        memory[20]=8'h94;
        memory[19]=8'h53;   // funct3 = 101
        memory[18]=8'h33;

        // SRA
        memory[25]=8'h20;   // funct7 = 0100000
        memory[24]=8'h94;
        memory[23]=8'h53;   // funct3 = 101
        memory[22]=8'h33;

        // OR
        memory[29]=8'h00;
        memory[28]=8'h94;
        memory[27]=8'h63;   // funct3 = 110
        memory[26]=8'h33;

        // AND
        memory[33]=8'h00;
        memory[32]=8'h94;
        memory[31]=8'h73;   // funct3 = 111
        memory[30]=8'h33;


        //------------ I-type instructions ------------//

        memory[37]=8'h00;
        memory[36]=8'ha0;
        memory[35]=8'h85;
        memory[34]=8'h13;   // ADDI instruction

        memory[41]=8'h00;
        memory[40]=8'h41;
        memory[39]=8'h93;
        memory[38]=8'h13;   // SLLi instruction

        memory[45]=8'h03;
        memory[44]=8'hf2;
        memory[43]=8'h32;
        memory[42]=8'h41;   // XORi instruction

       memory[46] = 8'h00;
       memory[45] = 8'h32;
       memory[44] = 8'hB5;
       memory[43] = 8'h13;   // SLTIU x10, x5, 3

        memory[50] = 8'h00;
        memory[49] = 8'h32;
        memory[48] = 8'hE5;
        memory[47] = 8'h13;   // ORI x10, x5, 3

        memory[54] = 8'h00;
        memory[53] = 8'h32;
        memory[52] = 8'hF5;
        memory[51] = 8'h13;   // ANDI x10, x5, 3

        memory[62] = 8'h00;
        memory[61] = 8'h32;
        memory[60] = 8'hD5;
        memory[59] = 8'h13;   // SRLI x10, x5, 3

        memory[66] = 8'h40;
        memory[65] = 8'h32;
        memory[64] = 8'hD5;
        memory[63] = 8'h13;   // SRAI x10, x5, 3

        //------------Load Instruction----------------//

        memory[68] = 8'h05;
        memory[67] = 8'ha8;
        memory[66] = 8'h25;
        memory[65] = 8'h37;   // LB x0, 0(x5)

        //------------branch Instructions---------------//

        memory[72]=8'h00;
        memory[71]=8'h30;
        memory[70]=8'h84;
        memory[69]=8'h63;   // BEQ instruction x3,x1 --> pc=pc+8

        memory[76]=8'h00;
        memory[75]=8'h30;
        memory[74]=8'h94;
        memory[73]=8'h63;   // BNE instruction x3,x1 --> pc=pc+8

        memory[80]=8'h00;
        memory[79]=8'h30;
        memory[78]=8'ha4;
        memory[77]=8'h63;   // BLT (Less than Sign) instruction x3,x1 --> pc=pc+8

        memory[84]=8'h00;
        memory[83]=8'h30;
        memory[82]=8'hb4;
        memory[81]=8'h63;   // BGE(Greater than Signed) instruction x3,x1 --> pc=pc+8

        memory[88]=8'h00;
        memory[87]=8'hA0;
        memory[86]=8'hE4;
        memory[85]=8'h63;   // BLTU (Less than Unsigned) instruction x10,x1 --> pc=pc+8

        memory[92]=8'h00;
        memory[91]=8'hA0;
        memory[90]=8'hF4;
        memory[89]=8'h63;  // BGEU (Greater than Unsigned)instruction x10,x1 --> pc=pc+8

//------------jump instruction------------------//

        memory[96]=8'h00;
        memory[95]=8'hC0;
        memory[94]=8'h02;
        memory[93]=8'hEF;  
     // JUMP instruction X5 ,offset=12
end
end




endmodule

