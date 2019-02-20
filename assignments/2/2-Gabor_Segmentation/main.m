function [ main ] = main()
% createGabor( sigma, theta, lambda, psi, gamma )
for theta = 0:30:60
    createGabor(3, theta, 9, 50, 0.3);
end
end
