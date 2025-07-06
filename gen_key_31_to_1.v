`timescale 1ns / 1ps

module gen_key_31_to_1(
    input  [127:0] key,   
    output reg [127:0] kreg,
    output reg [4:0]  round,
    input         load,   
    input         clk
    );

    wire [127:0] kreg_en;
    wire [4:0] round_en;
    
    gen_key_1_to_31 generate_key( .key(key), .kreg(kreg_en), .round(round_en), .load(load), .clk(clk) );
    reg [127:0] kreg_array [0:31];


    // Load/reload key into key register
    reg [4:0] round_en_reg; 
    always @(posedge clk)
    begin
        round_en_reg <= round_en;
    end
    always @(posedge clk)
    begin
        kreg_array[round_en] <= kreg_en;
    end

    // Round counter
    always @(posedge clk)
    begin
        round <= 0;
        
        if (round_en == 0 && round_en_reg != 0)  begin

            kreg <= kreg_en;
            round <= 31; 
            end
        else if (round != 0) begin
            kreg <= kreg_array[round];
            round <= round - 1;
            end
    end
    
endmodule
