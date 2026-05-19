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

perc=zeros(size(stim));

trans2=normpdf(x,x',std(diff(stim)));

for i=1:n
    like=normpdf(meas(i),x,2);
    post=like.*prior;
    post=post/sum(post*dx);
    perc(i)=post*x'*dx;
    %plot(x,like,x,prior,x,post)
    %drawnow
    %pause(0.1)
    % prior=conv(trans,post,'same');
    % calculate new prior
    post2=repmat(post,size(post,2),1);
    posttrans=post2.*trans2;
    prior=sum(posttrans,2)'*dx;
    prior=prior/sum(prior*dx);
end
%%
plot(stim,perc,'.')
refline
hold on
plot(xlim,xlim,'--k')
hold off

disp(sum((meas-stim).^2)/n)
disp(sum((perc-stim).^2)/n)