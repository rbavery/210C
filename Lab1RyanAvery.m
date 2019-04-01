# 1.1-1.4

#1.1

y = 2*3.5 + 4*3.5 + 8;

p = 1.6*exp(-4*3.5);

z = 4*sin(31);

v = pi*6.9*3.7^2;

#1.2
a = [31 28 31 30 31 30 31 31 30 31 30 31]';
b = [31 29 31 30 31 30 31 31 30 31 30 31]';

ab = [a, b]


#1.3

M = [[1 0 0 0]',[-1 1 0 0]',[0 -1 1 0]',[0 0 -1 1]'];
y = [1 2 3 5]';
I = eye(4);

x = (I/M)*y

#check that x solves for y
M*x

#1.4 Not sure why teoplitz matrix is flipped when plotted
toeplitzrow = [M(1,:), zeros(1,46)];
toeplitzcol = [M(:,1)', zeros(1,46)]';
toeplitze50by50 = toeplitz(toeplitzcol,toeplitzrow)
pcolor(toeplitze50by50)
colorbar()
title('Toeplitz Matrix')