`timescale 1ns/1ps

module DM_PRESENT (
    output        hash_valid,           
    output reg [63:0] hash = 64'h0,    
    input  [63:0] plaintext,           
    input  [127:0] key,                
    input         load,                
    input         clk                  
);

    wire [63:0] xor_input;             
    wire [63:0] ciphertext;            
    wire        load_encrypt;          
    assign xor_input = plaintext ^ key[127:64];

    PRESENT_ENCRYPT encrypt (
        .load_encrypt(load_encrypt),
        .ciphertext(ciphertext),
        .plaintext(xor_input),
        .key(key),
        .load(load),
        .clk(clk)
    );


    always @(posedge clk) begin
        if (load_encrypt) begin
            hash <= ciphertext ^ plaintext;
        end
    end

    assign hash_valid = load_encrypt;

endmodule