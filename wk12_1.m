fun = @tank_fill;
h0=0;
tspan=0:0.1:1000;
[t,h]=ode45(fun,tspan,h0);
plot(t,h)
xlabel('t(s)')
ylabel('h(m)')

function dhdt=tank_fill(t,h)

A=5;
a=0.01;
g=9.8;
Q=0.03;
dhdt=zeros(1,1);
dhdt(1)=Q/A-a/A*sqrt(2*g*h);
end