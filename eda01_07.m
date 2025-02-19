% eda01_07
% example of vector and matrix multiplication

% define matrices and vectors
a=[1, 3, 5]';
b=[2, 4, 6]';
M=[ [1, 0, 2]', [0, 1, 0]', [2, 0, 1]'];
N=[ [1, 0, -1]', [0, 2, 0]', [-1, 0, 3]'];

% dot product
s = a'*b;
s

% outer product
T = a*b';
T

% matrix times vector
c = M*a;
c

% matrix times matrix
P = M*N;
P

% element-wise multiplication of two vectors
d = a.*b;
d