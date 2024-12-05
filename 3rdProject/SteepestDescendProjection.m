clc; clear;

% Define the function and its gradient
f = @(x1, x2) (1/3) * x1.^2 + 3 * x2.^2;  % Example quadratic function
grad_f = @(x1, x2) [(2/3) * x1; 6 * x2]; % Gradient of f

% Parameters
max_iters = 1000; % Maximum number of iterations
bounds = [-10, 5; -8, 12]; % Bounds for x1 and x2
tolerance = 0.01; % Convergence tolerance
gamma_k = [0.5, 0.1, 0.2]; % Step size
s_k = [5, 15, 0.1]; % Projection step size

% Initial point
x1k = [-5, -5, 8];
x2k = [5, 10, -10]; 

% Steepest descend variation 
variation = 1;

% Reset initial point for each method
x1 = x1k(variation);
x2 = x2k(variation);

% Prepare a figure
figure;
hold on;
title(sprintf('Steepest Descent with Projection - Initial Point (%.2f, %.2f)', x1, x2));
xlabel('Iteration');
ylabel('f(x_1, x_2)');

% Initialize iteration counter
iter = 0;

% Store function values
func_values = [];

% Steepest Descent Algorithm with Projection
while true
    % Compute the gradient
    grad = grad_f(x1, x2);
    grad_norm = norm(grad);
    
    % Track function value
    func_values = [func_values, f(x1, x2)];

    % Check convergence
    if grad_norm < tolerance || iter >= max_iters
        break;
    end

    % Update variables
    x1 = x1 - gamma_k(variation) * grad(1);
    x2 = x2 - gamma_k(variation) * grad(2);

    if x1 < bounds(1,1) || x1 > bounds(1,2) || x2 < bounds(2,1) || x2 > bounds(2,2)
        % Project x_k back into the feasible region
        x1 = x1 - s_k(variation) * grad(1);
        x2 = x2 - s_k(variation) * grad(2);

        % Check if the new point is within the bounds
        if x1 < bounds(1,1)
            x1 = bounds(1,1);
        elseif x1 > bounds(1,2)
            x1 = bounds(1,2);
        elseif x2 < bounds(2,1)
            x2 = bounds(2,1);
        elseif x2 > bounds(2,2)
            x2 = bounds(2,2);
        end
    end

    iter = iter + 1;

end

% Plot the convergence
plot(func_values, 'r', 'DisplayName', sprintf('gamma = %.2f', gamma_k(variation)));

% Final results for this method
fprintf('Minimum at (%.4f, %.4f) with f(x1, x2) = %.6f after %d iterations.\n', x1, x2, f(x1, x2), iter);

% Add legend and finalize plot
legend;
hold off;
fprintf('\n');