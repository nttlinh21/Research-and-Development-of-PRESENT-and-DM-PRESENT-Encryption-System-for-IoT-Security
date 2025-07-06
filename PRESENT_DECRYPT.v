module PRESENT_DECRYPT (

        
        output        load_decrypt,
        output reg   [63:0] plaintext,   
        input  [63:0] ciphertext,   
        input  [127:0] key,    
        input         load,   
        input         clk
    );

wire  [63:0]odat;

//---------wires, registers----------
wire  [127:0] kreg;               // key register
wire  [63:0] dreg;               // data register
wire  [4:0]  round;              // round counter
reg  [4:0]  round_reg;              // round counter

wire [63:0] dat1;
wire [63:0] dat2;
reg [63:0] dat3;     // intermediate data


gen_key_31_to_1 generate_key_decrypt( .key(key), .kreg(kreg), .round(round), .load(load), .clk(clk) );


//---------combinational processes----------
assign load_decrypt = (round_reg == 1) ? 1 : 0;
assign dreg = dat1 ^ kreg[127:64];
assign odat = dreg;                   
genvar i;
generate
    for (i=0; i<64; i=i+4) begin: sbox_loop
       Sbox_Decrypt USBOX( .odat(dat1[i+3:i]), .ciphertext(dat2[i+3:i]) );
    end
endgenerate

// instantiate pbox (p-layer)
Pbox_Decrypt UPBOX    ( .odat(dat2), .ciphertext(dat3) );


// Load data
always @(posedge clk)
begin

    if (round_reg == 0)
        dat3 <= ciphertext ^ kreg[127:64];
    else
        dat3 <= dreg;
end


always @(posedge clk)
begin
   if (round == 0 && round_reg != 0)
        plaintext <= dreg;
end

always @(posedge clk)
begin
   round_reg <= round;
end



endmodule
