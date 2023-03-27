tic
fun=@fun3_1;
x1=0;
x2=1;
x=fminbnd(fun,x1,x2);
ans=-fun3_1(x)
toc
function y=fun3_1(x)
y=-(x*(1-x))/(3*(1-x)*(1-x)-0.8*x+1);
end
