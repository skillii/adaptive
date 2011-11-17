clear;
close all;

% 1.3 (b): Generieren des Wasserfall-Plots
N = 1000;

x = diag(ones(1,N));

y = zeros(N,3);

for n = 1:N
    [temp,~] = unknownsystem(x(n,:));
    y(n,:) = temp(n:n+2);
end


figure;

[mx, my] = meshgrid(0:2, 0:20:999);
waterfall(mx, my, y(1:20:1000, :));
xlabel('i = 0..2');
ylabel('n = 0...999');
zlabel('h[i+n]');



%%
% 1.3 (c): kein Rauschen

%generate input signal (white noise) with variance 1:
x = randn(1000,1);

[d_without_noise,h] = unknownsystem(x);

d = d_without_noise;
calc_c_and_plot;

%%
% 1.3 (d): Rauschen mit Varianz=0.5

v = 0.25*randn(1002,1);
d = d_without_noise + v;
calc_c_and_plot;

%%
% 1.3 (e): Rauschen: v[n] = 0.5(x[n] + x[n-1])

v(1) = 0;
for i = 2:1000
    v(i) = 0.5*(x(i)+x(i-1));
end
d = d_without_noise + v;
calc_c_and_plot;