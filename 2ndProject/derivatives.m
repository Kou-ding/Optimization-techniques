function [dZdx, dZdy, d2Zdx2, d2Zdy2] = derivative()
    % Declare symbolic variables
    syms X Y

    % Define the function Z
    Z = X^5 * exp(-X^2 - Y^2);
    
    % First partial derivatives
    dZdx = diff(Z, X);
    dZdy = diff(Z, Y);
    
    % Second partial derivatives
    d2Zdx2 = diff(dZdx, X);
    d2Zdy2 = diff(dZdy, Y);
end

% Call the function to compute derivatives
[dZdx, dZdy, d2Zdx2, d2Zdy2] = derivative();

% Display results using symbolic output functions
disp('First partial derivatives:');
disp(['dZ/dX = ', char(dZdx)]);
disp(['dZ/dY = ', char(dZdy)]);

disp('Second partial derivatives:');
disp(['d^2Z/dX^2 = ', char(d2Zdx2)]);
disp(['d^2Z/dY^2 = ', char(d2Zdy2)]);
