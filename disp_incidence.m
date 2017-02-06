% Transfer Distance matrix to dispersal incidence model (ref. Hanski & Woiwod, 1993)
%
% syntax:
%         disp_mat = disp_incidence(D_mat, c, weight)
%
% [D_mat] : distance matrix, symmetric
% [c] : dispersal parameter c, small c value means long distance travel
% [weight] : asymmetric matrix, specify the dispersal weight, or preference, between each paair. Optional,
% default is 0 on the diagnal and 1 on everywhere else. Each row represent weight of settlement
% preference FROM one patch.
% 
% [disp_mat] : each raw is the probability FROM one patch 
% 
function disp_mat = disp_incidence(D_mat, c, weight)
[N,P] = size(D_mat);
% Defaul value
if nargin <3 ; weight=ones(N)-eye(N);end
% default of weight is to ignore the current patch

disp_mat = zeros(N); % empty sheet
for i = 1:N
    inc = exp((-1)*c*D_mat(i,:)) .* weight(i,:); % relative incidence
            % with default weight matrix, this exclude i=i
    disp_mat(i,:) = inc/sum(inc,2);                              
end
 disp_mat(isnan(disp_mat)) = 0;