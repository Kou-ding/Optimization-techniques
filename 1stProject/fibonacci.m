% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);


function fcount = fibonacciFunc(f, l)
    % fibonacci_min: Finds the minimum of a function in a given interval
    % using the Fibonacci search algorithm.
    %
    % INPUTS:
    %   f   - function handle of the objective function to minimize
    %   l   - tolerance for the stopping criterion
    %
    % OUTPUTS:
    %   xmin - x value where the minimum is found
    %   fmin - function value at xmin
    %   iter - number of iterations performed
    
    % Set up the interval [a, b]
    a = -1;
    b = 3;

    % Counter for the number of function evaluations
    fcount = 0;      
    
    % Initialize the Fibonacci sequence
    n = 1;
    F = [1, 1]; % Initialize the first two Fibonacci numbers
    
    % Determine the smallest Fibonacci number F(n) such that F(n) > (b - a) / l
    while (F(n+1) < (b - a) / l)
        F = [F, F(n) + F(n+1)]; % Generate the next Fibonacci number
        n = n + 1;
    end
    
    % Set up initial points
    k = 1;
    x1 = a + F(n-1) / F(n+1) * (b - a);
    x2 = a + F(n) / F(n+1) * (b - a);
    
    % Evaluate the function at initial points
    f1 = f(x1);
    f2 = f(x2);
    fcount = fcount + 2;

    % Main loop
    while k < n-1
        if f1 > f2
            % Move the interval to the right
            a = x1;
            x1 = x2;
            f1 = f2;
            
            % Update x2 based on the Fibonacci numbers
            x2 = a + F(n-k) / F(n-k+1) * (b - a);
            f2 = f(x2);
            fcount = fcount + 1;
        else
            % Move the interval to the left
            b = x2;
            x2 = x1;
            f2 = f1;
            
            % Update x1 based on the Fibonacci numbers
            x1 = a + F(n-k-1) / F(n-k+1) * (b - a);
            f1 = f(x1);
            fcount = fcount + 1;
        end
        k = k + 1;
    end
    
    % Determine the final x value where the minimum occurs
    if f1 < f2
        xmin = x1;
        fmin = f1;
    else
        xmin = x2;
        fmin = f2;
    end

    fprintf('Approximate minimum value: f(%.5f) = %.5f\n', xmin, fmin);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);
end

% Function calculation count vs. l
l_values = 0.0021:0.01:1; % The range of l values
fcount_values = zeros(size(l_values)); % Preallocate for efficiency

for idx = 1:length(l_values)
    l = l_values(idx);
    fcount_values(idx) = fibonacciFunc(f1,l);
end

% Plot
plot(l_values, fcount_values, 'b-', 'LineWidth', 1.5);
xlabel('l');
ylabel('f calc count');
title('Fibonacci Method');
grid on;
