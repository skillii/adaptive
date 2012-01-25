clc;
close all;
clear;


h = [0.6;0.2;0.4];
noise_variance = 0.008;
N = 3;
M = 30;



for NORM = 0:1
    for mu = [0.0001, 0.001, 0.01, 1]

        if NORM == 0
            switch(mu)
                case 0.0001
                    Ns = 60000; % number of samples
                case 0.001
                    Ns = 8000;
                case 0.01
                    Ns = 800;
                case 1
                    Ns = 200;
            end
        else
            switch(mu)
                case 0.0001
                    Ns = 140000; % number of samples
                case 0.001
                    Ns = 20000;
                case 0.01
                    Ns = 2000;
                case 1
                    Ns = 1000;
            end
        end

        c = zeros(N, Ns, M);
        y = zeros(Ns, M);
        e = zeros(Ns, M);

        for m = 1:M
            x = randn(1,Ns);
            d = filter(h,1,x);
            d = d + sqrt(noise_variance)*randn(size(d));

            [y(:,m),e(:,m),c(:,:,m)] = n_lms(x, d, N, mu, NORM, zeros(N, 1));

        end

        y_mean = mean(y, 2);
        e_mean = mean(e, 2);
        c_mean = mean(c, 3);

        v_mean = c_mean - repmat(h, 1, Ns);

        %% plots:

        log_v_mean1 = real(log(v_mean(1,:)./v_mean(1,1)));
        log_v_mean2 = real(log(v_mean(2,:)./v_mean(2,1)));
        log_v_mean3 = real(log(v_mean(3,:)./v_mean(3,1)));


        log_e_mean = log(e_mean.^2 ./ e_mean(1)^2);

        figure;
        subplot(2,1,1);
        plot(0:(Ns-1), log_v_mean1, 'r-');
        hold on;
        plot(0:(Ns-1), log_v_mean2, 'g-');
        plot(0:(Ns-1), log_v_mean3, 'b-');



        poly1 = polyfit(0:(Ns/2), log_v_mean1(1:(Ns/2+1)),1);
        poly2 = polyfit(0:(Ns/2), log_v_mean2(1:(Ns/2+1)),1);
        poly3 = polyfit(0:(Ns/2), log_v_mean3(1:(Ns/2+1)),1);

        tau1 = -1/poly1(1);
        tau2 = -1/poly2(1);
        tau3 = -1/poly3(1);

        legend(['v_1[n], tau_1=', num2str(tau1,5)], ['v_2[n], tau_2=', num2str(tau2,5)], ['v_3[n], tau_3=', num2str(tau3,5)]);
        title(['mu = ', num2str(mu), ', NORM=', num2str(NORM)]);
        xlabel('n');
        ylabel('misalignment');
        
        subplot(2,1,2);
        plot(0:(Ns-1), log_e_mean, 'LineWidth', 5);
        xlabel('n');
        ylabel('MSE');
    end
end

%%
mu = 0.001;

for NORM = [0:1]
    for x_var = [0.2, 1.5]

        if NORM == 0
            switch(x_var)
                case 0.2
                    Ns = 40000;
                case 1.5
                    NS = 6000;
            end
        else
            switch(x_var)
                case 0.2
                    Ns = 30000;
                case 1.5
                    Ns = 20000;
            end
        end
        

        c = zeros(N, Ns, M);
        y = zeros(Ns, M);
        e = zeros(Ns, M);

        for m = 1:M
            x = sqrt(x_var)*randn(1,Ns);
            d = filter(h,1,x);
            d = d + sqrt(noise_variance)*randn(size(d));

            [y(:,m),e(:,m),c(:,:,m)] = n_lms(x, d, N, mu, NORM, zeros(N, 1));

        end

        y_mean = mean(y, 2);
        e_mean = mean(e, 2);
        c_mean = mean(c, 3);

        v_mean = c_mean - repmat(h, 1, Ns);

        %% plots:

        log_v_mean1 = real(log(v_mean(1,:)./v_mean(1,1)));
        log_v_mean2 = real(log(v_mean(2,:)./v_mean(2,1)));
        log_v_mean3 = real(log(v_mean(3,:)./v_mean(3,1)));


        log_e_mean = log(e_mean.^2 ./ e_mean(1)^2);

        figure;
        subplot(2,1,1);
        plot(0:(Ns-1), log_v_mean1, 'r-');
        hold on;
        plot(0:(Ns-1), log_v_mean2, 'g-');
        plot(0:(Ns-1), log_v_mean3, 'b-');


        %for calculation of tau just use half of the valuee
        %(just use the beggining of the curves:
        poly1 = polyfit(0:(Ns/2), log_v_mean1(1:(Ns/2+1)),1);
        poly2 = polyfit(0:(Ns/2), log_v_mean2(1:(Ns/2+1)),1);
        poly3 = polyfit(0:(Ns/2), log_v_mean3(1:(Ns/2+1)),1);

        tau1 = -1/poly1(1);
        tau2 = -1/poly2(1);
        tau3 = -1/poly3(1);

        legend(['v_1[n], tau_1=', num2str(tau1,5)], ['v_2[n], tau_2=', num2str(tau2,5)], ['v_3[n], tau_3=', num2str(tau3,5)]);       
        title(['mu = ', num2str(mu), ', NORM=', num2str(NORM), ', Input-Variance:', num2str(x_var)]);
        xlabel('n');
        ylabel('misalignment');
        
        subplot(2,1,2);
        plot(0:(Ns-1), log_e_mean, 'LineWidth', 5); 
        xlabel('n');
        ylabel('MSE');
    end
end




%%
mu = 0.001;

for NORM = [0,1]
    for x_var = [1]

        if NORM == 0
            Ns = 50000;
        else
            Ns = 50000;
        end
        

        c = zeros(N, Ns, M);
        y = zeros(Ns, M);
        e = zeros(Ns, M);

        for m = 1:M
            x = sqrt(x_var)*randn(1,Ns);
            
            % filter noise:
            x = filter([0.5 0.5], 1, x);
            
            d = filter(h,1,x);
            d = d + sqrt(noise_variance)*randn(size(d));

            [y(:,m),e(:,m),c(:,:,m)] = n_lms(x, d, N, mu, NORM, zeros(N, 1));

        end

        y_mean = mean(y, 2);
        e_mean = mean(e, 2);
        c_mean = mean(c, 3);

        v_mean = c_mean - repmat(h, 1, Ns);

        %% plots:

        log_v_mean1 = real(log(v_mean(1,:)./v_mean(1,1)));
        log_v_mean2 = real(log(v_mean(2,:)./v_mean(2,1)));
        log_v_mean3 = real(log(v_mean(3,:)./v_mean(3,1)));


        log_e_mean = log(e_mean.^2 ./ e_mean(1)^2);

        figure;
        subplot(2,1,1);
        plot(0:(Ns-1), log_v_mean1, 'r-');
        hold on;
        plot(0:(Ns-1), log_v_mean2, 'g-');
        plot(0:(Ns-1), log_v_mean3, 'b-');


        %for calculation of tau just use half of the valuee
        %(just use the beggining of the curves:
        poly1 = polyfit(0:(Ns/2), log_v_mean1(1:(Ns/2+1)),1);
        poly2 = polyfit(0:(Ns/2), log_v_mean2(1:(Ns/2+1)),1);
        poly3 = polyfit(0:(Ns/2), log_v_mean3(1:(Ns/2+1)),1);

        tau1 = -1/poly1(1);
        tau2 = -1/poly2(1);
        tau3 = -1/poly3(1);

        legend(['v_1[n], tau_1=', num2str(tau1,5)], ['v_2[n], tau_2=', num2str(tau2,5)], ['v_3[n], tau_3=', num2str(tau3,5)]);       
        title(['mu = ', num2str(mu), ', NORM=', num2str(NORM), ', Input-Variance:', num2str(x_var), ', filtered white-noise']);
        xlabel('n');
        ylabel('misalignment');
        
        subplot(2,1,2);
        plot(0:(Ns-1), log_e_mean, 'LineWidth', 5); 
        xlabel('n');
        ylabel('MSE');
    end
end
