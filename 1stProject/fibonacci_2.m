% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);


function [count_values, a_values, b_values] = fibonacciFunc(f, l)
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

    % Preallocate arrays with a row vector structure for efficiency
    max_iterations = 100;  % Adjust this based on expected iteration count
    count_values = zeros(1, max_iterations);
    a_values = zeros(1, max_iterations);
    b_values = zeros(1, max_iterations);

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
        else
            % Move the interval to the left
            b = x2;
            x2 = x1;
            f2 = f1;
            
            % Update x1 based on the Fibonacci numbers
            x1 = a + F(n-k-1) / F(n-k+1) * (b - a);
            f1 = f(x1);
        end

        % Store the current iteration count and interval limits
        count_values(k) = k;
        a_values(k) = a;
        b_values(k) = b;

        % Increment the iteration counter
        k = k + 1; % here we count iterations
    end
    
    % Determine the final x value where the minimum occurs
    if f1 < f2
        xmin = x1;
        fmin = f1;
    else
        xmin = x2;
        fmin = f2;
    end

    % Trim the unused preallocated array space
    count_values = count_values(1:k-1);
    a_values = a_values(1:k-1);
    b_values = b_values(1:k-1);

    % Output the result
    fprintf('Approximate minimum value: f(%.5f) = %.5f\n', xmin, fmin);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);
end

% Call dichotomyFunc and retrieve iteration data
[count_values, a_values, b_values] = fibonacciFunc(f1,0.5);

% Plot
plot(count_values, a_values, 'b-', 'LineWidth', 1.5);
hold on;
plot(count_values, b_values, 'r-', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Interval limits');
title('Fibonacci Method (l = 0.5)');
legend('a', 'b');
grid on;
hold off;
