import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Define the range for x and y
x = np.linspace(-100, 100, 100)  # 100 points between -100 and 100
y = np.linspace(-100, 100, 100)

# Create a meshgrid for x and y
X, Y = np.meshgrid(x, y)

# Define the function f(x, y)
Z = (1/3) * X**2 + 3 * Y**2

# Create a 3D surface plot
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Plot the surface
surf = ax.plot_surface(X, Y, Z, cmap='jet', edgecolor='none')

# Add labels and title
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('f(x, y)')
ax.set_title('Plot of f(x, y) = (1/3) * x^2 + 3 * y^2')

# Add a color bar for the surface
fig.colorbar(surf, ax=ax, shrink=0.5, aspect=10)

# Improve visualization
ax.view_init(30, 120)  # Set a good viewing angle
plt.show()
