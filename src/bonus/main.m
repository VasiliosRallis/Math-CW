myIterations = zeros(1,20);
myOmegas = zeros(1,20);

for myI = 0:19
    %Set the new value of Omega
    omega = 1+ 0.05*myI;
    %Run the sor script
    sor
    %Add iteration to the myIterations array and the Omegas to the myOmegas
    %array
    myIterations(myI+1) = iteration;
    myOmegas(myI+1) = omega;
end

%Plot
plot(myOmegas,myIterations);
ylim([0,200]);
xlabel('Omega value');
ylabel('Number of iteration');
title('Omega vs Number of iterations');