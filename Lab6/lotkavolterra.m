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
plot(x, 'r');
hold on;
plot(y, 'g');
%plot(x,y);
