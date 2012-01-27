Ns = 10^6;  % number of samples

w = randn(1, 2 + Ns);

u = zeros(1, 2 + Ns);
u(1) = 0;
u(2) = 0;

e1 = zeros(1, 2 + Ns);
e2 = zeros(1, 2 + Ns);


%% calculate e[n] for different N

for i = 3:Ns
    
    u(i) = w(i) + u(i-1) - 1/8 * u(i-2);
    
    e1(i) = u(i) - 8/9 * u(i-1);  % N=1
    e2(i) = u(i) + 1 * u(i-1) - 1/8 * u(i-2);  % N=2
    
end


%% calculate ehat for different N and B

[eh01, M01] = BGsQuantizer(u, 1);
[eh02, M02] = BGsQuantizer(u, 2);
[eh03, M03] = BGsQuantizer(u, 3);
[eh04, M04] = BGsQuantizer(u, 4);
[eh05, M05] = BGsQuantizer(u, 5);

[eh11, M11] = BGsQuantizer(e1, 1);
[eh12, M12] = BGsQuantizer(e1, 2);
[eh13, M13] = BGsQuantizer(e1, 3);
[eh14, M14] = BGsQuantizer(e1, 4);
[eh15, M15] = BGsQuantizer(e1, 5);

[eh21, M21] = BGsQuantizer(e2, 1);
[eh22, M22] = BGsQuantizer(e2, 2);
[eh23, M23] = BGsQuantizer(e2, 3);
[eh24, M24] = BGsQuantizer(e2, 4);
[eh25, M25] = BGsQuantizer(e2, 5);


%% calculate entropy for different N and B

H01 = CondEntropy(eh01, M01);
H02 = CondEntropy(eh02, M02);
H03 = CondEntropy(eh03, M03);
H04 = CondEntropy(eh04, M04);
H05 = CondEntropy(eh05, M05);

H11 = CondEntropy(eh11, M11);
H12 = CondEntropy(eh12, M12);
H13 = CondEntropy(eh13, M13);
H14 = CondEntropy(eh14, M14);
H15 = CondEntropy(eh15, M15);

H21 = CondEntropy(eh21, M21);
H22 = CondEntropy(eh22, M22);
H23 = CondEntropy(eh23, M23);
H24 = CondEntropy(eh24, M24);
H25 = CondEntropy(eh25, M25);


%% plot results

x = 1:3;

figure(1);
plot(x, H01, x, H02, x, H03, x, H04, x, H05);
title('Upper Bounds of Entropy rate for N=0');
xlabel('n');
ylabel('H(\hat{e}[n])');
legend('B=1', 'B=2', 'B=3', 'B=4', 'B=5');

figure(2);
plot(x, H11, x, H12, x, H13, x, H14, x, H15);
title('Upper Bounds of Entropy rate for N=1');
xlabel('n');
ylabel('H(\hat{e}[n])');
legend('B=1', 'B=2', 'B=3', 'B=4', 'B=5');

figure(3);
plot(x, H21, x, H22, x, H23, x, H24, x, H25);
title('Upper Bounds of Entropy rate for N=2');
xlabel('n');
ylabel('H(\hat{e}[n])');
legend('B=1', 'B=2', 'B=3', 'B=4', 'B=5');
