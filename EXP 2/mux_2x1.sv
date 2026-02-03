// -----------------------------------------------------------------------------
// File        : mux_2x1.sv
// Author      : Prajwal M (1BM23EC187)
// Created     : 2026-01-22
// Module      : mux_2x1
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : 2x1 multiplexer that selects one of two input signals based on
//               the select line and forwards it to the output. Used for basic
//               functional verification and coverage demonstration.
// -----------------------------------------------------------------------------
module mux_2x1(input logic [7:0]a,b,input logic s, output logic [7:0]y);
  assign y=s?b:a;
endmodule
