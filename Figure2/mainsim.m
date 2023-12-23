% Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022


format short;clear all;
close all;clc;
rng(938196); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.


Areas=1:30;Nareas=length(Areas);G=0.48; %G is the global coupling strength
par=parameters(Areas,fln,sln,wiring,hierVals,G);
bringparam(par);Iext=zeros(3,Nareas); %Tpulse= pulse duration in seconds.
Tpulse=0.5;mu0=1*0.3;Iext(1,1)=mu0; %selective fast input to V1 (WM)


%run the trial (lesionarea=0--> healthy brain:
lesionarea=0;  %V2=2, V4=3, MT=5, LIP=22, TEpd=19, 9/46d=17, ProM=25, 24c=30
[rate,totalinput2,totalinput3]=trial(lesionarea,par,Iext,Nareas,Tpulse);
multiplot;brain3d(rate,1);
%experimental evidence of persistent WM activity: 
%0-> negative evidence(neg>=3 or pos=0), 
%1->strong positive evidence (pos>=2 or neg=0).
%2-> weak positive evidence (mixed, pos<2), 
ratexp=10.*[0 1 0 0 0 1 1 1 2 1 0 1 1 1 0 1 1 1 ... %last one is F5
    2 0 0 1 1 0 0 1 1 1 1 1]'; %last one is 24c
brain3dexp(ratexp,1);

%we plot the spatial bifurcation
robustbif;





