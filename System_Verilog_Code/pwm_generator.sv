`timescale 1ns / 1ps

module pwm_top(
    input logic Clk,
    input logic reset_rtl_0,
    input logic en,
    input logic jump,  // Jump sound trigger
    input logic dead,  // Dead sound trigger
    input logic win,   // Win sound trigger
    output logic leftsound,
    output logic rightsound,
    output logic playback_complete
);
    logic pwm;
    logic ena;
    logic [7:0] pwm_value;
    logic [16:0] address;
    integer sample_counter = 0;
    logic [16:0] last_address;  // Adjusted to match the largest ROM size
    logic audio_active;  // Indicates if audio should currently be active

    // Priority management and playback status
    logic special_playback_active;  // Indicates if a special sound (dead or win) is playing
    logic [1:0] audio_select;
    logic [1:0] last_audio_select;

    assign leftsound = pwm;
    assign rightsound = pwm;

    // Update audio select with priority consideration
    always_comb begin
        if (dead)
            audio_select = 2'b10;
        else if (win)
            audio_select = 2'b11;
        else if (jump)
            audio_select = 2'b01;
        else
            audio_select = 2'b00;
    end

    // Determine the last address based on the selected audio track
    always_comb begin
        case (audio_select)
            2'b01: last_address = 6655;   // 'Jump' audio
            2'b10: last_address = 26431;  // 'Dead' audio
            2'b11: last_address = 69887;  // 'Win' audio
            default: last_address = 0;    // No audio
        endcase
    end

    // Playback control logic
    always_ff @(posedge Clk or posedge reset_rtl_0) begin
        if (reset_rtl_0) begin
            address <= 0;
            ena <= 0;
            sample_counter <= 0;
            playback_complete <= 0;
            audio_active <= 0;
            special_playback_active <= 0;
            last_audio_select <= 2'b00;
        end else begin
            if (audio_select != last_audio_select && !special_playback_active) begin
                ena <= 1;
                address <= 0;
                playback_complete <= 0;
                audio_active <= 1;
                last_audio_select <= audio_select;

                // Mark special playback as active if dead or win sound is selected
                special_playback_active <= (audio_select == 2'b10 || audio_select == 2'b11);
            end

            if (audio_active) begin
                if (sample_counter >= 2267) begin
                    sample_counter <= 0;
                    if (address == last_address) begin
                        playback_complete <= 1;
                        audio_active <= 0;
                        ena <= 0;
                        if (special_playback_active) special_playback_active <= 0; // Reset on special sound completion
                    end else begin
                        address <= address + 1;
                    end
                end else begin
                    sample_counter <= sample_counter + 1;
                end
            end
        end
    end

    // Instantiate ROM and PWM generator
    audio_rom rom (
        .clk(Clk),
        .address(address),
        .select(audio_select),
        .data(pwm_value)
    );

    pwm_core pwm_generator(
        .rst_n(~reset_rtl_0),
        .clk(Clk),
        .en(ena),
        .period(8'd255),
        .pulse_width(pwm_value),
        .pwm(pwm)
    );
endmodule
