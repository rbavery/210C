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

% plot error
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,e,'k-','LineWidth',2);
xlabel('time, days');
ylabel('error, C')



