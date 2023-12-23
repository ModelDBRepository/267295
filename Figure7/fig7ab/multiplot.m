%plot, 8-areas
close all;
figure('Position',[50,50,800,400]);
hold on;


Nareas=length(areaList);
chosenones=[1 5 22 30 26 17];
blue1=[.1 .6 .8];

for kkk=1:6
  k=chosenones(kkk);
  %k=kkk;  
  
  subplot(2,3,kkk)
  Tmin=dt;Tmax=triallength;
  r1=rate0(1,Tmin/dt:Tmax/dt,k);
  r2=rate1(1,Tmin/dt:Tmax/dt,k);
  r3=rate2(1,Tmin/dt:Tmax/dt,k);
  time=Tmin:dt:Tmax;
  plot(time(1:10:end),r1(1:10:end),'Color',0.7*[1 1 1],'LineWidth',2.0);hold on;
  plot(time(1:10:end),r2(1:10:end),'Color',1.2*blue1,'LineWidth',2.0);hold on;
  plot(time(1:10:end),r3(1:10:end),'Color',0.7*blue1,'LineWidth',2.0);hold on;
  set(gca,'FontSize',12,'LineWidth',2,'TickLength',[0.01 0.01])
  
  stra=char(areaList(k));
  stra2=sprintf('%s',stra);
  title(stra2,'fontsize',12);
  if k==1
      hleg=legend('Control','24c silenced','9/46d silenced');
      set(hleg,'FontSize',12,'box','off');
  end
  maxi=1.3*max([r1(1000:end) r2(1000:end)]);
  topyaxis=max(maxi,2);topyaxis=max(topyaxis,20);
  ylim([-5 topyaxis]);%ylim([0 20]);
  topxaxis=par.triallength;%topxaxis=15;
  xlim([0 topxaxis]);xlim([3.5 8]);
  format short g;
  set(gca,'box','off');
  if kkk==1 || kkk==4
      ylabel('Rate (sp/s)');
  end
  if kkk>3
      xlabel('Time (s)');
  end
  
end




