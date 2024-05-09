`timescale 1ns / 1ps


module pwm_core(
    input rst_n,
    input clk,
    input en,
    input [7:0] period,
    input [7:0] pulse_width,
    output reg pwm
);

    reg [7:0] counter = 8'd0;

    always @ (posedge clk)
    begin
        if (rst_n == 1'b0 || en == 1'b0)
            counter <= 8'd0;
        else
            if (counter == period)
                counter <= 8'd0;
            else
                counter <= counter + 1'b1;
    end     

    always @ (posedge clk)
    begin
        if (en == 1'b0 || rst_n == 1'b0)
            pwm <= 1'b0;
        else
            pwm <= (counter < pulse_width) ? 1'b1 : 1'b0;
    end

endmodule