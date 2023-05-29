clear all
clc
close all

tic
% Define the number of samples
N = 1e4; 

% Initialize the array to hold the sample values
sampling_N = zeros(1, N); 

for n = 1:N
    % Generate random values for x and y
    x = rand;
    y = rand;
    
    % Check if the point is inside the circle
    if x^2+y^2 <= 1
        % Record a 1 if the point is inside the circle
        sampling_N(n) = 1;
        % Plot the point in red if it is inside the circle
        plot(x,y,'.r');
        hold on;
    else
        % Plot the point in blue if it is outside the circle
        plot(x,y,'.b');
        hold on;
    end
    
    % Set the axis limits to show the unit circle
    xlim([0 1]);
    ylim([0 1]);
    axis square;

end

% Compute the estimate of pi
pi_estimate = 4*sum(sampling_N)/N
error = abs(pi_estimate-pi)/pi
toc

