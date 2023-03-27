clear all;
clc;
close all;

x = zeros(1,11);
y = zeros(1,11);
T = zeros(1,11);


for n = 1:11
    
    x(n) = (n-1)/10;
    
    p_error = 100;
    T_test = 350;
    
    while p_error > 0.01
        p5 = exp(10.422-26799/8.314/T_test);
        p7 = exp(11.431-35200/8.314/T_test);
        p = x(n)*p5 + (1-x(n))*p7;
        
        p_error = abs((p-1.013)/1.013);
        T_test = ((1.013/p)^0.1)*T_test;
    end
    
    
    T(n) = T_test;
    y(n) = x(n)*p5/p;
    
end


plot(x,T,'-s','markerfacecolor', 'w');
hold on;
plot(y,T, '-o','markerfacecolor', 'w');

title('T-x-y diagram');
xlabel('x_5 or y_5');
ylabel('T (K)');           

figure
plot(x,y,'-o','markerfacecolor', 'w');
hold on;
plot(x,x,'--');
title('x-y diagram');
xlabel('x_5');
ylabel('y_5');