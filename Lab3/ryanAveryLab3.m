% 1

figure(1)
load('linedata01.txt');
X = linedata01(:,1);
Y = linedata01(:,2);
scatter(X, Y)
hold on

p1 = polyfit(X, Y, 1)
pred1 = polyval(p1,X);
plot(X,pred1)
hold on

p2 = polyfit(X, Y, 2)
pred2 = polyval(p2, X);
plot(X,pred2)
hold on

p3 = polyfit(X, Y, 3)
pred3 = polyval(p3, X);
plot(X,pred3)
hold on

p4 = polyfit(X, Y, 4);
pred4 = polyval(p4, X);
plot(X,pred4)
hold off 
legend('Original Data', 'Degree 1', 'Degree 2', 'Degree 3', 'Degree 4')

% ANSWER
% I think that the 1st degree polynomial is the best fit, just judging 
% by how it fits the overall trend I infer with my eyes. I would test 
% for overfitting rigourously by using a test set of data to measure 
% the least squares error on. I can also plot how the model fits the data and
% determine if the line appears to be overly complicated in fitting the data.

% 2a
% ANSWER
% The exponential model has the smaller squared error but this is because it
% overfits the model, as seen by the over curving toward the upper data point.
% The model using the second order polynomial will have lower variance in the 
% long run for other data points.

figure(2)
M = 3;
N = length(X);
G = zeros(N, M);
G(:,1)=1;
G(:,2)=X;
G(:,3)=X.^2;
params = (G'*G)\G'*Y;
pred2kernel = params(1)+params(2)*X+params(3)*X.^2; 
e = Y - pred2kernel;
E2a = e'*e

scatter(X, Y)
hold on

plot(X,pred2kernel)
hold on

G(:,3)=exp(X);
params = (G'*G)\G'*Y;
predekernel = params(1)+params(2)*X+params(3)*exp(X); 
ee = Y - predekernel;
E2ae = ee'*ee
plot(X,predekernel)

legend('Original Data', 'Degree 2', 'exponential')

% 3
% ANSWER: Adding 2 more terms for the semi-annual period 
% performs the best, judging by the reduction in squared error, E. 
% Comparing E2 (representing 3.2) with the other E's, E2 is the smallest.
% This is the best one to acheive the fit, because there is no third-of-a-year
% cycle to be represneted by the added terms in 3.3. And the other terms are
% not descriptive of the intermediate/half-year cycle.

% eda04_11
% load Black Rock Forest temperature data

% read the data
Draw=load('brf_temp.txt');
traw=Draw(:,1);
draw=Draw(:,2);
Nraw=length(draw);

% exclude bad data
n = find( (draw~=0) & (draw>-40) & (draw<38) );
t=traw(n);
d=draw(n);

N=length(d);
M=4;

% plot the data
figure(1);
clf;
subplot(3,1,1);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,d,'k-','LineWidth',2);
xlabel('time, days');
ylabel('obs temp, C');

% set up data kernel
Ty=365.25;
G=zeros(N,4);
G(:,1)=1;
G(:,2)=t;
G(:,3)=cos(2*pi*t/Ty);
G(:,4)=sin(2*pi*t/Ty);

% set up data kernel 3.1
Ty=365.25;
G1=zeros(N,5);
G1(:,1)=1;
G1(:,2)=t;
G1(:,3)=cos(2*pi*t/Ty);
G1(:,4)=sin(2*pi*t/Ty);
G1(:,5)=t.^2;

% set up data kernel 3.2
Ty=365.25;
G2=zeros(N,6);
G2(:,1)=1;
G2(:,2)=t;
G2(:,3)=cos(2*pi*t/Ty);
G2(:,4)=sin(2*pi*t/Ty);
G2(:,5)=cos(2*pi*t/(Ty/2));
G2(:,6)=sin(2*pi*t/(Ty/2));

% set up data kernel 3.3
Ty=365.25;
G3=zeros(N,8);
G3(:,1)=1;
G3(:,2)=t;
G3(:,3)=cos(2*pi*t/Ty);
G3(:,4)=sin(2*pi*t/Ty);
G3(:,5)=cos(2*pi*Ty/2);
G3(:,6)=cos(2*pi*Ty/3);
G3(:,7)=cos(2*pi*Ty/2);
G3(:,8)=cos(2*pi*Ty/3);

% predict data
mest = (G'*G)\(G'*d);
dpre = G*mest;
e = d - dpre;
E = e'*e;
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,dpre,'k-','LineWidth',2);;
xlabel('time, days');
ylabel('pre temp, C')

hold on
% predict data 3.1
mest = (G1'*G1)\(G1'*d);
dpre = G1*mest;
e1 = d - dpre;
E1 = e1'*e1;
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
plot(t,dpre,'x-','LineWidth',2);;


hold on
% predict data 3.2
mest = (G2'*G2)\(G2'*d);
dpre = G2*mest;
e2 = d - dpre;
E2 = e2'*e2;
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
plot(t,dpre,'o-','LineWidth',2);;


hold on
% predict data 3.3
mest = (G3'*G3)\(G3'*d);
dpre = G3*mest;
e3 = d - dpre;
E3 = e3'*e3;
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
plot(t,dpre,'.-','LineWidth',2);;

hold off
% plot error
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,e,'k-','LineWidth',2);
xlabel('time, days');
ylabel('error, C')

hold on 

% plot error 3.1
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,e1,'k-','LineWidth',2);
xlabel('time, days');
ylabel('error, C')

hold on 

% plot error 3.2
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,e2,'k-','LineWidth',2);
xlabel('time, days');
ylabel('error, C')

hold on

% plot error 3.3
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,e3,'k-','LineWidth',2);
xlabel('time, days');
ylabel('error, C')
hold off



















