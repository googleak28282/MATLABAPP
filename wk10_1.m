clear all
clc
close all

fun = @adiabaticCSTR;
x_T_0 = [0.3, 370];
x_T = fsolve(fun, x_T_0)

% x_T(1) = xA, conversion
% x_T(2) = T, steady-state temperature T [K] in the reactor

function y = adiabaticCSTR(x_T)

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

k = k_300*exp(Ea/R*(1/300-1/x_T(2))); % rate constant at T [L/mol/min] 

% x_T(1) = xA, conversion
% x_T(2) = T, steady-state temperature T [K] in the reactor

y(1) = CA0*F*x_T(1) - k*CA0^2*(1-x_T(1))^2*V; % mass balance equation
y(2) = CA0*CPA*(x_T(2) - Tin) + CS0*CPS*(x_T(2) - Tin) + CS0*x_T(1)*Hrxn; % energy balance equation 1
end