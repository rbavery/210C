% eda01_17
% load and plot the neuse.txt dataset

D=load('neuse.txt');
t=D(:,1);
d=D(:,2);

figure(1);
clf;

set(gca,'LineWidth',2);
plot(t,d,'k-','LineWidth',2);
title('Neuse River Hydrograph');
xlabel('time in days');
ylabel('discharge in cfs');


