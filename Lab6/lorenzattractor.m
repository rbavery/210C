% timestep
dt=0.001;
% iterations
iter=5000;

% initialize vectors
x=zeros(iter,1); y=zeros(iter,1); z=zeros(iter,1); t=zeros(iter,1);
x(1)=1; y(1)=1; z(1)=40; t(1)=0; % starting point
sigma=10; r=28; b=8/3;

for i=2:iter
    dx=sigma*(y(i-1)-x(i-1));
    dy=r*x(i-1)-y(i-1)-x(i-1)*z(i-1);
    dz=x(i-1)*y(i-1)-b*z(i-1);
    x(i)=x(i-1)+dt*dx;
    y(i)=y(i-1)+dt*dy;
    z(i)=z(i-1)+dt*dz;
    t(i)=t(i-1)+dt;
    
    plot3(x,y,z);
    pause(0.001);
    xlabel('x');
    ylabel('y');
end

%plot(x,y);
%plot3(x,y,z);
