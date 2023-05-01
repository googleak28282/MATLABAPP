clear all;
clc;
close all;

Tc = 154.6; % in K
Pc = 5.046e6; % in Pa
omega = 0.021; 
T = input('Input temperature (K): ');

if T >= Tc
    disp('Your input should be smaller than Tc.')
else
    P_VLE = PREOS_VLE(Tc, Pc, omega, T);
    
    P_VLE = num2str(P_VLE, '%E'); % '%E' is a format spec for engineering expression
    result = ['The pressure at VLE is ', P_VLE, ' bar.'];
    disp(result);
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