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
function y = dichotomyFunc(f,l,epsilon)
    % Initialize the interval and tolerance parameters
    a = -1;
    b = 3;
    fcount = 0;      % Counter for the number of iterations

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
        fcount = fcount + 2; % here we count function evaluations
    end

    % Output the result
    minimum_x = (a + b) / 2;
    minimum_f = f(minimum_x);

    fprintf('Approximate minimum value: %.5f at x = %.5f\n', minimum_f, minimum_x);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);

    y = fcount;
end

% Function calculation count vs. epsilon
i_values = 0.00001:0.00001:0.004999999; % The range of i values
fcount_values = zeros(size(i_values)); % Preallocate for efficiency

for idx = 1:length(i_values)
    i = i_values(idx);
    fcount_values(idx) = dichotomyFunc(f1,0.01,i);
end

% Plot
plot(i_values, fcount_values, 'b-', 'LineWidth', 1.5);
xlabel('epsilon');
ylabel('f calc count');
title('Dichotomy Method');
grid on;

