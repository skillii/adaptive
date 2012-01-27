%load('speech_signals.mat');

% optimal parameters
N = 236;
mu = 0.00205;
delta = 16;

% parameter search
%mmse_min = inf;
%N_min = 0;
%mu_min = 0;
%delta_min = 0;

d = dtmfs(:);

%for N = 235:1:237
%    for mu = 0.0019:0.00005:0.0021
%        for delta = 15:1:17

            x = [zeros(delta,1);d(1:end-delta)];


            [ y, e, c] = nlms2( x, d, N, mu);

            %e = d;

            MMSQE = sum((e - clean).^2);

%            if MMSQE < mmse_min
%                mmse_min = MMSQE;
%                N_min = N;
%                mu_min = mu;
%                delta_min = delta;
%            end
            
%        end
%    end
%end

%MMSQE = mmse_min;

SNR = 10*log(sum((clean-mean(clean)).^2)/MMSQE);

%disp(['optimal parameters: N=', num2str(N_min), ', mu=', num2str(mu_min), ', delta=', num2str(delta_min)]);
disp(['SNR: ', num2str(SNR), 'dB']);
