%figure 1

figure('position',[100,100,800,300]);
subplot(1,2,1)
blue1=[.1 .6 .8]; %also, [0 .7 .9] for mf solution
G=Gmin:Gstep:Gmax;
Gtheo=Gtheomin:Gtheostep:Gtheomax;
%average firing rate:
Rlow=mean(lowbranch,2);Rhigh=mean(highbranch,2);
plot(G,Rlow,'o','LineWidth',3,'Color',blue1,'HandleVisibility','off');hold on;
plot(G,Rhigh,'o','LineWidth',3,'Color',blue1,'HandleVisibility','off');hold on;
%now the first order mean field solution:
SPplot1=0.165;SPplot2=0.3135; %old ones: 0.165, 0.3135
z1=find(Gtheo<SPplot2);plot(Gtheo(z1),R01(z1),'-','LineWidth',2,'Color',0.8*[1 1 1]);hold on;
z2=find(Gtheo>SPplot1 & Gtheo<SPplot2);plot(Gtheo(z2),R02(z2),'--','LineWidth',2,'Color',0.8*[1 1 1],'HandleVisibility','off');hold on;
z3=find(Gtheo>SPplot1);plot(Gtheo(z3),R03(z3),'-','LineWidth',2,'Color',0.8*[1 1 1],'HandleVisibility','off');hold on;
%and finally, the second order mean field solution:
SPplot1=0.185;SPplot2=0.271; %old ones: 0.165, 0.3135
z1=find(Gtheo<SPplot2);plot(Gtheo(z1),R1(z1),'-','LineWidth',2,'Color',1.2*blue1);hold on;
z2=find(Gtheo>SPplot1 & Gtheo<SPplot2);plot(Gtheo(z2),R2(z2),'--','LineWidth',2,'Color',1.2*blue1,'HandleVisibility','off');hold on;
z3=find(Gtheo>SPplot1);plot(Gtheo(z3),R3(z3),'-','LineWidth',2,'Color',1.2*blue1,'HandleVisibility','off');
set(gca,'box','off');xlabel('Global coupling');ylabel('Network firing rate');ylim([0,70]);
legend({'1st-order solution' '2nd-order solution'});


%now the individual firing rates:
subplot(1,2,2)
for j=1:3 %early areas are black, later ones are blue
    i=chosen(j);
    plot(G,lowbranch(:,i),'o','LineWidth',2,'Color',(i/Nareas)*[0 .5 1]);hold on;
    plot(G,highbranch(:,i),'o','LineWidth',2,'Color',(i/Nareas)*[0 .5 1]);
end

%and their mean-field solutions. First one:
z1=find(Gtheo<SPplot2);plot(Gtheo(z1),ra1(z1),'-','LineWidth',2,'Color',(chosen(1)/Nareas)*[0 .7 .9]);hold on;
z2=find(Gtheo>SPplot1 & Gtheo<SPplot2);plot(Gtheo(z2),ra2(z2),'--','LineWidth',2,'Color',(chosen(1)/Nareas)*[0 .7 .9]);hold on;
z3=find(Gtheo>SPplot1);plot(Gtheo(z3),ra3(z3),'-','LineWidth',2,'Color',(chosen(1)/Nareas)*[0 .7 .9]);
%second one:
z1=find(Gtheo<SPplot2);plot(Gtheo(z1),rb1(z1),'-','LineWidth',2,'Color',(chosen(2)/Nareas)*[0 .7 .9]);hold on;
z2=find(Gtheo>SPplot1 & Gtheo<SPplot2);plot(Gtheo(z2),rb2(z2),'--','LineWidth',2,'Color',(chosen(2)/Nareas)*[0 .7 .9]);hold on;
z3=find(Gtheo>SPplot1);plot(Gtheo(z3),rb3(z3),'-','LineWidth',2,'Color',(chosen(2)/Nareas)*[0 .7 .9]);
%third one:
z1=find(Gtheo<SPplot2);plot(Gtheo(z1),rc1(z1),'-','LineWidth',2,'Color',(chosen(3)/Nareas)*[0 .7 .9]);hold on;
z2=find(Gtheo>SPplot1 & Gtheo<SPplot2);plot(Gtheo(z2),rc2(z2),'--','LineWidth',2,'Color',(chosen(3)/Nareas)*[0 .7 .9]);hold on;
z3=find(Gtheo>SPplot1);plot(Gtheo(z3),rc3(z3),'-','LineWidth',2,'Color',(chosen(3)/Nareas)*[0 .7 .9]);
set(gca,'box','off');xlabel('Global coupling');ylabel('Individual firing rates');ylim([0 70]);













