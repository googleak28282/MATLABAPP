xEA = 0:0.1:1;
PEAvap=0.946;
PBZvap=0.862;
gammaEA=exp(1.15./(1+(1.15.*xEA)./(0.92.*(1-xEA))).^2);
gammaBZ=exp(0.92./(1+(0.92.*(1-xEA))./(1.15.*xEA)).^2);
P=gammaEA.*PEAvap.*xEA+gammaBZ.*(1-xEA).*PBZvap;
yEA = gammaEA.*xEA.*PEAvap./P;
plot(xEA,P,':s')
hold on
plot(yEA,P,'--o')
figure
plot(xEA,yEA,'-s')
hold on
plot(xEA,xEA,'--')