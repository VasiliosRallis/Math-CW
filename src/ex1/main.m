%Clean up
close all;
clear;
clc;

my_max_error = zeros(1,10);
my_h = zeros(1,10);
for i = 1:10
    h = 1e-5/(5*i);
    error_script
    max_error = max(error);
    my_max_error(i) = max_error;
    my_h(i) = h;
end

p = polyfit(my_h, my_max_error, 1);


plot(log(my_h), log(my_max_error));