// to use syncrhonous reset, comment this out and in tb_counter.sv
`define SYNC_RST

module counter # (
  parameter DATA_WIDTH = 32,
  parameter DEFAULT_LOWER_BOUND = 0
)
(
  // port list
  output    [DATA_WIDTH-1:0]   out,
  input     [DATA_WIDTH-1:0]   lower_bound,
  input     [DATA_WIDTH-1:0]   upper_bound,
  input                        clk,
  input                        rst
);
  
  reg [DATA_WIDTH-1:0] counter; // this will output a don't care until the first posedge clk

  assign out = counter;

  `ifdef SYNC_RST
      always_ff @(posedge clk) begin
        if (rst)
          counter <= lower_bound;
        else begin 
            if (counter >= lower_bound && counter < upper_bound) // valid region of operation
              counter <= counter + 1;
            else // reset to lower bound as soon as we hit upper bound and initial state
              counter <= lower_bound;
          end
        end
  `else
      always_ff @(posedge clk or posedge rst) begin
        if (rst)
          counter <= lower_bound;
        else begin 
            if (counter >= lower_bound && counter < upper_bound) // valid region of operation
              counter <= lower_bound + counter + 1;
            else // reset to lower bound as soon as we hit upper bound
              counter <= lower_bound
          end
        end
    `endif

endmodule