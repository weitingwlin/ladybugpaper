% This is a function to create time series (TS) for each set of each scales 
% from (real or simulated) TS of aphids and ladybugs
function [L3, L9, L27, A3, A9, A27] = TDBU_scale_TS(data_A, data_L, Day)

nd=length(Day); % number of days, D 
% preparing output data sheet
L3=zeros(27,nd);   A3=zeros(27,nd);
L9=zeros(9,nd);     A9=zeros(9,nd);
L27=zeros(3,nd);   A27=zeros(3,nd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3-plant TS
for i=0:26
    ind=[i*3+1:i*3+3];
    L3(i+1,:)=sum(data_L(ind,:));
    A3(i+1,:)=sum(data_A(ind,:));
end
%%%%%%%%%%%%%
% 9-plant TS
for i=0:8
    ind=[i*9+1:i*9+9];
    L9(i+1,:)=sum(data_L(ind,:));
    A9(i+1,:)=sum(data_A(ind,:));
end
%%%%%%%%%%%%%%
% 27-plant TS
for i=0:2
    ind=[i*27+1:i*27+27];
    L27(i+1,:)=sum(data_L(ind,:));
    A27(i+1,:)=sum(data_A(ind,:));
end