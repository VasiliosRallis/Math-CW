function [x1, x2] = RK4(dx1, dx2, x1_0, x2_0, h, t0,  tf)
    
    x1(1) = x1_0;
    x2(1) = x2_0;
    
    N = round((tf - t0) / h); %nr of steps: (interval size)/(step size)
    t = t0 : h : N*h;
    
    %Setting up fourth order RK
    a1 = 1/6;
    a2 = 1/3;
    a3 = 1/3;
    a4 = 1/6;
    
    
    %Inefficient solution
    %{
    k1 = @(t, x1, x2) dx1(t, x1, x2);
    k2 = @(t, x1, x2) dx1(t + 0.5*h, x1 + 0.5*k1(t, x1, x2)*h, x2 + 0.5*j1(t, x1, x2)*h);
    k3 = @(t, x1, x2) dx1(t + 0.5*h, x1 + 0.5*k2(t, x1, x2)*h, x2 + 0.5*j2(t, x1, x2)*h);
    k4 = @(t, x1, x2) dx1(t + h, x1 + k3(t, x1, x2)*h, x2 + j3(t, x1, x2)*h);
    
    j1 = @(t, x1, x2) dx2(t,x1,x2);
    j2 = @(t, x1, x2) dx2(t + 0.5*h, x1 + 0.5*k1(t, x1, x2)*h, x2 + 0.5*j1(t, x1, x2)*h);
    j3 = @(t, x1, x2) dx2(t + 0.5*h, x1 + 0.5*k2(t, x1, x2)*h, x2 + 0.5*j2(t, x1, x2)*h);
    j4 = @(t, x1, x2) dx2(t + h, x1 + k3(t, x1, x2)*h, x2 + j3(t, x1, x2)*h);
    %}
    
    for i = 1 : length(t) - 1
        k1 = dx1(t(i), x1(i), x2(i));
        j1 = dx2(t(i), x1(i), x2(i));
        k2 = dx1(t(i) + 0.5*h, x1(i) + 0.5*h*k1, x2(i) + 0.5*h*j1);
        j2 = dx2(t(i) + 0.5*h, x1(i) + 0.5*h*k1, x2(i) + 0.5*h*j1);
        k3 = dx1(t(i) + 0.5*h, x1(i) + 0.5*h*k2, x2(i) + 0.5*h*j2);
        j3 = dx2(t(i) + 0.5*h, x1(i) + 0.5*h*k2, x2(i) + 0.5*h*j2);
        k4 = dx1(t(i) + h, x1(i) + h*k3, x2(i) + h*j3);
        j4 = dx2(t(i) + h, x1(i) + h*k3, x2(i) + h*j3);
        
        x1(i+1) = x1(i) + h*(a1*k1 + a2*k2 + a3*k3 + a4*k4);
        x2(i+1) = x2(i) + h*(a1*j1 + a2*j2 + a3*j3 + a4*j4);
    end
    