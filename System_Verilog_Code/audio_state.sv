`timescale 1ns / 1ps

module audio_state(
    input logic Clk,
    input logic reset_rtl_0,
    input logic dead,
    input logic win,
    input logic jump,
    
    output logic leftsound,
    output logic rightsound
);

    logic [1:0] audio_select;
    logic audio_enable;
    logic audio_complete;  // Flag to indicate when audio playback is complete

    // State definitions for audio control
    typedef enum logic [2:0] {
        IDLE,
        PLAY_JUMP,
        PLAY_DEAD,
        PLAY_WIN,
        WAIT_COMPLETE  // State to wait until the audio completes
    } audio_state_t;

    audio_state_t audio_state, next_audio_state;

    // Audio state machine
    always_ff @(posedge Clk or posedge reset_rtl_0) begin
        if (reset_rtl_0)
            audio_state <= IDLE;
        else
            audio_state <= next_audio_state;
    end

    // Next state logic
    always_comb begin
        next_audio_state = audio_state;
        case (audio_state)
            IDLE: begin
                if (jump)
                    next_audio_state = PLAY_JUMP;
                else if (dead)
                    next_audio_state = PLAY_DEAD;
                else if (win)
                    next_audio_state = PLAY_WIN;
            end
            PLAY_JUMP: begin
                if (audio_complete)
                    next_audio_state = IDLE;
            end
            PLAY_DEAD, PLAY_WIN: begin
                // Remain in these states until the audio completes
                if (audio_complete)
                    next_audio_state = WAIT_COMPLETE;
            end
            WAIT_COMPLETE: begin
                // Stay in this state to inhibit other sounds until reset or specific signal
            end
            default: begin
                next_audio_state = IDLE;
            end
        endcase
    end

    // Control signals based on state
    always_comb begin
        audio_enable = (audio_state == PLAY_JUMP) || (audio_state == PLAY_DEAD) || (audio_state == PLAY_WIN);
        audio_complete = (audio_pwm.playback_complete);  
        case (audio_state)
            PLAY_JUMP: audio_select = 2'b01;
            PLAY_DEAD: audio_select = 2'b10;
            PLAY_WIN: audio_select = 2'b11;
            default: audio_select = 2'b00;
        endcase
    end

    // Instantiate the audio PWM module
    pwm_top audio_pwm (
        .Clk(Clk),
        .reset_rtl_0(reset_rtl_0),
        .en(audio_enable),
        .audio_select(audio_select),
        .leftsound(leftsound),
        .rightsound(rightsound),
        .playback_complete(audio_complete)
    );


endmodule