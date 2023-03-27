x=0:0.0001:1;
y=fun3_1(x);

[ymin,index]=max(y)
xmax=x(index) 



function [y]=fun3_1(x)
y=(x.*(1-x))./(3.*(1-x).*(1-x)-0.8.*x+1);
end
