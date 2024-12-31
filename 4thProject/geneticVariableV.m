function geneticVariableV()
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
        % Check if solution satisfies flow constraints
        flows = Aeq * x';
        if any(flows < beq_min' - 1e-6) || any(flows > beq_max' + 1e-6)
            f = Inf;
            return;
        end
        
        % Check capacity constraints
        ratios = x ./ c;
        if any(ratios >= 0.95) || any(x < 0)
            f = Inf;
            return;
        end
        
        % Compute actual fitness
        epsilon = 1e-6;
        f = sum(a .* (x ./ (1 - ratios)+epsilon));
    end

    % Bounds for traffic densities (x_i)
    lb = zeros(1, n); % Lower bounds: x >= 0
    ub = c;            % Upper bounds: x <= c
    
    % GA options
    options = optimoptions('ga', ...
        'CreationFcn', @gacreationlinearfeasible, ...
        'CrossoverFcn', @crossoverintermediate, ...
        'SelectionFcn', @selectionstochunif, ...
        'MutationFcn', @mutationadaptfeasible, ...
        'Display', 'iter', ...
        'MaxGenerations', 1000, ...
        'PopulationSize', 100, ...
        'FunctionTolerance', 1e-6, ...
        'ConstraintTolerance', 1e-6,  ...
        'PlotFcn', @gaplotbestf);
    
    % Run optimization for average case (nominal value)
    % beq = [V_min, 0, 0, 0, 0, 0, 0, 0, V_min];
    % [optimal_X, optimal_T] = ga(@validateAndComputeFitness, n, [], [], Aeq, beq, lb, ub, [], options);
    
    % % Display results
    % disp('Optimal Traffic Densities (x_i) for nominal case:');
    % disp(optimal_X);
    % fprintf('Minimum Total Traversal Time (T) for nominal case: %.4f\n', optimal_T);
    
    % Run optimization for worst case (maximum input)
    beq = [V, 0, 0, 0, 0, 0, 0, 0, V];
    [worst_X, worst_T] = ga(@validateAndComputeFitness, n, [], [], Aeq, beq, lb, ub, [], options);
    
    disp('Optimal Traffic Densities (x_i) for maximum input case:');
    disp(worst_X);
    fprintf('Minimum Total Traversal Time (T) for maximum input case: %.4f\n', worst_T);
end