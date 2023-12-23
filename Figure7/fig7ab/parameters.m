% parameters for the model:

function [par]=parameters(Areas,fln,sln,wiring,hierVals,G)

%parameters to scale mfr properly while maintaining the dynamics:
SF1=0.5;SF2=2.; %condition: SF1*SF2=1
%SF1=1;SF2=1;

Nareas=length(Areas);
% We put all the relevant parameters in the parameter structure "par":
par.dt=0.5e-3;par.triallength=10.;par.transient=1.;
par.gamma=0.641*SF2;par.gammai=SF2;
%time constants, in seconds:
taua=0.002;taur=taua;taug=0.005;taun=0.06; %tauNMDA=60ms, tauGABA=5ms
par.tau=[taur taur taur taun taun taug]; % r1,r2,r3(=rI),S1,S2,S3
par.tstep=((par.dt)./(par.tau))';
par.tstep=par.tstep*ones(1,Nareas);% to cover all areas
sig=1*0.01.*[1 1 0 0 0 0]; %noise on r1 and r2 (make 0.02 for DM)
par.tstep2=(((par.dt.*sig.*sig)./(par.tau)).^(0.5))';
par.tstep2=par.tstep2*ones(1,Nareas);% to cover all areas
par.binx=20;par.eta=0.5; 
par.G=G;


%f-I curve parameters:
par.ae=SF1*270;par.be=SF1*108;par.de=SF2*0.154;
par.invgi=SF1*0.5;par.c1=615;par.c0=177;par.r0=SF1*11.;

%----------
% local synaptic couplings (Jns and Jnie are set with the gradient):
% NMDA:
Jns=0.3213*0;      % EE self-population coupling
Jnc=0.0107;      % EE cross-population coupling
Jnie=0.15*0;        % E to I coupling
% AMPA:
Jas=0.*taua;          % EE self-population coupling
Jac=0.*taua;          % EE cross-population coupling
Jaie=0.*taua;         % E to I coupling
%GABA:
Jgei=-0.31;       % I to E coupling
Jgii=-0.12;      % I to I coupling


J=zeros(3,6);
%we assign the weights:
J(1,1)=Jas;J(1,2)=Jac;J(1,3)=0;J(1,4)=Jns;J(1,5)=Jnc;J(1,6)=Jgei;
J(2,1)=Jac;J(2,2)=Jas;J(2,3)=0;J(2,4)=Jnc;J(2,5)=Jns;J(2,6)=Jgei;
J(3,1)=Jaie;J(3,2)=Jaie;J(3,3)=0;J(3,4)=Jnie;J(3,5)=Jnie;J(3,6)=Jgii;
par.J=J;

%gradients:
gi=1/(par.invgi);c1=par.c1;gammai=par.gammai;
zeta=c1*Jgei*taug*gammai/(gi-Jgii*taug*gammai*c1);
Js=0.3213; %original value
Jnsmin=0.21;Jnsmax=0.26; %all areas monostable [0.21 0.42]

%%------------------------------------------------------

%SPINE COUNT DATA (Elston, several papers)
spinec=[643 1201 2429 -10 2077 3200 4689 3200 -10 4812 -10 8337 2572 6600 ... %46d
    6488 7800 7800 -10 6200 -10 2294 2316 -10 6841 -10 8337 -10 -10 8337 6825]; %24c
%age factor
AF=ones(1,30);
AF([14 15 16 17 19 30])=AF([14 15 16 17 19 30]).*1.15; %5yo, 15% increase
AF([6 8 21])=AF([6 8 21]).*1.30; %10yo, 30% increase
par.spine=spinec;
spinec=spinec.*AF; %age correction successful
par.spineaf=spinec;
hierVals2=spinec./max(spinec);

%now the ones based on hierarchical positions:
indice=find(spinec<0); %areas with no spine count data (spinec<0)
hierVals2(indice)=hierVals(indice);hierVals2=hierVals2';

%%------------------------------------------------------

%gradient with real spine count and hierarchycal values:
Jnsgrad=(Jnsmin+hierVals2*(Jnsmax-Jnsmin))';

Jplus=0.2112; %original value, corresponds to Jnie=0.15 and Jns=0.3213
Jniegrad=0.5*(Jplus-Jnsgrad-Jnc)/zeta;
par.Jnsgrad=Jnsgrad;par.Jniegrad=Jniegrad;
%background inputs (common to all areas)
I0e=0.3294;I0i=0.26;
par.inputbg=zeros(3,Nareas);
par.inputbg(1:2,:)=I0e;
par.inputbg(3,:)=I0i;


%-----------
% inter-areal projections:

flnM=fln(Areas,Areas);
slnM=sln(Areas,Areas);
flnM=1.2.*flnM.^(0.3); % range compression
%we properly normalize the FLNs entering each area:
norm=sum(flnM,2);
for i=1:Nareas
    flnM(i,:)=flnM(i,:)/norm(i,1);
end

par.flnM=flnM;par.slnM=slnM;

%we transform the NxN distance matrix into NxN delay matrix:
wires=wiring(Areas,Areas);
par.delay=round(1+wires./(1500*par.dt)); %v=1.5m/s
%delays given now in units of dt=0.5ms


%W(areapost,areapre), E/I balance:
par.We=par.G*flnM;zeta2=2.*c1*taug*gammai*Jgei/(c1*taug*gammai*Jgii-gi);
par.Wi=(1/zeta2).*par.We;


%let's introduce a gradient for the long-range projections We, Wi as well.
%this gradient will have the same slope as for the local case, and the
%strongest value will be as in the nongradient case:
slopee=(Jnsgrad/max(Jnsgrad))';
slopei=(Jniegrad/max(Jniegrad))';
egrad=slopee*ones(1,Nareas);igrad=slopei*ones(1,Nareas);
par.We=par.We.*egrad;par.Wi=par.Wi.*igrad; %done


%FB is biased towards being net inhibitory, FF towards net excitatory
%The deviation is assumed to be proportional to SLN.
lambdae=sln;lambdai=ones(Nareas,Nareas)-sln;
frontal=[6 8 11 14 15 16 17 18 23 25 27 28]; %areas in frontal lobe
%We cap the inhibitory long-range strength to FEF from frontal
%%areas. That was we avoid the spontaneous state stability problem that
%%appeared due to the above (commented) frontal FB rule.
for i=1:2 %we consider as targets 8m and 8l
    for j=1:length(frontal)
        x=frontal(i);
        y=frontal(j);
        maxi=0.4; %this means long-range inhibition to FEF tops at maxi
        %lambdai(x,y)
        if lambdai(x,y)>maxi
            lambdai(x,y)=maxi;
        end
    end
end
par.We=par.We.*lambdae;par.Wi=par.Wi.*lambdai;





