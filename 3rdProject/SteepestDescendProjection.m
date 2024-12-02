clc; clear;

% Define the function and its gradient
f = @(x, y) (1/3) * x.^2 + 3 * y.^2;  % Example quadratic function
grad_f = @(x, y) [(2/3) * x; 6 * y]; % Gradient of f

% Parameters
tolerance = 0.01; % Convergence tolerance
max_iters = 1000; % Maximum number of iterations
gamma_k = 0.5;    % Step size
bounds = [-10, 5; -8, 12]; % Bounds for x and y
x_k = [-5; 5];    % Initial point (x, y)
s_k = 5;          % Fixed step size (not explicitly used in the algorithm)

% Gradient Descent with Projection
for k = 1:max_iters
    % Compute gradient
    grad = grad_f(x_k(1), x_k(2));
    
    % Update step
    x_next = x_k - gamma_k * grad;
    
    % Apply projection
    x_next(1) = min(max(x_next(1), bounds(1, 1)), bounds(1, 2)); % Project x
    x_next(2) = min(max(x_next(2), bounds(2, 1)), bounds(2, 2)); % Project y
    
    % Check convergence
    if norm(grad) < tolerance
        fprintf('Converged at iteration %d.\n', k);
        fprintf('Minimum at (%.4f, %.4f) with f(x, y) = %.6f.\n', x_k(1), x_k(2), f(x_k(1), x_k(2)));
        break;
    end
    
    % Update variables
    x_k = x_next;
end

% If the maximum iterations are reached
if k == max_iters
    fprintf('Maximum iterations reached. Last point: (%.4f, %.4f).\n', x_k(1), x_k(2));
end
