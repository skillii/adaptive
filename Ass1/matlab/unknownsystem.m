function [ y,h ] = unknownsystem(x)
%SYSTEM Summary of this function goes here
%   Detailed explanation goes here

x = x(:);

N = length(x);
M = 3;

warning off;
X = toeplitz(x, zeros(3,1));
warning on;

y = zeros(N + M - 1, 1);


h = zeros(3, N);

for n = 1:N
    h(:,n) = [1; 0.001*n; 2-0.003*n];
    
    y(n) = X(n,:) * h(:,n);
end


end
