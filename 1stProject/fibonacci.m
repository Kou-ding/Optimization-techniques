% Define f1(x)
f1 = @(x) (x - 2)^2 + x * log(x + 3);
% Define f2(x)
f2 = @(x) exp(-2 * x) + (x - 2)^2;
% Define f3(x)
f3 = @(x) exp(x) * (x^3 - 1) + (x - 1) * sin(x);

function y = fibonacciFunc(f,l)
    % Initialize the interval and tolerance parameters
    a = -1;
    b = 3;
    l = 0.01;  % Desired accuracy
    k=1; % Counter for the number of iterations

    x1 = a + (F(n-2)/F(n))*(b - a);
    x2 = a + (F(n-1)/F(n))*(b - a);

    % Iterative search
    while (F(n)>(b-a)/l)>0
        % Evaluate function at points c and d
        f_x1 = f(x1);
        f_x2 = f(x2);
        
        % Update the interval [a, b]
        if f_x1 > f_x2
            a = x1;
            x1 = x2;
            x2 = a + (F(n-k-1)/F(n-k))*(b - a);
            if k == n-2
                x2 = x1 + epsilon;
                if f(x1) > f(x2)
                    a = x1;
                else
                    b = x2;
                end
            end
        else
            b = x2;
            x2 = x1;
            x1 = a + (F(n-k-2)/F(n-k))*(b - a);
            if k == n-2
                x2 = x1 + epsilon;
                if f(x1) > f(x2)
                    a = x1;
                else
                    b = x2;
                end
            end
        end
        k = k + 1;
    end

    % Calculate the approximate minimum
    minimum_x = (a + b) / 2;
    minimum_f = f(minimum_x);

    % Display results
    fprintf('Approximate minimum value: %.5f at x = %.5f\n', minimum_f, minimum_x);
    fprintf('Interval [a, b]: [%.5f, %.5f]\n', a, b);
end