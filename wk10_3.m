F = 10; % volumetric flow rate of feed [L/min]
CA0 = 4; % feed concentration of CA [mol/L]
CS0 = 4; % feed concentration of solvent [mol/L]
V = 500; % volume of reactor [L]

Hrxn = -3300; % heat of reaction [cal/mol]
CPA = 15; % heat capacity of A and B [cal/mol/K]
CPS = 18; % heat capacity of solvent [cal/mol/K]
k_300 = 0.0005; % rate constant at 300 K [L/mol/min]
Ea = 15000; % activation energy [cal/mol]
R = 1.987; % gas constant [cal/mol/K]
Tin = 300; % entrance temperature [K]

T = 300:0.1:400;
k = k_300.*exp(Ea./R.*(1./300.-1./T)); % rate constant at T [L/mol/min] 

% x_T(1) = xA, conversion
% x_T(2) = T, steady-state temperature T [K] in the reactor

a=k.*CA0.*V;
b=-1.*(F+2.*k.*CA0.*V);
c=k.*CA0.*V;

x=(-1.*b-(b.^2.-4.*a.*c).^(1/2))./(2*a);
EB=(CA0.*CPA.*(T - Tin) + CS0.*CPS.*(T - Tin))./(CS0.*-Hrxn);
plot(T,x)
hold on
plot(T,EB)

