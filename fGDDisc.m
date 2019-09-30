function xdot = fGDDisc(x)
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

global sigmaGDDisc epsGD constGDDisc noiseGDDisc GDDIndex

% state
z1 = x(1);

% Black box: H could be anything. 
y1 = GradientL(z1);

gdDiscNoise = sigmaGDDisc*randn(1,1);

if (y1 == 0)
    u = -y1 + epsGD + constGDDisc*(y1 + sign(y1)*gdDiscNoise);
else
    u = -y1 + constGDDisc*(y1 + sign(y1)*gdDiscNoise);
end  

noiseGDDisc(GDDIndex) = constGDDisc*(y1 + sign(y1)*gdDiscNoise);
GDDIndex = GDDIndex + 1;

xdot = [u];
end