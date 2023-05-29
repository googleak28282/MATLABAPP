clear all
clc
close all

v0=185*1000/3600; % velocity in [m/s]
angle=45; % angle in [dgree]

tspan = 0:0.01:8;
x0 = [v0*sind(angle), 0, v0*cosd(angle), 0];
fun = @(t,x) fly_baseball_no_drag(v0,angle,t,x);
[t,x]=ode45(fun,tspan,x0);

cutoff = 0;

for n = 1:(length(t)-1)
    if x(n,2)*x(n+1,2)<0
        cutoff = n;
    end
end

plot(t(1:cutoff),x(1:cutoff,2));
xlabel('t(s)');  
ylabel('x or y distance(m)'); hold on
plot(t(1:cutoff),x(1:cutoff,4));
legend('y distance', 'x distance','location','northwest')

figure
plot(x(1:cutoff,4), x(1:cutoff,2));
xlabel('x distance(m)');  
ylabel('y distance(m)');

distance = x(cutoff,4)

function dxdt=fly_baseball_no_drag(v0,angle,t,x)

m=0.145; % mass of baseball in [kg]
g=9.8; % gravity in [m/s^2]
rho=1.18;
A=0.0042;
dragc=0.3;
Fd=1/2*dragc*rho*(x(1)^2+x(3)^2)*A;
dxdt = zeros(4,1);

dxdt(1) = -g-Fd*(x(1)/sqrt(x(1)^2+x(3)^2))/m;
dxdt(2) = x(1);
dxdt(3) = -Fd*(x(3)/sqrt(x(1)^2+x(3)^2))/m;
dxdt(4) = x(3);

end
