%Clean up
close all;
clear;
clc;

%Choose step size, initial condition, final value
x0 = 0;
y0 = 500e-9;
h = 1e-6;
xf = 1e-3;

%Choose Vin
Vin = @(x) 2.5;

%Choose circuit constants
R = 1e+3;
C = 100e-9;

dy = @(x,y) Vin(x)/R - y/(C*R);

%Let ye = qc(t)
[x,ye] = RK2(dy,x0,y0,h,xf);

%Generate the arrays for Vin(t) and Vout(t)
vout = ye/C;
vin = arrayfun(@(x) Vin(x), x);

%Plot Vin(t) and Vout(t)
plot(x, vout, 'r');
hold on;
plot(x, vin, 'b');

xlabel('Time(s)');
ylabel('Voltage(V) Vin(t) in blue/Vout(t) in red');

ylim([0 max(vout)]);