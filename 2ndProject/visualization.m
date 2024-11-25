% Define the range for x and y
x = linspace(-3, 3, 100); % 100 points between -3 and 3
y = linspace(-3, 3, 100);

% Create a meshgrid for x and y
[X, Y] = meshgrid(x, y);

% Define the function f(x, y)
Z = X.^5 .* exp(-X.^2 - Y.^2);

% Create a 3D surface plot
figure;
surf(X, Y, Z);

% Add labels and title
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('Plot of f(x, y) = x^5 e^{-x^2 - y^2}');

% Improve visualization
shading interp; % Smooth color transition
colormap jet; % Use a colorful colormap
colorbar; % Show color scale
grid on;
