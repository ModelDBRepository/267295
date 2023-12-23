%Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;rng(938191); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.
Areas=1:30;Nareas=length(Areas);
Imin=0.01;Istep=0.01;Imax=0.8;distarea=[1];dist=0;Tpulse2=2;dist2=0;
yellow1=[.7 .7 .1];blue1=[.1 .6 .8];purple1=[.6 0 .5];

%first, we evaluate the minimal strength of target and distractor input
%strength in the classical case:
dist2=0;
for mu0=Imin:Istep:Imax
    %CWM:
    Wplus=0.468;G=0.21;flnx=tril(fln); % all FB projections are zero
    %now the rest:
    par=parameters(Areas,flnx,sln,wiring,hierVals,G,Wplus);
    bringparam(par);Iext=zeros(3,Nareas);Tpulse=0.8;Iext(1,1)=mu0;
    rate=trial(0,par,Iext,Nareas,Tpulse,Tpulse2,dist,dist2,distarea);
    if rate(1,end,17)>10.
        binCWMt=mu0;
        break;
    end
end

%and we now compute the minimal strenght of an effective distractor:
mu=0.3;
for dist2=Imin:Istep:Imax
    %CWM:
    Wplus=0.468;G=0.21;flnx=tril(fln); % all FB projections are zero
    %now the rest:
    par=parameters(Areas,flnx,sln,wiring,hierVals,G,Wplus);
    bringparam(par);Iext=zeros(3,Nareas);Tpulse=0.8;Iext(1,1)=mu0;
    rate=trial(0,par,Iext,Nareas,Tpulse,Tpulse2,dist,dist2,distarea);
    if rate(2,end,17)>10.
        binCWMd=dist2;
        break;
    end
end


%next, we evaluate the minimal strength of target and distractor input
%strength in the distributed case:
dist2=0;
for mu0=Imin:Istep:Imax
    %DWM:
    Wplus=0.26;G=0.48;flnx=fln; 
    %now the rest:
    par=parameters(Areas,flnx,sln,wiring,hierVals,G,Wplus);
    bringparam(par);Iext=zeros(3,Nareas);Tpulse=0.8;Iext(1,1)=mu0;
    rate=trial(0,par,Iext,Nareas,Tpulse,Tpulse2,dist,dist2,distarea);
    if rate(1,end,17)>10.
        binDWMt=mu0;
        break;
    end
end

%and finally, minimal strenght of an effective distractor for DWM:
mu=0.3;binDWMd=0;
for dist2=Imin:Istep:Imax
    %DWM:
    Wplus=0.26;G=0.48;flnx=fln; 
    %now the rest:
    par=parameters(Areas,flnx,sln,wiring,hierVals,G,Wplus);
    bringparam(par);Iext=zeros(3,Nareas);Tpulse=0.8;Iext(1,1)=mu0;
    rate=trial(0,par,Iext,Nareas,Tpulse,Tpulse2,dist,dist2,distarea);
    if rate(2,end,17)>10.
        binDWMd=dist2;
        break;
    end
end

figure;
xbins=[1.1 1.9 3.1 3.9];bins=[binCWMt binCWMd binDWMt binDWMd];
%bar(xbins,bins,'FaceColor',[.1 .4 .6]);
%colorstim=[.7 .7 .1];colordist=[.6 0 .5];
for i=1:4
    color0=blue1;
    if i==2 || i==4
        color0=purple1;
    end
    bar(xbins(i),bins(i),'FaceColor',color0);hold on;
end
set(gca,'FontSize',12,'LineWidth',2,'TickLength',[0.01 0.01]);
set(gca,'box','off');set(gca,'XTick',xbins,'XTickLabelRotation',45);
set(gca,'XTickLabel',{'LWM, cue','LWM, dist.','DWM, cue','DWM, dist.'});
ylabel('Minimal strength');ymax=1.2*max([bins]);ylim([0 ymax]);







