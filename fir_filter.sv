`timescale 1ns/1ns

module fir_filter (
    input wire clk,
    input wire reset,
    input wire update_coeff,
    input wire [15:0] data_in,
    input wire [15:0] coeff[40:0],
    output reg [31:0] data_out
);
    reg [15:0] coeff_reg[40:0];
    reg [15:0] data_reg[40:0];
    reg [31:0] acc;
    reg [3:0] i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 40; i > 0; i--) begin
                data_reg[i] <= 0;
                coeff_reg[i] <= 0;
            end
            acc <= 0;
        end else begin
            if(update_coeff) begin
                coeff_reg <= coeff;
            end else begin
                data_reg[0] <= data_in;
                acc <= acc + data_reg[0] * coeff_reg[0];
                for (i = 39; i > 0; i--) begin
                    data_reg[i] <= data_reg[i-1];
                    acc <= acc + data_reg[i] * coeff_reg[i];
                end
                data_out <= acc;
            end
        end
    end
endmodule
