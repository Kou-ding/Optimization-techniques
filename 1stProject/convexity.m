% Load symbolic package
syms x

% Define the functions
f1 = (x - 2)^2 + x * log(x + 3);
f2 = exp(-2 * x) + (x - 2)^2;
f3 = exp(x) * (x^3 - 1) + (x - 1) * sin(x);

% Compute the second derivatives
f1_second_derivative = diff(f1, x, 2);
f2_second_derivative = diff(f2, x, 2);

f3_first_derivative = diff(f3, x);
f3_second_derivative = diff(f3, x, 2);

% Display the results
disp('Second derivative of f1(x):');
disp(f1_second_derivative);

disp('Second derivative of f2(x):');
disp(f2_second_derivative);

disp('First derivative of f3(x):');
disp(f3_first_derivative);

disp('Second derivative of f3(x):');
disp(f3_second_derivative);
