function GradL = GradientL(z1)
global z1Star1 z1Star2 z1Star3 z1Star4 
% z1Star5 z1Star6

% z1Star1 = 2.75;
% z1Star2 = 3.25;

z1Star1 = 0;
z1Star2 = 10;
z1Star3 = 20;
z1Star4 = 30;
% z1Star5 = 3.5;
% z1Star6 = 5.5;

% z1Star1 = 0;
% z1Star2 = 10;
% z1Star3 = 20;
% z1Star4 = 30;

GradL = 0.0001*(2*z1 - 2*z1Star1)*(z1 - z1Star2)^2*(z1 - z1Star3)^2*(z1 - z1Star4)^2 + 0.0001*(2*z1 - 2*z1Star2)*(z1 - z1Star1)^2*(z1 - z1Star3)^2*(z1 - z1Star4)^2 + 0.0001*(2*z1 - 2*z1Star3)*(z1 - z1Star1)^2*(z1 - z1Star2)^2*(z1 - z1Star4)^2 + 0.0001*(2*z1 - 2*z1Star4)*(z1 - z1Star1)^2*(z1 - z1Star2)^2*(z1 - z1Star3)^2;

% GradL = 3*pi*cos(pi*z1);

% GradL = (2*z1 - 2*z1Star1)*(z1 - z1Star2)^2 + (2*z1 - 2*z1Star2)*(z1 - z1Star1)^2;
end