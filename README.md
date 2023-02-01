# fir-filter-system-verilog

The code implements a 41-tap finite impulse response (FIR) filter. 
The inputs are 
a clock signal (clk), 
a reset signal (reset), 
a signal to update the filter coefficients (coeff_update), 
a selector for the coefficient to update (coeff_sel), 
the new coefficient value (new_coeff), 
the input data (din), 
and the filter output (dout).

The reg_x and reg_y arrays are used to store the intermediate values of the input and filter output, respectively. 
The acc register is used to accumulate the final filter output. The coeff array is used to store the filter coefficients.

The always_ff block updates the reg_x and reg_y arrays on each rising edge of the clock. 
If the reset signal is active, all the registers are cleared. 
If the reset signal is inactive, the input data is shifted into the reg_x array, and the intermediate values in the reg_y array are updated.

The always_comb block updates the filter coefficients when the coeff_update signal is high. 
The final filter output is calculated in another always_comb block by adding up all the intermediate values stored in the reg_y array. 
This accumulated value is stored in the acc register, and it is assigned to the filter output (dout).

Simulation images shows the function of the filter.
