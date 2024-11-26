clc; clear;

% Define the function, its gradient, and its Hessian
f = @(X, Y) X^5 * exp(-X^2 - Y^2);
grad_f = @(X, Y) [
    (5 * X^4 - 2 * X^6) * exp(-X^2 - Y^2);   % Partial derivative w.r.t. X
    -2 * Y * X^5 * exp(-X^2 - Y^2)           % Partial derivative w.r.t. Y
];

hessian_f = @(X, Y) [
    exp(-X^2 - Y^2) * (20 * X^3 - 12 * X^5 + 4 * X^7), -10 * X^4 * Y * exp(-X^2 - Y^2); 
    -10 * X^4 * Y * exp(-X^2 - Y^2), exp(-X^2 - Y^2) * (2 * X^5 - 2 * X^5 * Y^2)
];

% Initial points
initial_points = [0, 0; -1, 1; 1, -1]; % Points xy1, xy2, xy3

% Parameters
tolerance = 1e-6; % Convergence tolerance
max_iters = 1000; % Maximum number of iterations
gamma_constant = 0.1; % Constant step size for method 1
mu_initial = 1e-3; % Initial damping factor for Levenberg-Marquardt

% Iterate over each initial point
for idx = 1:size(initial_points, 1)
    % Extract the current initial point
    Xk = initial_points(idx, 1);
    Yk = initial_points(idx, 2);
    
    fprintf('Starting point: (%.2f, %.2f)\n', Xk, Yk);
    
    for method = 1:3 % Loop through methods 1 (constant), 2 (minimization), 3 (Armijo)
        % Reset initial point for each method
        x = Xk;
        y = Yk;
        iter = 0;
        mu = mu_initial;
        
        while true
            % Compute gradient and Hessian
            grad = grad_f(x, y);
            hess = hessian_f(x, y);
            grad_norm = norm(grad);
            
            % Check convergence
            if grad_norm < tolerance || iter >= max_iters
                break;
            end
            
            % Modify Hessian using Levenberg-Marquardt damping
            hess_lm = hess + mu * eye(2);
            
            % Compute the direction
            direction = -hess_lm \ grad;
            
            % Determine step size
            if method == 1
                % Case 1: Constant gamma
                gamma = gamma_constant;
            elseif method == 2
                % Case 2: Minimize f(x_k + gamma_k * d_k)
                gamma_fun = @(g) f(x + g * direction(1), y + g * direction(2));
                gamma = fminbnd(gamma_fun, 0, 1); % Minimize in range [0,1]
            elseif method == 3
                % Case 3: Armijo's rule
                beta = 0.5; sigma = 0.1;
                gamma = 1;
                while f(x + gamma * direction(1), y + gamma * direction(2)) > ...
                        f(x, y) + sigma * gamma * grad' * direction
                    gamma = beta * gamma; % Reduce gamma
                end
            end
            
            % Update variables
            x_new = x + gamma * direction(1);
            y_new = y + gamma * direction(2);
            
            % Adjust damping factor
            if f(x_new, y_new) < f(x, y)
                mu = mu / 10; % Reduce damping factor if progress is made
            else
                mu = mu * 10; % Increase damping factor if no progress
            end
            
            % Update the variables
            x = x_new;
            y = y_new;
            iter = iter + 1;
        end
        
        % Final results for this method
        fprintf('Method %d: Minimum at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n', ...
            method, x, y, f(x, y), iter);
    end
    
    fprintf('\n');
end
