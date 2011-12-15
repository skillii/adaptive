% Testing the (N)LMS script
%
% Bernhard Geiger, SPSC, 2011
clear all; close all; clc;

Ns=1e4; % number of samples

h=[0.5 0.4 1 0.8]';  % impulse response of unknown system
Nh=length(h);
N=Nh;               % adaptive filter order is order of unknown system


%% Test Case 1: LMS, noise-free, zero initial vector

x=randn(1,Ns);
d=filter(h,1,x);

c0=zeros(1,N);     % initialize with zero vector

[~,e,c]=n_lms(x,d,N,0.01,0);
h-c(:,end)

figure(1)
plot(c(1,:),'r')
hold on
plot(c(2,:),'b')
plot(c(3,:),'m')
plot(c(4,:),'k')
axis([1 Ns 0 1])
title('LMS, noise-free, zero initial vector')
legend('c(1)','c(2)','c(3)','c(4)');
xlabel('n');

%% Test Case 2: LMS, noisy, random initial vector

d=d+0.1*randn(1,Ns);
c0=rand(1,N);

[~,~,c]=n_lms(x,d,N,0.01,0,c0);
h-c(:,end)

figure(2)
plot(c(1,:),'r')
hold on
plot(c(2,:),'b')
plot(c(3,:),'m')
plot(c(4,:),'k')
axis([1 Ns 0 1])
title('LMS, noisy, random initial vector')
legend('c(1)','c(2)','c(3)','c(4)');
xlabel('n');

%% Test Case 3: NLMS, noisy, random initial vector
[y,e,c]=n_lms(x,d,N,0.03,1,c0);
h-c(:,end)

figure(3)
plot(c(1,:),'r')
hold on
plot(c(2,:),'b')
plot(c(3,:),'m')
plot(c(4,:),'k')
axis([1 Ns 0 1])
title('NLMS, noisy, random initial vector')
legend('c(1)','c(2)','c(3)','c(4)');
xlabel('n');