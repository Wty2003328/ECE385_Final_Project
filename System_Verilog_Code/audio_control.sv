`timescale 1ns / 1ps

module audio_control(
    input logic clk,
    input logic reset,
    input logic [1:0] audio_select,  // Audio selection input
    input logic playback_complete,   // Signal from pwm_core_top indicating playback completion
    output reg en,                   // Enable signal for pwm_core_top
    output reg [1:0] effective_select // The effective audio select signal to pass to pwm_core_top
);

    reg [1:0] last_audio_select;  // Track last audio selection to detect changes
    logic special_playback_active;  // Flag to indicate if a special (2'b10 or 2'b11) playback is active

    // Process to handle audio selection and playback
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            en <= 0;
            effective_select <= 2'b00;
            last_audio_select <= 2'b00;
            special_playback_active <= 0;
        end else begin
            // Reset last_audio_select when no audio is selected
            if (audio_select == 2'b00 && !special_playback_active) begin
                last_audio_select <= 2'b00;
            end

            // Check for a new selection different from the last
            if (audio_select != last_audio_select && audio_select != 2'b00 && !special_playback_active) begin
                // New selection and not the same as the last
                effective_select <= audio_select;
                en <= 1;  // Enable the sound playback
                last_audio_select <= audio_select;  // Update last_audio_select
                // Set the special playback active flag for specific conditions
                if (audio_select == 2'b10 || audio_select == 2'b11) begin
                    special_playback_active <= 1;
                end
            end else if (playback_complete) begin
                // Once playback completes, disable further sounds until a new select
                en <= 0;
                if (special_playback_active) begin
                    // If it was a special playback, keep it disabled
                    effective_select <= 2'b00;  // Clear the effective select after playback
                end
            end
        end
    end
endmodule

