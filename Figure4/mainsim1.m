%Large-scale network model for distribured working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;
rng(938191); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.

Areas=1:30;Nareas=length(Areas);
Iext=zeros(3,Nareas);%Tpulse= pulse duration in seconds.
Tpulse=0.5;mu0=0.3;Iext(1,1)=mu0; %selective fast input to V1 (WM)
Dmin=0.;Dstep=0.1;Dmax=1.;
WMareas1=zeros(10,length(Dmin:Dstep:Dmax));WMareas2=WMareas1;



Gext=0.48;i=1;
for delta=Dmin:Dstep:Dmax;
    %parameters for this coupling value
    par=parameters2(Areas,fln,sln,wiring,hierVals,delta,Gext);bringparam(par);
    rate=trial(0,par,Iext,Nareas,Tpulse); %run the trial
    threshold=10;
    WMareas1(:,i)=rate(1,end,1:10);
    WMareas2(:,i)=rate(1,end,21:30);
    i=i+1;
end



figure;
delta=0:0.1:1;
plot(delta,mean(WMareas1,1),'-','LineWidth',4,'Color',[.2 .2 .5]);hold on;
plot(delta,mean(WMareas2,1),'-','LineWidth',4,'Color',[.99 .45 .1]);hold on;
for i=1:10
    plot(delta,WMareas1(i,:),'-','LineWidth',1,'Color',[.2 .2 .5]);hold on;
    plot(delta,WMareas2(i,:),'-','LineWidth',1,'Color',[.99 .45 .1]);hold on;
end
set(gca,'FontSize',16,'LineWidth',3,'TickLength',[0.01 0.01])
xlabel('Strength of CIB (norm.)');
ylabel('Rate during delay (sp/s)');
ylim([-1 60]);xlim([0 1]);
set(gca,'box','off');
hleg=legend('bottom-hierarchy areas','top-hierarchy areas');
set(hleg,'box','off');








