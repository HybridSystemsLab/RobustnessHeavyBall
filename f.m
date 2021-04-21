function xdot = f(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: f.m
%--------------------------------------------------------------------------
% Project: Simulation of the Heavy Ball method for finding the nearest
% non-unique minimum. This is non-hybrid, for now.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
   
% The global variables
global lambda gamma sigmaHBF constHBF noiseHBF HBFIndex C_0

% state
z1 = x(1);
z2 = x(2);
q = x(3);
a = x(4);
tau = x(5);

hbfNoise = sigmaHBF*randn(1,1);

y = [z2 GradientL(z1)];

if (q == 0)
    u = - lambda*(y(1)) - gamma*(y(2) - ((tau*(log(tau))^2)/C_0)*constHBF*(y(2) + sign(y(2))*hbfNoise));
elseif (q == 1)
    u = a;
end

noiseHBF(HBFIndex) = ((tau*(log(tau))^2)/C_0)*constHBF*(y(2) + sign(y(2))*hbfNoise);
HBFIndex = HBFIndex + 1;

xdot = [z2;u;0;0;1];

end