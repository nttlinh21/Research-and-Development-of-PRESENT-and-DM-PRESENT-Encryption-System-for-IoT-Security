`timescale 1ns/1ps

`define PLAINTEXT1 64'h4c746e677579656e
`define PLAINTEXT2 64'h0123456789ABCDEF
`define KEY1 128'h00000000000000000000000000000000
`define KEY2 128'h0123456789ABCDEF0123456789ABCDEF
`define CIPHERTEXT1 64'h9ead5046c7164e1f
`define CIPHERTEXT2 64'h0e9d28685e671dd6

module PRESENT_ENCRYPT_TB;

wire        load_encrypt;
wire [63:0] ciphertext;
reg [63:0] plaintext = 0;
reg [127:0] key = 0;
reg load = 1'b0;
reg clk = 1'b0;
reg reset = 1'b1;

PRESENT_ENCRYPT dut (.load_encrypt(load_encrypt), .ciphertext(ciphertext), 
                    .plaintext(plaintext), .key(key), .load(load), .clk(clk));

always #5 clk = ~clk;

initial begin
   #10 reset = 1'b0;
   #10 reset = 1'b1;

   #10 load = 1'b1;
   plaintext = `PLAINTEXT1;
   key = `KEY1;
   #10 load = 1'b0;
   wait(load_encrypt);
   #20;
   if (ciphertext == `CIPHERTEXT1) begin
      $display("Test 1 PASSED: ciphertext = %h, expected = %h", ciphertext, `CIPHERTEXT1);
   end else begin
      $display("Test 1 FAILED: ciphertext = %h, expected = %h", ciphertext, `CIPHERTEXT1);
   end

   #20 load = 1'b1;
   plaintext = `PLAINTEXT2;
   key = `KEY2;
   #10 load = 1'b0;
   wait(load_encrypt);
   #20;
   if (ciphertext == `CIPHERTEXT2) begin
      $display("Test 2 PASSED: ciphertext = %h, expected = %h", ciphertext, `CIPHERTEXT2);
   end else begin
      $display("Test 2 FAILED: ciphertext = %h, expected = %h", ciphertext, `CIPHERTEXT2);
   end

   #20 $finish;
end
endmodule