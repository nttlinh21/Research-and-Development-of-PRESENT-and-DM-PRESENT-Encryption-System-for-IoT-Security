module PRESENT_ENCRYPT (
    output        load_encrypt,
    output reg [63:0] ciphertext = 64'h0, 
    input  [63:0] plaintext,
    input  [127:0] key,
    input         load,
    input         clk
);

wire [127:0] kreg;
reg  [63:0] dreg;
wire [4:0]  round;
wire [63:0] dat1, dat2, dat3;
reg load_encrypt_reg;
wire [63:0] odat;
gen_key_1_to_31 generate_key (.key(key), .kreg(kreg), .round(round), .load(load), .clk(clk));

assign load_encrypt = (round == 0) ? 1 : 0;
always @(posedge clk)
begin
   load_encrypt_reg <= load_encrypt;
end
assign dat1 = dreg ^ kreg[127:64];
assign odat = dat1;

genvar i;
generate
    for (i=0; i<64; i=i+4) begin: sbox_loop
       Sbox_Encrypt SBOX (.odat(dat2[i+3:i]), .plaintext(dat1[i+3:i]));
    end
endgenerate
Pbox_Encrypt UPBOX (.odat(dat3), .plaintext(dat2));

always @(posedge clk)
begin
   if (load)
      dreg <= plaintext;
   else
      dreg <= dat3;
end

always @(posedge clk)
begin
   if (round == 0 & load_encrypt & !load_encrypt_reg)
      ciphertext <= odat;
end
endmodule