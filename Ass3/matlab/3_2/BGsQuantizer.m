function [xhat, M]=BGsQuantizer(x,B)
% [xhat, M]=BGsQuantizer(x,B)
%
% INPUTS:
% x..............data vector
% B..............bits of the quantizer
% OUTPUTS:
% xhat...........quantized data vector
% M..............reconstruction values
%
% Bernhard Geiger, SPSC, 2011

stepsize=(max(x)-min(x))/(2^B-1);
M=min(x):stepsize:max(x);

xhat=zeros(size(x));
for n=1:length(M)
    xhat(x>M(n))=M(n);
end
