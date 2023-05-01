clear all;
clc;
close all;

Tc = 154.6; % in K
Pc = 5.046e6; % in Pa
omega = 0.021; 

T = [98.15, 123.15, 148.15, Tc];
v_plot = logspace(-4.62, -1, 1e4);

for n = 1:4
    
    p_plot = PREOS_PVT_fun(Tc, Pc, omega, T(n), v_plot);
    semilogx(v_plot, p_plot);
    hold on;
    
end

hold off;

xlabel('Molar volume (m^3/mol)');
ylabel('Pressure (Pa)');
title('PV diagram');
xlim([2e-5 1e-1]);
ylim([-4e7 4.2e7]);
legend('-175 ^oC,', '-150 ^oC','-125 ^oC', 'Tc');

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
