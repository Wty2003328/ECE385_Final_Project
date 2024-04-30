`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 12:19:51 PM
// Design Name: 
// Module Name: game_state
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game_state(
    input logic clk,              
    input logic rst_n,            
    input logic man_collide_trap,              
    input logic level_complete,   
    output logic dead,            
    output logic reset,           
    output logic win              
    );
    typedef enum logic [1:0] {
        ALIVE = 2'b00,
        DEAD = 2'b01,
        RESET = 2'b10,
        WIN = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= RESET;
        end else begin
            current_state <= next_state;
        end
    end


    always_comb begin
        next_state = current_state; // ??????????????????????
        case (current_state)
            ALIVE: begin
                if (man_collide_trap) begin
                    next_state = DEAD;
                end else if (level_complete) begin
                    next_state = WIN;
                end
            end
            DEAD: begin
                next_state = DEAD;
            end
            RESET: begin
                next_state = ALIVE;
            end
            WIN: begin
                next_state = WIN;
            end
        endcase
    end

    always_comb begin
        dead = (current_state == DEAD);
        reset = (current_state == RESET);
        win = (current_state == WIN);
    end
endmodule
