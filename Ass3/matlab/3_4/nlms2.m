function [ y, e, c] = nlms2( x, d, N, mu)
%NLMS2   Adaptive transversal filter using NORMALIZED LMS
% [y, e, c] = nlms2( x, d, N, mu)
% INPUT
%   x ... vector with the samples of the input signal x[n], length(x) = xlen
%   d ... vector with the samples of the desired output signal d[n]
%         length(d) = xlen
%   N ... number of coefficients
%   mu .. step-size parameter (0 < mu < 2)
% OUTPUT
%   y ... vector with the samples of the output signal y[n]
%         size(y) = [ xlen, 1] ... column vector
%   e ... vector with the samples of the error signal e[n]
%         size(y) = [ xlen, 1] ... column vector
%   c ... matrix with the used coefficient vectors c[n]
%         size(c) = [ N, xlen]

x = x(:); % now x is definitely a column vector

xlen = length(x);


x = [ zeros( N-1, 1); x]; % initialize taps with zeros: e.g. for n=0:
                          % tap_vector[0] = [ x[0], x[-1], ..., x[-(N-1)] ].'
                          % with x[-1] = x[-2] = ... = x[-(N-1)] = 0

c = zeros( N, xlen+1); % initialize coefficients with 0 (column vector)
                       % and preallocate memory to speedup loop
e = zeros( xlen, 1);   % preallocate memory to speedup loop (column vector)
y = zeros( xlen, 1);   % preallocate memory to speedup loop (column vector)

% sample-by-sample processing
for n = 1:xlen % note: MATLAB indices start from 1
  tap_vector = x( n+N-1:-1:n); % tap-input vector
  y(n) = c(:,n)' * tap_vector; % filter (inner vector product)
  e(n) = d(n) - y(n); % error computation
  m = mu / ( eps + tap_vector' * tap_vector);
  c(:,n+1) = c(:,n) + m * tap_vector * e(n)'; % coefficient adaptation
end

c = c( :, 1:xlen); % discard the last (unused) coefficient vector
