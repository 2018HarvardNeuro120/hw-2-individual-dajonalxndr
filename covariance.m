function [cov_mtrx, V,D] = covariance(data)

mean_diff = removeMean(data); % return matrix with mean removed

N = length(data(:,1)); 

var_1 = 0; % variance of column 1 or x
var_2 = 0; % variance of column 2 or y
cov_1 = 0; % covariance of x and y

%% summations for variance and covarance
for i = 1:N
    a_1 = (mean_diff(i,1))^2;
    var_1 = var_1 + a_1;
    
    a_2 = (mean_diff(i,2))^2;
    var_2 = var_2 + a_2;
    
    a_3 = (mean_diff(i,1))*(mean_diff(i,2));
    cov_1 = cov_1 + a_3;
end

cov_mtrx = [var_1 cov_1; cov_1 var_2]*(1/(N-1));

%% eigenvalues and eigenvectors

[V,D] = eig(cov_mtrx);

x = mean_diff(:,1);
y = mean_diff(:,2);

diag_vals = diag(D);
prin_cmp = maxk(diag_vals,length(diag_vals));
pc1 = prin_cmp(1);
pc2 = prin_cmp(2);

scatter(x,y,2,'k','filled')

