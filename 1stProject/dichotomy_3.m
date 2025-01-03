% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Dichotomy method for finding the minimum of a function
% dichotomyFunc(function, l, epsilon)
% l: Desired accuracy
% Epsilon: Tolerance
function [count_values, a_values, b_values] = dichotomyFunc(f,l,epsilon)
    % Initialize the interval and tolerance parameters
    a = -1;
    b = 3;
    count = 0;      % Counter for the number of iterations

    % Preallocate arrays with a row vector structure for efficiency
    max_iterations = 100;  % Adjust this based on expected iteration count
    count_values = zeros(1, max_iterations);
    a_values = zeros(1, max_iterations);
    b_values = zeros(1, max_iterations);
    
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
            b = x2;  % Keep the left half
        else
            a = x1;  % Keep the right half
        end

        % Store the current iteration count and interval limits
        count_values(count + 1) = count;
        a_values(count + 1) = a;
        b_values(count + 1) = b;

        % Increment the iteration counter
        count = count + 1; % here we count iterations
    end

    % Trim the unused preallocated array space
    count_values = count_values(1:count);
    a_values = a_values(1:count);
    b_values = b_values(1:count);

    % Output the result
    minimum_x = (a + b) / 2;
    minimum_f = f(minimum_x);

    fprintf('Approximate minimum value: f(%.5f) = %.5f\n', minimum_x, minimum_f);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);
end

% Call dichotomyFunc and retrieve iteration data
[count_values, a_values, b_values] = dichotomyFunc(f3,1,0.001);

% Plot
plot(count_values, a_values, 'b-', 'LineWidth', 1.5);
hold on;
plot(count_values, b_values, 'r-', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Interval limits');
title('Dichotomy Method (l = 1)');
legend('a', 'b');
grid on;
hold off;
