fun = @rxn_series;

tspan=0:0.1:100;
[t,Ci]=ode45(fun,tspan,[1;0;0;0]);
plot(t,Ci(:,1))
hold on
plot(t,Ci(:,2))
hold on
plot(t,Ci(:,3))
hold on
plot(t,Ci(:,4))
xlabel('t(s)')
ylabel('Ci')

function dCidt= rxn_series(t,Ci)

k1=0.3;
k2=0.8;
dCidt=zeros(4,1);
dCidt(1)=-k1*Ci(1)^2;
dCidt(2)=1/3*k1*Ci(1)^2-k2*Ci(2)*Ci(3);
dCidt(3)=2/3*k1*Ci(1)^2-2*k2*Ci(2)*Ci(3);
dCidt(4)=k2*Ci(2)*Ci(3);
end