%1 Regression models of density and flow predicted by moveProb
moveProb_range = 0:.05:1
inFlow = 0.5
withGraphics = []

for i=1:length(moveProb_range)
    [density, flow] = simulate_cars(moveProb_range(i), inFlow, []);
    density_arr(i)=density;
    flow_arr(i)=flow;
end

fitlm(moveProb_range,density_arr)

fitlm(moveProb_range, flow_arr)

%2 Disease


% Author: Stefano Balietti and Karsten Donnay, 2012

% Simulate disease spreading on a 2D grid

% Set parameter values
N=100;              % Grid size (NxN)
beta=0.01;          % Infection rate
gamma=0.01;         % Immunity rate

% define grid
x = zeros(N, N);    % The grid x, is coded as:  0=Susceptible, 1=Infected, 2=Removed

% Set the initial grid, x with a circle of infected individuals in the
% center of the grid, and with a radius of 10 cells.
for i=1:N
    for j=1:N
        dx = i-N/2;
        dy = j-N/2;
        R = sqrt(dx*dx+dy*dy);
        if ( R<10 )
            x(i,j)=1;
        end
    end
end


% Define the Moore neighborhood, i.e. the 8 nearest neighbors
neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];

% Create a new figure
figure

% main loop, iterating the time variable, t
for t=1:5000
 
    % iterate over all cells in grid x, for index i=1..N and j=1..N
    for i=1:N
        for j=1:N
            
            % Iterate over the neighbors and spread the disease
            for k=1:length(neigh)
                i2 = i+neigh(k, 1);
                j2 = j+neigh(k, 2);
                % Check that the cell is within the grid boundaries
                if ( i2>=1 && j2>=1 && i2<=N && j2<=N )
                    % if cell is in state Susceptible and neighboring cell
                    % Infected => Spread infection with probability beta
                    if ( x(i,j)==0 && x(i2, j2)==1 )
                        if ( rand<beta )
                            x(i,j) = 1;
                        end
                    end
                end
            end
            
            % If infected => Recover from disease with probability gamma
            if ( x(i,j)==1 && rand<gamma )
                x(i,j) = 2;
            end
            
        end
    end

    % Animate
    clf                                 % Clear figure
    imagesc(x, [0 2])                   % Display grid
    pause(0.01)                         % Pause for 0.01 s
    colormap([1 0 0; 0 1 0; 0 0 1]);    % Define colors: Red, Green, Blue
    
    % Animate relative fractions through time
    figure(2)
    sus = sum(x(:) == 0)
    inf = sum(x(:) == 1)
    rec = sum(x(:) == 2)
    total = sus + rec + inf;
    % printing relative fractions. not sur ewhy plotting is not working
    susfrac = sus/total
    inffrac = inf/total
    recfrac = rec/total
    plot(t, susfrac)
    hold on
    plot(t,inffrac)
    hold on
    plot(t,recfrac)
    xlabel('Time')
    ylabel('Relative Fraction')
    title('Change in Infection State over Time')
    legend('Susceptible','Infected','Recovered')
    
    % If no more infected => Stop the simulation
    if ( sum(x==1)==0 )
        break;
    end

end

%2.2 With a second order Moore neighborhood the disease would 
% spread faster as there are more neighbors to affect.

% To define the second order, add terms for secondary neighbors 
% [-2,-2] for lower left corner, etc.
neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];


%3
% I'd build a resevoir in an area with higher 
% elevation for easier routing to lower elevation,
% high population areas  low slope for easier construction,
% and with high flow accumulation.
% It looks like either the area around 200, 200, 200,100 or 200,75
% would be good spots judging by these criteria.

clear

%%
fid = fopen('S01E036.hgt','r');
SRTM = fread(fid,[1201,inf],'int16','b');
fclose(fid);

%%
SRTM = SRTM';
SRTM = flipud(SRTM);
SRTM(find(SRTM==-32768)) = NaN;

%%
F = 1/9 * ones(3,3);
SRTM = filter2(F, SRTM(750:1200,750:1200));
SRTM = SRTM(2:449,2:449);

%%
figure(1)
h = pcolor(SRTM);
demcmap(SRTM), colorbar
set(h,'LineStyle','none')
axis equal
title('Elevation [m]')
[r c] = size(SRTM);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
refvec = [1200 0 0];
[asp, slp] = gradientm(SRTM, refvec);

%%
figure(2)
h = pcolor(slp);
colormap(jet), colorbar
set(h,'LineStyle','none')
axis equal
title('Slope [�]')
[r c] = size(slp);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
figure(3)
h = pcolor(asp);
colormap(hsv), colorbar
set(h,'LineStyle','none')
axis equal
title('Aspect')
[r c] = size(asp);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
watersh = watershed(SRTM);

%%
figure(4)
h = pcolor(watersh);
colormap(hsv), colorbar
set(h,'LineStyle','none')
axis equal
title('Watershed')
[r c] = size(watersh);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
sinks = 1*imregionalmin(SRTM);

%%
figure(5)
h = pcolor(sinks);
colormap(gray)
set(h,'LineStyle','none')
axis equal
title('Sinks')
[r c] = size(sinks);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
N = [0 -1;-1 -1;-1 0;+1 -1;0 +1;+1 +1;+1 0;-1 +1];
[a b] = size(SRTM);
grads = zeros(a,b,8);
for c = 2 : 2 : 8
 grads(:,:,c) = (circshift(SRTM,[N(c,1) N(c,2)]) ...
 -SRTM)/sqrt(2*90);
end
for c = 1 : 2 : 7
 grads(:,:,c) = (circshift(SRTM,[N(c,1) N(c,2)]) ...
 -SRTM)/90;
end
grads = atan(grads)/pi*2;

%%
w = 1.1;
flow = (grads.*(-1*grads<0)).^w;

%%
upssum = sum(flow,3);
upssum(upssum==0) = 1;

%%
for i = 1:8
 flow(:,:,i) = flow(:,:,i).*(flow(:,:,i)>0)./upssum;
end

%%
inflowsum = upssum;
flowac = upssum;

%%
inflow = grads*0;

%%
while sum(inflowsum(:))>0
 for i = 1:8
 inflow(:,:,i) = circshift(inflowsum,[N(i,1) N(i,2)]);
 end
 inflowsum = sum(inflow.*flow.*grads>0,3);
 flowac = flowac + inflowsum;
end

%%
figure(6)
h =pcolor(log(1+flowac));
colormap(flipud(jet)), colorbar
set(h,'LineStyle','none')
axis equal
title('Flow accumulation')
[r c] = size(flowac);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
weti = log((1+flowac)./tand(slp));

%%
figure(7)
h = pcolor(weti);
colormap(flipud(jet)), colorbar
set(h,'LineStyle','none')
axis equal
title('Wetness index')
[r c] = size(weti);
axis([1 c 1 r])
set(gca,'TickDir','out');

%%
spi = flowac.*tand(slp);

%%
figure(8)
h = pcolor(log(1+spi));
colormap(jet), colorbar
set(h,'LineStyle','none')
axis equal
title('Stream power index')
[r c] = size(spi);
axis([1 c 1 r])
set(gca,'TickDir','out');






