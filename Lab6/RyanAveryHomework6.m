%1
dt=0.01;        % time step
g=9.81;         % gravity
L=1.0;          % pendulum length

% initial condition
theta=-0.9;      % modified angle
thetaPrime=0;   % angular velocity

% simulation loop see lecture 12
for t=0:dt:5
    thetaBis=-g/L*sin(theta);
    thetaPrime=thetaPrime+dt*thetaBis;
    theta=theta+dt*thetaPrime;
    plot([0 cos(theta-pi/2)],[0 sin(theta-pi/2)]);
    xlim([-1 1]);
    ylim([-1 0]);
    xlabel('x');
    ylabel('y');
    pause(0.01);
end


% 1
dt=0.01;        % time step
g=1.625;         % gravity
L=1.0;          % pendulum length

% initial condition
theta=-0.9;      % modified angle
thetaPrime=0;   % angular velocity

% simulation loop see lecture 12
for t=0:dt:5
    thetaBis=-g/L*sin(theta);
    thetaPrime=thetaPrime+dt*thetaBis;
    theta=theta+dt*thetaPrime;
    plot([0 cos(theta-pi/2)],[0 sin(theta-pi/2)]);
    xlim([-1 1]);
    ylim([-1 0]);
    xlabel('x');
    ylabel('y');
    pause(0.01);
end
% on the moon the pendulum would swing slower

%2
clc                        %---------------------------------------------------------------------------------------------------%
clear                      % 
                           %                                                                                                   %                                              %                                                                             
                           % parameters:                                                                                       % 
                           % th1(1) :         the angle of the top mass of the first double pendulum                           %                                                            
                           % th2(1) :         the angle of the bottom mass of the first double pendulum                        %                                                          
dt=0.01;                   % thd1(1):         the speed of the top mass of the first double pendulum                           %                                                                    
T=10;                      % thd2(1):         the speed of the bottom mass of the first double pendulum                        %                                                                     
N=int16(T/dt);                                    %                                                                     
th1=zeros(N,1);                                  %                                                                      
                         
th2=zeros(N,1);                                  %                                                                       
thd1=zeros(N,1);           %                                            \                                                      %
thd2=zeros(N,1);           %                                              \                                                    %
         %                                               \                                                   %
thdd1=zeros(N,1);          %                                                \                                                  %
        %                                                 \                                                 %
thdd2=zeros(N,1);          %                                                  \                                                %
        %                                                   \                                               %
X1=zeros(N,1);             %                                                   ooo                                             %
Y1=zeros(N,1);             %                                                  o O o                                            %
          %                                                       \                                           %    
X2=zeros(N,1);             %                                                          \                                        %       
Y2=zeros(N,1);             %                                                             \                                     %           
            %                                                                   \                               %          
                           %                                                                      \                            %           
                           %                                                                         \                         %          
figure;                    %                                                                            \                      %    
hold off;                  %                                                                             ooo                   %           
                           %                                                                            o O o                  %    
th1(1)=pi/2;               %                                                                             ooo                   %
             %                                                                                                   %
th2(1)=pi+0.02;            %---------------------------------------------------------------------------------------------------%  

thd1(1)=0;

thd2(1)=0;

g=10;

A=-2*g*sin(th1(1))-sin(th1(1)-th2(1))*thd2(1)^2;

B=-g*sin(th2(1))+sin(th1(1)-th2(1))*thd1(1)^2;

thdd1(1)=(A-B*cos(th1(1)-th2(1)))/(2-(cos(th1(1)-th2(1)))^2);
thdd2(1)=B-cos(th1(1)-th2(1))*thdd1(1);

X1(1)=sin(th1(1));
Y1(1)=cos(th1(1));

X2(1)=sin(th1(1))+sin(th2(1));
Y2(1)=cos(th1(1))+cos(th2(1));


for i=2:N
    thd1(i)=thd1(i-1)+dt*thdd1(i-1);
    
    thd2(i)=thd2(i-1)+dt*thdd2(i-1);
    
    th1(i)=th1(i-1)+dt*thd1(i);
   
    th2(i)=th2(i-1)+dt*thd2(i);
    
    A=-2*g*sin(th1(i))-sin(th1(i)-th2(i))*thd2(i)^2;
    
    B=-g*sin(th2(i))+sin(th1(i)-th2(i))*thd1(i)^2;
    
    thdd1(i)=(A-B*cos(th1(i)-th2(i)))/(2-(cos(th1(i)-th2(i)))^2);
    
    thdd2(i)=B-cos(th1(i)-th2(i))*thdd1(i);
  
    X1(i)=sin(th1(i));
   
    Y1(i)=cos(th1(i));
   
    X2(i)=sin(th1(i))+sin(th2(i));
  
    Y2(i)=cos(th1(i))+cos(th2(i));
  
    plot([0, X1(i), X2(i)], [0, -Y1(i), -Y2(i)],'-o');
    hold on
  
    axis([-2 2 -2 2]);
    title(['t = ', num2str(double(i)*dt, '% 5.3f'), ' s']);
    hold on
    plot(X2(1:i), -Y2(1:i), 'r');
    
    hold off
    drawnow;
end

clc                        %---------------------------------------------------------------------------------------------------%
clear                      % 
                           %                                                                                                   %                                              %                                                                             
                           % parameters:                                                                                       % 
                           % th1(1) :         the angle of the top mass of the first double pendulum                           %                                                            
                           % th2(1) :         the angle of the bottom mass of the first double pendulum                        %                                                          
dt=0.01;                   % thd1(1):         the speed of the top mass of the first double pendulum                           %                                                                    
T=10;                      % thd2(1):         the speed of the bottom mass of the first double pendulum                        %                                                                     
N=int16(T/dt);                                    %                                                                     
th1=zeros(N,1);                                  %                                                                      
                         
th2=zeros(N,1);                                  %                                                                       
thd1=zeros(N,1);           %                                            \                                                      %
thd2=zeros(N,1);           %                                              \                                                    %
         %                                               \                                                   %
thdd1=zeros(N,1);          %                                                \                                                  %
        %                                                 \                                                 %
thdd2=zeros(N,1);          %                                                  \                                                %
        %                                                   \                                               %
X1=zeros(N,1);             %                                                   ooo                                             %
Y1=zeros(N,1);             %                                                  o O o                                            %
          %                                                       \                                           %    
X2=zeros(N,1);             %                                                          \                                        %       
Y2=zeros(N,1);             %                                                             \                                     %           
            %                                                                   \                               %          
                           %                                                                      \                            %           
                           %                                                                         \                         %          
figure;                    %                                                                            \                      %    
hold off;                  %                                                                             ooo                   %           
                           %                                                                            o O o                  %    
th1(1)=pi/4;               %                                                                             ooo                   %
             %                                                                                                   %
th2(1)=pi/4;            %---------------------------------------------------------------------------------------------------%  

thd1(1)=0;

thd2(1)=0;

g=10;

A=-2*g*sin(th1(1))-sin(th1(1)-th2(1))*thd2(1)^2;

B=-g*sin(th2(1))+sin(th1(1)-th2(1))*thd1(1)^2;

thdd1(1)=(A-B*cos(th1(1)-th2(1)))/(2-(cos(th1(1)-th2(1)))^2);
thdd2(1)=B-cos(th1(1)-th2(1))*thdd1(1);

X1(1)=sin(th1(1));
Y1(1)=cos(th1(1));

X2(1)=sin(th1(1))+sin(th2(1));
Y2(1)=cos(th1(1))+cos(th2(1));


for i=2:N
    thd1(i)=thd1(i-1)+dt*thdd1(i-1);
    
    thd2(i)=thd2(i-1)+dt*thdd2(i-1);
    
    th1(i)=th1(i-1)+dt*thd1(i);
   
    th2(i)=th2(i-1)+dt*thd2(i);
    
    A=-2*g*sin(th1(i))-sin(th1(i)-th2(i))*thd2(i)^2;
    
    B=-g*sin(th2(i))+sin(th1(i)-th2(i))*thd1(i)^2;
    
    thdd1(i)=(A-B*cos(th1(i)-th2(i)))/(2-(cos(th1(i)-th2(i)))^2);
    
    thdd2(i)=B-cos(th1(i)-th2(i))*thdd1(i);
  
    X1(i)=sin(th1(i));
   
    Y1(i)=cos(th1(i));
   
    X2(i)=sin(th1(i))+sin(th2(i));
  
    Y2(i)=cos(th1(i))+cos(th2(i));
  
    plot([0, X1(i), X2(i)], [0, -Y1(i), -Y2(i)],'-o');
    hold on
  
    axis([-2 2 -2 2]);
    title(['t = ', num2str(double(i)*dt, '% 5.3f'), ' s']);
    hold on
    plot(X2(1:i), -Y2(1:i), 'r');
    
    hold off
    drawnow;
end


% 3. 

% timestep
dt=0.001;
% iterations
iter=5000;

% initialize vectors
x=zeros(iter,1); y=zeros(iter,1); z=zeros(iter,1); t=zeros(iter,1);
x(1)=1; y(1)=1; z(1)=40; t(1)=0; % starting point
sigma=10; r=14; b=8/3;
% crit value of r is 14
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

plot(x,y);
plot3(x,y,z);

clear;

x(1) = 5;
y(1) = 5;

alpha = 1.0;
beta = 1.0;
gamma = 1.0;
delta = 1.0;

dt = 0.01;

for t = 2:5000
    dx = x(t-1) * (alpha - beta * y(t-1));
    dy = - y(t-1) * (gamma - delta * x(t-1));
    x(t) = x(t-1) + dt*dx;
    y(t) = y(t-1) + dt*dy;
end
figure(4)
plot(x, 'r');
hold on;
plot(y, 'g');
title('Prey and Predator vs Time')
figure(5)
plot(x,y);
title('Phase Plot')

% The initial conditions at the start of each new die/revive cycle are changed. When predators eat
% prey until the predators die out, it allows the diminished prey population to explode due to less 
% predators to predate them. When the prey population becomes very large it allows the predators 
% to consume a larger prey population, causing the population of the predators to explode in size
% more and then subsequently bust. The process then repeats itself, amplifying the larger boom/ larger
% bust cycle.

%5

clear;

s(1) = 999;
i(1) = 1;
r(1) = 0;

beta = 0.0001;
gamma = 0.01;

dt = 1;

for t = 2:300
    ds = - beta * i(t-1) * s(t-1);
    di = beta * i(t-1) * s(t-1) - gamma * i(t-1);
    dr = gamma * i(t-1);
    s(t) = s(t-1) + dt*ds;
    i(t) = i(t-1) + dt*di;
    r(t) = r(t-1) + dt*dr;
end
figure(6)
plot(s, 'b');
hold on;
plot(i, 'r');
plot(r, 'g');


s(1) = 999;
i(1) = 1;
r(1) = 0;

beta = 0.0001;
gamma = 0.01;

dt = 1;
% k is the initial number of infected
for k = 1:1000
    s(1) = 1000-k(1);
    i(1) = k(1);
    for t = 2:300
        ds = - beta * i(t-1) * s(t-1);
        di = beta * i(t-1) * s(t-1) - gamma * i(t-1);
        dr = gamma * i(t-1);
        s(t) = s(t-1) + dt*ds;
        i(t) = i(t-1) + dt*di;
        r(t) = r(t-1) + dt*dr;
    end
    max_inf(k)= max(i);
end

figure(7)
plot(k, 'b');
hold on;
plot(max_inf, 'r');
xlabel('initial infected')
ylabel('max infected')













