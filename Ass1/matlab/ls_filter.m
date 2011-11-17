function c = ls_filter( x, d, N)
% x ... input signal
% d ... desired output signal (of same length as x)
% N ... number of filter coefficients

x = x(:);
d = d(:);


M = length(x);
warning off;
X = toeplitz(x, zeros(N,1));
warning on;

%Moore-Penrose Inverse:
c = X \ d;

end