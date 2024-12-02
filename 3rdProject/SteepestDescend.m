clc; clear;

% Define the function and its gradient
f = @(x, y) (1/3) * x^2 + 3 * y^2;
grad_f = @(x, y) [(2*x)/3; x 6*y;];

% Parameters
tolerance = 0.001; % Convergence tolerance
max_iters = 100000; % Maximum number of iterations
gamma_constant = [0.1, 0.3, 3, 5];


% Colors for the plots
colors = ['r', 'g', 'b', 'm'];

% Initial point
xk = -5;
yk = 5;

% Prepare a figure
figure;
hold on;
title(sprintf('Steepest descend - Initial Point (%.2f, %.2f)', xk, yk));
xlabel('Iteration');
ylabel('f(x, y)');

for i = 1:length(gamma_constant)
    % Produce results for all gamma values
    gamma = gamma_constant(i);
    
    % Reset initial point for each method
    x = xk;
    y = yk;
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
    fprintf('Minimum at (%.4f, %.4f) with f(x, y) = %.6f after %d iterations.\n', x, y, f(x, y), iter);
end
    
% Add legend and finalize plot
legend;
hold off;
fprintf('\n');
