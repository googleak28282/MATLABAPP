dlg=inputdlg({"Tc","Pc","omega","T","p"},'User input',[1 30:1 30:1 30:1 30:1 30]);
Tc=str2num(dlg{1});
Pc=str2num(dlg{2});
omega=str2num(dlg{3});
T=str2num(dlg{4});
P=str2num(dlg{5});

[V1,V2,V3] = PREOS (Tc,Pc,omega,T,P);
V1_string=num2str(V1);
V2_string=num2str(V2);
V3_string=num2str(V3);

disp(V1);
disp(V2);
disp(V3);

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