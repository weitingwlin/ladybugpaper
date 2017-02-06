% This is a function to calculate R_TD, R_BU 
% from (real or simulated) TS of aphids and ladybugs
function out = TDBU_scale_logreg(data_A, data_L, Day)

nd = length(Day); % number of days, D 
%% scale up 
[L_3, L_9, L_27, A_3, A_9, A_27] = TDBU_scale_TS(data_A, data_L, Day);
%%  calculate moving averageand (MA) and difference (DF)
t = 1; %temporal data point
for d = 1:nd-1
    if Day(d+1) - Day(d) == 1 % find 2 consecutive days
        %%% 1-plant
         for k = 1:81
            MA_L_1(k,t) = mean(data_L(k,d:d+1));
            DF_L_1(k,t) = log( data_L(k,d+1) + 1 ) - log(data_L(k,d) + 1 );
            MA_A_1(k,t) = mean(data_A(k,d:d+1));
            DF_A_1(k,t) = log(data_A(k,d+1) + 1 ) - log(data_A(k,d) + 1);
        end
        %%%  3-plant
        for p=1:27
            MA_L_3(p,t) = mean(L_3(p,d:d+1));
            DF_L_3(p,t) = log(L_3(p,d+1) + 1) - log(L_3(p,d) + 1 );
            MA_A_3(p,t) = mean(A_3(p,d:d+1));
            DF_A_3(p,t) = log(A_3(p,d+1) + 1) - log(A_3(p,d) + 1 );
        end
        %%% 9-plant
         for q = 1 :9
            MA_L_9(q,t) = mean(L_9(q,d:d+1));
            DF_L_9(q,t) = log(L_9(q,d+1) + 1 ) - log(L_9(q,d) + 1 );
            MA_A_9(q,t) = mean(A_9(q,d:d+1));
            DF_A_9(q,t) = log(A_9(q,d+1) +1) - log(A_9(q,d) + 1 );
         end
        %%% 27-plant scale
         for r = 1 : 3
            MA_L_27(r,t) = mean(L_27(r,d:d+1));
            DF_L_27(r,t) = log(L_27(r,d+1) + 1 ) - log(L_27(r,d) + 1 );
            MA_A_27(r,t) = mean(A_27(r,d:d+1));
            DF_A_27(r,t) = log(A_27(r,d+1) + 1 ) - log(A_27(r,d) + 1 );
         end      
        t = t+1;
    end
end

%% Get the regression coefficients
BU=zeros(1,4);
    [temp, m, b] = regression(MA_A_1(:)', DF_L_1(:)');        BU(1,1)=temp;
    [temp, m, b] = regression(MA_A_3(:)', DF_L_3(:)');       BU(1,2)=temp;
    [temp, m, b] = regression(MA_A_9(:)', DF_L_9(:)');       BU(1,3)=temp;
    [temp, m, b] = regression(MA_A_27(:)', DF_L_27(:)');   BU(1,4)=temp;
TD=zeros(1,4);
    [temp, m, b] = regression(MA_L_1(:)', DF_A_1(:)' );         TD(1,1)=temp;
    [temp, m, b] = regression(MA_L_3(:)', DF_A_3(:)');         TD(1,2)=temp;
    [temp, m, b] = regression(MA_L_9(:)', DF_A_9(:)');         TD(1,3)=temp;
    [temp, m, b] = regression(MA_L_27(:)', DF_A_27(:)');     TD(1,4)=temp;
out= [TD;BU];
