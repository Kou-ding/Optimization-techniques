% Newton Method for minimizing f(X, Y)
% f(X,Y) = X^5 * exp(-X^2 - Y^2)

clc; clear;

% Define the function, its gradient, and Hessian
f = @(X, Y) X.^5 .* exp(-X.^2 - Y.^2);
grad_f = @(X, Y) [
    (5 * X.^4 - 2 * X.^6) .* exp(-X.^2 - Y.^2);   % Partial derivative w.r.t. X
    -2 * Y .* X.^5 .* exp(-X.^2 - Y.^2)           % Partial derivative w.r.t. Y
];
hess_f = @(X, Y) [
    (20 * X.^3 - 12 * X.^5 + 4 * X.^7) .* exp(-X.^2 - Y.^2), -10 * Y .* X.^4 .* exp(-X.^2 - Y.^2);
    -10 * Y .* X.^4 .* exp(-X.^2 - Y.^2), (-2 * X.^5 + 4 * Y.^2 .* X.^5) .* exp(-X.^2 - Y.^2)
];

% Initial points
initial_points = [0, 0; -1, 1; 1, -1]; % Points xy1, xy2, xy3

% Parameters
tolerance = 1e-6; % Convergence tolerance
max_iters = 100;  % Maximum number of iterations

% Iterate over each initial point
for idx = 1:size(initial_points, 1)
    % Extract the current initial point
    Xk = initial_points(idx, 1);
    Yk = initial_points(idx, 2);
    
    fprintf('Starting point: (%.2f, %.2f)\n', Xk, Yk);
    iter = 0;
    
    while true
        % Compute gradient and Hessian
        grad = grad_f(Xk, Yk);
        hess = hess_f(Xk, Yk);
        
        % Check convergence
        if norm(grad) < tolerance || iter >= max_iters
            break;
        end
        
        % Solve Newton's direction: d = -H^-1 * grad
        d = -hess \ grad;
        
        % Update variables
        Xk = Xk + d(1);
        Yk = Yk + d(2);
        iter = iter + 1;
        
        % Display progress
        fprintf('Iter %d: X = %.4f, Y = %.4f, f(X, Y) = %.6f\n', iter, Xk, Yk, f(Xk, Yk));
    end
    
    % Display result
    fprintf('Minimum found at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n\n', ...
        Xk, Yk, f(Xk, Yk), iter);
end
