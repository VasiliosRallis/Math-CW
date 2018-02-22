close all;
clear;
clc;

%Choose gridsize and residual size
h = 0.01;
max_res = 0.1;

%Choose the border functions
fi1 = @(x) sin(2*pi*10*x);
fi2 = @(y) cos(2*pi*10*y);
fi3 = @(x) sin(2*pi*10*x);
fi4 = @(y) 0;

%Setting up
x(1) = 0;
xf = 1;
yf = 1;
n = round((xf - x(1))/h);
x = 0:h:n*h;
y = 0:h:n*h;
z = zeros(length(x),length(y));


sum = 0;

for i = 1:length(x)
    z(i,length(y)) = fi1(x(i));
    z(length(x),i) = fi2(y(i));
    z(i,1) = fi3(x(i));
    z(1,i) = fi4(y(i));
end

%Calculate the average value
total = 4*(n + 1) - 4;
avg = sum/total;

%Set all the inner points as this average value
for i = 2:length(x) - 1
    for j = 2:length(y) - 1
            z(i,j) = avg;
    end
end

while (true)
    r_max = 0;
    for i = 2:length(x) - 1
        for j = 2:length(y) -1
            r = (z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1) - 4*z(i,j))/4;
            z(i,j) = z(i,j) + r;
            if(abs(r) > r_max)
                r_max = abs(r);
            end
        end
    end
    if(r_max < max_res)
        break;
    end
end

mesh(x,y,z);
