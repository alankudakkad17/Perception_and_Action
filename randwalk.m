n=1000;
stimuli=zeros(n,1);

% random walk stimuli
for i=2:n
    stimuli(i)=stimuli(i-1)+randn(1);
end

% normally distributed stimuli
% stimuli=randn(n,1)*10;

plot(stimuli)
hold on

noise=randn(n,1)*10;

meas=stimuli+noise;
plot(meas)

rmse(meas,stimuli)

dx=0.1;
x=-200:dx:200;

prior=normpdf(x,0,std(stimuli));
est=zeros(size(stimuli));
estw=zeros(size(stimuli));

% estimation model for independent random numbers
for i=1:n
    likel=normpdf(meas(i),x,10);
    post=likel.*prior;
    post=post/(sum(post)*dx);
    est(i)=post*x'*dx;
end

plot(est)
rmse(est,stimuli)

trnsp=normpdf(x,x',1);

% estimator model for random walk
for i=1:n

    likel=normpdf(meas(i),x,10);
    post=likel.*prior;
    post=post/(sum(post)*dx);
    estw(i)=post*x'*dx;

    cmp=trnsp.*repmat(post,numel(x),1);
    prior=sum(cmp,2);
    prior=prior'/(sum(prior)*dx);
end

plot(estw)
rmse(estw,stimuli)




