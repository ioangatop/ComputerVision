function G = gauss2D( sigma , kernel_size )
    %% solution
    G1 = gauss1D( sigma , kernel_size );
    G2 = gauss1D( sigma , kernel_size );
    
    % To get a 2D matrix kernel, we should traspose G1, so that
    % (1x5).T * (1x5) = 5x1 * 1x5 = 5x5
    G = transpose(G1)*G2;
end