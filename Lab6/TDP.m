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
