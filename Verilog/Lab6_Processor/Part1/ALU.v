module ALU(output [31:0] out, output zero, output sign, output over, input signed [31:0] a, input signed [31:0] b, input [3: 0] func);
    /*  func:
        0: add
        1: sub
        2: and
        3: or
        4: xor
        5: 2s complement
        6: Left shift
        7: Right shift arithmetic
        8: Right shift logical
    */
    assign out = (func == 0)?(a+b):(
                    (func == 1)?(a-b):(
                        (func == 2)?(a&b):(
                            (func == 3)?(a|b):(
                                (func == 4)?(a^b):(
                                    (func == 5)?(~a):(
                                        (func == 6)?(a << b):(
                                            (func == 7)?(a >>> b):(a >> b)
                                        )
                                    )
                                )
                            )
                        )
                    )
                );
    assign zero = (out == 0);
    assign sign = (out < 0);
    assign over = (a[31]&(func[0]^b[31])&out[31])|(!a[31]&!(func[0]^b[31])&!out[31])
endmodule