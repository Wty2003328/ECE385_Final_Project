`timescale 1ns / 1ps


module audio_rom(
    input logic clk,
    input logic [16:0] address,
    input logic [1:0] select,
    output logic [7:0] data
);
    // Block Memory Interface Wires for each sound type
    wire [7:0] data_jump;
    wire [7:0] data_dead;
    wire [7:0] data_win;


    // Instantiate each Block Memory for different sound data
    blk_mem_gen_9 blk_sound_jump(
        .clka(clk),
        .wea(1'b0),
        .addra(address),
        .dina(8'b0),
        .douta(data_jump)
    );

    blk_mem_gen_10 blk_sound_dead(
        .clka(clk),
        .wea(1'b0),
        .addra(address),
        .dina(8'b0),
        .douta(data_dead)
    );

    blk_mem_gen_11 blk_sound_win(
        .clka(clk),
        .wea(1'b0),
        .addra(address),
        .dina(8'b0),
        .douta(data_win)
    );



    // Data selection logic based on input select
    always_ff @(posedge clk) begin
        case(select)
            2'b00: data <= 8'd0;
            2'b01: data <= data_jump;
            2'b10: data <= data_dead;
            2'b11: data <= data_win;
            default: data <= 8'd0; // Safe default
        endcase
    end
endmodule