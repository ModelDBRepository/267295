%Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;
rng(938191); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.


Areas=1:30;Nareas=length(Areas);G=0.48;
par=parameters(Areas,fln,sln,wiring,hierVals,G);
bringparam(par);Iext=zeros(3,Nareas); %Tpulse= pulse duration in seconds.
Tpulse=0.5;mu0=1*0.3;Iext(1,1)=mu0; %selective fast input to V1 (WM)


%run the trial (lesionarea=0--> healthy brain, lesionarea=-1-->LIPafterWM):
%lesions: V2=2, V4=3, MT=5, LIP=22, TEpd=19, 9/46d=17, ProM=25, 24c=30
lesionarea=0;[rate0]=trial(lesionarea,par,Iext,Nareas,Tpulse);
lesionarea=30;[rate1]=trial(lesionarea,par,Iext,Nareas,Tpulse);areaList(lesionarea)
lesionarea=17;[rate2]=trial(lesionarea,par,Iext,Nareas,Tpulse);areaList(lesionarea)
multiplot;




