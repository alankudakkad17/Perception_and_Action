% tau*du/dt=v(t)-u(t)
rng default

u0=0;
tau=1;
dt=0.1;

Tfinal=10;
n=round(Tfinal/dt);

t=(0:n-1)'*dt;

u=zeros(n,1);
u(1)=u0;

v=ones(n,1)*10;
v(1:10)=0;
v(end-10:end)=0;
%v=(rand(n,1)-0.5)*10;
v=v+randn(n,1)*0.5;

for i=1:n-1
    dudt=(v(i)-u(i))/tau;
    u(i+1)=u(i)+dudt*dt; % Euler 1-step forward integration
end

plot(t,v,t,u,'LineWidth',2)
xlabel('time')