% Single trial for the network of 30 areas
%

function [rate]=trial(par,Nareas,G,Iext,Tpulse)
	

% we rewrite the par structure into local parameters for readiness:
bringparam(par);W=W'; %W(pre,post) more convenient here
auxones=ones(3,Nareas);

%we set up the variables for this trial:
irate=zeros(1,Nareas);iratenew=zeros(1,Nareas);
rate=zeros(1,round(triallength/dt),Nareas);transfer=zeros(1,Nareas);
totalinput=zeros(1,Nareas);input=zeros(1,Nareas);


rate(1,1,:)=0; %first iteration (initial condition)
i=2; %now the temporal evolution:
for time=2*dt:dt:triallength
	
  %we set the instantaneous rates and conductances:
  irate(:,:)=rate(:,i-1,:);  %6x30
  
  %total input to r1,2,3 of each area:
  input=Ibg; %1x30
  if time>=2 && time<(2+Tpulse);
      input=input+Iext;
  end


  %local interactions through area-dependent connections (gradients):
  totalinput(1,:)=input+J*eta.*irate(1,:);  
  %global interareal projections: 
  totalinput(1,:)=totalinput(1,:)+G*irate(1,:)*W;


  %Input after transfer functions. Excitatory populations:
  transfer(1,:)=Smax./(auxones(1,:)+exp(-Ssat*(totalinput(1,:)-I0)));
 
  %we evolve the firing rates of all areas:
  iratenew(1,:)=irate(1,:)+tstep(1,:).*(-irate(1,:)+transfer(1,:));
  
  %update and index iteration:
  rate(:,i,:)=iratenew(:,:);i=i+1;
end







