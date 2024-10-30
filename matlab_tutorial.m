% Optimization Techniques - Demo

%% Basics
clearvars; % clear workspace
clc; % clear command window
close all;

save mydata.mat
load mydata.mat

%% Arrays
a = [1 2 3 4]; % vector (or 1D matrix)
a = [1; 2; 3; 4]; % or [1 2 3 4]'
a = 1:100;
a = 1:2:10;
a = 10:-2:1;
a = linspace(1, 20, 7); % specified number of points 
a = linspace(1, 20, 7)';

% custom data
b = zeros(1,3);
for i = 2:3
    b(1,i) = 2*i + 1;
    disp("hello");
end

% ones, zeros, rand
a = [1 2; 3 4];
a = ones(4,6);
a = zeros(4,6);
%% test
a = 4*rand(4,6);
hy = rand(1,1);
c = rand(1,1);

eye(3);
eye(3,4);
%% end
% call of array elements
a(1,2)
a(1,[1 2])
a(1,[1 3])
a(1,1:3)
a(a < 0.6)
a < 1.2
%% test1
for i = 1:3 % rows 
    for j = 1:2 % columns
        c(i,j) = 2*i + 1;
    end
end
%% end1
% operations between matrices 
k*vector
k*Array
A + B
A*B % with proper dimension A*B'
A.*B % pointwise a(1,1) * b(1,1) = c(1,1)
A^2 % A*A
A.^2

% composition of matrices
C = [A B];
C = [A; B];

% size, length
vector = [1 2 3 4];
size(vector)
size(A) % size(A,1) size(A,2)
length(vector)

% Eigenvalues -> the solution of det(lambda*I - A) = 0
A = [7 3; 3 -1];
eig(A)

% inverse matrix
inv(A)

% linsolve (AX = B)
A = [1 2 3; 2 0 0; 0 1 1];
b = [5 1 3]';
linsolve(A,b)

%% Functions
% Symbolic functions - continuous functions
syms x y z
f1(x) = sin(x^2);
f2(x,y) = x + y^2;

% Derivative
diff(f1(x),x)

% Gradient
jacobian(f1(x),x) % or gradient(f1(x))
jacobian(f2(x,y),[x,y])'

% Gradient Matrix (vector functions)
f3(x,y,z) = [x*y*z; y; x+z];
jacobian(f3(x,y,z),[x y z])'

% Hessian 
hessian(f1(x),x)
jacobian(gradient(f1(x)))

hessian(f2(x,y),[x,y])

% call of symbolic functions
f1(0) % subs(f1,x,0)
f2(1,2) % subs(f2,{x,y},{1,2})
f3(1,2,3) % subs(f3,{x,y,z},{1,2,3})

%% inline/anonymous function (why inline/anonymous? because this way we 
% don't need a separate .m file for such simple expressions)
in_f = inline('x^2 - 3*x + 2','x');
result = in_f(1);
diff(in_f,x) % disadvantage !

% another way for inline functions
ft = @(t) sin(t);

%% solve
% f1(x) = sin(x^2);
% f2(x,y) = x + y^2;
solve(f1(x) == 0, x)

solve(f2(x,y) == 0, x)
solve(f2(x,y) == 0, y)

%% Plotting
ft = @(t) sin(t);
gt = @(t) cos(2*t);
time = linspace(0,10,100);
%% edn
figure;
plot(time, ft(time), 'LineStyle', '--', 'LineWidth', 2.5);
hold on
plot(time, gt(time), 'LineStyle', '-.', 'LineWidth', 2.5);
ylabel('f,g','FontSize',22);
xlabel('t','FontSize',22);
title('Figures','FontSize',22);
legu1 = legend('f(t)','g(t)');
set(legu1,'FontSize',22);
% axis([0 8 -0.8  0.8]);
grid on

%% constraint optimization - visualization
% one argument
% in this case use https://www.desmos.com/calculator as well
fx = @(x) (x+1).^2;
% gx1 = @(x) - x < 0;
% gx2 = @(x) x - 5 < 0;
arg1 = linspace(-5,5,500);

[x, y] = meshgrid(-5:0.1:5, 0:0.1:fx(5));
mask = - x < 0 & x - 5 < 0;

figure;
scatter(x(mask), y(mask),'g');
hold on
plot(arg1, fx(arg1), 'LineWidth', 2.5,'MarkerEdgeColor','k');
legu1 = legend('g1(x) U g2(x)','f(x)');
set(legu1,'FontSize',22);
xlabel('x','FontSize',22);
ylabel('y','FontSize',22);
grid on

% two arguments
syms x y

f = (x-1)^2 + x*y;
g1 = x^2 - 5;
g2 = x + y - 2;

figure;
fsurf(f,[0 5 -5 5],'g')
zlim([-15 0])
hold on
fsurf(g1,[0 5 -5 5],'r')
zlim([-15 0])
hold on
fsurf(g2,[0 5 -5 5],'b')
zlim([-15 0])
hold on
legu1 = legend('f(x)','g1(x)','g2(x)');
set(legu1,'FontSize',22);
xlabel('x','FontSize',22);
ylabel('y','FontSize',22);
zlabel('z','FontSize',22);

% isobar curves
f = @(x,y) x.^2 + y.^2;
x = -10:0.2:10;
y = -10:0.2:10;
[X,Y] = meshgrid(x,y);
Z = f(X,Y);

figure;
fsurf(f,[-10 10 -10 10],'w');
hold on
[M,c] = contour3(X,Y,Z,10,'ShowText','on');
c.LineWidth = 3;
xlabel('x','FontSize',22);
ylabel('y','FontSize',22);
zlabel('z','FontSize',22);

%% Function 
function y = auxiliaryfunc(a,b)
    y = a + b;
end
auxiliaryfunc(1,2)