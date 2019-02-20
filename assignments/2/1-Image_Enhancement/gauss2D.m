function G = gauss2D( sigma , kernel_size )
    %% solution
    G1 = gauss1D( sigma , kernel_size );
    G2 = gauss1D( sigma , kernel_size );
    G = G1.*G2;
    G = G / sum (G);
end
