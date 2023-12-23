%plot, 8-areas
close all;



%refresh
%hfig=figure(i);
%set(hfig,'Position',[100,300,1200,1000]);
figure('Position',[50,50,600,400]);
%clf('Figure 1','reset')
hold on;
yellow1=[.7 .7 .1];blue1=[.1 .6 .8];purple1=[.6 0 .5];

Nareas=length(areaList);
chosenones=[1 5 28 17];

for kkk=1:4
  k=chosenones(kkk);
    
  
  subplot(2,2,kkk)
  Tmin=dt;Tmax=triallength;
  r1=rate(1,Tmin/dt:Tmax/dt,k);
  r2=rate(2,Tmin/dt:Tmax/dt,k);
  r3=rate(3,Tmin/dt:Tmax/dt,k);
  time=Tmin:dt:Tmax;
  plot(time(1:10:end),r1(1:10:end),'Color',blue1,'LineWidth',2.0);hold on;
  plot(time(1:10:end),r2(1:10:end),'Color',purple1,'LineWidth',2.0);hold on;
  set(gca,'FontSize',12,'LineWidth',2,'TickLength',[0.01 0.01])
  
  stra=char(areaList(k));
  stra2=sprintf('%s',stra);
  title(stra2,'fontsize',12);
  maxi=1.3*max([r1(1000:end) r2(1000:end) r3(1000:end)]);
  topyaxis=max(maxi,2);topyaxis=max(topyaxis,20);
  ylim([-2 topyaxis]);%ylim([0 20]);
  topxaxis=par.triallength;%topxaxis=15;
  xlim([0 topxaxis]);xlim([0 15]);
  format short g;
  
  box off;
  if kkk==1 
      ylabel('Rate (sp/s)');
  end
  
  if kkk==3
      ylabel('Rate (sp/s)');
      xlabel('Time (s)')
  end
      
  if kkk==4
      xlabel('Time (s)');
  end
  
end




