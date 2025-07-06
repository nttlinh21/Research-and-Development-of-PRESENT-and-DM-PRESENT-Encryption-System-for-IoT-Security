`timescale 1ns / 1ps

module gen_key_1_to_31(
    input  [127:0] key,   
    output reg [127:0] kreg,
    output reg [4:0]  round,
    input         load,   
    input         clk
);
    
    wire [127:0] kdat1, kdat2;   
    assign kdat1 = {kreg[66:0], kreg[127:67]}; // Xoay trái 61 bit
    assign kdat2[66:62] = kdat1[66:62] ^ round; // XOR v?i round t?i [66:62]
    Sbox_Encrypt S_box (.odat(kdat2[127:124]), .plaintext(kdat1[127:124])); // S-box cho 4 bit cao nh?t
    Sbox_Encrypt S_box_1 (.odat(kdat2[123:120]), .plaintext(kdat1[123:120]));
    
    assign kdat2[119:67] = kdat1[119:67]; // Gi? nguyên
    assign kdat2[61:0] = kdat1[61:0];
 
    always @(posedge clk)
    begin
       if (load)
          kreg <= key;
       else
          kreg <= kdat2;
    end

    always @(posedge clk)
    begin
       if (load)
          round <= 1;
       else if (round != 0)
          round <= round + 1;
       else
          round <= 0; // 
    end
endmodule