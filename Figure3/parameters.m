% parameters for the model:

function [par]=parameters(Areas,saturation,delta)

Nareas=length(Areas);
par.dt=0.5e-3;par.triallength=10.;par.transient=1.;
par.tau=0.02; %time constant, in seconds
par.tstep=(par.dt)./(par.tau);
par.tstep=par.tstep*ones(1,Nareas);% to cover all areas
par.Smax=60;par.Ssat=0.1;par.I0=30; %f-I curve parameters
par.Ibg=4.813627; %background current
par.J=0.9092; %local coupling
par.etamin=0.55;par.etamax=0.85; %gradient limits


%%------------------------------------------------------

%linear gradients for local coupling:
step=(par.etamax-par.etamin)/Nareas;etalinear=[(par.etamin+step):step:par.etamax]; %linear gradient

figure('Position',[50 50 350 250]);
etalinear2=etalinear;etath=0.725;etalinear2(etalinear2>etath)=etath;
%plot(Areas,0.055*Areas,'-','LineWidth',3,'Color',[0 .3 1]);hold on;
plot(Areas,etalinear,'-','LineWidth',3,'Color',1.2*[.1 .7 .3]);hold on;
plot(Areas,etalinear2,'-','LineWidth',3,'Color',0.8*[.1 .7 .3]);hold on;
set(gca,'box','off');ylabel('Local coupling strength');xlabel('Areas (ranked by local coupling)');
legend('Linear gradient','Saturating gradient');


%Choose: gradient with saturation or linear:
%par.eta=(par.etamin+hierVals2*(par.etamax-par.etamin))';
if saturation==0
    par.eta=etalinear;
else
    par.eta=etalinear2;
end


%-------------------------------------------------------
% inter-areal projections:
%slnM=sln(Areas,Areas); %(post,pre)
%delta=0;%delta=0.021;
par.W=ones(Nareas,Nareas)*(1/Nareas);
for i=1:Nareas
    for j=1:i
        par.W(j,i)=par.W(j,i)-delta;
    end
    for j=i:Nareas
        par.W(j,i)=par.W(j,i)+delta;
    end
    par.W(i,i)=0;
end


% %Extra: FB is biased towards being net inhibitory, FF towards net excitatory
% %The deviation is assumed to be proportional to SLN.
% lambdae=sln;lambdai=ones(Nareas,Nareas)-sln;
% par.We=par.We.*lambdae;par.Wi=par.Wi.*lambdai;




