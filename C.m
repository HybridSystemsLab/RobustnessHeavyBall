function [value] = C(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: C.m
%--------------------------------------------------------------------------
% Description: Flow set
% Return 0 if outside of C, and 1 if inside C
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

global eps1 eps2 rho1 rho2

% state
z1 = x(1);
z2 = x(2);
q = x(3);

y2 = GradientL(z1);

if ~(abs(y2) < eps1 && q == 0 && abs(z2) < rho1) && ~(abs(y2) > eps2 && q == 1 && abs(z2) > rho2)
    value = 1;
else 
    value = 0;
end

end