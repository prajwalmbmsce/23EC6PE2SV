// -----------------------------------------------------------------------------
// File        : digital_clock.sv
// Author      : Prajwal M(1BM23EC187)
// Created     : 2026-01-28
// Module      : counter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Testbench to validate digital clock functionality.
// ----------------------------------------------------------------------------- 
module tb_digital_clock;

    logic clk;
    logic rst;
    logic [5:0] sec;
    logic [5:0] min;

    digital_clock dut (
        .clk(clk),
        .rst(rst),
        .sec(sec),
        .min(min)
    );

    // Clock generation (1 time unit period)
    initial clk = 0;
    always #2 clk = ~clk;

    // COVERAGE GROUP
    covergroup clock_cg @(posedge clk);

        // Transition bin for seconds rollover
        sec_transition : coverpoint sec {
            bins rollover = (59 => 0);
        }

        // Check minute increments when sec wraps
        min_transition : coverpoint min {
            bins inc = (0 => 1), (1 => 2), (2 => 3), (3 => 4),
                       (4 => 5), (5 => 6), (6 => 7), (7 => 8),
                       (8 => 9), (9 => 10);
        }

    endgroup

    clock_cg cg;
   
    initial begin
      $dumpfile("digital_clock.vcd");
      $dumpvars;
    end

    initial begin
        cg = new();

        // Reset
        rst = 1;
        #12;
        rst = 0;

        // Run long enough to see multiple rollovers
        #500;

        $display("Coverage = %0.2f%%", cg_get_coverage());

        $finish;
    end

endmodule
