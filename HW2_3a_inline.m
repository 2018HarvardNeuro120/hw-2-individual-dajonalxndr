clear all

load toWhiten.mat
mtrx = toWhiten;

m = @(A)A - mean(A); % function removes mean from matrix

mtrx_final = m(mtrx); % test inline function

% check
mtrx_correct = mtrx - mean(mtrx);