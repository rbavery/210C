% eda01_15
% example of the matrix inverse via slash operator

% define matrices and vector
A = [ [1, 5, 13]', [2, 7, 17]', [3, 11, 19]'];
B = [ [1, 2, 3]', [4, 5, 6]', [7, 8, 9]'];
b = [2, 4, 6]';

% solve b=Ac as c=Ainv b
c = A\b;
A
b
c
A*c

% postmultiply D = B Ainv
D = B/A;
A
B
D
D*A
