`timescale 1ns/1ps

module control_unit(
    input reset,
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [5:0] alu_control,
    output reg lb,
    output reg bneq_control,
    output reg beq_control,
    output reg bgeq_control,
    output reg blt_control,
    output reg jump,
    output reg sw,
    output reg lui_control,
    output reg mem_to_reg
);

always @(reset) begin
    if(reset)
            alu_control=0;
end

//-----------------------R type instructions----------------------------//

always @(funct7  or funct3 or opcode)
begin

  if(opcode==7'b0110111)
    begin
    mem_to_reg = 0;
    beq_control = 0;
    bneq_control = 0;
    bgeq_control = 0;
    blt_control = 0;
    jump = 0;
    lui_control = 0;

    case(funct3)
    3'b000:
        begin
            //--------Addition-----------------//
            if(funct7==0)
                alu_control=6'b000001;

            //--------Subtraction-----------------//    
            else if(funct7==7'b0100000)
                alu_control=6'b000010;
      
        end


//------------------------Shift left logical-----------------//
    3'b001:
        begin
            if(funct7==0)
                alu_control=6'b000011;
      
        end
    
    //-------------------Set less than------------------------//

    3'b010:
        begin
          if(funct7==0)

        alu_control=6'b000100;
        end

    //-------------------Set Less than Unsigned----------------------// 

    3'b011:
        begin
            if(funct7==0)
                alu_control=6'b000101;
        end
    

    //-------------------XOR----------------------//
    3'b100:
        begin
          if(funct7==0)
            alu_control=6'b000110;
        end

    //-------------------Shift right logical----------------------//
    3'b101:
        begin
          if(funct7==0)
            alu_control=6'b000111;
        
        else if(funct7==7'b0100000)
            alu_control=6'b001000; // Shift right arithmetic
        end
    
    //---------------------OR operation-------------------//
    3'b110:
        begin
          if(funct7==0)
            alu_control=6'b001001; //OR opeartion
        end

    //---------------------AND operation-------------------//    
    3'b111:
        begin  
            if(funct7==0)
                alu_control=6'b001010;
        end
    endcase

    end

    //-------------------------End R Type Instruction--------------------//

    //-------------------I type Instruction---------------------------//

    else if(opcode==7'b0010011)
    begin

        mem_to_reg = 0;
        beq_control = 0;
        bneq_control = 0;
        jump = 0;
        lb = 0;
        sw = 0;
                        
      
      //---------------------ADDI---------------------------//

      case(funct3)

        3'b000:
            begin
                alu_control=6'b001011; 
            end
        
        //--------------------Shift left logical-----------------//
        3'b001:
            begin
              alu_control=6'b001100;
            end

        //-------------------Shift left logical immediate -----------------------//

        3'b010:
            begin
               alu_control=6'b001101;
            end
        

        //------------------AND immediate-----------------//
        3'b011:
            begin
              alu_control=6'b001110;    
            end
    
        //------------------XOR immediate-----------------//
        3'b100:
            begin
              alu_control=6'b001111;
            end
        
        //-----------------Shift Right logic immediate------------------//

        3'b101:
            begin
              alu_control=6'b010000;
            end

        //-----------------OR immediate------------------//
        3'b110:
            begin
              alu_control=6'b010001;
            end

        //-----------------AND immediate------------------//
        3'b111:
            begin
              alu_control=6'b010010;
            end
      endcase

    end


    //-------------------End I type instruction-------------------------//

    
    //---------------Load type instruction------------------------//
    else if(opcode==7'b0000011)
    begin
      
      case(funct3)
      3'b000:   
        begin
          mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          lb=1; // load byte instruction
          alu_control=6'b010011;
        end
       
       3'b001:
        begin
          mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          lb=0; // load_half instruction
          alu_control=6'b010100;
        end
    
        3'b010:
        begin
          mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          lb=0; // load word instruction
          alu_control=6'b010101;
        end  
        
        3'b011:
        begin
        mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          lb=0; // load byte unsigned instruction   
          alu_control=6'b010110;
        end

        3'b100:
        begin
           mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          lb=0; // load byte unsigned instruction   
          alu_control=6'b010111;
        end

      endcase     
    end  

    else if(opcode==7'b0100011)
    begin
      case(funct3)
        3'b000:
        begin
          sw=1; // store byte instruction
          mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          alu_control=6'b011000;
        end

        3'b110:
        begin
          sw=1; // store half_word instruction
          mem_to_reg = 1;
          beq_control = 0;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          alu_control=6'b011001;
        end

         3'b111 :begin
                mem_to_reg = 1;        
                beq_control = 0;               
                bneq_control = 0;              
                jump = 0;
                sw = 1;
                alu_control = 6'b011010; // store word
                end

      endcase
    end


    ///------------------------Branch instructions-------------------------//
    else if(opcode==7'b1100011)
    begin

        //--------------------Branch Equal Instruction------------------//
      case(funct3)
        3'b000:
        begin
          beq_control = 1;
          bneq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          mem_to_reg = 0;
          alu_control=6'b011011; 
        end

        //---------------Branch Not Equal Instruction------------------//
        3'b001:
        begin
          bneq_control = 1;
          beq_control = 0;
          bgeq_control = 0;
          blt_control = 0;
          jump = 0;
          mem_to_reg = 0;
          alu_control=6'b011100; // BNE
        end

        3'b010:
        //----------------Branch Less than Instruction------------------//
        alu_control=6'b011101; // BLT

        3'b100:
        begin
            alu_control = 6'b100000; //BRANCH LESS THAN INSTRUCTION
            blt_control = 1;
            beq_control = 0;
            bneq_control = 0;
            bgeq_control = 0;
        end

        3'b101:
        begin
            alu_control = 6'b011111; //BRANCH  IF  GREATER THAN OR EQUAL TO INSTRUCTION
            bgeq_control = 1;
            beq_control = 0;
            bneq_control = 0;
            blt_control = 0;
        end

        3'b110:
            alu_control=6'b100000; //branch greater than instruction        
        endcase
    end

     //LUI INSTRUCTION
                       
        else if(opcode == 7'b011_0111)
            begin
                alu_control = 6'b100001;
                lui_control = 1;
                sw = 0;
                lb = 0;
                beq_control = 0;
                blt_control = 0;
                bneq_control = 0;
                bgeq_control = 0;
            end

        //JUMP INSTRUCTION
        else if(opcode == 7'b1101111)
            begin
                alu_control = 6'b100010;
                jump = 1;
                sw = 0;
                lb = 0;
                beq_control = 0;
                blt_control = 0;
                bneq_control = 0;
                bgeq_control = 0;
            end 
            
    

end



endmodule
