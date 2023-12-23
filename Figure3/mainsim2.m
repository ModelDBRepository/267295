% Simplified network model for distributed working memory
%
% Jorge Mejias, 2022


format short;clear all;
close all;clc;rng(938196); %938197

%Parameters and initializations:
Areas=1:30;Nareas=length(Areas);saturation=0;delta=0;
par=parameters(Areas,saturation,delta);bringparam(par);
%mean-field solution for the average firing rate and each of the individual rates considered:
%we plot bifdiag vs input bias for G=0 vs G>0, to see the shifting effect.
etai=eta(14);Imin=0.;Istep=0.02;Imax=20;
%isolated one:
G=0;[R,r]=bifurcation2(par,Imin,Istep,Imax,etai,G);
%R1=R(:,1);R2=R(:,2);R3=R(:,3);
ra1=r(:,1);ra2=r(:,2);ra3=r(:,3);
%connected one:
G=0.2;[R,r]=bifurcation2(par,Imin,Istep,Imax,etai,G);
%R1=R(:,1);R2=R(:,2);R3=R(:,3);
rb1=r(:,1);rb2=r(:,2);rb3=r(:,3);

figure2




