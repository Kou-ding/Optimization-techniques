clc; clear;

% Define the function and its gradient
f = @(X, Y) X^5 * exp(-X^2 - Y^2);
grad_f = @(X, Y) [
    (5 * X^4 - 2 * X^6) * exp(-X^2 - Y^2);   % Partial derivative w.r.t. X
    -2 * Y * X^5 * exp(-X^2 - Y^2)           % Partial derivative w.r.t. Y
];

% Initial points
initial_points = [0, 0; -1, 1; 1, -1]; % Points xy1, xy2, xy3

% Parameters
tolerance = 1e-4; % Convergence tolerance
max_iters = 100; % Maximum number of iterations
gamma_constant = 0.001; % Constant step size for method 1

% Colors for the plots
colors = ['r', 'g', 'b'];

% Iterate over each initial point
for idx = 1:size(initial_points, 1)
    % Extract the current initial point
    Xk = initial_points(idx, 1);
    Yk = initial_points(idx, 2);
    
    % Prepare a figure
    figure;
    hold on;
    title(sprintf('Steepest descend - Initial Point (%.2f, %.2f)', Xk, Yk));
    xlabel('Iteration');
    ylabel('f(X, Y)');
    
    for method = 1:3 % Loop through methods 1 (constant), 2 (minimization), 3 (Armijo)
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
            
            % Determine step size
            if method == 1
                % Case 1: Constant gamma
                gamma = gamma_constant;
            elseif method == 2
                % Case 2: Minimize f(x_k + gamma_k * d_k)
                gamma_fun = @(g) f(x - g * grad(1), y - g * grad(2));
                gamma = fminbnd(gamma_fun, 0, 1); % Minimize in range [0,1]
            elseif method == 3
                % Case 3: Armijo's rule
                beta = 0.5; 
                sigma = 0.1;
                gamma = 1;
                while f(x - gamma * grad(1), y - gamma * grad(2)) > ...
                        f(x, y) - sigma * gamma * grad_norm^2
                    gamma = beta * gamma; % Reduce gamma
                end
            end
            
            % Update variables
            x = x - gamma * grad(1);
            y = y - gamma * grad(2);
            iter = iter + 1;
        end
        
        % Plot the convergence
        plot(func_values, colors(method), 'DisplayName', sprintf('Method %d', method));
        
        % Final results for this method
        fprintf('Method %d: Minimum at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n', ...
            method, x, y, f(x, y), iter);
    end
    
    % Add legend and finalize plot
    legend;
    hold off;
    fprintf('\n');
end