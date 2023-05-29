clear all
clc
close all

fun = @nonisoCSTR;
tspan = 0:0.1:800; % time span [min]
results = zeros(100,4);

for n = 1:10
    x0 = 0 + 0.1*n; % initial conversion
    
    for m = 1:10
        T0 = 300 + 10*m; % initial temperature of the CSTR [K]
        [t, x_T] = ode45(fun,tspan,[x0 T0]); %solving ODEs with the initial conditions
        results(((n-1)*10+m),1) = x0;
        results(((n-1)*10+m),2) = T0;
        results(((n-1)*10+m),3) = x_T(8001,1);
        results(((n-1)*10+m),4) = x_T(8001,2);
    end   
end

function dx_Tdt = nonisoCSTR(t, x_T)

F = 17; % volumetric flow rate of feed [L/min]
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

k = k_300*exp(Ea/R*(1/300-1/x_T(2))); % rate constant at T [L/mol/min] 

dx_Tdt = zeros(2,1); % Initialize the vector before assigning values

dx_Tdt(1) = -F/V*x_T(1) + k*CA0*(1-x_T(1))^2; % mass balance equation
dx_Tdt(2) = F/V*((CPA+CPS)/CPA)*(Tin - x_T(2)) + k*CA0*(1-x_T(1))^2*(-Hrxn/CPA); % energy balance equation
end
