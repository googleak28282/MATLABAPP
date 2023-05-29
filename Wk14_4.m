clear all
clc
close all

k = 1.38064E-23; % Boltzmann constant
h = 6.62607E-34; % Planck constant

mass = 40/1E3/(6.02*1E23); % mass of argon
V_gas = 0.025; % volume of gas phase

Lattice = zeros(50,50); % a 2D lattice with all elements of 0
M = numel(Lattice); % number of total sites available for adsorption

T = 300; % temperature in K
N_gas = 1*6.02E23; % number of gas molecules
q_gas = (2*pi*mass*k*T/h^2)^1.5*V_gas; % partition function of a single gas molecule
mu = -k*T*log(q_gas/N_gas); % chemical potential of the gas phase as well as the adsorbed phase
P_gas = N_gas*k*T/V_gas; % pressure of gas phase

E_ads = -5E-20; % energy level of an adsorbed molecule

MCM = 10^5; % number of Monte Carlo moves

for L = 1:MCM
    
    i = randi([1 50]);
    j = randi([1 50]); % pick a random site
    new_state = randi([0 1]); % dicided if the new_state to be adsorbed or vacant
    
    P_ratio = exp((new_state*(mu-E_ads) - Lattice(i,j)*(mu-E_ads))/k/T); % probability ratio between the new state and the current one
    
    if P_ratio >= 1
        Lattice(i,j) = new_state;
    else
        if rand < P_ratio
            Lattice(i,j) = new_state;
        end
    end
    
end

figure(1);
imagesc(Lattice); colormap summer; colorbar; % display the final results

N_ads = sum(Lattice(:)); % calculate number of lattice sites being adsorbed
coverage = N_ads/M % ratio of lattice sites being adsorbed

