%plot, 8-areas
close all;
figure('Position',[50,50,800,500]); %700 350
hold on;


Nareas=length(areaList);
chosenones=[1 30 28 17]; %[1 5 22 30 28 17]
blue1=[.1 .6 .8];purple1=[.6 0 .5];

%First, inactivation of 9/46d during delay for localized WM:
for kkk=1:4
  k=chosenones(kkk);
    
  
  subplot(3,4,kkk)
  Tmin=dt;Tmax=triallength;
  r1=rateCWM(1,Tmin/dt:Tmax/dt,k);
  r2=rateCWM(2,Tmin/dt:Tmax/dt,k);
  time=Tmin:dt:Tmax;
  plot(time(1:10:end),r1(1:10:end),'Color',blue1,'LineWidth',2.0);hold on;
  plot(time(1:10:end),r2(1:10:end),'Color',purple1,'LineWidth',2.0);hold on;
  set(gca,'FontSize',12,'LineWidth',2,'TickLength',[0.01 0.01])
  
  stra=char(areaList(k));
  stra2=sprintf('%s',stra);
  title(stra2,'fontsize',12);
  if k==1
      hleg=legend('Excit. A','Excit. B');
      set(hleg,'FontSize',10);
  end
  maxi=1.3*max([r1(1000:end) r2(1000:end)]);
  topyaxis=max(maxi,2);topyaxis=max(topyaxis,30);
  %ylim([-2 topyaxis]);ylim([0 30]);
  if kkk==1
      ylim([-2 80]);
      ylabel('Rate (sp/s)');
  end
  topxaxis=par.triallength;%topxaxis=15;
  xlim([0 topxaxis]);xlim([3.5 15]);format short g;
  set(gca,'box','off');
  
end

%Second, inactivation of 9/46d during delay for DWM:
for kkk=1:4
  k=chosenones(kkk);
    
  subplot(3,4,kkk+4)
  Tmin=dt;Tmax=triallength;
  r1=rateDWM1(1,Tmin/dt:Tmax/dt,k);
  r2=rateDWM1(2,Tmin/dt:Tmax/dt,k);
  time=Tmin:dt:Tmax;
  plot(time(1:10:end),r1(1:10:end),'Color',blue1,'LineWidth',2.0);hold on;
  plot(time(1:10:end),r2(1:10:end),'Color',purple1,'LineWidth',2.0);hold on;
  set(gca,'FontSize',12,'LineWidth',2,'TickLength',[0.01 0.01])
  
  stra=char(areaList(k));
  stra2=sprintf('%s',stra);
  title(stra2,'fontsize',12);
  maxi=1.3*max([r1(1000:end) r2(1000:end)]);
  topyaxis=max(maxi,2);topyaxis=max(topyaxis,30);
  %ylim([-2 topyaxis]);ylim([0 30]);
  if kkk==1
      ylim([-2 80]);
      ylabel('Rate (sp/s)');
  end
  topxaxis=par.triallength;%topxaxis=15;
  xlim([0 topxaxis]);xlim([3.5 15]);format short g;
  set(gca,'box','off');
  
end


%finally, inactivation of four top areas to shut down DWM
for kkk=1:4
  k=chosenones(kkk);
    
  subplot(3,4,kkk+8)
  Tmin=dt;Tmax=triallength;
  r1=rateDWM2(1,Tmin/dt:Tmax/dt,k);
  r2=rateDWM2(2,Tmin/dt:Tmax/dt,k);
  time=Tmin:dt:Tmax;
  plot(time(1:10:end),r1(1:10:end),'Color',blue1,'LineWidth',2.0);hold on;
  plot(time(1:10:end),r2(1:10:end),'Color',purple1,'LineWidth',2.0);hold on;
  set(gca,'FontSize',12,'LineWidth',2,'TickLength',[0.01 0.01])
  
  stra=char(areaList(k));
  stra2=sprintf('%s',stra);
  title(stra2,'fontsize',12);
  maxi=1.3*max([r1(1000:end) r2(1000:end)]);
  topyaxis=max(maxi,2);topyaxis=max(topyaxis,30);
  %ylim([-2 topyaxis]);ylim([0 30]);
  if kkk==1
      ylim([-2 80]);
      ylabel('Rate (sp/s)');
  end
  topxaxis=par.triallength;%topxaxis=15;
  xlim([0 topxaxis]);xlim([3.5 15]);format short g;
  set(gca,'box','off');xlabel('Time (s)');
  
end






