% Single trial for the network of 30 Wong-Wang areas
%
% Jorge F. Mejias, 2022
%

function [rate,totalinput2,totalinput3]=trial(lesionarea,par,Iext,Nareas,Tpulse,Tpulse2,dist,dist2,distarea)
	

% we rewrite the par structure into local parameters for readiness:
dt=par.dt;triallength=par.triallength;
transient=par.transient;tau=par.tau;
tstep=par.tstep;tstep2=par.tstep2;
Jnsgrad=par.Jnsgrad;Jniegrad=par.Jniegrad;
gamma=par.gamma;gammai=par.gammai;
ae=par.ae;be=par.be;de=par.de;
invgi=par.invgi;c1=par.c1;c0=par.c0;r0=par.r0;
J=par.J;inputbg=par.inputbg;
We=(par.We)';Wi=(par.Wi)'; %this form (pre,post) is more convenient here
auxones=ones(3,Nareas);



%we set up the variables for this trial:
irate=zeros(6,Nareas);
iratenew=zeros(6,Nareas);
rate=zeros(6,round(triallength/dt),Nareas);
totalinput=zeros(3,Nareas);
totalinput2=zeros(3,Nareas,100);totalinput3=totalinput2;
inoise=zeros(3,Nareas);
transfer=zeros(3,Nareas);
xi=normrnd(0,1,3,round(triallength/dt),Nareas); %noise
input=zeros(3,Nareas);
ounoise=zeros(3,Nareas);

%first iteration:
rate(1:3,1,:)=5*(1+tanh(2.*xi(:,1,:))); %r1,2,3 --> [0,10] spikes/s
rate(4:6,1,:)=0; %S1,2,3

%Now we start the real simulation:
i=2;kk=1;
for time=2*dt:dt:triallength
	
  %we set the instantaneous rates and conductances for computations:
  irate(:,:)=rate(:,i-1,:);  %6x30
  
  %noise (OU process):
  inoise(:,:)=xi(:,i-1,:);
  ounoise(:,:)=ounoise(:,:)+tstep(1:3,:).*(-ounoise(:,:))+...
  tstep2(1:3,:).*inoise;
  
  %total input to r1,2,3 of each area:
  input=inputbg+ounoise; %3x30
  if time>=2 && time<(2+Tpulse);
      input=input+Iext;
  end
  
%%% first distractor (to E2 of V1):
  if time>=0.3*triallength && time<(0.3*triallength+Tpulse)
      distractor=zeros(3,Nareas);
      distractor(2,distarea)=dist; %if 3-> input at I population!!!
      input=input+distractor;
  end
  
  %%% second distractor (to E2 of V1):
  if time>=0.6*triallength && time<(0.6*triallength+Tpulse2)
      distractor=zeros(3,Nareas);
      distractor(2,distarea)=dist2; %if 3-> input at I population!!!
      input=input+distractor;
  end

  %local interactions through regular connections:
  totalinput(:,:)=input+J*irate(:,:); %3x30, J*irate is (3x6)*(6x30)
  %local interactions through area-dependent connections (gradients):
  totalinput(1,:)=totalinput(1,:)+Jnsgrad.*irate(4,:);
  totalinput(2,:)=totalinput(2,:)+Jnsgrad.*irate(5,:);
  totalinput(3,:)=totalinput(3,:)+Jniegrad.*(irate(4,:)+irate(5,:));
  
  %interareal projections (I cells receive from both E populations):
  totalinput(1,:)=totalinput(1,:)+irate(4,:)*We;
  totalinput(2,:)=totalinput(2,:)+irate(5,:)*We;
  totalinput(3,:)=totalinput(3,:)+(irate(4,:)+irate(5,:))*Wi;

    
  %Input after transfer functions. Excitatory populations:
  transfer(1:2,:)=(ae.*totalinput(1:2,:)-be)./(auxones(1:2,:)...
  -exp(-de*(ae.*totalinput(1:2,:)-be)));
  %Inhibitory populations:
  %threshold-linear f-I curve:
  transfer(3,:)=invgi*c1.*totalinput(3,:)-invgi*c0+r0;
  %transfer(3,transfer(3,:)<0)=0;
  
  
  %we evolve the firing rates of all areas:
  iratenew(1:3,:)=irate(1:3,:)+tstep(1:3,:).*(-irate(1:3,:)+transfer(:,:));
  %and also the NMDA conductances:
  taun=tau(4);taug=tau(6);
  iratenew(4:5,:)=irate(4:5,:)+tstep(4:5,:).*...
  (-irate(4:5,:)+gamma*taun*(ones(2,Nareas)-irate(4:5,:)).*irate(1:2,:));
  %and GABA conductances:
  iratenew(6,:)=irate(6,:)+tstep(6,:).*(-irate(6,:)+taug*gammai.*irate(3,:));
  
  %lesion on area j (V2=2, V4=3, MT=5, LIP=22, TEpd=19, 9/46d=17, ProM=25, 24c=30)
  if lesionarea>0
      j=lesionarea;iratenew(1:6,j)=0;
  end
  
  
  %save the input levels:
  if time>=(triallength-1) && kk<=size(totalinput2,3)
      %totalinput2 is for the gradient-affected local weights:
      totalinput2(1,:,kk)=Jnsgrad.*irate(4,:);
      totalinput2(2,:,kk)=Jnsgrad.*irate(5,:);
      totalinput2(3,:,kk)=Jniegrad.*(irate(4,:)+irate(5,:));
      %totalinput3 is for the long-range input:
      totalinput3(1,:,kk)=irate(4,:)*We;
      totalinput3(2,:,kk)=irate(5,:)*We;
      totalinput3(3,:,kk)=(irate(4,:)+irate(5,:))*Wi;
      kk=kk+1;
  end
  
  %update and index iteration:
  rate(:,i,:)=iratenew(:,:);i=i+1;
end






