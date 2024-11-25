% Steepest Descent Algorithm for minimizing f(X, Y)
% f(X,Y) = X^5 * exp(-X^2 - Y^2)

clc; clear;

% Define the function and its gradient
f = @(X, Y) X.^5 .* exp(-X.^2 - Y.^2);
grad_f = @(X, Y) [
    (5 * X.^4 - 2 * X.^6) .* exp(-X.^2 - Y.^2);   % Partial derivative w.r.t. X
    -2 * Y .* X.^5 .* exp(-X.^2 - Y.^2)           % Partial derivative w.r.t. Y
];

% Initial points
initial_points = [0, 0; -1, 1; 1, -1]; % Points xy1, xy2, xy3

% Parameters
tolerance = 1e-6; % Convergence tolerance
max_iters = 1000; % Maximum number of iterations
gamma_constant = 0.1; % Constant step size for method 1

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
        
        while true
            % Compute gradient
            grad = grad_f(x, y);
            grad_norm = norm(grad);
            
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
                beta = 0.5; sigma = 0.1;
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
        
        % Final results for this method
        fprintf('Method %d: Minimum at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n', ...
            method, x, y, f(x, y), iter);
    end
    
    fprintf('\n');
end

% % Steepest Descent Algorithm for minimizing f(X, Y)
% % f(X,Y) = X^5 * exp(-X^2 - Y^2)

% clc; clear;

% % Define the function and its gradient
% f = @(X, Y) X.^5 .* exp(-X.^2 - Y.^2);
% grad_f = @(X, Y) [
%     (5 * X.^4 - 2 * X.^6) .* exp(-X.^2 - Y.^2);   % Partial derivative w.r.t. X
%     -2 * Y .* X.^5 .* exp(-X.^2 - Y.^2)           % Partial derivative w.r.t. Y
% ];

% % Initial points
% xy1 = [0, 0];
% xy2 = [-1, 1];
% xy3 = [1, -1];

% % Parameters
% tolerance = 1e-6; % Convergence tolerance
% max_iters = 1000; % Maximum number of iterations
% gamma_constant = 0.1; % Constant step size for case 1

% % Iterate over each initial point
% for idx = 1:size(initial_points, 1)
%     % Starting point
%     Xk = initial_points(idx, 1);
%     Yk = initial_points(idx, 2);
    
%     fprintf('Starting point (%.2f, %.2f):\n', Xk, Yk);
%     fprintf('Iter\tX\t\tY\t\tf(X, Y)\n');
    
%     for method = 3
%         % Reset initial point for each method
%         x = Xk;
%         y = Yk;
%         iter = 0;
        
%         while true
%             % Compute gradient
%             grad = grad_f(x, y);
%             grad_norm = norm(grad);
            
%             % Check convergence
%             if grad_norm < tolerance || iter >= max_iters
%                 break;
%             end
            
%             % Determine step size
%             if method == 1
%                 % Case 1: Constant gamma
%                 gamma = gamma_constant;
%             elseif method == 2
%                 % Case 2: Minimize f(x_k + gamma_k * d_k)
%                 gamma_fun = @(g) f(x - g * grad(1), y - g * grad(2));
%                 gamma = fminbnd(gamma_fun, 0, 1); % Minimize in range [0,1]
%             elseif method == 3
%                 % Case 3: Armijo's rule
%                 beta = 0.5; sigma = 0.1;
%                 gamma = 1;
%                 while f(x - gamma * grad(1), y - gamma * grad(2)) > ...
%                         f(x, y) - sigma * gamma * grad_norm^2
%                     gamma = beta * gamma; % Reduce gamma
%                 end
%             end
            
%             % Update variables
%             x = x - gamma * grad(1);
%             y = y - gamma * grad(2);
%             iter = iter + 1;
            
%             % Display progress
%             fprintf('%d\t%.4f\t%.4f\t%.6f\n', iter, x, y, f(x, y));
%         end
        
%         % Display result
%         fprintf('Method %d: Minimum found at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n\n', ...
%             method, x, y, f(x, y), iter);
%     end
% end

% % % Μέγιστη Κάθοδος για ελαχιστοποίηση f(x, y) = x^5 * exp(-x^2 - y^2)

% % clc; clear;

% % % Ορισμός της συνάρτησης και των παραγώγων
% % f = @(x, y) x.^5 .* exp(-x.^2 - y.^2);
% % grad_f = @(x, y) [
% %     (5 * x.^4 - 2 * x.^6) .* exp(-x.^2 - y.^2);  % ∂f/∂x
% %     -2 * y .* x.^5 .* exp(-x.^2 - y.^2)          % ∂f/∂y
% % ];

% % % Αρχικά σημεία
% % initial_points = [0, 0; -1, 1; 1, -1];

% % % Παράμετροι
% % tolerance = 1e-6; % Όριο σύγκλισης
% % max_iters = 1000; % Μέγιστες επαναλήψεις
% % gamma_constant = 0.1; % Σταθερό βήμα
% % beta = 0.5; sigma = 0.1; % Παράμετροι Armijo

% % % Επανάληψη για κάθε αρχικό σημείο
% % for idx = 1:size(initial_points, 1)
% %     % Αρχικοποίηση
% %     Xk = initial_points(idx, 1);
% %     Yk = initial_points(idx, 2);
    
% %     fprintf('Αρχικό σημείο: (%.2f, %.2f)\n', Xk, Yk);
% %     fprintf('Iter\tX_const\t\tY_const\t\tf_const\t\tX_opt\t\tY_opt\t\tf_opt\t\tX_armijo\tY_armijo\tf_armijo\n');
    
% %     % Επαναρχικοποίηση για όλες τις στρατηγικές
% %     x_const = Xk; y_const = Yk;
% %     x_opt = Xk; y_opt = Yk;
% %     x_armijo = Xk; y_armijo = Yk;
% %     iter = 0;

% %     while true
% %         % Υπολογισμός κλίσεων
% %         grad_const = grad_f(x_const, y_const);
% %         grad_opt = grad_f(x_opt, y_opt);
% %         grad_armijo = grad_f(x_armijo, y_armijo);

% %         % Έλεγχος σύγκλισης
% %         norm_const = norm(grad_const);
% %         norm_opt = norm(grad_opt);
% %         norm_armijo = norm(grad_armijo);

% %         if max([norm_const, norm_opt, norm_armijo]) < tolerance || iter >= max_iters
% %             break;
% %         end

% %         % Υπολογισμός βημάτων
% %         % 1. Σταθερό
% %         gamma_const = gamma_constant;
% %         x_const = x_const - gamma_const * grad_const(1);
% %         y_const = y_const - gamma_const * grad_const(2);
% %         f_const = f(x_const, y_const);

% %         % 2. Βέλτιστο
% %         gamma_fun = @(g) f(x_opt - g * grad_opt(1), y_opt - g * grad_opt(2));
% %         gamma_opt = fminbnd(gamma_fun, 0, 1); % Ελαχιστοποίηση f
% %         x_opt = x_opt - gamma_opt * grad_opt(1);
% %         y_opt = y_opt - gamma_opt * grad_opt(2);
% %         f_opt = f(x_opt, y_opt);

% %         % 3. Armijo
% %         gamma_armijo = 1;
% %         while f(x_armijo - gamma_armijo * grad_armijo(1), y_armijo - gamma_armijo * grad_armijo(2)) > ...
% %                 f(x_armijo, y_armijo) - sigma * gamma_armijo * norm(grad_armijo)^2
% %             gamma_armijo = beta * gamma_armijo;
% %         end
% %         x_armijo = x_armijo - gamma_armijo * grad_armijo(1);
% %         y_armijo = y_armijo - gamma_armijo * grad_armijo(2);
% %         f_armijo = f(x_armijo, y_armijo);

% %         % Ενημέρωση μετρητή
% %         iter = iter + 1;

% %         % Εμφάνιση αποτελεσμάτων
% %         fprintf('%d\t%.4f\t%.4f\t%.6f\t%.4f\t%.4f\t%.6f\t%.4f\t%.4f\t%.6f\n', ...
% %             iter, x_const, y_const, f_const, x_opt, y_opt, f_opt, x_armijo, y_armijo, f_armijo);
% %     end

% %     % Τελικά αποτελέσματα
% %     fprintf('Αποτελέσματα για αρχικό σημείο (%.2f, %.2f):\n', Xk, Yk);
% %     fprintf('Σταθερό: Ελάχιστο στο (%.4f, %.4f) με f = %.6f\n', x_const, y_const, f(x_const, y_const));
% %     fprintf('Βέλτιστο: Ελάχιστο στο (%.4f, %.4f) με f = %.6f\n', x_opt, y_opt, f(x_opt, y_opt));
% %     fprintf('Armijo:  Ελάχιστο στο (%.4f, %.4f) με f = %.6f\n\n', x_armijo, y_armijo, f(x_armijo, y_armijo));
% % end

% % % % Steepest Descent Algorithm for minimizing f(X, Y)
% % % % f(X,Y) = X^5 * exp(-X^2 - Y^2)

% % % clc; clear;

% % % % Define the function and its gradient
% % % f = @(X, Y) X.^5 .* exp(-X.^2 - Y.^2);
% % % grad_f = @(X, Y) [
% % %     (5 * X.^4 - 2 * X.^6) .* exp(-X.^2 - Y.^2);   % Partial derivative w.r.t. X
% % %     -2 * Y .* X.^5 .* exp(-X.^2 - Y.^2)           % Partial derivative w.r.t. Y
% % % ];

% % % % Initial points
% % % initial_points = [0, 0; -1, 1; 1, -1];

% % % % Parameters
% % % tolerance = 1e-6; % Convergence tolerance
% % % max_iters = 1000; % Maximum number of iterations
% % % gamma_constant = 0.1; % Constant step size for case 1

% % % % Iterate over each initial point
% % % for idx = 1:size(initial_points, 1)
% % %     % Starting point
% % %     Xk = initial_points(idx, 1);
% % %     Yk = initial_points(idx, 2);
    
% % %     fprintf('Starting point (%.2f, %.2f):\n', Xk, Yk);
% % %     fprintf('Iter\tX\t\tY\t\tf(X, Y)\n');
    
% % %     for method = 1:3
% % %         % Reset initial point for each method
% % %         x = Xk;
% % %         y = Yk;
% % %         iter = 0;
        
% % %         while true
% % %             % Compute gradient
% % %             grad = grad_f(x, y);
% % %             grad_norm = norm(grad);
            
% % %             % Check convergence
% % %             if grad_norm < tolerance || iter >= max_iters
% % %                 break;
% % %             end
            
% % %             % Determine step size
% % %             if method == 1
% % %                 % Case 1: Constant gamma
% % %                 gamma = gamma_constant;
% % %             elseif method == 2
% % %                 % Case 2: Minimize f(x_k + gamma_k * d_k)
% % %                 gamma_fun = @(g) f(x - g * grad(1), y - g * grad(2));
% % %                 gamma = fminbnd(gamma_fun, 0, 1); % Minimize in range [0,1]
% % %             elseif method == 3
% % %                 % Case 3: Armijo's rule
% % %                 beta = 0.5; sigma = 0.1;
% % %                 gamma = 1;
% % %                 while f(x - gamma * grad(1), y - gamma * grad(2)) > ...
% % %                         f(x, y) - sigma * gamma * grad_norm^2
% % %                     gamma = beta * gamma; % Reduce gamma
% % %                 end
% % %             end
            
% % %             % Update variables
% % %             x = x - gamma * grad(1);
% % %             y = y - gamma * grad(2);
% % %             iter = iter + 1;
            
% % %             % Display progress
% % %             fprintf('%d\t%.4f\t%.4f\t%.6f\n', iter, x, y, f(x, y));
% % %         end
        
% % %         % Display result
% % %         fprintf('Method %d: Minimum found at (%.4f, %.4f) with f(X, Y) = %.6f after %d iterations.\n\n', ...
% % %             method, x, y, f(x, y), iter);
% % %     end
% % % end
