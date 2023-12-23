% Simplified network model for distributed working memory
%
% Jorge Mejias, 2022


format short;clear all;
close all;clc;rng(938196); %938197

%Parameters and initializations:
Areas=1:30;Nareas=length(Areas);
saturation=0;delta=0;G=0.2; %G is the global coupling strength
par=parameters(Areas,saturation,delta);bringparam(par);


%numerical solutions vs G (i.e. numerical bifurcation diagram):
Gmin=0.1;Gstep=0.01;Gmax=0.35;Gdim=length(Gmin:Gstep:Gmax); %step=0.001, Gstep=0.015
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


%mean-field solution for the average firing rate and each of the individual rates considered:
%we start with the first order  mean field solution:
chosen=[1 12 24];order=0;
%first one:
eta1=eta(chosen(1));Gtheomin=0.1;Gtheostep=0.001;Gtheomax=0.35;
Gtheodim=length(Gtheomin:Gtheostep:Gtheomax);
[R]=bifurcation(par,Gtheomin,Gtheostep,Gtheomax,eta1,order);
R01=R(:,1);R02=R(:,2);R03=R(:,3);
%second one:
eta2=eta(chosen(2));Gtheomin=0.1;Gtheostep=0.001;Gtheomax=0.35;
Gtheodim=length(Gtheomin:Gtheostep:Gtheomax);
[R]=bifurcation(par,Gtheomin,Gtheostep,Gtheomax,eta2,order);
R01=R(:,1);R02=R(:,2);R03=R(:,3);
%third one:
eta3=eta(chosen(3));Gtheomin=0.1;Gtheostep=0.001;Gtheomax=0.35;
Gtheodim=length(Gtheomin:Gtheostep:Gtheomax);
[R]=bifurcation(par,Gtheomin,Gtheostep,Gtheomax,eta3,order);
R01=R(:,1);R02=R(:,2);R03=R(:,3);

%now the second order mean field solution:
chosen=[1 12 24];order=1;
%first one:
eta1=eta(chosen(1));Gtheomin=0.1;Gtheostep=0.001;Gtheomax=0.35;
Gtheodim=length(Gtheomin:Gtheostep:Gtheomax);
[R,r]=bifurcation(par,Gtheomin,Gtheostep,Gtheomax,eta1,order);
R1=R(:,1);R2=R(:,2);R3=R(:,3);ra1=r(:,1);ra2=r(:,2);ra3=r(:,3);
%second one:
eta2=eta(chosen(2));Gtheomin=0.1;Gtheostep=0.001;Gtheomax=0.35;
Gtheodim=length(Gtheomin:Gtheostep:Gtheomax);
[R,r]=bifurcation(par,Gtheomin,Gtheostep,Gtheomax,eta2,order);
R1=R(:,1);R2=R(:,2);R3=R(:,3);rb1=r(:,1);rb2=r(:,2);rb3=r(:,3);
%third one:
eta3=eta(chosen(3));Gtheomin=0.1;Gtheostep=0.001;Gtheomax=0.35;
Gtheodim=length(Gtheomin:Gtheostep:Gtheomax);
[R,r]=bifurcation(par,Gtheomin,Gtheostep,Gtheomax,eta3,order);
R1=R(:,1);R2=R(:,2);R3=R(:,3);rc1=r(:,1);rc2=r(:,2);rc3=r(:,3);


figure1




