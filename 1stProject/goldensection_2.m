% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Golden section method for finding the minimum of a function
function [count_values, a_values, b_values] = goldenFunc(f,l)
    % Initialize the interval and tolerance parameters
    a = -1;
    b = 3;

    % Golden ratio
    gamma = 0.618; 

    % Counter for the number of iterations
    count = 0;

    % Compute initial interior points
    x1 = a + (1 - gamma) * (b - a);
    x2 = a + gamma * (b - a);

    % Preallocate arrays with a row vector structure for efficiency
    max_iterations = 100;  % Adjust this based on expected iteration count
    count_values = zeros(1, max_iterations);
    a_values = zeros(1, max_iterations);
    b_values = zeros(1, max_iterations);

    % Iterative search
    while (b - a) > l
        % Evaluate function at points c and d
        f_x1 = f(x1);
        f_x2 = f(x2);
        
        % Update the interval [a, b]
        if f_x1 > f_x2
            a = x1;    
            x1 = x2;  
            x2 = a + gamma*(b-a);  
        else
            b = x2; 
            x2 = x1;      
            x1 = a + (1 - gamma)*(b - a); 
        end

        % Store the current iteration count and interval limits
        count_values(count + 1) = count;
        a_values(count + 1) = a;
        b_values(count + 1) = b;

        % Increment the iteration counter
        count = count + 1; % here we count function evaluations
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

% Call goldenFunc and retrieve iteration data
[count_values, a_values, b_values] = goldenFunc(f3,0.5);

% Plot
plot(count_values, a_values, 'b-', 'LineWidth', 1.5);
hold on;
plot(count_values, b_values, 'r-', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Interval limits');
title('Golden section Method (l = 0.5)');
legend('a', 'b');
grid on;
hold off;
