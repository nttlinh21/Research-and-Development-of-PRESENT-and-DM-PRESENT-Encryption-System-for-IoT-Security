`timescale 1ns/1ps

`define PLAINTEXT1 64'h4c746e677579656e
`define PLAINTEXT2 64'h0123456789ABCDEF
`define KEY1 128'h00000000000000000000000000000000
`define KEY2 128'h0123456789ABCDEF0123456789ABCDEF
`define CIPHERTEXT1 64'h9ead5046c7164e1f
`define CIPHERTEXT2 64'h0e9d28685e671dd6

module PRESENT_DECRYPT_TB;

wire        load_decrypt;
wire [63:0] plaintext;
reg [63:0] ciphertext = 0;
reg [127:0] key = 0;
reg load = 1'b0;
reg clk = 1'b0;
reg reset = 1'b1;

PRESENT_DECRYPT dut (.load_decrypt(load_decrypt), .ciphertext(ciphertext), 
                    .plaintext(plaintext), .key(key), .load(load), .clk(clk));

always #5 clk = ~clk;

initial begin
   #10 reset = 1'b0;
   #10 reset = 1'b1;

   #10 load = 1'b1;
   ciphertext = `CIPHERTEXT1;
   key = `KEY1;
   #10 load = 1'b0;
   wait(load_decrypt);
   #20; 
   if (plaintext == `PLAINTEXT1) begin
      $display("Test 1 PASSED: plaintext = %h, expected = %h", plaintext, `PLAINTEXT1);
   end else begin
      $display("Test 1 FAILED: plaintext = %h, expected = %h", plaintext, `PLAINTEXT1);
   end

   #20 load = 1'b1;
   ciphertext = `CIPHERTEXT2;
   key = `KEY2;
   #10 load = 1'b0;
   wait(load_decrypt);
   #20;
   if (plaintext == `PLAINTEXT2) begin
      $display("Test 2 PASSED: plaintext = %h, expected = %h", plaintext, `PLAINTEXT2);
   end else begin
      $display("Test 2 FAILED: plaintext = %h, expected = %h", plaintext, `PLAINTEXT2);
   end

   #20 $finish;
end
endmodule