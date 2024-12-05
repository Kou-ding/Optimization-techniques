clc; clear;

% Define the function and its gradient
f = @(x1, x2) (1/3) * x1^2 + 3 * x2^2;  % Function
grad_f = @(x1, x2) [(2*x1)/3; 6*x2];    % Gradient of f

% Parameters
tolerance = 0.001; % Convergence tolerance
max_iters = 5;     % Maximum number of iterations
gamma_constant = [0.1, 0.3, 3, 5]; % Learning rates

% Colors for the plots
colors = ['r', 'g', 'b', 'm'];

% Initial point
x1k = -10;
x2k = 10;

% Prepare a figure
figure;
hold on;
title(sprintf('Steepest Descent - Initial Point (%.2f, %.2f)', x1k, x2k));
xlabel('Iteration');
ylabel('f(x_1, x_2)');

for i = 1:length(gamma_constant)-2
    % Produce results for all gamma values
    gamma = gamma_constant(i);
    
    % Reset initial point for each method
    x1 = x1k;
    x2 = x2k;
    iter = 0;
    
    % Store function values
    func_values = [];
    
    while true
        % Compute gradient
        grad = grad_f(x1, x2);
        grad_norm = norm(grad);
        
        % Track function value
        func_values = [func_values, f(x1, x2)];
        
        % Check convergence
        if grad_norm < tolerance || iter >= max_iters
            break;
        end
        
        % Update variables
        x1 = x1 - gamma * grad(1);
        x2 = x2 - gamma * grad(2);
        iter = iter + 1;
    end
    
    % Plot the convergence
    plot(func_values, colors(i), 'DisplayName', sprintf('gamma = %.2f', gamma_constant(i)));
    
    % Final results for this method
    fprintf('Minimum at (%.4f, %.4f) with f(x_1, x_2) = %.6f after %d iterations.\n', x1, x2, f(x1, x2), iter);
end
    
% Add legend and finalize plot
legend;
hold off;
fprintf('\n');
