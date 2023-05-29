F=5;
m=10;

tspan=0:0.1:10;
x0=[0,0];
fun = @(t,x) newton2law(F,m,t,x);
[t,x]=ode45(fun,tspan,x0);
plot(t,x(:,1))
plot(t,x(:,2))
function dxdt=newton2law(F,m,t,x)
dxdt=zeros(2,1);
dxdt(1)=F/m;
dxdt(2)=x(1);
end