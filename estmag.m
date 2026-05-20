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

prior=normpdf(x,mean(stim),std(stim));

perc=zeros(size(stim));

for i=1:n
    like=normpdf(meas(i),x,2);
    post=like.*prior;
    post=post/sum(post*dx);
    perc(i)=post*x'*dx;
    %plot(x,like,x,prior,x,post)
end
%%
plot(stim,perc,'.')
refline
hold on
plot(xlim,xlim,'--k')
hold off

disp(sum((meas-stim).^2)/n)
disp(sum((perc-stim).^2)/n)