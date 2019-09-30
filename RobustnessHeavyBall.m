%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: HeavyBall.m
%--------------------------------------------------------------------------
% Project: Testing out parameters lambda and gamma for fast, oscillatory
% convergence globally and slow, smooth convergence locally.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

clear all

set(0,'defaultTextInterpreter','latex');

% global variables
global C_0 gamma lambda eps1 eps2 rho1 rho2 sigma sigmaGD constGD sigmaGDDisc epsGD sigmaHBF constHBF constGDDisc constGD2 noiseCoeff noiseHBF noiseSA noiseGD noiseGDDisc GDIndex GDDIndex HBFIndex SAIndex cMax aConst
%%%%%%%%%%%%%%%%%%%%%
% setting the globals
%%%%%%%%%%%%%%%%%%%%%
% Heavy-ball constants: 
lambda = 120; % Gravity. 
            % For gamma fixed, "large values of  lambda are seen to give rise to slowly converging 
            % solutions resembling the steepest descent’s while smaller values give 
            % rise to fast solutions with oscillations getting wilder as lambda decreases."
gamma = 3/4; % Viscous friction to mass ratio.

% These will need to be tuned:
eps1 = 0.01; % 0.001
eps2 = 10; % 0.002 3.15

rho1 = 0.01; % 0.001
rho2 = 10; % 0.002 3.15

aConst = 10000000;

noiseCoeff = 0.00000000001; % Was 0.08 % was 0.00000000001
const = 1;
initCond = 15.00000000001;

sigmaHBF = noiseCoeff;
constHBF = const;
noiseHBF = [];
HBFIndex = 1;

% For the SA temperature. Adjust this as needed, but C_0 needs to be "large enough"  
C_0 = 100000000000; %  100000000000

% Standard deviation for Gaussian noise in SA
sigma = noiseCoeff; 
noiseSA = [];
SAIndex = 1;

% Standard deviation for Gaussian noise in Smooth GD
sigmaGD = noiseCoeff;
constGD = const;
constGD2 = 0.5;
noiseGD = [];
GDIndex = 1;

% Standard deviation for Gaussian noise in Discontinuous GD
sigmaGDDisc = noiseCoeff;
epsGD = 0.0001;
constGDDisc = const;
noiseGDDisc = [];
GDDIndex = 1;

%%%%%%%%%%%%%%%%%%%%%%
% setting the locals %
%%%%%%%%%%%%%%%%%%%%%%
% jumpsx1_H = zeros(1,1);
% jumpsL1_H = [];
% jumpst_H = [];
% jumpIndex_H = 1;

% initial conditions: Smooth Gradient Descent 
z1_0 = initCond;

x01 = [z1_0];

gdNoise = sigmaGD*randn(1,1);
noiseGD(GDIndex) = constGD*(GradientL(z1_0) + sign(GradientL(z1_0))*gdNoise);
GDIndex = GDIndex + 1;

% initial conditions: Discontinuous Gradient Descent
z1_0 = initCond;

x02 = [z1_0];

gdDiscNoise = sigmaGDDisc*randn(1,1);
noiseGDDisc(GDDIndex) = constGDDisc*(GradientL(z1_0) + sign(GradientL(z1_0))*gdDiscNoise);
GDDIndex = GDDIndex + 1;

% initial conditions: SA
z1_0 = initCond; 
GLz1_0 = GradientL(z1_0); %This is just for debugging, so I can see what the gradient values are.
tau_0 = 1.01;

cMax = ((tau_0*(log(tau_0))^2)/C_0);

% Assign initial conditions to vector for SA
x0 = [z1_0;GLz1_0;tau_0];

saNoise = sigma*randn(1,1);
noiseSA(SAIndex) = (C_0/(tau_0*(log(tau_0))^2))*(((tau_0*(log(tau_0))^2)/C_0)*(GradientL(z1_0) + sign(GradientL(z1_0))*saNoise));
SAIndex = SAIndex + 1;

% initial conditions: hybrid heavy ball
z1_00 = initCond; 
z2_00 = 0;
p_00 = 0;
a_00 = 0; 
while a_00 == 0
    a_00 = aConst*randi([-1,1]); 
end

% Assign initial conditions to vector for hybrid heavy ball
x00 = [z1_00;z2_00;p_00;a_00];

hbfNoise = sigmaHBF*randn(1,1);
noiseHBF(HBFIndex) = constHBF*(GradientL(z1_00) + sign(GradientL(z1_00))*hbfNoise);
HBFIndex = HBFIndex + 1;

% simulation horizon
TSPAN=[0 10];
JSPAN = [0 400];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% Simulate GD with no const
[tGD,jGD,xGD] = HyEQsolver(@fGD,@gGD,@CGD,@DGD,...
    x01,TSPAN,JSPAN,rule,options);

% Simulate Discontinuous GD with no const
[tGDD,jGDD,xGDD] = HyEQsolver(@fGDDisc,@gGD,@CGD,@DGD,...
    x02,TSPAN,JSPAN,rule,options);

% Simulate SA with const=5*10^(-13)
[tSA,jSA,xSA] = HyEQsolver(@fSA,@gSA,@CSA,@DSA,...
    x0,TSPAN,JSPAN,rule,options);

% Simulate SA with const=3*10^(-13)
[tSA2,jSA2,xSA2] = HyEQsolver(@fSA2,@gSA,@CSA,@DSA,...
    x0,TSPAN,JSPAN,rule,options);

% Simulate SA with const=1*10^(-13)
[tSA3,jSA3,xSA3] = HyEQsolver(@fSA3,@gSA,@CSA,@DSA,...
    x0,TSPAN,JSPAN,rule,options);

% Simulate SA with const=1*10^(-14)
[tSA4,jSA4,xSA4] = HyEQsolver(@fSA4,@gSA,@CSA,@DSA,...
    x0,TSPAN,JSPAN,rule,options);

% Simulate SA with no const
[tSA5,jSA5,xSA5] = HyEQsolver(@fSA5,@gSA,@CSA,@DSA,...
    x0,TSPAN,JSPAN,rule,options);

% lSA = zeros(1,length(tSA));
% for i=1:length(xSA(:,1))
%     lSA(i) = (CalculateL(xSA(i,1)));
% end
% 
% lSA2 = zeros(1,length(tSA2));
% for i=1:length(xSA2(:,1))
%     lSA2(i) = (CalculateL(xSA2(i,1)));
% end
% 
% lSA3 = zeros(1,length(tSA3));
% for i=1:length(xSA3(:,1))
%     lSA3(i) = (CalculateL(xSA3(i,1)));
% end

% lSA4 = zeros(1,length(tSA4));
% for i=1:length(xSA4(:,1))
%     lSA4(i) = (CalculateL(xSA4(i,1)));
% end
% 
% lSA5 = zeros(1,length(tSA5));
% for i=1:length(xSA5(:,1))
%     lSA5(i) = (CalculateL(xSA5(i,1)));
% end

% Simulate Heavy ball algorithm (nominal, for now, need to add noise).
[tH,jH,xH] = HyEQsolver(@f,@g,@C,@D,...
    x00,TSPAN,JSPAN,rule,options);

% lH = zeros(1,length(tH));
% for i=1:length(xH(:,1))
%     lH(i) = (CalculateL(xH(i,1)));
% end

% % Find the jumps for the hybrid plot:
% for i=2:length(jH)
%     if(jH(i,1) ~= jH(i-1,1))
% %         jumpsx1_H(jumpIndex_H) = xH(i,1);
%         jumpsL1_H(jumpIndex_H) = lH(1,i);
%         jumpst_H(jumpIndex_H) = tH(i,1);
%         jumpIndex_H = jumpIndex_H + 1;
%     end
% end

figure(1)
clf
modificatorF{1} = '';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 3;
modificatorJ{1} = '*--';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 1.5;
subplot(2,2,1), plotHarc(tGD,jGD,xGD(:,1),[],modificatorF,modificatorJ); %plotHarc(tGD,jGD,xGD(:,1),[],modificatorF,modificatorJ);
hold on
ylabel('$\mathrm{z_1}$','FontSize',20)
title('$\mathbf{Gradient \ Descent}$','FontSize',20)
% axis([0 10 10 21]);
axis([0 0.2 9 16]);
yticks([9 10 11 12 13 14 15 16]);
grid on
subplot(2,2,2),plotHarc(tGDD,jGDD,xGDD(:,1),[],modificatorF,modificatorJ);
title('$\mathbf{Discontinuous \ Feedback}$','FontSize',20)
% axis([0 10 10 21]);
axis([0 0.2 9 16]);
yticks([9 10 11 12 13 14 15 16]);
grid on

subplot(2,2,3), plotHarc(tSA5,jSA5,xSA5(:,1),[],modificatorF,modificatorJ);
hold on
plot(tSA2,xSA2(:,1),'Color',[0.8500 0.3250 0.0980],'LineWidth',3);
plot(tSA3,xSA3(:,1),'Color',[0.4660 0.6740 0.1880],'LineWidth',3);
plot(tSA4,xSA4(:,1),'Color',[0.4940 0.1840 0.5560],'LineStyle','--','LineWidth',3);
plot(tSA,xSA(:,1),'Color',[0.6350, 0.0780, 0.1840],'LineWidth',3);
grid on
ylabel('$\mathrm{z_1}$','FontSize',20)
xlabel('$\mathrm{t}$','FontSize',20)
title('$\mathbf{Simulated \ Annealing}$','FontSize',20)
axis([0 0.2 9 16]);
yticks([9 10 11 12 13 14 15 16]);
subplot(2,2,4), plotHarc(tH,jH,xH(:,1),[],modificatorF,modificatorJ);
grid on
xlabel('$\mathrm{t}$','FontSize',20)
title('$\mathbf{Hybrid \ Algorithm}$','FontSize',20)
% axis([0 10 -0.002 0.008]);
axis([0 0.2 9 16]);
yticks([9 10 11 12 13 14 15 16]);
saveas(gcf,'Plots\MotivationNoise','epsc')

% Just the noise
figure(2)
clf
subplot(2,2,1), plot(tGD,noiseGD(1:length(tGD)));
ylabel('$\mathrm{m}$','FontSize',20)
title('$\mathbf{Gradient \ Descent}$','FontSize',20)
% axis([0 10 13 17]);
grid on

subplot(2,2,2), plot(tGDD,noiseGDDisc(1:length(tGDD)));
title('$\mathbf{Discontinuous \ Feedback}$','FontSize',20)
% axis([0 10 13 17]);
grid on

subplot(2,2,3), plot(tSA5,noiseSA(1:length(tSA5)));
grid on
ylabel('$\mathrm{m}$','FontSize',20)
xlabel('$\mathrm{t}$','FontSize',20)
title('$\mathbf{Simulated \ Annealing}$','FontSize',20)

subplot(2,2,4), plot(tH,noiseHBF(1:length(tH)));
grid on
xlabel('$\mathrm{t}$','FontSize',20)
title('$\mathbf{Hybrid \ Algorithm}$','FontSize',20)
% axis([0 0.045 14.999 15.0001]);
saveas(gcf,'Plots\MotivationNoiseSignals','epsc')