ruo = 1.184; % density in SI unit
mu = 1.849e-5; % viscosity in SI unit
d = 0.0762; % diameter in m
L = 1000; % length in m
delt_P = 3400; % pressure drop in Pa
tic

u = logspace(-2,3,200000);
Re = ruo.*u.*d./mu;
u2=u.*u;
fd_guess = delt_P.*2.*d./(L.*ruo.*u2);
fd_es=1./(-1.8.*log((6.9)./Re)).^2;
fd_er=abs((fd_guess-fd_es)./fd_es);
[ymin,index]=min(fd_er);
umin=u(index);
toc

tic

u_guess=1;
Re = ruo*u_guess*d/mu;
fd_guess2 = delt_P*2*d/(L*ruo*u_guess^2);
fd_es2=1/(-1.8*log((6.9)/Re))^2;
fder=abs((fd_guess2-fd_es2)/fd_guess2);
while fder>1e-4
   u_guess=u_guess/(fd_es2/fd_guess2);
   Re = ruo*u_guess*d/mu;
    fd_guess2 = delt_P*2*d/(L*ruo*u_guess^2);
    fd_es2=1/(-1.8*log((6.9)/Re))^2;
    fder=abs((fd_guess2-fd_es2)/fd_guess2);
end

toc