% Use symbolic variables
syms x;

% Define f1(x)
f1 = (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Dichotomy method(with derivatives) for finding the minimum of a function
function iter = dichotomy2Func(f, l)
    % Derivative of the function
    df = diff(f);
    % Convert symbolic expressions to functions handle
    f = matlabFunction(f);
    df = matlabFunction(df);

    % Initialize the interval and tolerance
    a = -1;
    b = 3;

    % Initialize the minimum values
    minimum_x = 0; 
    minimum_f = 0;
    
    count = 0; % Counter for the number of iterations

    % Iterative search using the dichotomy method with derivative
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
            % If derivative is negative, move right
            a = mid;  % New interval is [mid, b]
        else
            % If derivative is zero, the minimum is found
            minimum_x = mid;
            minimum_f = f(mid);
        end
        count = count + 2;
    end

    % Calculate the approximate minimum
    % (if we failed to hit the df=0 point) 
    if minimum_x == 0
        minimum_x = (a + b) / 2;
    end
    if minimum_f == 0
        minimum_f = f(minimum_x);
    end

    % Display results
    fprintf('Approximate minimum: f(%.5f) = %.5f\n', minimum_x, minimum_f);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);

    iter = count;
end

% Function calculation count vs. l
l_values = 0.0021:0.01:1; % The range of l values
fcount_values = zeros(size(l_values)); % Preallocate for efficiency

for idx = 1:length(l_values)
    l = l_values(idx);
    fcount_values(idx) = dichotomy2Func(f1,l);
end

% Plot
plot(l_values, fcount_values, 'b-', 'LineWidth', 1.5);
xlabel('l');
ylabel('df calc count');
title('Dichotomy Method(with derivatives)');
grid on;
