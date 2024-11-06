% Use symbolic variables
syms x;

% Define f1(x)
f1 = (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Dichotomy method(with derivatives) for finding the minimum of a function
function [count_values, a_values, b_values] = dichotomy2Func(f,l)
    % Derivative of the function
    df = diff(f);
    % Convert symbolic expressions to functions handle
    f = matlabFunction(f);
    df = matlabFunction(df);

    % Initialize the interval and tolerance parameters
    a = -1;
    b = 3;
    % Counter for the number of iterations
    count = 0;    
    % Initialize the minimum values  
    minimum_x = 0;
    minimum_f = 0;

    % Preallocate arrays with a row vector structure for efficiency
    max_iterations = 100;  % Adjust this based on expected iteration count
    count_values = zeros(1, max_iterations);
    a_values = zeros(1, max_iterations);
    b_values = zeros(1, max_iterations);
    
    % Iterative search
    while (b - a) > l
        % Compute the midpoint
        mid = (a + b) / 2;
        
        % Evaluate the function's derivative at the midpoint
        df_mid = df(mid);
        
        % Check the derivative to determine the direction
        if df_mid > 0
            % If derivative is positive, move left
            b = mid;  % New interval is [a, mid]
        elseif df_mid < 0
            % If derivative is negative , move right
            a = mid;  % New interval is [mid, b]
        else
            % If derivative is zero, the minimum is found
            minimum_x = mid;
            minimum_f = f(mid);
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
    if minimum_x==0 
        minimum_x = (a + b) / 2;
    end
    if minimum_f==0
        minimum_f = f(minimum_x);
    end

    fprintf('Approximate minimum value: f(%.5f) = %.5f\n', minimum_x, minimum_f);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);
end

% Call dichotomyFunc and retrieve iteration data
[count_values, a_values, b_values] = dichotomy2Func(f1,1);

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

