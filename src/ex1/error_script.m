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
B = (5*C)/((W*R*C)^2 + 1);
A = y0 - B;


%Choose Vin
Vin = @(x) 5*cos(1e+4*2*pi*x);
%Vout =@(x) 10e-6*exp(1e-4*x) + (2*pi*sin(2*pi*1e+4*x) + cos(2*pi*1e+4*x))/((1 + 4*pi^2)*1e+6);
Vout =@(x) B*(cos(W*x) + W*R*C*sin(W*x)) + A*exp(-x/(R*C));

dy = @(x,y) Vin(x)/R - y/(C*R);

%Let ye = qc(t)
[x,y_estimation] = RK2(dy,x0,y0,h,xf);

%Generate the arrays for Vin(t) and Vout(t)
y_real = arrayfun(@(x) Vout(x), x);

error = abs(y_real - y_estimation);

%Plot Vin(t) and Vout(t)
%plot(x, error, 'r');
%hold on;
%plot(x, y_real, 'b');
%xlabel('Time(s)');
%ylabel('Voltage(V) Vin(t) in blue/Vout(t) in red');
