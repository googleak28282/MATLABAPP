clear all
clc
close all

k = 1.38064E-23; % Boltzmann constant
h = 6.62607E-34; % Planck constant

mass = 40/1E3/(6.02*1E23); % mass of argon
V_gas = 0.025; % volume of gas phase

Lattice = zeros(50,50); % a 2D lattice with all elements of 0
M = numel(Lattice); % number of total sites available for adsorption

E_ads = -5E-20; % energy level of an adsorbed molecule
T = [220, 250];
N_gas = 6.02E25*[0.001, 1, 2, 3, 4, 5, 6, 7, 8, 9]; % number of gas molecules, which will be adjusted in line 24
coverage = zeros(1,10);
P_plot = zeros(1,10);

for n = 1:2
    
    for m = 1:10
        
        N_gas_actual = N_gas(m)/T(n); % corrected number of gas molecules
        q_gas = (2*pi*mass*k*T(n)/h^2)^1.5*V_gas; % partition function of a single gas molecule
        mu = -k*T(n)*log(q_gas/N_gas_actual); % chemical potential of the gas phase as well as the adsorbed phase
        
        MCM = 10^5; % number of Monte Carlo moves
        
        for L = 1:MCM
            
            i = randi([1 50]);
            j = randi([1 50]); % pick a random site
            new_state = randi([0 1]); % dicided if the new_state to be adsorbed or vacant
            
            P_ratio = exp((new_state*(mu-E_ads) - Lattice(i,j)*(mu-E_ads))/k/T(n)); % probability ratio between the new state and the current one
            
            if P_ratio >= 1
                Lattice(i,j) = new_state;
            else
                if rand < P_ratio
                    Lattice(i,j) = new_state;
                end
            end
            
        end
        
        N_ads = sum(Lattice(:)); % calculate number of lattice sites being adsorbed
        coverage(m) = N_ads/M; % ratio of lattice sites being adsorbed
        P_plot(m) = N_gas_actual*k*T(n)/V_gas;
    end
    
    plot(P_plot, coverage, 'o-');
    hold on
        
end

T1 = [num2str(T(1)),' K'];
T2 = [num2str(T(2)),' K'];
legend(T1,T2, 'location', 'northwest');
xlabel('Pressure (Pa)');
ylabel('Surface Coverage (-)');