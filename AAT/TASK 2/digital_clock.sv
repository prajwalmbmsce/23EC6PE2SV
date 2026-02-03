// -----------------------------------------------------------------------------
// File        : digital_clock.sv
// Author      : Prajwal M(1BM23EC187)
// Created     : 2026-01-28
// Module      : counter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Digital clock that tracks time using counters.
// ----------------------------------------------------------------------------- 
module digital_clock (
    input  logic clk,
    input  logic rst,
    output logic [5:0] sec,
    output logic [5:0] min
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sec <= 0;
            min <= 0;
        end
        else begin
            if (sec == 59) begin
                sec <= 0;

                if (min == 59)
                    min <= 0;
                else
                    min <= min + 1;
            end
            else begin
                sec <= sec + 1;
            end
        end
    end

endmodule
