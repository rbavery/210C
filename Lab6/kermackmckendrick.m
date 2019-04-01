clear;

s(1) = 500;
i(1) = 500;
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

plot(s, 'b');
hold on;
plot(i, 'r');
plot(r, 'g');