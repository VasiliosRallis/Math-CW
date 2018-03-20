%Clean up
%close all;
%clear;
%clc;

%Choose step size, initial condition, final value
x0 = 0;
y0 = 500e-9;
%h = 1e-6;
xf = 1e-3;

%Choose circuit constants
R = 1e+3;
C = 100e-9;
W = 2*pi*10^4;

%Create some contants so that the equation is easier to write
B = (5*C)/((W*R*C)^2 + 1);
A = y0 - B;

%Choose Vin and Vout
Vin = @(x) 5*cos(W*x);
Vout =@(x) B*(cos(W*x) + W*R*C*sin(W*x)) + A*exp(-x/(R*C));

dy = @(x,y) Vin(x)/R - y/(C*R);

%Let ye = qc(t)
[x,y_estimation] = RK2(dy,x0,y0,h,xf);

%Generate the arrays for Vin(t) and Vout(t)
y_real = arrayfun(@(x) Vout(x), x);

error = y_real - y_estimation;

%Plot Vin(t) and Vout(t)
%plot(x, error);
%title('Error with Ralston method');
%xlabel('Time(s)');
%ylabel('Error of Charge(C)');
