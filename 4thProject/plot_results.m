function plot_results()
    % Number of edges (variables)
    n = 17;
    V = 100;  % Nominal incoming traffic
    V_min = V * 0.85;  % -15% of nominal
    V_max = V * 1.15;  % +15% of nominal
    
    % Maximum traffic density c_i [vehicles/minute]
    c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, ...
         47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73];
    
    % Road constants a_i
    a = [1.25 * ones(1, 5), 1.5 * ones(1, 5), 1.75 * ones(1, 7)];
    
    % Graph-based equations matrix
    Aeq = [
        1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % Input flow constraint
        1, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 1, 0, 0, 0, 0, -1, -1, 0, 1, 1, 0, 0, 0, 0, 0;
        0, 0, 0, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0;
        0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, -1;
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1  % Output flow constraint
    ];
    
    % Define variable bounds for input/output constraints
    beq_min = [V_min, 0, 0, 0, 0, 0, 0, 0, V_min];  % Min flow constraints
    beq_max = [V_max, 0, 0, 0, 0, 0, 0, 0, V_max];  % Max flow constraints

    % Modified fitness function with validation
    function f = validateAndComputeFitness(x)
        % Check capacity constraints
        ratios = x ./ c;
        if any(ratios >= 0.99) || any(x < 0)
            f = Inf;
            return;
        end
        
        % Compute actual fitness
        epsilon = 1e-6;
        f = sum(a .* (x ./ (1 - ratios) + epsilon));
    end

    % Bounds for traffic densities (x_i)
    lb = zeros(1, n);   % Lower bounds: x >= 0
    ub = c;             % Upper bounds: x <= c
    
    % GA options
    options = optimoptions('ga', ...
        'CreationFcn', @gacreationlinearfeasible, ...
        'CrossoverFcn', @crossoverintermediate, ...
        'SelectionFcn', @selectionstochunif, ...
        'MutationFcn', @mutationadaptfeasible, ...
        'Display', 'iter', ...
        'MaxGenerations', 1000, ...
        'PopulationSize', 100, ...
        'PlotFcn', @gaplotbestf);
    
    % Initialize best solution variables
    best_X = [];
    best_T = Inf;

    % Define a range of beq values between beq_min and beq_max
    beq_values = linspace(beq_min(1), beq_max(1), 10); % Adjust the number of steps as needed

    % Initialize matrix to store optimal x and T values
    results_matrix = zeros(18, length(beq_values));

    % Run optimization for each beq value
    for i = 1:length(beq_values)
        beq = [beq_values(i), 0, 0, 0, 0, 0, 0, 0, beq_values(i)];
        [optimal_X, optimal_T] = ga(@validateAndComputeFitness, n, [], [], Aeq, beq, lb, ub, [], options);
        
        % Update best solution if current solution is better
        if optimal_T < best_T
            best_X = optimal_X;
            best_T = optimal_T;
        end
        
        % Save the optimal x and T values in the matrix
        results_matrix(1:n, i) = optimal_X;
        results_matrix(18, i) = optimal_T;
    end
    
    % Plot the results
    figure;
    hold on; % Hold on to overlay plots
    for i = 1:length(beq_values)
        plot(1:n, results_matrix(1:n, i), 'DisplayName', sprintf('V = %.2f', beq_values(i)));
    end
    
    % Add legend and labels
    legend show;
    xlabel('Variable Index');
    ylabel('Traffic Density');
    title('Optimal Traffic Densities for Different V Values');
    
    % Plot the results for optimal T values
    figure;
    plot(beq_values, results_matrix(18, :), '-o');
    xlabel('V Value');
    ylabel('Optimal Total Traversal Time (T)');
    title('Optimal Total Traversal Time for Different V Values');

    % Display best results
    disp('Optimal Traffic Densities (x_i) for best input case:');
    disp(best_X);
    fprintf('Minimum Total Traversal Time (T) for best input case: %.4f\n', best_T);
end