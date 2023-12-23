%Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;rng(938191); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.
Areas=1:30;Nareas=length(Areas);%G=0.45;


%first, inactivation of 9/46 (d&v) for LWM:
%Wplus=0.49;G=0.2; %good for silencing 46d (area 14)
Wplus=0.468;G=0.21; %we silence 9/46d&v now (it works with these parameters)
par=parameters(Areas,fln,sln,wiring,hierVals,G,Wplus,1);bringparam(par);
inhibareas=[16 17]; %%% inhibit 9/46d&v transiently %%%
Iext=zeros(3,Nareas);Tpulse=0.5;mu0=0.15;Iext(3,inhibareas)=mu0; %Tpulse=2;mu0=0.3;
rateCWM=trial(0,par,Iext,Nareas,Tpulse); %run trial
%rate=rateCWM;

%now, inactivation of 9/46 (d&v) for DWM:
%Wplus=0.25;G=0.46; %Wplus=0.25; G=0.46 as in SFig 9 (DWM dies out)
Wplus=0.26;G=0.48; %0.3 and 0.45, the new data (DWM resists)
par=parameters(Areas,fln,sln,wiring,hierVals,G,Wplus,0);bringparam(par);
inhibareas=[16 17]; %%% inhibit 9/46d transiently %%%
Iext=zeros(3,Nareas);Tpulse=0.5;mu0=0.15;Iext(3,inhibareas)=mu0;
rateDWM1=trial(0,par,Iext,Nareas,Tpulse); %run trial
%attractor is retrieved after transient inactivation of 9/46dv.

%and finally, stronger inactivation of top four areas during delay to shut down DWM:
Wplus=0.26;G=0.48; %0.3 and 0.45, the new data (DWM resists)
par=parameters(Areas,fln,sln,wiring,hierVals,G,Wplus,0);bringparam(par);
inhibareas=[16 17 27 28]; %%% inhibit 9/46d&v, F7 and 8B transiently %%%
Iext=zeros(3,Nareas);Tpulse=1;mu0=0.15;Iext(3,inhibareas)=mu0;
rateDWM2=trial(0,par,Iext,Nareas,Tpulse);multiplot; %run trial and plot
%shutting down DWM is therefore possible




