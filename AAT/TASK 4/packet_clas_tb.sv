//------------------------------------------------------------------------------
// File       : packet_class_tb.sv
// Author     : Prajwal M (1BM23EC187)
// Created    : 2026-01-29
// Module     : tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
//              Faculty    : Prof. Ajaykumar Devarapalli
// Description: Verification of EthPacket class using functional coverage
//------------------------------------------------------------------------------
module tb;
  class EthPacket;
    rand int len;
    rand byte payload[];

    constraint c_size { payload.size() == len; }
    constraint c_len  { len inside {[4:8]}; }
  endclass

  EthPacket pkt;

  int sig_len;
  int sig_size;

  covergroup cg_pkt @(sig_len);

    cp_len : coverpoint sig_len {
      bins b4={4}; bins b5={5}; bins b6={6}; bins b7={7}; bins b8={8};
    }

    cp_size : coverpoint sig_size {
      bins s4={4}; bins s5={5}; bins s6={6}; bins s7={7}; bins s8={8};
    }

    cross cp_len, cp_size {
      ignore_bins illegal = 
        binsof(cp_len) intersect {4,5,6,7,8} &&
        binsof(cp_size) intersect {4,5,6,7,8}
        with (cp_len != cp_size);
    }

  endgroup

  cg_pkt cg;

  initial begin
    $dumpfile("packet_dump.vcd");
    $dumpvars(0, tb);

    pkt = new();
    cg = new();

    // Directed
    for(int i=4;i<=8;i++) begin
      pkt.len = i;
      pkt.payload = new[i];

      sig_len  = pkt.len;
      sig_size = pkt.payload.size();

      cg.sample();
      #10;
    end

    // Random
    repeat(10) begin
      pkt.randomize();

      sig_len  = pkt.len;
      sig_size = pkt.payload.size();

      cg.sample();
      #10;
    end

    $display("Coverage = %0.2f %%", cg.get_inst_coverage());
    $finish;
  end

endmodule
