% Simplified network model for distributed working memory
%
% Jorge Mejias, 2022


format short;clear all;
close all;clc;rng(938196); %938197

%First, the case with saturation but without FF/FB bias:
%Parameters and initializations:
Areas=1:30;Nareas=length(Areas);G=0.2; %G is the global coupling strength
saturation=1;delta=0*0.021; %use either 0 or 0.021
par=parameters(Areas,saturation,delta);bringparam(par);
%numerical solutions vs G (i.e. numerical bifurcation diagram):
%Gmin=0.14;Gstep=0.002;Gmax=0.24;Gdim=length(Gmin:Gstep:Gmax); %for etalinear
Gmin=0.16;Gstep=0.002;Gmax=0.4;Gdim=length(Gmin:Gstep:Gmax); %for etalinear2
i=1;lowbranch=zeros(Gdim,Nareas);highbranch=lowbranch;
for G=Gmin:Gstep:Gmax
    %low branch:
    Iext=zeros(1,Nareas);Tpulse=0.5;Iext(1,:)=0;
    rate=trial(par,Nareas,G,Iext,Tpulse);
    lowbranch(i,:)=rate(1,end,:);
    
    %high branch:
    Iext=zeros(1,Nareas);Tpulse=0.5;Iext(1,:)=30;
    rate=trial(par,Nareas,G,Iext,Tpulse);
    highbranch(i,:)=rate(1,end,:);
    
    i=i+1;
end


%Now, same but with FF/FB bias:
%Parameters and initializations:
Areas=1:30;Nareas=length(Areas);G=0.2; %G is the global coupling strength
saturation=1;delta=1*0.021; %use either 0 or 0.021
par=parameters(Areas,saturation,delta);bringparam(par);
%numerical solutions vs G (i.e. numerical bifurcation diagram):
%Gmin=0.14;Gstep=0.002;Gmax=0.24;Gdim=length(Gmin:Gstep:Gmax); %for etalinear
Gmin=0.16;Gstep=0.002;Gmax=0.4;Gdim=length(Gmin:Gstep:Gmax); %for etalinear2
i=1;lowbranch2=zeros(Gdim,Nareas);highbranch2=lowbranch2;
for G=Gmin:Gstep:Gmax
    %low branch:
    Iext=zeros(1,Nareas);Tpulse=0.5;Iext(1,:)=0;
    rate=trial(par,Nareas,G,Iext,Tpulse);
    lowbranch2(i,:)=rate(1,end,:);
    
    %high branch:
    Iext=zeros(1,Nareas);Tpulse=0.5;Iext(1,:)=30;
    rate=trial(par,Nareas,G,Iext,Tpulse);
    highbranch2(i,:)=rate(1,end,:);
    
    i=i+1;
end



figure3




