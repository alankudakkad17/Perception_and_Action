rng default
n=400;
stim=randn(n,1)*4+15;

stim=zeros(n,1)*4;
for i=2:numel(stim)
    stim(i)=stim(i-1)+randn*5;
end

meas=stim+randn(n,1)*2;

dx=0.1;
x=-100:dx:100;

prior=normpdf(x,5,10);
priorsamp=randn(1,2000)*10+5;

% prior=normpdf(x,mean(stim),std(stim));
% priorsamp=randn(1,2000)*std(stim)+mean(stim);
% 
% histogram(priorsamp,40,"Normalization","pdf")
% hold on
% plot(x,prior,'LineWidth',2)
% hold off

perc=zeros(size(stim));

transsd=std(diff(stim));
tic
for i=1:n
    like=normpdf(meas(i),priorsamp,2);
    postsamp=datasample(priorsamp,numel(priorsamp),"Weights",like);
    perc(i)=mean(postsamp);
    trans=randn(size(postsamp))*transsd;
    priorsamp=postsamp+trans;
end
toc
%%
figure
plot(stim,perc,'.')
refline
hold on
plot(xlim,xlim,'--k')
hold off

disp(sum((meas-stim).^2)/n)
disp(sum((perc-stim).^2)/n)

percpart=perc;