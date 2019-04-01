clear all;

% histogram of earthquake magnitudes
d = load('earthquake_magnitudes.txt');
time = 10; % 10 years of data
m = [5:0.1:10]';
count = hist(d,m)';
r = count/time;

% Gutenberg-Richter magnitude-energy relation
log10Ee = 1.5*m + 11.8; % in ergs
log10Ej = log10Ee - 7; % in joules
E = 1e-7 * 10.^log10Ej;

figure(1);
clf;
lw = 2.2;
set(gca,'LineWidth',lw,'Xscale','log','Yscale','log','TickLength', [0.04 0.035]);
hold on;
axis([1e5,1e10,0.1,1000]);
hold on;
plot( E, r, 'ko', 'LineWidth', lw );
plot( E, r, 'k-', 'LineWidth', lw );
xlabel('energy (joules)');
ylabel('earthquakes rate (per year)');
title('Earthquake rate vs energy');

figure(2); % plot with fewer parameters
clf;
set(gca,'Xscale','log','Yscale','log');
hold on;
plot( E, r, 'ko', 'LineWidth', 2);
xlabel('energy (joules)');
ylabel('earthquakes rate (per year)');
title('Earthquake rate vs energy');