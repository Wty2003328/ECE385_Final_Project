`timescale 1ns / 1ps

module audio_selector(
    input logic clk,
    input logic reset,
    input logic jump,
    input logic dead,
    input logic win,
    output reg [1:0] audio_select
);

// Initialize audio_select to no sound
initial begin
    audio_select = 2'b00;
end

// Process to determine audio selection based on input flags
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        audio_select <= 2'b00; // Default to no audio on reset
    end else begin
        if (jump)
            audio_select <= 2'b01;
        else if (dead)
            audio_select <= 2'b10;
        else if (win)
            audio_select <= 2'b11;
        else
            audio_select <= 2'b00;
    end
end

endmodule
