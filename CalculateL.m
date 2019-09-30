function L = CalculateL(z1)
global z1Star1 z1Star2 
% z1Star3 z1Star4 
% z1Star5 z1Star6

z1Star1 = 2.75;
z1Star2 = 3.25;

z1Star1 = 0;
z1Star2 = 10;
z1Star3 = 20;
z1Star4 = 30;
% z1Star5 = 3.5;
% z1Star6 = 5.5;

L = 0.0001*(z1-z1Star1)^2*(z1-z1Star2)^2*(z1-z1Star3)^2*(z1-z1Star4)^2;

% L = (z1-z1Star1)^2*(z1-z1Star2)^2*(z1-z1Star3)^2*(z1-z1Star4)^2;

% L = 3*sin(pi*z1);

% L = (z1 - z1Star1)^2 * (z1 - z1Star2)^2;
end