%load('speech_signals.mat');


N = 100;
mu = 0.005;

delta =7;


d = dtmfs(:);
x = [zeros(delta,1);d(1:end-delta)];


[ y, e, c] = nlms2( x, d, N, mu);

%e = d;

MMSQE = sum((e - clean).^2);
SNR = 10*log(sum((clean-mean(clean)).^2)/MMSQE);
disp(num2str(delta));
disp(['SNR: ', num2str(SNR), 'dB']);
