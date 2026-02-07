module instruction_fetch_unit (
    input   clk,
    input  reset,

    // control signals
    input  beq,
    input  bneq,
    input  blt,
    input  bge,
    input  jump,

    // immediates
    input  wire [31:0] imm_address,
    input  wire [31:0] imm_address_jump,

    // outputs
    output reg  [31:0] pc,
    output reg  [31:0] current_pc
);

always @(posedge clk)
begin
  if(reset)
  begin
    pc<=0;

  end
  else if(beq==1 && bneq==0 && blt==0 && bge==0 && jump==0)
  begin
    pc<=pc+4;
  end

  else if(beq==1 || bneq==1 || blt==1 || bge==1)
  begin
    pc<=pc+imm_address;
  end

  else if(jump)
  pc<=pc+imm_address_jump;

  
end

always @(posedge clk)
begin
  if(reset)
  begin
    current_pc<=0;
  end

  else if(reset==0 && jump==0)
  begin
  current_pc<=pc+4;
  end
  else
  begin
    current_pc<=pc;
  end

end


endmodule
