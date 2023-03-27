f1= @(V)PREOS_PVT(154.6,5.046e6,0.021,110,V);
minV=fminbnd(f1,3e-5,4e-5);
fplot(f1,[2e-5 1e-2])

function [P]= PREOS_PVT(Tc,Pc,omega,T,V)
R=8.314;
kapa = 0.37464 + 1.54226*omega - 0.26992*omega^2;
alpha=1+kapa*(1-(T/Tc)^0.5);
a=0.45724*(R*Tc)^2/Pc*alpha;
b=0.0778*R*Tc/Pc;
P=R.*T./(V-b)-a./(V.*(V+b)+b.*(V+b));
end