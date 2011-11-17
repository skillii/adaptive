N = 3;


%segment size 20:
M = 20;

c_20 = zeros(3,ceil(1000/M));

for i = 1:ceil(1000/M);
    range = (1+M*(i-1)):(M*(i));
    c_20(:,i) = ls_filter(x(range), d(range), N);
end


%segment size 50:
M = 50;

c_50 = zeros(3,ceil(1000/M));

for i = 1:ceil(1000/M);
    range = [1+M*(i-1):M*(i)];
    c_50(:,i) = ls_filter(x(range), d(range), N);
end

%Plotten der Koeffizienten für M=20
M = 20;
figure;
subplot(3,1,1);
plot(0:M:999, c_20(1,:), 'r-o');
hold on;
plot(0:999, h(1,:), 'b- ');
ylabel('h_1[n], c_1[n]');
xlabel('n');
title('Vergleich Koeffizient c_1[n] und h_1[n] (M=20)');

subplot(3,1,2);
plot(0:M:999, c_20(2,:), 'r-o');
hold on;
plot(0:999, h(2,:), 'b- ');
ylabel('h_2[n], c_2[n]');
xlabel('n');
title('Vergleich Koeffizient c_2[n] und h_2[n] (M=20)');

subplot(3,1,3);
plot(0:M:999, c_20(3,:), 'r-o');
hold on;
plot(0:999, h(3,:), 'b- ');
ylabel('h_3[n], c_3[n]');
xlabel('n');
title('Vergleich Koeffizient c_3[n] und h_3[n] (M=20)');
legend('c_3[n]', 'h_3[n]');


%Plotten der Koeffizienten für M=50
M = 50;
figure;
subplot(3,1,1);
plot(0:M:999, c_50(1,:), 'r-o');
hold on;
plot(0:999, h(1,:), 'b- ');
ylabel('h_1[n], c_1[n]');
xlabel('n');
title('Vergleich Koeffizient c_1[n] und h_1[n] (M=50)');

subplot(3,1,2);
plot(0:M:999, c_50(2,:), 'r-o');
hold on;
plot(0:999, h(2,:), 'b- ');
ylabel('h_2[n], c_2[n]');
xlabel('n');
title('Vergleich Koeffizient c_2[n] und h_2[n] (M=50)');

subplot(3,1,3);
plot(0:M:999, c_50(3,:), 'r-o');
hold on;
plot(0:999, h(3,:), 'b- ');
ylabel('h_3[n], c_3[n]');
xlabel('n');
title('Vergleich Koeffizient c_3[n] und h_3[n] (M=50)');
legend('c_3[n]', 'h_3[n]');