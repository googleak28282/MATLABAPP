clear all
clc
close all

tic
% Define the number of samples
N = 1e4; 

% Initialize the array to hold the sample values
sampling_N = zeros(1, N); 
plot_in_x = -ones(1,N);
plot_in_y = -ones(1,N);
plot_out_x = -ones(1,N);
plot_out_y = -ones(1,N);

for n = 1:N
    % Generate random values for x and y
    x = rand;
    y = rand;
    
    % Check if the point is inside the circle
    if x^2+y^2 <= 1
        % Record a 1 if the point is inside the circle
        sampling_N(n) = 1;
        plot_in_x(n) = x;
        plot_in_y(n) = y;
    else
        plot_out_x(n) = x;
        plot_out_y(n) = y;
    end
end

% Compute the estimate of pi
pi_estimate = 4*sum(sampling_N)/N
error = abs(pi_estimate-pi)/pi

%plot
plot_in_x(plot_in_x==-1)=[];
plot_in_y(plot_in_y==-1)=[];
plot_out_x(plot_out_x==-1)=[];
plot_out_y(plot_out_y==-1)=[];

plot(plot_in_x,plot_in_y,'.r');
hold on
plot(plot_out_x,plot_out_y,'.b');
xlim([0 1]);
ylim([0 1]);
axis square
toc

