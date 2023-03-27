x5 = 0:0.1:1;
P7vap=0.188;
P5vap=1.564;
P=x5.*p5vap+(1-x5).*P7vap;
y5 = x5.*P5vap./P;
P5=y5.*P+(1-y5).*P;
plot(x5,P,':s')
hold on
plot(y5,P5,'--o')