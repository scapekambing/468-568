// to use syncrhonous reset, comment this out and in tb_counter.sv
`define SYNC_RST
`define USE_DEFAULT_LOWER_BOUND

module counter # (
  parameter DATA_WIDTH = 32,
  parameter DEFAULT_LOWER_BOUND = 0
)
(
  // port list
  output [DATA_WIDTH-1:0]   out,
  input  [DATA_WIDTH-1:0]   lower_bound,
  input  [DATA_WIDTH-1:0]   upper_bound,
  input                     clk,
  input                     rst
);

  // internal signals
  `ifdef USE_DEFAULT_LOWER_BOUND
    reg [DATA_WIDTH-1:0] counter = {{DATA_WIDTH{1'b0}}, DEFAULT_LOWER_BOUND};
  `else
    reg [DATA_WIDTH-1:0] counter; // this will output a don't care until the first posedge clk
  `endif
  assign out = counter;

  `ifdef SYNC_RST
      always @(posedge clk) begin
        if (rst)
          counter <= lower_bound;
        else
          if (counter >= lower_bound && counter < upper_bound)
            counter <= counter + 1;
          else
            counter <= lower_bound;
      end 
  `else
      always @(posedge clk or posedge rst) begin
        if (rst)
          counter <= lower_bound;
        else
          if (counter >= lower_bound & counter < upper_bound)
            counter <= counter + 1;
          else
            counter <= lower_bound;
      end 
    `endif

endmodule