`timescale 1ns / 1ps
module fir_filter (
  input logic clk,
  input logic reset,
  input logic coeff_update,
  input logic [5:0] coeff_sel,
  input logic [15:0] new_coeff,
  input logic [15:0] din,
  output logic [31:0] dout
);
  logic [15:0] reg_x[41];
  logic [31:0] reg_y[41];
  logic [31:0] acc;
  logic [15:0] coeff[41];
  integer i;

  always_ff @(posedge clk) begin
    if (reset) begin
      for(int i=0; i<41; i++) begin
      reg_x[i] <= {16'b0};
      reg_y[i] <= {32'b0};
      end
      acc<=0;
      
    end 
    else if(!coeff_update) begin
      for (i=40; i>0; i=i-1) begin
        reg_x[i] <= reg_x[i-1];
      end
      reg_x[0] <= din;
      
      //multiply
      for(int i=0; i<41; i++) begin
        reg_y[i] <= reg_x[i]*coeff[i];
      end
      
      //accumulate
      acc<=0;
      //maunally unrolling and accumulating as simulator crashes if I d with a for loop
      acc<= reg_y[0]+reg_y[1]+reg_y[2]+reg_y[3]+reg_y[4]+reg_y[5]+reg_y[6]+reg_y[7]+reg_y[8]+reg_y[9]+reg_y[10]+reg_y[11]+reg_y[12]+reg_y[13]+reg_y[14]+reg_y[15]
      +reg_y[16]+reg_y[16]+reg_y[17]+reg_y[18]+reg_y[19]+reg_y[20]+reg_y[21]+reg_y[22]+reg_y[23]+reg_y[24]+reg_y[25]+reg_y[26]+reg_y[27]+reg_y[28]+reg_y[29]+reg_y[30]
      +reg_y[31]+reg_y[32]+reg_y[33]+reg_y[34]+reg_y[35]+reg_y[36]+reg_y[37]+reg_y[38]+reg_y[39]+reg_y[40]
      ;
    end
    
 
  end
  always_comb if (coeff_update) begin
    coeff[coeff_sel] <= new_coeff;
  end
  
//always_comb if(!reset) begin
      
      
// end

//always_comb if(!reset) begin
//     acc<=0;
//      acc<= reg_y[0]+reg_y[1]+reg_y[2]+reg_y[3]+reg_y[4]+reg_y[5]+reg_y[6]+reg_y[7]+reg_y[8]+reg_y[9]+reg_y[10]+reg_y[11]+reg_y[12]+reg_y[13]+reg_y[14]+reg_y[15]
//      +reg_y[16]+reg_y[16]+reg_y[17]+reg_y[18]+reg_y[19]+reg_y[20]+reg_y[21]+reg_y[22]+reg_y[23]+reg_y[24]+reg_y[25]+reg_y[26]+reg_y[27]+reg_y[28]+reg_y[29]+reg_y[30]
//      +reg_y[31]+reg_y[32]+reg_y[33]+reg_y[34]+reg_y[35]+reg_y[36]+reg_y[37]+reg_y[38]+reg_y[39]+reg_y[40]
//      ;
      
// end

  assign dout = acc;
endmodule
