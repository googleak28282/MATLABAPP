clear all;
clc;
close all;

Tc = 154.6; % in K
Pc = 5.046e6; % in Pa
omega = 0.021; 

P_VLE = zeros(1,65);
T = zeros(1,65);
V_L_VLE = zeros(1,65);
V_V_VLE = zeros(1,65);

for n = 1:65
    
    T(n) = 89 + n;
       
    P_VLE(n) = PREOS_VLE(Tc, Pc, omega, T(n));
    
    [Z1, Z2, Z3, phi_L, phi_V, V_L, V_V] = PREOS_fugacity(Tc, Pc, omega, T(n), P_VLE(n));
    V_L_VLE(n) = V_L;
    V_V_VLE(n) = V_V;
    
end

V_plot = [V_L_VLE, 0.0732e-3, flip(V_V_VLE)];
P_plot = [P_VLE, Pc, flip(P_VLE)];
loglog(V_plot, P_plot, 'k');
hold on;

xlabel('Molar volume (m^3/mol)');
ylabel('Pressure (Pa)');
title('PV diagram');
xlim([2e-5 2e-2]);
ylim([1e5 1e7]);

T_above_Tc = [423.15, 323.15, 223.15, Tc];

for m = 1: 4
    
    v_plot = logspace(-4.62, -1, 1e4);
    p_plot = PREOS_PVT_fun(Tc, Pc, omega, T_above_Tc(m), v_plot);
    loglog(v_plot, p_plot);
    
end

T_below_Tc = [148.15, 123.15, 98.15];


for k = 1:3
    
    P_VLE(k) = PREOS_VLE(Tc, Pc, omega, T_below_Tc(k));
    [Z1, Z2, Z3, phi_L, phi_V, V_L, V_V] = PREOS_fugacity(Tc, Pc, omega, T_below_Tc(k), P_VLE(k));
    
    v_plot1 = logspace(-4.62, log10(V_L), 1e3);
    v_plot2 = logspace(log10(V_V), -1, 1e3);
    v_plot = [v_plot1, v_plot2];
    
    p_plot = PREOS_PVT_fun(Tc, Pc, omega, T_below_Tc(k), v_plot);
    loglog(v_plot, p_plot);
end

legend('VLE', '150 ^oC', '50 ^oC', '-50 ^oC', 'Tc', '-125 ^oC', '-150 ^oC', '-175 ^oC')


function [Z1, Z2, Z3, phi_L, phi_V, V_L, V_V] = PREOS_fugacity(Tc, Pc, omega, T, P)

% This function outputs the roots, Z, fugacity coeff, and molar volume of liquid and vapor phases based on the Peng-Robinson equation
% of state
% Input properties include the species properties, Tc, Pc, and omega (acentric factor), and
% the current temperture(T) and pressure(P).
% Tc and T should be in K
% Pc and P should be in Pa
% omega is dimensionless

R = 8.314; % gas constant
kapa = 0.37464 + 1.54226.*omega - 0.26992.*omega.^2; % for calculating alpha
alpha = (1 + kapa.*(1-sqrt(T./Tc))).^2; % for calculating a
a = 0.45724.*R^2.*alpha.*Pc.^-1.*Tc.^2; % a in PR EOS
b = 0.07780.*R.*Tc.*Pc.^-1; % b in PR EOS

A = a.*P.*R^-2.*T^-2; % A for solving Z
B = b.*P.*R^-1.*T^-1; % B for solving Z

Z_coeff = [1, -(1-B), (A-3.*B.^2-2.*B), -(A.*B-B.^2-B.^3)]; % coeff for the cubic equation for solving Z
s = roots(Z_coeff);

Z1 = s(1);  % The three Z values based on PREOS
Z2 = s(2);
Z3 = s(3);

Z = [Z1, Z2, Z3];

Z_L = min(Z); % The min Z value corresponds to liquid state
Z_V = max(Z); % The max Z value corresponds to vapor state

V_L = Z_L*R*T/P;
V_V = Z_V*R*T/P;

ln_phi_L = (Z_L-1)-log(Z_L-B)-A./2./sqrt(2)./B.*log((Z_L+(1+sqrt(2)).*B)./(Z_L+(1-sqrt(2)).*B)); % phi is fugacity coefficient
ln_phi_V = (Z_V-1)-log(Z_V-B)-A./2./sqrt(2)./B.*log((Z_V+(1+sqrt(2)).*B)./(Z_V+(1-sqrt(2)).*B));

phi_L = exp(ln_phi_L);
phi_V = exp(ln_phi_V);

end

function [P_VLE] = PREOS_VLE(Tc, Pc, omega, T)
%This function compute the VLE pressure for a given species at given T
%This function has to work with PREOS_fugaction function
% Input properties include the species properties, Tc, Pc, and omega (acentric factor), and
% the current temperture(T)
% Tc and T should be in K
% Pc should be in Pa
% omega is dimensionless

P_guess = Pc;
Z = i;

while isreal(Z) == 0;
    [Z1, Z2, Z3] = PREOS_fugacity(Tc, Pc, omega, T, P_guess);
    Z = [Z1, Z2, Z3];
    P_guess = P_guess*0.999;
end

[Z1, Z2, Z3, phi_L, phi_V] = PREOS_fugacity(Tc, Pc, omega, T, P_guess);

error = 10^3;

while error > 0.0001
    P_guess = (phi_L/phi_V)*P_guess;
    [Z1, Z2, Z3, phi_L, phi_V, V_L, V_V] = PREOS_fugacity(Tc, Pc, omega, T, P_guess);
    error = abs((phi_L-phi_V)/phi_V);
end

P_VLE = P_guess;
end

function [P] = PREOS_PVT_fun(Tc, Pc, omega, T, V)
% This function expresses P as a function of T and V based on Peng-Robinson EOS
% It allows you to generate the data for a PV diagram

% Input properties include the species properties, Tc, Pc, and omega (acentric factor), and
% the current temperture(T) and molar volume(V).
% Tc and T should be in K
% Pc should be in Pa
% V should be in m^3/mol
% omega is dimensionless

R = 8.314; % gas constant
kapa = 0.37464 + 1.54226.*omega - 0.26992.*omega.^2; % for calculating alpha
alpha = (1 + kapa.*(1-sqrt(T./Tc))).^2; % for calculating a
a = 0.45724.*R^2.*alpha.*Pc.^-1.*Tc.^2; % a in PR EOS
b = 0.07780.*R.*Tc.*Pc.^-1; % b in PR EOS

P = R.*T./(V-b) - a./(V.*(V + b) + b.*(V - b));

end
