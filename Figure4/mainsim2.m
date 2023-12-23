%Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;
rng(938191); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.


Areas=1:30;Nareas=length(Areas);
Iext=zeros(3,Nareas);%Tpulse= pulse duration in seconds.
Tpulse=0.5;mu0=0.3;Iext(1,1)=mu0; %selective fast input to V1 (WM)
Gmin=0.;Gstep=0.02;Gmax=1.2;
WMareas0=zeros(1,length(Gmin:Gstep:Gmax));WMareas1=WMareas0;


delta=0.;i=1;
for Gext=Gmin:Gstep:Gmax;
    %parameters for this coupling value
    par=parameters(Areas,fln,sln,wiring,hierVals,delta,Gext);bringparam(par);
    rate=trial(0,par,Iext,Nareas,Tpulse); %run the trial
    threshold=10;WMareas0(1,i)=sum(heaviside(rate(1,end,:)-threshold));
    i=i+1;
end


delta=1;i=1;
for Gext=Gmin:Gstep:Gmax;
    %parameters for this coupling value
    par=parameters(Areas,fln,sln,wiring,hierVals,delta,Gext);bringparam(par);
    rate=trial(0,par,Iext,Nareas,Tpulse); %run the trial
    threshold=10;WMareas1(1,i)=sum(heaviside(rate(1,end,:)-threshold));
    i=i+1;
end


figure;
Gext=Gmin:Gstep:Gmax;
plot(Gext,WMareas0,'-*','LineWidth',3,'Color',[.7 .7 .7]);hold on;
plot(Gext,WMareas1,'-*k','LineWidth',3);
set(gca,'FontSize',16,'LineWidth',3,'TickLength',[0.01 0.01])
xlabel('Global coupling');ylabel('Number of WM areas');
ylim([-1 40]);xlim([0 1.2]);set(gca,'box','off');
hleg=legend('Without CIB','With CIB');set(hleg,'box','off','FontSize',20);





