// -----------------------------------------------------------------------------
// File        : the_calculator_tb.sv
// Author      : Prajwal M(1BM23EC187)
// Created     : 2026-01-28
// Module      : tb_alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Testbench to validate ALU functionality.
// ----------------------------------------------------------------------------- 
class alu_transaction;

    rand logic [7:0] a;
    rand logic [7:0] b;
    rand opcode_t   op;

    constraint op_dist {
        op dist {
            ADD := 30,
            SUB := 30,
            MUL := 20,
            XOR := 20
        };
    }

endclass

module tb_alu;

    logic [7:0] a, b;
    opcode_t   op;
    logic [15:0] result;

    alu dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    alu_transaction tr;

    covergroup alu_cg;
        coverpoint op {
            bins add = {ADD};
            bins sub = {SUB};
            bins mul = {MUL};
            bins xor1 = {XOR};
        }
    endgroup

    alu_cg cg;

    initial begin
      $dumpfile("alu.vcd");
      $dumpvars;
        tr = new();
        cg = new();

      repeat (50) begin
            assert(tr.randomize());

            a  = tr.a;
            b  = tr.b;
            op = tr.op;

            #5;

            cg.sample();
            $display("a=%0d b=%0d op=%0d result=%0d",
                      a, b, op, result);
        end

        $display("Coverage = %0.2f%%", cg.get_coverage());

        $finish;
    end

endmodule
