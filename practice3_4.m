Tc=input('Tc');
Pc=input('Pc');
omega=input('omega');
T=input('T');
P=input('P');

[V1,V2,V3] = PREOS (Tc,Pc,omega,T,P)

function [V1,V2,V3] = PREOS (Tc,Pc,omega,T,P)

R=8.314;

kapa = 0.37464 + 1.54226*omega - 0.26992*omega^2;
alpha=1+kapa*(1-(T/Tc)^0.5);
a=0.45724*(R*Tc)^2/Pc*alpha;
b=0.0778*R*Tc/Pc;
B=P*b/(R*T);
A=a*P/(R*T)^2;
p=[1 B-1 A-3*B^2-2*B B^2+B^3-A*B];
Z=roots(p);
V1=P*Z(1)/R*T;
V2=P*Z(2)/R*T;
V3=P*Z(3)/R*T;
end