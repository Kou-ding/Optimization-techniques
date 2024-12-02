clc; clear;

% Define the function and its gradient
f = @(X, Y) X^5 * exp(-X^2 - Y^2);
grad_f = @(X, Y) [
    (5 * X^4 - 2 * X^6) * exp(-X^2 - Y^2);   % Partial derivative w.r.t. X
    -2 * Y * X^5 * exp(-X^2 - Y^2)           % Partial derivative w.r.t. Y
];

% Parameters
tolerance = 0.001; % Convergence tolerance
max_iters = 1000; % Maximum number of iterations
gamma_constant = [0.1, 0.3, 3, 5];


% Colors for the plots
colors = ['r', 'g', 'b', 'm'];

% Initial point
Xk = -1;
Yk = 1;

% Prepare a figure
figure;
hold on;
title(sprintf('Steepest descend - Initial Point (%.2f, %.2f)', Xk, Yk));
xlabel('Iteration');
ylabel('f(X, Y)');

for i = 1:length(gamma_constant)
    % Produce results for all gamma values
    gamma = gamma_constant(i);
    
    % Reset initial point for each method
    x = Xk;
    y = Yk;
    iter = 0;
    
    % Store function values
    func_values = [];
    
    while true
        % Compute gradient
        grad = grad_f(x, y);
        grad_norm = norm(grad);
        
        % Track function value
        func_values = [func_values, f(x, y)];
        
        % Check convergence
        if grad_norm < tolerance || iter >= max_iters
            break;
        end
        
        % Update variables
        x = x - gamma * grad(1);
        y = y - gamma * grad(2);
        iter = iter + 1;
    end
    
    % Plot the convergence
    plot(func_values, colors(i), 'DisplayName', sprintf('gamma = %.2f', gamma_constant(i)));
    
    % Final results for this method
    fprintf('Minimum at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n', x, y, f(x, y), iter);
end
    
% Add legend and finalize plot
legend;
hold off;
fprintf('\n');
