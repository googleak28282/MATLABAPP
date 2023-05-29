clear all
clc
close all

fun = @nonisoCSTR;
tspan = 0:1:2000; % time span [min]

x01 = 0.64; % initial conversion
T01 = 364; % initial temperature of the CSTR [K]
[t1, x_T1] = ode45(fun,tspan,[x01 T01]); %solving ODEs with the initial conditions

x02 = 0.6358; % initial conversion
T02 = 363.58; % initial temperature of the CSTR [K]
[t2, x_T2] = ode45(fun,tspan,[x02 T02]); %solving ODEs with the initial conditions

x03 = 0.6357696499066; % initial conversion
T03 = 363.5769649906603; % initial temperature of the CSTR [K]
[t3, x_T3] = ode45(fun,tspan,[x03 T03]); %solving ODEs with the initial conditions
%replace the solver with ode15s and you will see some differences

plot(t1,x_T1(:,1));
xlabel('t (min)');  
ylabel('X_A');
hold on
plot(t2,x_T2(:,1));
plot(t3,x_T3(:,1));
legend('(0.64, 364)', '(0.6358, 363.58)', '(0.6357696499066, 363.5769649906603)')

figure; plot(t1,x_T1(:,2));
xlabel('t (min)');  
ylabel('T (K)'); % Corrected the ylabel
hold on
plot(t2,x_T2(:,2));
plot(t3,x_T3(:,2));
legend('(0.64, 364)', '(0.6358, 363.58)', '(0.6357696499066, 363.5769649906603)')

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
