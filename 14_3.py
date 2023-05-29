import numpy as np
import matplotlib.pyplot as plt

# Define the number of samples
N = int(1e4)

# Initialize the array to hold the sample values
sampling_N = np.zeros(N)
plot_in_x = -np.ones(N)
plot_in_y = -np.ones(N)
plot_out_x = -np.ones(N)
plot_out_y = -np.ones(N)

for n in range(N):
    # Generate random values for x and y
    x = np.random.rand()
    y = np.random.rand()

    # Check if the point is inside the circle
    if x**2 + y**2 <= 1:
        # Record a 1 if the point is inside the circle
        sampling_N[n] = 1
        plot_in_x[n] = x
        plot_in_y[n] = y
    else:
        plot_out_x[n] = x
        plot_out_y[n] = y

# Compute the estimate of pi
pi_estimate = 4*np.sum(sampling_N)/N
error = abs(pi_estimate-np.pi)/np.pi

# Clean up plot data
plot_in_x = plot_in_x[plot_in_x!=-1]
plot_in_y = plot_in_y[plot_in_y!=-1]
plot_out_x = plot_out_x[plot_out_x!=-1]
plot_out_y = plot_out_y[plot_out_y!=-1]

# Plotting
plt.plot(plot_in_x, plot_in_y, '.r')
plt.plot(plot_out_x, plot_out_y, '.b')
plt.xlim([0, 1])
plt.ylim([0, 1])
plt.gca().set_aspect('equal', adjustable='box')
plt.show()

print("Estimated Pi: ", pi_estimate)
print("Error: ", error)
