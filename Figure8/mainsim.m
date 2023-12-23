%Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;rng(938191); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.
Areas=1:30;Nareas=length(Areas);
Iext=zeros(3,Nareas);Tpulse=0.8;mu0=1*0.3;Iext(1,1)=mu0; %selective fast input to V1 (WM)
DWM=1; %we set our model to DWM or CWM
if DWM==1
    %This is for DWM:
    Wplus=0.26;G=0.48;flnx=fln;
    Tpulse2=2;dist2=0*2.*mu0;
else
    %this is for CWM, with only four areas in the network: V1->1, MT->5, LIP->22, 9/46d->17. 
    Wplus=0.468;G=0.21;flnx=tril(fln); % all FB projections are zero
    Tpulse2=2;dist2=0; %in this case, we don't need a 2nd distractor
end
%now the rest:
par=parameters(Areas,flnx,sln,wiring,hierVals,G,Wplus);bringparam(par);
%run the trial (lesionarea=0--> healthy brain, lesionarea=-1-->LIPafterWM):
[~,newindex]=sort(Jnsgrad);
distarea=[1];dist=mu0;rate=trial(0,par,Iext,Nareas,Tpulse,Tpulse2,dist,dist2,distarea);
multiplot;







