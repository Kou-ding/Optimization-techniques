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
phi = (1 + sqrt(5)) / 2; % Golden ratio

% Compute initial interior points
c = b - (b - a) / phi;
d = a + (b - a) / phi;

% Iterative search
while (b - a) > l
    % Evaluate function at points c and d
    f_c = f(c);
    f_d = f(d);
    
    % Update the interval [a, b]
    if f_c < f_d
        b = d;       % Keep the left part
        d = c;       % New point d moves closer to a
        c = b - (b - a) / phi; % Recalculate c using golden section
    else
        a = c;       % Keep the right part
        c = d;       % New point c moves closer to b
        d = a + (b - a) / phi; % Recalculate d using golden section
    end
end

% Output the result
minimum_x = (a + b) / 2;
minimum_f = f(minimum_x);

fprintf('Approximate minimum value: %.5f at x = %.5f\n', minimum_f, minimum_x);
fprintf('Number of iterations: %d\n', count);
fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);
