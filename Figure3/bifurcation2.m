% bifurcation diagram routine, for individual units and vs input


function [R,r]=bifurcation2(par,Imin,Istep,Imax,etai,G)

bringparam(par);
Idim=length(Imin:Istep:Imax);
R1=-99*ones(Idim,1);i=1;R2=R1;R3=R1; %we consider three branches
r1=R1;r2=r1;r3=r1; %also for the individual firing rates
SPlow=18;SPhigh=40; % saddle points in the Y-axis
%we approximate <eta*r>~alpha*eta0*R+beta*G*etamax*etamin;
eta0=(etamax+etamin)/2;alpha=0.94;beta=10.; %alpha,beta are parameters, play with them. [.9,15],[.95,8]

%we define the function of node firing rate to find the fixed point in 'r'
%for a given fixed point in 'R', assuming there will be only one:
myfun= @(r,Rprov,Iprov) r-Smax/(1+exp(-Ssat*(J*etai*r+G*Rprov+Iprov-I0)));
Rprov=0;Iprov=1;

%example:
% myfun = @(x,c) cos(c*x);  % parameterized function
% c = 2;                    % parameter
% fun = @(x) myfun(x,c);    % function of x alone
% x = fzero(fun,0.1)

for I=Imin:Istep:Imax
    
    %first branch (spontaneous activity):
    F1prev=-1;
    for R=5:0.2:SPlow
        %input=J*eta0*R+J*alpha*etamax*etamin+G*R+Ibg;
        input=J*R*eta0*alpha+J*beta*G*etamax*etamin+G*R+I;
        F1=R-Smax/(1+exp(-Ssat*(input-I0)));
        if (F1prev*F1)<0
            R1(i)=R;
            %now the individual rate:
            Rprov=R;Iprov=I;
            fun=@(r) myfun(r,Rprov,Iprov);
            r1(i)=fzero(fun,R);
            %now the rest
            F1prev=F1;
            break;
        end 
    end
    
    %second branch (unstable point):
    F1prev=1;
    for R=SPlow:0.2:SPhigh
        %input=J*eta0*R+J*alpha*etamax*etamin+G*R+I;
        %input=J*R*(eta0+alpha*G*etamax*etamin)+G*R+I;
        input=J*R*eta0*alpha+J*beta*G*etamax*etamin+G*R+I;
        F1=R-Smax/(1+exp(-Ssat*(input-I0)));
        if (F1prev*F1)<0
            R2(i)=R;
            %now the individual rate:
            Rprov=R;Iprov=I;
            fun=@(r) myfun(r,Rprov,Iprov);
            r2(i)=fzero(fun,R);
            %now the rest
            F1prev=F1;
            break;
        end 
    end
    
    %third branch (persistent state):
    F1prev=-1;
    for R=SPhigh:0.2:60
        %input=J*eta0*R+J*alpha*etamax*etamin+G*R+I;
        %input=J*R*(eta0+alpha*G*etamax*etamin)+G*R+I;
        input=J*R*eta0*alpha+J*beta*G*etamax*etamin+G*R+I;
        F1=R-Smax/(1+exp(-Ssat*(input-I0)));
        if (F1prev*F1)<0
            R3(i)=R;
            %now the individual rate:
            Rprov=R;Iprov=I;
            fun=@(r) myfun(r,Rprov,Iprov);
            r3(i)=fzero(fun,R);
            %now the rest
            F1prev=F1;
            break;
        end 
    end
    
    i=i+1;
end

R=[R1 R2 R3];
r=[r1 r2 r3];



