fun=@CSTR;
C0=10*ones(1,4);
CA=fsolve(fun,C0)

function y=CSTR(CA)
y(1)=1000-1000*CA(1)-100*CA(1);
y(2)=1000*CA(1)+100*CA(3)-1100*CA(2)-1500*0.2*CA(2);
y(3)=1100*CA(2)+100*CA(4)-1200*CA(3)-100*0.4*CA(3);
y(4)=1100*CA(3)-1100*CA(4)-500*0.3*CA(4);
end