clear all;
clc;
close all;

R = 8.314;
x = 0:0.1:1;

for n = 1:3
    
    T = 323.15*(n-1)*0.1 + 323.15;
    
    p5 = exp(10.422 - 26799/R/T);
    p7 = exp(11.431 - 35200/R/T);
    
    T_plot = T*ones(1,11);
    p = x.*p5 + (1-x).*p7;
    y = x.*p5./p;
    
    plot3(x,T_plot,p,'-s','markerfacecolor', 'w');
    hold on;
    plot3(y,T_plot,p,'-s','markerfacecolor', 'w');

end

hold off;

title('P-x-y diagram at different T');
xlabel('x_5 or y_5');
ylabel('T (K)');
zlabel('P (bar)');           