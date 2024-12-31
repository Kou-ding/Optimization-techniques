%% Genetic Algorithm for Traffic Optimization
function genetic()
    % Number of edges (variables)
    n = 17;

    % Constant edge-specific traversal times t_i
    % t = []; % Not needed to minimize total traversal time

    % Maximum traffic density c_i [vehicles/minute]
    c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, ...
         47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73];

    % Road constants a_i
    a = [1.25 * ones(1, 5), 1.5 * ones(1, 5), 1.75 * ones(1, 7)];

    % V_i=100: incoming traffic density at the start of the graph
    % Graph-based equations 
    Aeq = [
        1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % x[1]+x[2]+x[3]+x[4]=100
        1, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % x[1]=x[5]+x[6]
        0, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0; % x[2]=x[7]+x[8]
        0, 0, 1, 0, 0, 0, 0, -1, -1, 0, 1, 1, 0, 0, 0, 0, 0; % x[3]+x[8]+x[9]=x[11]+x[12]
        0, 0, 0, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0; % x[4]=x[9]+x[10]
        0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0; % x[6]+x[7]+x[13]=x[14]+x[15]
        0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0; % x[5]+x[14]=x[16]
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, -1; % x[10]+x[11]=x[17]
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1; % x[12]+x[15]+x[16]+x[17]=100
    ];
    beq = [100, 0, 0, 0, 0, 0, 0, 0, 100]; % Incoming traffic=outgoing traffic

    % Fitness function (minimizing total traversal time)
    % Parameters
    % -----------
    % a_i: constant 
    % a_i = 1.25 for i belongs (1,...,5) 
    % a_i = 1.5 for i belongs (6,...,10)
    % a_i = 1.75 for i belongs (11,...,17)
    % t_i: time it takes to travel when there is no traffic
    % x_i: traffic density [vehicles/minute]
    % c_i: maximum traffic density [vehicles/minute]
    epsilon = 1e-6; % Small value to prevent division by zero
    fitnessFunction = @(x) sum(a .* (x ./ (1 - (x ./ c) + epsilon)));

    % Bounds for traffic densities (x_i)
    lb = zeros(1, n); % Lower bounds: x >= 0
    ub = c;           % Upper bounds: x <= c

    % Solve using Genetic Algorithm
    options = optimoptions('ga', ...
        'CreationFcn', @gacreationlinearfeasible, ...
        'CrossoverFcn', @crossoverintermediate, ...
        'SelectionFcn', @selectionstochunif, ...
        'MutationFcn', @mutationadaptfeasible, ...
        'Display', 'iter', ...
        'MaxGenerations', 1000, ...
        'PopulationSize', 100, ...
        'PlotFcn', @gaplotbestf);

    % Run Genetic Algorithm
    % [x, fval] = ga(fitnessfcn, nvars, A, b, Aeq, beq, lb, ub, nonlcon, options)
    % fitnessfcn: The fitness function to minimize (fitnessFunction in this case).
    % nvars: The number of variables (17 traffic flow variables).
    % A, b: Linear inequality constraints (not used here, so passed as empty []).
    % Aeq, beq: Linear equality constraints (traffic flow conservation equations).
    % lb, ub: Lower and upper bounds for variables.
    % nonlcon: Nonlinear constraints (not used here, so passed as empty []).
    % options: The options object created earlier, which configures how the genetic algorithm runs.
    [optimal_X, optimal_T] = ga(fitnessFunction, n, [], [], Aeq, beq, lb, ub, [], options);

    % Display results
    disp('Optimal Traffic Densities (x_i):');
    disp(optimal_X);
    fprintf('Minimum Total Traversal Time (T): %.4f\n', optimal_T);
    %disp(optimal_T);
end