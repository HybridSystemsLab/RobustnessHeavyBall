function inside = D(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: D.m
%--------------------------------------------------------------------------
% Description: Jump set
% Return 0 if outside of D, and 1 if inside D
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

global eps1 eps2 rho1 rho2 C_0 constHBF sigmaHBF

% state
z1 = x(1);
z2 = x(2);
q = x(3);
tau = x(5);

hbfNoise = sigmaHBF*randn(1,1);

y2 = GradientL(z1);
GradLNoise = y2 - ((tau*(log(tau))^2)/C_0)*constHBF*(y2 + sign(y2)*hbfNoise);

if (abs(GradLNoise) <= eps1 && q == 0 && abs(z2) <= rho1) || (abs(GradLNoise) >= eps2 && q == 1 && abs(z2) >= rho2)
    inside = 1;
else
    inside = 0;
end

end