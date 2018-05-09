clear all 

load toWhiten.mat

% removes the mean from a data matrix
removeMean = @(x)x - sum(x)/length(x);

% calculates the convariance matrix of the data
findCovariance = @(x)x'*x/(length(x)-1);

mtrx = removeMean(toWhiten);
cov_mtrx = findCovariance(mtrx);

[V,D] = eig(cov_mtrx);

D; 

white_mtrx =  mtrx * V * inv(D.^0.5);

biplot(white_mtrx)