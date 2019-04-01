% eda01_18
% load the neuse.txt data set
% convert discharge from cfs to m3/s
% and write to a file neuse_metric.txt

D=load('neuse.txt');
t=D(:,1);
d=D(:,2);

f=35.3146;
dm = d/f;
Dm(:,1)=t;
Dm(:,2)=dm;

figure(1);
clf;

plot(t,dm,'k');
title('Neuse River Hydrograph');
xlabel('time in days');
ylabel('discharge in m3/s');

dlmwrite('neuse_metric.txt',Dm,'\t');

