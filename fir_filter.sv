module fir_filter (
  input logic clk,
  input logic reset,
  input logic coeff_update,
  input logic [5:0] coeff_sel,
  input logic [15:0] new_coeff,
  input logic [15:0] din,
  output logic [15:0] dout
);
  logic [15:0] reg_x[41];
  logic [15:0] reg_y;
  logic [15:0] coeff[41];
  integer i;

  initial begin
    for (int i = 0; i < 41; i++)
      coeff[i] = 16'b1;
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      for(int i=0; i<41; i++) begin
      reg_x[i] <= {16'b0};
      end
      reg_y <= 16'b0;
    end else begin
      for (i=40; i>0; i=i-1) begin
        reg_x[i] <= reg_x[i-1];
      end
      reg_x[0] <= din;
      
//      //reg_y <= ({41{coeff[40:0]}} * reg_x[40:0]);
//      reg_y<=0;
//      for(int i=0; i<41; i++) begin
//        reg_y <= coeff[i] * reg_x[i];
//      end
     
    end
    
 
  end
  always_comb if (coeff_update) begin
    coeff[coeff_sel] <= new_coeff;
    reg_y<=0;
  end
always_comb if(!reset) begin
      //reg_y <= ({41{coeff[40:0]}} * reg_x[40:0]);
      //reg_y<=0;
      for(int i=0; i<41; i++) begin
        reg_y <= coeff[i] * reg_x[i];
      end
        

 end


  assign dout = reg_y;
endmodule
