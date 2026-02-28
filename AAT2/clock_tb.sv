module clock_tb;

    clock_interface intf();

    digital_clock DUT (
        .clk(intf.clk),
        .reset(intf.reset),
        .seconds(intf.seconds),
        .minutes(intf.minutes)
    );

    clock_test test(intf);

    initial begin
        intf.clk = 0;
        forever #5 intf.clk = ~intf.clk;
    end

endmodule
