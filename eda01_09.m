% eda01_09
% example of derivative and integral

clear all;

% independent variable t
N = 21;
tmin = 0;
tmax = 1;
Dt = (tmax-tmin)/(N-1);
t = tmin + Dt*[0:N-1]';

% exemplary funtion
x = sin(pi*t);

% its derivative and integral
strue = pi*cos(pi*t);    % its derivative
atrue = 1/pi-cos(pi*t)/pi; % its integral, with integration constant
                            % chosen so integral is zero at t=0

% finite difference approximation of derivative
% note that its length is N-1
sapprox = (x(2:N)-x(1:N-1))/Dt;

% Riemann sum appoximation for integral
aapprox = Dt*cumsum(x);

% Riemann sum approximation for last value only
atotal = Dt*sum(x);

% time series plot
figure(1);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [0, 1, 0, 1.1 ] );
xlabel('t');
ylabel('x(t)');
% plot function as continuous curve
plot( t, x, 'g-', 'LineWidth', 4, 'Color', [0.8,0.8,0.8] );
% plot function as circles
plot( t, x, 'ko', 'LineWidth', 2 );
% plot vertical tics
for i=[1:N-1]
    plot([t(i),t(i)], [0,0.1], 'k-', 'LineWidth', 2 );
end

% calculus plot
figure(2);
clf;
subplot(3,1,1);
set(gca,'LineWidth',2);
hold on;
axis( [0, 1, 0, 1.1 ] );
xlabel('t');
ylabel('x(t)');
% plot exemplary rectangles, shaded
K=5;
for k=[1:5]
    if(x(k)>0)
        r=rectangle( 'Position', [t(k),0,Dt,x(k)], 'FaceColor', [0.9,0.9,0.9] );
    end
end
% plot function as continuous curve
plot( t, x, 'g-', 'LineWidth', 4, 'Color', [0.9,0.9,0.9] );
% plot function as circles
plot( t, x, 'ko', 'LineWidth', 2 );
% embolden one slope
K=5;
plot( [t(K),t(K+1)], [x(K),x(K+1)], 'k-', 'LineWidth', 6, 'Color', [0,0,0]);
% plot polygons
for i=[1:N-1]
    plot([t(i),t(i),t(i+1),t(i+1)], [0,x(i),x(i+1),0], 'k-', 'LineWidth', 2 );
end

% plot derivative
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
axis( [0, 1, -1.1*pi, 1.1*pi ] );
xlabel('t');
ylabel('s=dx/dx');
plot( t, strue, 'k-', 'LineWidth', 4, 'Color', [0.8,0.8,0.8] );
plot( t(1:N-1), sapprox, 'k-', 'LineWidth', 2 );

% plot integral
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 1, 0, 1.1*2/pi ] );
xlabel('t');
ylabel('integral of x');
plot( t, atrue, 'k-', 'LineWidth', 4, 'Color', [0.8,0.8,0.8] );
plot( t, aapprox, 'k-', 'LineWidth', 2 );
plot( t(N), atotal, 'ko', 'LineWidth', 3 ); % last value