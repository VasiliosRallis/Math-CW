%Clean up
%close all;
%clear;
%clc;

my_max_error_r = zeros(1,20);
my_h = zeros(1,20);
for i = 1:20
    h = 1e-4/(5*i);
    error_script
    max_error = max(error);
    my_max_error_r(i) = max_error;
    my_h(i) = h;
end

p_r = polyfit(log(my_h), log(my_max_error_r), 1);

plot(log(my_h), log(my_max_error_r), 'bs');
hold on;
xlabel('Log(h)');
ylabel('Log(Max Error)');
title('Global Error vs Step Size');
legend('Heun', 'Midpoint', 'Ralston');