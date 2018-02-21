close all;
clear;
clc;

%Forcing term
%Vin = @(t) 5;
%Vin = @(t) 5*exp(-(t^2)/3);
%Vin = @(t) square(109*t); needs another add-on
Vin = @(t) sin(2*pi*5*t);

%Initial conditions
x1(1) = 500*10^-9;
x2(1) = 0;

%Stepsize and final time
h = 0.0001;
t(1) = 0;
tf = 0.1;

%Circuit characteristics
R = 250;
C = 3.5*10^-6;
L = 600*10^-3;

%Let x1 = qc and x2 = d/dt(qc)
dx1 = @(t, x1, x2) x2;
dx2 = @(t, x1, x2) (Vin(t) - (1/C)*x1 - R*x2)/L;

[x1, x2] = RK4(dx1, dx2, x1(1), x2(1), h, t(1), tf);

N = round((tf - t(1)) / h); %nr of steps: (interval size)/(step size)
t = t(1) : h : N*h;

plot(t, x1, 'b');
hold on;
plot(t, x2, 'r');