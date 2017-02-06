% Simulate null model by shuffling the plant ID (location) of data, calculate the confidance interval and mediam.  
% Syntax:
%           bootstrapTDBU = TDBU_bootstrap_logreg(dataA, dataL, Day, itt, replacement)
function bootstrapTDBU = TDBU_bootstrap_logreg(dataA, dataL, Day, itt, replacement)
% default is without replacement 
    if (nargin <5),  replacement = false;  end
% convert replacement to logical if it is numeric
    if isa(replacement,'double') == 1
            replacement=logical(replacement);
    end

%%% Prepare sheet
    TDsh = zeros(itt, 4);
    BUsh = zeros(itt, 4);

%%% Do simulation
    parfor t = 1:itt
    % create permutated data: permutation was done for each time step
    sh_data_A = datasample(dataA, 81, 1, 'replace', replacement); % shuffle the patch(plant) ID of the data 
    sh_data_L = datasample(dataL, 81, 1,'replace', replacement);
    output = TDBU_scale_logreg(sh_data_A, sh_data_L, Day); % calculate TD, BU indices
    TDsh(t, :) = output(1, :);  % save output
    BUsh(t, :) = output(2, :);
    end
% Calculate CI and median
ciTD = quantile(TDsh, [0.025 0.975], 1); % get 95%, 2-tail confidence interval for each column in TDsh
ciBU = quantile(BUsh, [0.025 0.975], 1);
medTD = median(TDsh);
medBU = median(BUsh);
%%% Calculate R_TD, R_BU for original data
real = TDBU_scale_logreg(dataA, dataL, Day);

% P value: inverse percentile
for s = 1:4
        nlessTD = sum( TDsh(:, s) < real(1,s ));
        nequalTD = sum(TDsh(:, s) ==  real(1,s ));
    Pval(1,s) = (nlessTD + 0.5*nequalTD) / itt;
        nlessBU = sum( BUsh(:, s) < real(2,s ));
        nequalBU = sum(BUsh(:, s) ==  real(2,s ));
    Pval(2,s)  = 1-((nlessBU + 0.5*nequalBU) / itt);
end
% prepare output
bootstrapTDBU = struct('ciTD',ciTD,'ciBU',ciBU,'medTD',medTD, 'medBU',medBU,'real',real, 'Pval', Pval);
