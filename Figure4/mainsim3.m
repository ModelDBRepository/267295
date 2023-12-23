% Large-scale network model for distributed working memory
%
% Jorge Mejias, 2022

format short;clear all;
close all;clc;
rng(938196); %938197
load('subgraphData30.mat'); %FLN and SLN, rank-ordered. Distances given in mm.

%select the level of FB bias for which you want to obtain the 3d brain map:
delta=0.6;

%now the rest:
Areas=1:30;Nareas=length(Areas);Gext=0.48; %G is the global coupling strength
par=parameters(Areas,fln,sln,wiring,hierVals,delta,Gext);bringparam(par);
bringparam(par);Iext=zeros(3,Nareas);%Tpulse= pulse duration in seconds.
Tpulse=0.5;mu0=1*0.3;Iext(1,1)=mu0; %selective fast input to V1 (WM)


%run the trial
rate=trial(0,par,Iext,Nareas,Tpulse);
brain3d(rate,1);
%multiplot;






