%% Load habitat structure
    XY = load('XY.txt'); % the X-Y locations of each plant
    % to visualize the array:
    %               plot(XY(:,1), XY(:,2), 'g.'); 
%% Papameters setting
exitP = 0;      % The rate of dispersing out of the system
gH = 0.2;       % The intrinsic growth rate of herbivore
eP = 3;           % Consumption rate of herbivore by predator
H_0 = 30;      % Half saturate herbivore density
aP = 0.2;        %  Assimilation rate
KH = 200;      % Carrying capacity
mH = 0.1;       % Mortality
mP = 0.05;      % 
dH = 0.01;      % Increased dispersal 
dHz = 0.01;     % Background dispersal
dP = 0.4;         % Increased dispersal
dPz = 0.2;       % Background dispersal
sH = 1;           % body size
sP = 20;         % body size 20*sH is realistic 
H_thH = 100; % dispersal threshhold for H
H_thP = 15;    % dispersal threshhold for P
cP = 0.5;         % dispersal parameter c for P , small number means long distance travel
cH = 0.1;        % dispersal parameter c for H
B = 0.3; 
%% Dispersal matrix
Dist = squareform(pdist(XY)); % XY cordinates --> distance matrix   
DispH = disp_incidence (Dist,cH,  ones(size(Dist)));  % Distance matrix --> dispersal matrix
DispP = disp_incidence (Dist,cP, ones(size(Dist)));
