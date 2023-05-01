fun = @chemical_E;
x0 = [0.1,0.1];
[x,y]=fsolve(fun,x0)

xB=x(1)
xD=x(2)

function y=chemical_E(x)
y(1)=(15*x(1)+10*x(2))/(40-30*x(1)-10*x(2))^2/(15-15*x(1))-5e-4;
y(2)=(15*x(1)+10*x(2))/(40-30*x(1)-10*x(2))/(10-10*x(2))-4e-2;
end
