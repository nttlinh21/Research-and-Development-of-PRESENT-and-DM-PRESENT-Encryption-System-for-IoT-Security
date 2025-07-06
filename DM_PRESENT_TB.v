`timescale 1ns/1ps

`define PLAINTEXT1 64'h4c746e677579656e
`define KEY1 128'h00000000000000000000000000000000

`define HASH1 64'h9ead5046c7164e1f ^ 64'h4c746e677579656e // = 64'hd2d93e21b26f2b71

module DM_PRESENT_TB;

    wire        hash_valid;
    wire [63:0] hash;
    reg  [63:0] plaintext = 0;
    reg  [127:0] key = 0;
    reg         load = 1'b0;
    reg         clk = 1'b0;
    reg         reset = 1'b1;

    DM_PRESENT dut (
        .hash_valid(hash_valid),
        .hash(hash),
        .plaintext(plaintext),
        .key(key),
        .load(load),
        .clk(clk)
    );

    always #5 clk = ~clk;

    initial begin
        
        #10 reset = 1'b0;
        #10 reset = 1'b1;

        // Test case 1
        #10 load = 1'b1;
        plaintext = `PLAINTEXT1;
        key = `KEY1;
        #10 load = 1'b0;
        wait(hash_valid);
        #50;
        $display("Hash value: %h", hash);
        if (hash == `HASH1) begin
            $display("Test 1 PASSED: hash = %h, expected = %h", hash, `HASH1);
        end else begin
            $display("Test 1 FAILED: hash = %h, expected = %h", hash, `HASH1);
        end

    

        #20 $finish;
    end

endmodule