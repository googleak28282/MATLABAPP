fun=@flow;
Q0=10*ones(1,5);
Q=fsolve(fun,Q0);

function y=flow(Q)
y(1)=Q(1)+Q(2)-25;
y(2)=Q(1)-Q(4)-Q(3);
y(3)=Q(2)+Q(3)-Q(5)-10;
y(4)=2*Q(1)^2+Q(3)^2-3*Q(2)^2;
y(5)=2*Q(1)^2+3*Q(4)^2-3*Q(2)^2-2*Q(5)^2;
end