function [y,e,c] = n_lms(x,d,N,mu,NORM,c0)
% INPUTS:
% x ...... input signal vector
% d ...... desired output signal (of same length as x)
% N ...... number of filter coefficients
% mu .,... step size parameter
% NORM ... set "1" for NLMS (bias=0), "0" for LMS
% c0 ..... initial coefficient vector (optional; default all zeros)
% OUTPUTS:
% y ...... output signal vector (of same length as x)
% e ...... error signal vector (of same length as x)
% c ...... coefficient matrix (N rows, number of columns = length of x)


x = x(:);
d = d(:);

if(nargin < 6)
    c0 = zeros(N,1);
end

y = zeros(length(x),1);
e = zeros(length(x),1);
c = zeros(N,length(x));


c0 = c0(:);

c_last = c0;

for n = 1:length(x)
    x_taped = x(1:n);
    if(length(x_taped) <= N)
        x_taped = [zeros(N-length(x_taped),1); x_taped];
    else
        x_taped = x_taped(end-N+1:end);
    end
    
    x_taped = flipud(x_taped);
        
    y(n) = c_last'*x_taped;
    e(n) = d(n)-y(n);
    
    if(NORM == 1)
        factor = norm(x_taped)^2;
    else
        factor = 1;
    end
        
    c(:,n) = c_last + mu*e(n)*x_taped./factor;
    c_last = c(:,n);
end




end