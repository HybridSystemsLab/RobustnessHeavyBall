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

% Closeups
% figure(2)
% clf
% subplot(2,2,1), plotHarc(tGD,jGD,xGD(:,1));
% hold on
% % plot(tGD2,xGD2(:,1),'Color',[0.6350, 0.0780, 0.1840],'LineWidth',3);
% % plot(tGD3,xGD3(:,1),'Color',[0.8500 0.3250 0.0980],'LineWidth',3);
% % plot(tGD4,xGD4(:,1),'Color',[0.4660 0.6740 0.1880],'LineWidth',3);
% % plot(tGD5,xGD5(:,1),'Color',[0.4940 0.1840 0.5560],'LineWidth',3);
% ylabel('$\mathrm{z_1}$','FontSize',20)
% % axis([0 10 10 21]);
% % axis([0 1 14.5 15.5]);
% grid on
% subplot(2,2,2),plotHarc(tGDD,jGDD,xGDD(:,1));
% % axis([0 10 10 21]);
% % axis([0 1 14.5 15.5]);
% grid on
% 
% subplot(2,2,3), plotHarc(tSA5,jSA5,xSA5(:,1));
% hold on
% % plot(tSA2,xSA2(:,1),'Color',[0.8500 0.3250 0.0980],'LineWidth',3);
% % plot(tSA3,xSA3(:,1),'Color',[0.4660 0.6740 0.1880],'LineWidth',3);
% % plot(tSA4,xSA4(:,1),'Color',[0.4940 0.1840 0.5560],'LineStyle','--','LineWidth',3);
% % plot(tSA,xSA(:,1),'Color',[0.6350, 0.0780, 0.1840],'LineWidth',3);
% grid on
% ylabel('$\mathrm{z_1}$','FontSize',20)
% xlabel('$\mathrm{t}$','FontSize',20)
% % axis([0 0.2 14.5 15.5]);
% subplot(2,2,4), plotHarc(tH,jH,xH(:,1));
% grid on
% xlabel('$\mathrm{t}$','FontSize',20)
% 
% axis([0 0.045 14.999 15.0001]);
% saveas(gcf,'Plots\MotivationNoise','epsc')

% Just the noise
figure(3)
clf
subplot(2,2,1), plot(tGD,adversarialGD);
ylabel('$\mathrm{m}$','FontSize',20)
title('$\mathbf{Gradient \ Descent}$','FontSize',20)
% axis([0 10 13 17]);
grid on

subplot(2,2,2), plot(tGDD,adversarialGDD);
title('$\mathbf{Discontinuous \ Feedback}$','FontSize',20)
% axis([0 10 13 17]);
grid on

subplot(2,2,3), plot(tSA5,adversarialSA);
grid on
ylabel('$\mathrm{m}$','FontSize',20)
xlabel('$\mathrm{t}$','FontSize',20)
title('$\mathbf{Simulated \ Annealing}$','FontSize',20)

subplot(2,2,4), plot(tH,adversarialHBF);
grid on
xlabel('$\mathrm{t}$','FontSize',20)
title('$\mathbf{Hybrid \ Algorithm}$','FontSize',20)
% axis([0 0.045 14.999 15.0001]);
saveas(gcf,'Plots\MotivationNoiseSignals','epsc')