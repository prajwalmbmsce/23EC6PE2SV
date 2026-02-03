// -----------------------------------------------------------------------------
// File        : alu_tb.sv
// Author      : Prajwal M (1BM23EC187)
// Created     : 2026-01-22
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Testbench to validate ALU functionality using random inputs and
//               functional coverage for opcode verification.
// ----------------------------------------------------------------------------- 
module tb;
   logic [7:0] a, b, y;
   opcode_e op;
   alu dut(.*);

   covergroup cg_alu;
     cp_op: coverpoint op; 
   endgroup
   cg_alu cg=new();

   initial begin
     $dumpfile("dump.vcd");
     $dumpvars;
     repeat(50) begin
       a=$urandom(); b=$urandom();
       op=opcode_e '($urandom_range(0,3)); 
       #5; cg.sample();
     end
     $display( "Coverage: %0.2f %%", cg.get_inst_coverage());
   end
endmodule
