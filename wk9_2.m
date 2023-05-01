fun = @chemical_E;
x0 = [0,0,0];
[x,y]=fsolve(fun,x0)

x_IP=1-x(1)-x(2)-x(3)
x_NP=x(1)
x_H2=x(2)+x(3)
x_AC=x(2)
X_PA=x(3)

function y=chemical_E(x)
y(1)=x(1)/(1-x(1)-x(2)-x(3))-0.064;
y(2)=x(2)*(x(2)+x(3))/((1-x(1)-x(2)-x(3))*(1+x(2)+x(3)))-0.076;
y(3)=x(3)*(x(2)+x(3))/((1-x(1)-x(2)-x(3))*(1+x(2)+x(3)))-1.2e-4;
end
