% Use symbolic variables
syms x;

% Define f1(x)
f1 = (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Define the function f(x) and its derivative f'(x)
f = f1;
df = diff(f,x);

f = matlabFunction(f); % Convert symbolic expression to function handle
df = matlabFunction(df); % Convert symbolic expression to function handle

% Initialize the interval and tolerance
a = -1;
b = 3;
l = 0.01;  % Desired accuracy
count = 0; % Counter for the number of iterations

% Iterative search using the dichotomy method with derivative
while (b - a) > l
    % Compute the midpoint
    mid = (a + b) / 2;
    
    % Evaluate the function and its derivative at the midpoint
    f_mid = f(mid);
    df_mid = df(mid);
    
    % Check the derivative to determine the direction
    if df_mid > 0
        % If derivative is positive, move left
        b = mid;  % New interval is [a, mid]
    else
        % If derivative is negative or zero, move right
        a = mid;  % New interval is [mid, b]
    end
    count = count + 1;
end

% Calculate the approximate minimum
minimum_x = (a + b) / 2;
minimum_f = f(minimum_x);

% Display results
fprintf('Approximate minimum value: %.5f at x = %.5f\n', minimum_f, minimum_x);
fprintf('Number of iterations: %d\n', count);
fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);