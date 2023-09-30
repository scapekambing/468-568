`timescale 1ns/1ns

`include "vunit_defines.svh"

// to use asyncrhonous reset, comment this out and in counter.sv
`define SYNC_RST

module tb_counter();

  // initialize params
  localparam clk_period   = 10;
  localparam n_wraps      = 2;
  integer unsigned        i;
  localparam DATA_WIDTH   = 32;
  localparam lowb         = 3;
  localparam uppb         = 10;
  localparam range        = uppb - lowb + 1;
  localparam offset       = range/2;

  // internal signals
  reg                     clk;
  reg                     rst;
  wire  [DATA_WIDTH-1:0]  cout;

  // clock generation
  always begin
    #(clk_period/2) clk = ~clk;
  end

  // device under test (dut)
  reg [DATA_WIDTH-1:0] lower_bound = {{DATA_WIDTH{1'b0}}, lowb}; 
  reg [DATA_WIDTH-1:0] upper_bound = {{DATA_WIDTH{1'b0}}, uppb};

  counter dut (
    .out(cout),
    .lower_bound(lowb),
    .upper_bound(uppb),
    .clk(clk),
    .rst(rst)
  );

  `TEST_SUITE begin 
    `TEST_CASE("sanity") begin
      `CHECK_EQUAL(1,1);
    end

    `TEST_CASE("operation") begin
      clk = 0;
      rst = 0;
      $monitor("i=%d, time=%0t, clk=%b, cout=%d, rst=%b", i, $time, clk, cout, rst);
      for (i = 0; i <= range*n_wraps; i = i + 1) begin
        #(clk_period);
      end
      `CHECK_EQUAL(cout,lowb);
    end

    `TEST_CASE("hold_reset") begin
      clk = 0;
      rst = 0;
      for (i = 0; i <= range*n_wraps; i = i + 1) begin
        #(clk_period);
      end
      `CHECK_EQUAL(cout, lowb);
    end

    `TEST_CASE("enable_reset") begin
      clk = 0;
      rst = 0;
      $monitor("i=%d, time=%0t, clk=%b, cout=%d, rst=%b", i, $time, clk, cout, rst);
      for (i = 0; i <= range + offset; i = i + 1) begin
        #(clk_period);
      end
      `ifdef SYNC_RST
        $display("doing sync reset");
        rst = 1;
        #(clk_period);
        `CHECK_EQUAL(cout, lowb);
      `else
        $display("doing async reset");
        rst = 1;
        #(clk_period/2);
        `CHECK_EQUAL(cout, lowb);
      `endif
    end
    
  end
endmodule