program clock_test (clock_interface.TB intf);

    covergroup clk_cov;
        coverpoint intf.seconds { bins sec[] = {[0:59]}; }
        coverpoint intf.minutes { bins min[] = {[0:59]}; }

        sec_min_cross : cross intf.seconds, intf.minutes;

        sec_roll : coverpoint intf.seconds {
            bins rollover = (59 => 0);
        }

        min_roll : coverpoint intf.minutes {
            bins rollover = (59 => 0);
        }
    endgroup

    clk_cov cov = new();

    always @(posedge intf.clk) begin
        assert (intf.seconds <= 59)
            else $error("Seconds overflow!");

        assert (intf.minutes <= 59)
            else $error("Minutes overflow!");
    end

    initial begin
        intf.reset = 1;
        repeat(2) @(posedge intf.clk);
        intf.reset = 0;

        repeat(4000) begin
            @(posedge intf.clk);
            cov.sample();
        end

        $display("SIMULATION COMPLETE");
        $finish;
    end

endprogram
