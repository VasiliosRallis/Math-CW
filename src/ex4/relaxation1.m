%clean from previous run
close all;
clear;
clc;


%Choose gridsize and residual size tolerance
h = 0.05;
max_res = 1e-6;

%Choose the border functions
fi1 = @(x) 1;
fi2 = @(y) 0;
fi3 = @(x) heaviside(x-0.2)-heaviside(x-0.8);
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
    %set the maximum residue found in this iteration to 0
    %it will be updated in the for loop
    r_max = 0;
    for i = 2:length(x) - 1
        for j = 2:length(y) -1
            %Calculate the residue
            r = (z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1) - 4*z(i,j))/4;
            %Set the new value of the point
            z(i,j) = z(i,j) + r;
            if(abs(r) > r_max)
                r_max = abs(r);
            end
        end
    end
    %if the meximum residue value found in this iteration is smaller
    %than our maximum tolerence break
    if(r_max < max_res)
        break;
    end
end

%It is important not to forget to transpose because of the way matlab
%handles matrices 
mesh(x,y,z');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
title('Solution to Laplace Equation');
