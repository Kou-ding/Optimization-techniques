% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Choose the function to minimize
f=f1;

% Initialize the interval and tolerance parameters
a = -1;
b = 3;
l = 0.01;        % Desired accuracy
delta = 1e-5;    % Small tolerance for dichotomy