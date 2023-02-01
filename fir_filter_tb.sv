`timescale 1ns / 1ps
module tb_fir_filter;

  reg clk;
  reg [15:0] din;
  reg coeff_update;
  reg [5:0] coeff_sel;
  reg reset;
  reg [15:0] new_coeff;
  wire [15:0] dout;

  fir_filter fir_inst(
    .clk(clk),
    .din(din),
    .dout(dout),
    .coeff_update(coeff_update),
    .new_coeff(new_coeff),
    .coeff_sel(coeff_sel),
    .reset(reset)
  );

  initial begin
    clk = 0;
    reset = 1;
    coeff_update = 0;
    coeff_sel = 0;
    din = 0;
    #10 
    reset = 0;
    #10;
    for (int i = 0; i < 41; i++) begin
      coeff_sel = i;
      coeff_update = 1;
      new_coeff= 16'hffff;
      #1 coeff_update = 0;
    end
    #100
    din=16'hffff;
    #100;
    din=0;
    #100;
    din=16'h1111;
    #100
    $finish;
  end

  always #5 clk = ~clk;

endmodule
