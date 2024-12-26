
function genetic()
    % Parameters based on the problem
    % Edge-specific times t_i (from the graph)
    t = [];

    % Maximum traffic density c_i (arbitrary, adjust based on real data)
    c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, ...
         47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73];

    % Constants a_i (grouped as per the problem)
    a = [1.25 * ones(1, 5), 1.5 * ones(1, 5), 1.75 * ones(1, 7)];

    % Genetic Algorithm parameters
    nEdges = length(t); % Number of edges in the graph
    populationSize = 50;
    maxGenerations = 100;
    mutationRate = 0.1;

    % Fitness function (minimizing total traversal time)
    fitnessFunction = @(x) compute_total_time(x, t, a, c);

    % Bounds for traffic densities (x_i)
    lb = zeros(1, nEdges); % Lower bound (0 traffic)
    ub = c;               % Upper bound (max traffic)

    % Genetic Algorithm options
    options = optimoptions('ga', ...
        'PopulationSize', populationSize, ...
        'MaxGenerations', maxGenerations, ...
        'MutationFcn', {@mutationuniform, mutationRate}, ...
        'Display', 'iter');

    % Run Genetic Algorithm
    [optimalX, optimalT] = ga(fitnessFunction, nEdges, [], [], [], [], lb, ub, [], options);

    % Display results
    disp('Optimal Traffic Densities (x_i):');
    disp(optimalX);
    disp('Minimum Total Traversal Time (T):');
    disp(optimalT);
end

% Compute total traversal time T based on the traffic formula
function T = compute_total_time(x, t, a, c)
    % Parameters
    % a_i: constant 
    % a_i = 1.25 for i belongs (1,...,5) 
    % a_i = 1.5 for i belongs (6,...,10)
    % a_i = 1.75 for i belongs (11,...,17)
    % t_i: time it takes to travel when there is no traffic
    % x_i: traffic density [vehicles/minute]
    % c_i: maximum traffic density [vehicles/minute]
    T = sum(t + a .* (x ./ (1 - (x ./ c))));
end
% V_i: incoming traffic density at the start of the graph