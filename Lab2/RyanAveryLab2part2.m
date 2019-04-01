
%1 solving for X
A = [2 -3 -1 4; 2 3 -3 2; 2 -1 -1 -1; 2 -1 2 5];
b = [1; 2; 3; 4];
x=A\b

%2 summation function
answer = coolsum(1, 20)

%3 correlations, etc.
data = load('ding-data1.txt');
X = data(:,2);
Y = data(:,3);

% Pearson
pearson = corr(X,Y)

% Spearman
spearman = corr(X, Y, 'Type', 'Spearman')

%Kendall
kendall = corr(X,Y, 'Type', 'Kendall')

esize = effectivesize(X, Y)
t = pearson*sqrt((esize-2)/(1-pearson^2))
% from t table lookup, t is 7.5204 for the pearson correlation coef.
% from t table lookup, this is significant

% bootstrap method
rng(0);
rhos1000 = bootstrp(1000, 'corrcoef', X, Y);
% check if pearson is signifiant by using hsitogram to see if pearson is in center of histogram
figure(1)
histogram(rhos1000(:, 2), 80, 'Normalization','probability')
% pearson's correlation coefficient is slightly left of center but is still quite near the center.

% 4.2 Sample T-Test
figure(2)
load('organicmatter_three.mat')
histogram(corg1, 'FaceColor', 'b'), hold on
histogram(corg2, 'FaceColor', 'r'), hold off

[h,p,ci,stats] = ttest2(corg1,corg2, .05)
% The threshold of signifiance is a t value of 1.9803 for a two-sided test
% therefore the means of these distributions are significantly different 
load('organicmatter_five.mat')
%4.3 2 Sample F-Test
[hf,pf,cif,statsf] = vartest2(corg1,corg2, .05)
% The threshold of signifiance is an f value of about 3.5 therefore 
% the variances of these distributions are significantly different.


