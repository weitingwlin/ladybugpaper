
    clear; clc
%% calculate stochastic parameters   
    tlim = 100; % total time of simulation    
    trec = 10;  % time steps recorded 
    ts = tlim-trec +1: 01: tlim; % time points recorded
    it = 300;    % iteration 
%% Set model scenario
    scen = 1;
%%
    simA = []; simL = []; simD =[];
    rng(1); % for reproducibility
    tic
    parfor i = 1:it
        tic
        % initial values
        X0 = zeros(81,2);  
        for p = 1:81
                X0(p,:)  = [round(rand*100*(rand >= 0.3)) , rand>=0.9];  
        end
        % simulation
        %%%%%%%%%%%%%%%%%%%%%%%%%
        [t, x] = iva_Gillespie2( X0, tlim,  scen-1);
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % record at time specified in `ts`
                x1 = permute(x, [1 3 2]); % so the dimensions in x1 are [patch, time, species]
                tempA = fixsample(t, x1(:,:,1), ts);
                tempL = fixsample(t, x1(:,:,2), ts);
        simA = [simA tempA];
        simL = [simL tempL];
        simD = [simD ts];
        second = toc; disp(['iteration: ', num2str(i), ' time (s) ' , num2str(second) ]);
    end
    second2 = toc; disp(['Total  time (s) ' , num2str(second2) ]);


%% Calculate R_TD, R_BU and simulate null model
sh = 10000;
tic
out = TDBU_bootstrap_logreg(simA, simL, simD, sh,1);
toc
%% Check the results
% R_TD (for 1-, 3-, 9-, 27 plant scale)
    out.real(1,:)
    % median and CI are in null model
    out.medTD
    out.ciTD
    % p-value
    out.Pval(1,:)
% R_BU (for 1-, 3-, 9-, 27 plant scale)
    out.real(2,:)
    % median and CI are in null  model
    out.medBU
    out.ciBU
    % p-value
    out.Pval(2,:)