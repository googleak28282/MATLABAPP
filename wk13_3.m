clear all
clc
close all

v0=185*1000/3600; % velocity in [m/s]
angles=38:52; % angle in [dgree]
flyingt=zeros(15,1);
distance=zeros(15,1);
tspan = 0:0.01:9;
for n = 1:15
    x0 = [v0*sind(angles(n)), 0, v0*cosd(angles(n)), 0];
    fun = @(t,x) fly_baseball_no_drag(v0,angles(n),t,x);
    [t,x]=ode45(fun,tspan,x0);

    cutoff = 0;

    for m = 1:(length(t)-1)
        if x(m,2)*x(m+1,2)<0
            cutoff = m;
        end
    end
    flyingt(n)=t(cutoff);
    distance(n)= x(cutoff,4);
end

plot(angles,flyingt,'o')
figure
plot(angles,distance,'o')
function dxdt=fly_baseball_no_drag(v0,angle,t,x)

m=0.145; % mass of baseball in [kg]
g=9.8; % gravity in [m/s^2]

dxdt = zeros(4,1);

dxdt(1) = -g;
dxdt(2) = x(1);
dxdt(3) = 0;
dxdt(4) = x(3);

end
