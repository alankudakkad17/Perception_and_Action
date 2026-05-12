dq=0.001;
q=0:dq:1;

% neutral prior
prior=ones(size(q));

d=[1 0 0 1 0 0 0 0 0 0]; % die showed 6
d=[0 0 0 0 0 0 0 1 1 0]; % die showed 6
d=rand(1,1000)<1/6;

for i=1:numel(d)

    % likelihood function for this die
    %likelihood=binopdf(d(i),1,q);
    if d(i)==1
        likelihood=q;
    else
        likelihood=1-q;
    end

    % theorem of Bayes
    posterior=prior.*likelihood; 
    posterior=posterior/(sum(posterior)*dq);

    plot(q,prior,q,likelihood,q,posterior,'LineWidth',2)
    drawnow
    %pause

    prior=posterior;
end

% now take all data at once
likelihoodall=binopdf(sum(d),numel(d),q);
posteriorall=ones(size(q)).*likelihoodall;
posteriorall=posteriorall/(sum(posteriorall)*dq);

plot(q,posterior,q,posteriorall,'--','LineWidth',2)

