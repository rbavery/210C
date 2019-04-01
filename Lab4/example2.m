N = 20;
x = [0:100]/100;
f = ones(1,101)*1/2;
ff= zeros(1,101);
for i = 1:2:N
    a = 2/pi/i;
f = f+ a*sin(2*pi*i*x);

end

plot(x,f)