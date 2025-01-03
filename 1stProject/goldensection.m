% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Golden section method for finding the minimum of a function
function y = goldenFunc(f,l)
    % Initialize the interval and tolerance parameters
    a = -1;
    b = 3;

    % Golden ratio
    gamma = 0.618; 

    % Counter for the number of iterations
    fcount = 0;

    % Compute initial interior points
    x1 = a + (1 - gamma) * (b - a);
    x2 = a + gamma * (b - a);

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
        fcount = fcount + 2; % here we count function evaluations
    end

    % Output the result
    minimum_x = (a + b) / 2;
    minimum_f = f(minimum_x);

    fprintf('Approximate minimum value: f(%.5f) = %.5f\n', minimum_x, minimum_f);
    fprintf('Interval [a,b]: [%.5f,%.5f]\n', a, b);

    y = fcount;
end

% Function calculation count vs. l
l_values = 0.0021:0.01:1; % The range of l values
fcount_values = zeros(size(l_values)); % Preallocate for efficiency

for idx = 1:length(l_values)
    l = l_values(idx);
    fcount_values(idx) = goldenFunc(f3,l);
end

% Plot
plot(l_values, fcount_values, 'b-', 'LineWidth', 1.5);
xlabel('l');
ylabel('f calc count');
title('Golden section Method');
grid on;

