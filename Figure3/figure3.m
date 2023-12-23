%figure 1

figure('position',[50,50,350,250]); %800 300
% subplot(2,2,1)
% G=Gmin:Gstep:Gmax;
% Gtheo=Gtheomin:Gtheostep:Gtheomax;
% %average firing rate:
% Rlow=mean(lowbranch,2);Rhigh=mean(highbranch,2);
% plot(G,Rlow,'o','LineWidth',3,'Color',[0 .3 1]);hold on;
% plot(G,Rhigh,'o','LineWidth',3,'Color',[0 .3 1]);hold on;
% %now the theoretical solution:
% SPplot1=0.185;SPplot2=0.271; %old ones: 0.165, 0.3135
% z1=find(Gtheo<SPplot2);plot(Gtheo(z1),R1(z1),'-','LineWidth',2,'Color',[0 .7 .9]);hold on;
% z2=find(Gtheo>SPplot1 & Gtheo<SPplot2);plot(Gtheo(z2),R2(z2),'--','LineWidth',2,'Color',[0 .7 .9]);hold on;
% z3=find(Gtheo>SPplot1);plot(Gtheo(z3),R3(z3),'-','LineWidth',2,'Color',[0 .7 .9]);
% set(gca,'box','off');xlabel('Global coupling');ylabel('Network firing rate');ylim([0,70]);


% #areas in 'persistent state' (i.e. firing rate >threshold) for each value of G.
%subplot(2,2,3)
G=Gmin:Gstep:Gmax;
persistentareas=zeros(Gdim,2);ratethr=15;
for i=1:Gdim
    persistentareas(i,1)=sum(highbranch(i,:)>ratethr)+0.1;
    persistentareas(i,2)=sum(highbranch2(i,:)>ratethr);
end
plot(G,persistentareas(:,1),'-o','LineWidth',2,'Color',0.8*[1 1 1]);hold on;
plot(G,persistentareas(:,2),'-o','LineWidth',2,'Color',0.1*[1 1 1]);
set(gca,'box','off');xlabel('Global coupling');ylabel('Number of bistable areas');
legend({'Saturation' 'Sat. with weak FB'});

%now the individual firing rates:
%subplot(2,2,2)













