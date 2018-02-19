function [x,y] = RK2(dy,x0,y0,h,xf)

N = round((xf - x0) / h); %nr of steps: (interval size)/(step size)
x = [x0:h:(N*h + x0)];
y = y0;

%%Heun
a1 = 0.5; a2 = 0.5; p1 = 1; q1 = 1;

%%Midpoint
%%a1 = 0; a2 = 1; p1 = 0.5; q1 = 0.5;

%%Ralston
%%a1 = 1/3; a2 = 2/3; p1 = 3/4; q1 = 3/4;


k1 = dy;
k2 = @(x,y) dy(x + p1*h, y + q1*k1(x,y)*h);
fi = @(x,y) a1*k1(x,y) + a2*k2(x,y);


for i=1:N;
    y(i+1) = y(i) + h*fi(x(i),y(i));
end