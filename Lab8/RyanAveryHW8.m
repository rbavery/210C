% Q2
m = 5; % example image size
pic = rand(m,m);
s = 30;
[m, n] = size(pic);
[X,Y] = meshgrid(1:m); 
[XI,YI] = meshgrid(linspace(1,m,s*m-1));
figure(1)
imshow(pic,[0,1])
title('original')
figure(2)
pic_linear =interp2(X,Y,pic,XI,YI,'linear');
imshow(pic_linear,[0,1])
title('linear')
figure(3)
pic_nearest =interp2(X,Y,pic,XI,YI,'nearest');
imshow(pic_nearest,[0,1])
title('nearest')
figure(4)
pic_cubic =interp2(X,Y,pic,XI,YI,'cubic');
imshow(pic_cubic,[0,1])
title('cubic')
figure(5)
pic_spline =interp2(X,Y,pic,XI,YI,'spline');
imshow(pic_spline,[0,1])
title('spline')


%3
clear

%%
load geost_dat.mat
x2 = x
y2 = y
z2 = z
y2(150) = 0
x2(150) = 200
z2(150) = 7.5
%%
figure(6)
plot(x,y,'.')

%%
min(z)
max(z)

%%
figure(7)
histogram(z)
skewness(z)
kurtosis(z)

%%
[X1,X2] = meshgrid(x);
[Y1,Y2] = meshgrid(y);
[Z1,Z2] = meshgrid(z);

%%
D = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);

%%
G = 0.5*(Z1 - Z2).^2;

%%

indx = 1:length(z);
[C,R] = meshgrid(indx);
I = R > C;

%%
figure(8)
plot(D(I),G(I),'.' )
xlabel('lag distance')
ylabel('variogram')

%%
D2 = D.*(diag(x*NaN)+1);
lag = mean(min(D2))

%%
hmd = max(D(:))/2

%%
max_lags = floor(hmd/lag)

%%
LAGS = ceil(D/lag);

%%
for i = 1 : max_lags
 SEL = (LAGS == i);
 DE(i) = mean(mean(D(SEL)));
 PN(i) = sum(sum(SEL == 1))/2;
 GE(i) = mean(mean(G(SEL)));
end

%%
figure(9)
plot(DE,GE,'.' )
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
hold on

%%
plot(b,c, '--r')
yl = 1.1 * max(GE);
ylim([0 yl])
xlabel('Averaged distance between observations')
ylabel('Averaged semivariance')
hold off

%%
figure(10)
plot(DE,GE,'o','MarkerFaceColor',[.6 .6 .6])
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
hold on
plot(b,c,'--r')
xlim(b)
yl = 1.1*max(GE);
ylim([0 yl])

%%
nugget = 0;
sill = 0.803;
range = 45.9;
lags = 0:max(DE);
Gsph = nugget + (sill*(1.5*lags/range - 0.5*(lags/...
 range).^3).*(lags<=range) + sill*(lags>range));
plot(lags,Gsph,':g')

%%
nugget = 0.0239;
sill = 0.78;
range = 45;
Gexp = nugget + sill*(1 - exp(-3*lags/range));
plot(lags,Gexp,'-.b')

%%
nugget = 0.153;
slope = 0.0203;
Glin = nugget + slope*lags;
plot(lags,Glin,'-m')
xlabel('Distance between observations')
ylabel('Semivariance')
legend('Variogram estimator','Population variance',...
'Sperical model','Exponential model','Linear model')
hold off

%%
G_mod = (nugget + sill*(1 - exp(-3*D/range))).*(D>0);

%%
n = length(x);
G_mod(:,n+1) = 1;
G_mod(n+1,:) = 1;
G_mod(n+1,n+1) = 0;

%%
G_inv = inv(G_mod);

%%
R = 0 : 5 : 200;
[Xg1,Xg2] = meshgrid(R,R);

%%
Xg = reshape(Xg1,[],1);
Yg = reshape(Xg2,[],1);

%%
Zg = Xg * NaN;
s2_k = Xg * NaN;

%%
for k = 1 : length(Xg)
 DOR = ((x - Xg(k)).^2 + (y - Yg(k)).^2).^0.5;
 G_R = (nugget + sill*(1 - exp(-3*DOR/range))).*(DOR>0);
 G_R(n+1) = 1;
 E = G_inv * G_R;
 Zg(k) = sum(E(1:n,1).*z);
 s2_k(k) = sum(E(1:n,1).*G_R(1:n,1))+E(n+1,1);
end

%%
r = length(R);
Z = reshape(Zg,r,r);
SK = reshape(s2_k,r,r);

%%
figure(11)
subplot(1,2,1)
h = pcolor(Xg1,Xg2,Z);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Estimate')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
subplot(1,2,2)
h = pcolor(Xg1,Xg2,SK);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Variance')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
hold on
plot(x,y,'ok')
hold off


%3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% plotting difference with added value
%%
load geost_dat.mat

y(150) = 0
x(150) = 200
z(150) = 7.5


%%
min(z)
max(z)


%%
[X1,X2] = meshgrid(x);
[Y1,Y2] = meshgrid(y);
[Z1,Z2] = meshgrid(z);

%%
D = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);

%%
G = 0.5*(Z1 - Z2).^2;

%%

indx = 1:length(z);
[C,R] = meshgrid(indx);
I = R > C;

%%


%%
D2 = D.*(diag(x*NaN)+1);
lag = mean(min(D2))

%%
hmd = max(D(:))/2

%%
max_lags = floor(hmd/lag)

%%
LAGS = ceil(D/lag);

%%
for i = 1 : max_lags
 SEL = (LAGS == i);
 DE(i) = mean(mean(D(SEL)));
 PN(i) = sum(sum(SEL == 1))/2;
 GE(i) = mean(mean(G(SEL)));
end

%%
figure(9)
plot(DE,GE,'.' )
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
hold on

%%
plot(b,c, '--r')
yl = 1.1 * max(GE);
ylim([0 yl])
xlabel('Averaged distance between observations')
ylabel('Averaged semivariance')
hold off

%%

var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];



%%
nugget = 0;
sill = 0.803;
range = 45.9;
lags = 0:max(DE);
Gsph = nugget + (sill*(1.5*lags/range - 0.5*(lags/...
 range).^3).*(lags<=range) + sill*(lags>range));


%%
nugget = 0.0239;
sill = 0.78;
range = 45;
Gexp = nugget + sill*(1 - exp(-3*lags/range));


%%
nugget = 0.153;
slope = 0.0203;
Glin = nugget + slope*lags;


%%
G_mod = (nugget + sill*(1 - exp(-3*D/range))).*(D>0);

%%
n = length(x);
G_mod(:,n+1) = 1;
G_mod(n+1,:) = 1;
G_mod(n+1,n+1) = 0;

%%
G_inv = inv(G_mod);

%%
R = 0 : 5 : 200;
[Xg1n,Xg2n] = meshgrid(R,R);

%%
Xg = reshape(Xg1n,[],1);
Yg = reshape(Xg2n,[],1);

%%
Zg = Xg * NaN;
s2_k = Xg * NaN;

%%
for k = 1 : length(Xg)
 DOR = ((x - Xg(k)).^2 + (y - Yg(k)).^2).^0.5;
 G_R = (nugget + sill*(1 - exp(-3*DOR/range))).*(DOR>0);
 G_R(n+1) = 1;
 E = G_inv * G_R;
 Zg(k) = sum(E(1:n,1).*z);
 s2_k(k) = sum(E(1:n,1).*G_R(1:n,1))+E(n+1,1);
end

%%
r = length(R);
Zn = reshape(Zg,r,r);
SKn = reshape(s2_k,r,r);

%%
figure(12)
subplot(1,2,1)
h = pcolor(Xg1,Xg2,Z-Zn);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Estimate Difference Not Added - Added')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
subplot(1,2,2)
h = pcolor(Xg1,Xg2,SKn-SK);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Variance Difference Not Added - Added')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
hold on
plot(x,y,'ok')
hold off

%%% We see that there is very smoothed difference 
%%% around the corner where we added the point.
