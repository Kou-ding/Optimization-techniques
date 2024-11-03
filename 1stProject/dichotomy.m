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
epsilon = 0.001;    % Small tolerance for dichotomy
count = 0;      % Counter for the number of iterations

% Iterative search
while (b - a) > l
    % Midpoint of the current interval
    m = (a + b) / 2;
    
    % Calculate x1 and x2 close to the midpoint m
    x1 = m - epsilon;
    x2 = m + epsilon;
    
    % Evaluate function at x1 and x2
    f_x1 = f(x1);
    f_x2 = f(x2);
    
    % Update the interval [a, b] based on function values at x1 and x2
    if f_x1 < f_x2
        b = m;  % Keep the left half
    else
        a = m;  % Keep the right half
    end
    count = count + 1;
end

% Output the result
minimum_x = (a + b) / 2;
minimum_f = f(minimum_x);

fprintf('Approximate minimum value: %.5f at x = %.5f\n', minimum_f, minimum_x);
fprintf('Number of iterations: %d\n', count);
fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);

