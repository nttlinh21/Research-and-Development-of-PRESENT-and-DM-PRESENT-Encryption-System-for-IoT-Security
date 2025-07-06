`timescale 1ns/1ps

module Pbox_Decrypt(
   output [63:0] odat,
   input  [63:0] ciphertext
);

assign odat[0 ] = ciphertext[0 ];
assign odat[4] = ciphertext[1 ];
assign odat[8] = ciphertext[2 ];
assign odat[12] = ciphertext[3 ];
assign odat[16] = ciphertext[4 ];
assign odat[20] = ciphertext[5 ];
assign odat[24] = ciphertext[6 ];
assign odat[28] = ciphertext[7 ];
assign odat[32 ] = ciphertext[8 ];
assign odat[36] = ciphertext[9 ];
assign odat[40] = ciphertext[10];
assign odat[44] = ciphertext[11];
assign odat[48] = ciphertext[12];
assign odat[52] = ciphertext[13];
assign odat[56] = ciphertext[14];
assign odat[60] = ciphertext[15];

assign odat[1] = ciphertext[16];
assign odat[5] = ciphertext[17];
assign odat[9] = ciphertext[18];
assign odat[13] = ciphertext[19];
assign odat[17] = ciphertext[20];
assign odat[21] = ciphertext[21];
assign odat[25] = ciphertext[22];
assign odat[29] = ciphertext[23];
assign odat[33] = ciphertext[24];
assign odat[37] = ciphertext[25];
assign odat[41] = ciphertext[26];
assign odat[45] = ciphertext[27];
assign odat[49] = ciphertext[28];
assign odat[53] = ciphertext[29];
assign odat[57] = ciphertext[30];
assign odat[61] = ciphertext[31];

assign odat[2] = ciphertext[32];
assign odat[6] = ciphertext[33];
assign odat[10] = ciphertext[34];
assign odat[14] = ciphertext[35];
assign odat[18] = ciphertext[36];
assign odat[22] = ciphertext[37];
assign odat[26] = ciphertext[38];
assign odat[30] = ciphertext[39];
assign odat[34] = ciphertext[40];
assign odat[38] = ciphertext[41];
assign odat[42] = ciphertext[42];
assign odat[46] = ciphertext[43];
assign odat[50] = ciphertext[44];
assign odat[54] = ciphertext[45];
assign odat[58] = ciphertext[46];
assign odat[62] = ciphertext[47];

assign odat[3] = ciphertext[48];
assign odat[7] = ciphertext[49];
assign odat[11] = ciphertext[50];
assign odat[15] = ciphertext[51];
assign odat[19] = ciphertext[52];
assign odat[23] = ciphertext[53];
assign odat[27] = ciphertext[54];
assign odat[31] = ciphertext[55];
assign odat[35] = ciphertext[56];
assign odat[39] = ciphertext[57];
assign odat[43] = ciphertext[58];
assign odat[47] = ciphertext[59];
assign odat[51] = ciphertext[60];
assign odat[55] = ciphertext[61];
assign odat[59] = ciphertext[62];
assign odat[63] = ciphertext[63];

endmodule
