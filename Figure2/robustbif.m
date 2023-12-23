
%we plot the persistent firing rates vs areas: 

figure('Position',[50 50 800 400]);
[~,newindex]=sort(par.Jnsgrad);
rate1=squeeze(mean(rate(1,(end-1000):end,:),2));
%plot:    
[~,newindex2]=sort(rate1);
plot(1:Nareas,sort(rate1),'o','LineWidth',2,'MarkerSize',14,'MarkerFaceColor',blue1,'MarkerEdgeColor',blue1);hold on;
plot([5.5 5.51],[0 55],'--','Color',[.1 .1 .1],'LineWidth',3);hold on; %critical value
set(gca,'FontSize',12,'LineWidth',3,'TickLength',[0.01 0.01]);
set(gca,'box','off');xlabel('Areas (ranked by firing rate)');ylabel('Rate (sp/s)');
z3=areaList(newindex2);set(gca,'XTick',1:Nareas,'XTickLabelRotation',45);set(gca,'XTickLabel',z3);
xlim([0 31]);ylim([0 45]);
