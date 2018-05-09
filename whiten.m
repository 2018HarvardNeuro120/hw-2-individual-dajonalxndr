function white_data = whiten(data)
% whitens the data

% removes the mean from a data matrix
removeMean = @(x)x - sum(x)/length(x);
mean_removed = removeMean(data);

% calculates the convariance matrix of the data
findCovariance = @(x)x'*x/(length(x)-1);
cov_matrix = findCovariance(mean_removed);

[V,D] = eig(cov_matrix);

D; 

white_data =  mean_removed * V * inv(D.^0.5);