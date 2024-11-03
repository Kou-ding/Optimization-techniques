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
l = 0.01;  % Desired accuracy
count = 0; % Counter for the number of iterations

% Preallocate Fibonacci numbers array with a reasonable maximum size
maxSize = 100;   % This is an arbitrary size; it could be larger if needed
F = zeros(1, maxSize);
F(1) = 1;
F(2) = 1;
n = 2;

% Generate Fibonacci numbers up to a value that accommodates the interval length
while F(n) < (b - a) / l
    n = n + 1;
    F(n) = F(n - 1) + F(n - 2);
end

% Trim the Fibonacci array to keep only necessary numbers
F = F(1:n); 
N = length(F) - 1; % Number of iterations needed based on Fibonacci sequence

% Initial points within the interval [a, b] using the Fibonacci ratio
c = a + (F(N - 1) / F(N)) * (b - a);
d = a + (F(N) / F(N + 1)) * (b - a);

% Iterative search
for k = 1:N-1
    % Evaluate function at points c and d
    f_c = f(c);
    f_d = f(d);
    
    % Update the interval [a, b]
    if f_c < f_d
        b = d;
        d = c;
        c = a + (F(N - k - 1) / F(N - k)) * (b - a); % Recalculate c
    else
        a = c;
        c = d;
        d = a + (F(N - k) / F(N - k + 1)) * (b - a); % Recalculate d
    end
    count = count + 1;
end

% Calculate the approximate minimum
minimum_x = (a + b) / 2;
minimum_f = f(minimum_x);

% Display results
fprintf('Approximate minimum value: %.5f at x = %.5f\n', minimum_f, minimum_x);
fprintf('Interval [a, b]: [%.5f, %.5f]\n', a, b);
