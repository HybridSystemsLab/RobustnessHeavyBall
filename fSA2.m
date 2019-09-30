function xdot = fSA2(x)
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
global C_0 sigma sigma2 

const = 0.0000000000003;

% state
z1 = x(1);

tau = x(3);

% Black box: H could be anything. 
y1 = GradientL(z1);

saNoise = sigma*randn(1,1);

saNoise2 = sigma2*randn(1,1);

m = (-((tau*(log(tau))^2)/C_0)*(y1 + sign(y1)*saNoise)) + const;

u = - y1 - (C_0/(tau*(log(tau))^2))*m;

xdot = [u;y1;1]; 
end