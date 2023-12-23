%figure 1

figure('position',[100,100,400,300]);
I=Imin:Istep:Imax;
SPplot1=4.15;SPplot2=6.3; %position of the saddle points in the X-axis


%mean-field solution for individual unit. Isolated case:
z1=find(I<SPplot2);plot(I(z1),ra1(z1),'-','LineWidth',2,'Color',[0 .7 .9],'HandleVisibility','off');hold on;
z2=find(I>SPplot1 & I<SPplot2);plot(I(z2),ra2(z2),'--','LineWidth',2,'Color',[0 .7 .9],'HandleVisibility','off');hold on;
z3=find(I>SPplot1);plot(I(z3),ra3(z3),'-','LineWidth',2,'Color',[0 .7 .9]);
%connected case:
z1=find(I<SPplot2);plot(I(z1),rb1(z1),'-','LineWidth',2,'Color',0.5*[0 .7 .9],'HandleVisibility','off');hold on;
z2=find(I>SPplot1 & I<SPplot2);plot(I(z2),rb2(z2),'--','LineWidth',2,'Color',0.5*[0 .7 .9],'HandleVisibility','off');hold on;
z3=find(I>SPplot1);plot(I(z3),rb3(z3),'-','LineWidth',2,'Color',0.5*[0 .7 .9]);

set(gca,'box','off');xlabel('Background input');ylabel('Individual firing rate');ylim([0 70]);
legend('Isolated area','Connected area');






