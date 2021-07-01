module FA(a, b, c, cout, sum, ctr);

    input a, b, c, ctr;
    output cout, sum;
    
    wire   e1, e2, e3,b1;

	xor	(b1, ctr, b);
    xor (e1, a, b1);
    and (e2, a, b1);
    and (e3, e1, c);
    or	(cout,e2, e3);
    xor  (sum, e1, c);

endmodule

